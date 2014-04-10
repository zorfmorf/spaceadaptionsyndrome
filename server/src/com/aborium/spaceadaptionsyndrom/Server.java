package com.aborium.spaceadaptionsyndrom;

import java.net.InetSocketAddress;
import java.net.UnknownHostException;
import java.nio.ByteBuffer;
import java.util.EnumSet;
import java.util.HashMap;

import org.bespin.enet.EnetException;
import org.bespin.enet.Event;
import org.bespin.enet.Host;
import org.bespin.enet.Packet;
import org.bespin.enet.Peer;
import org.bespin.enet.Packet.Flag;

import com.aborium.spaceadaptionsyndrom.event.ClientEvent;
import com.aborium.spaceadaptionsyndrom.event.EventType;

/**
 * Simple placeholder server handling all players using enet networking library
 * 
 * @author zorfmorf
 * 
 */
public class Server {

	/**
	 * The host object clients can connect with
	 */
	private Host host;

	private Game game;
	
	private static Server server;
	
	private HashMap<String, Peer> peerMap;
	
	private int channelId = -1;

	private final InetSocketAddress address = new InetSocketAddress(
			"localhost", 5757);

	/**
	 * Enet connection settings
	 * 
	 * peer_count - max number of peers, defaults to 64 
	 *   channel_count - max number of channels, defaults to 1 
	 *   in_bandwidth - downstream bandwidth in bytes/sec, defaults to 0 (unlimited) 
	 *   out_bandwidth - upstream bandwidth in bytes/sec, defaults to 0 (unlimited)
	 */
	private final int peerCount = 24;
	private final int channelCount = 1;
	private final int incomingBandwithLimit = 0;
	private final int outgoingBandwithLimit = 0;
	private final int serviceTime = 0;

	private Server() {
		
		this.peerMap = new HashMap<String, Peer>();
		
		try {
			this.game = Game.getReference();
			this.host = new Host(address, peerCount, channelCount,
					incomingBandwithLimit, outgoingBandwithLimit);
			System.out.println("Connected to " + address.getHostString());
		} catch (EnetException e) {
			System.out.println("Error initializing Host object");
		}
	}
	
	public static synchronized Server getReference() {
		if(server == null) {
			server = new Server();
		}
		return server;
	}

	/**
	 * Service clients
	 * 
	 * @throws UnknownHostException
	 */
	public void service() {

		try {
			Event event = this.host.service(serviceTime);

			if (event != null) {
				
				if(channelId == -1) {
					this.channelId = event.channelID();
				}
				
				String peerId = event.peer().address().toString();

				if (event.type() == Event.Type.Connect) {
					game.addEvent(new ClientEvent(peerId,
							EventType.CONNECT));
					this.peerMap.put(peerId, event.peer());
					System.out.println("Client connected: "
							+ peerId + " channel: " + event.channelID());
				}

				if (event.type() == Event.Type.Disconnect) {
					game.addEvent(new ClientEvent(peerId,
							EventType.DISCONNECT));
					this.peerMap.remove(peerId);
					System.out.println("Client disconnected: "
							+ event.peer().address().getHostString());
				}

				if (event.type() == Event.Type.None) {
					// TODO: hibernation mode
				}

				if (event.type() == Event.Type.Receive) {
					ClientEvent clientEvent = MessageParser.parseClientMessage(
							peerId, event.packet().getBytes());
					if(clientEvent != null) {
						System.out.println("Event: " + clientEvent.getType());
						game.addEvent(clientEvent);
					} else {
						System.out.println("Recieved invalid package from: " + peerId);
					}
				}
			}
		} catch (UnknownHostException | EnetException e) {
			System.out.println("Error: Connection problem");
		}
	}
	
	/**
	 * Sends message to specified client.
	 * @param id if null it is broadcasted to all clients
	 */
	public void send(String id, String message) {
		
		ByteBuffer buffer = MessageParser.createPackage("MESSAGE|" + message);
		Packet packet = null;
		try {
			packet = new Packet(buffer, EnumSet.noneOf(Flag.class));
		} catch (EnetException e1) {
			e1.printStackTrace();
		}
		
		if(packet != null) {
			if(id == null) {
				for(Peer peer : peerMap.values()) {
					send(peer, packet);
				}
			} else {
				Peer peer = peerMap.get(id);
				if(peer != null) {
					send(peer, packet);
				}
			}
		}
	}
	
	private void send(Peer peer, Packet packet) {
		try {
			peer.send(channelId, packet);
		} catch (EnetException e) {
			e.printStackTrace();
		}
	}

	public boolean isActive() {
		return host != null;
	}

}
