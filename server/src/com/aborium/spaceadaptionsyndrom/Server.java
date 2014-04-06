package com.aborium.spaceadaptionsyndrom;

import java.net.InetSocketAddress;
import java.net.UnknownHostException;
import java.nio.ByteBuffer;

import org.bespin.enet.EnetException;
import org.bespin.enet.Event;
import org.bespin.enet.Host;


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

	private final InetSocketAddress address = new InetSocketAddress(
			"localhost", 5757);

	/** 
	 * Enet connection settings
	 * 
	 * peer_count - max number of peers, defaults to 64
	 * channel_count - max number of channels, defaults to 1
	 * in_bandwidth - downstream bandwidth in bytes/sec, defaults to 0 (unlimited)
	 * out_bandwidth - upstream bandwidth in bytes/sec, defaults to 0 (unlimited)
	 */
	private final int peerCount = 24;
	private final int channelCount = 1;
	private final int incomingBandwithLimit = 0;
	private final int outgoingBandwithLimit = 0;
	private final int serviceTime = 5000;

	public Server() {
		try {
			this.game = new Game();
			this.host = new Host(address, peerCount, channelCount, incomingBandwithLimit, outgoingBandwithLimit);
			System.out.println("Connected to " + address.getHostString());
		} catch (EnetException e) {
			System.out.println("Error initializing Host object");
		}
	}

	/**
	 * Service clients
	 * @throws UnknownHostException 
	 */
	public void service() {
		
		try {
			Event event = this.host.service(serviceTime);
	
			if (event != null) {
	
				if (event.type() == Event.Type.Connect) {
					System.out.println("Client connected: " + event.peer().address().getHostString());
					game.addNewPlayer(event.peer().toString(), "Player"); 
				}
	
				if (event.type() == Event.Type.Disconnect) {
					System.out.println("Client disconnected: " + event.peer().address().getHostString());
				}
	
				if (event.type() == Event.Type.None) {
					System.out.println("All is well...");
				}
	
				if (event.type() == Event.Type.Receive) {
					StringBuilder builder = new StringBuilder();
					ByteBuffer input = event.packet().getBytes();
					while (input.hasRemaining()) {
						
						builder.append((char) input.get());
					}
					System.out.println(builder.toString());
				}
			}
		} catch(UnknownHostException | EnetException e) {
			System.out.println("Error: Connection problem");
		}
	}

	public boolean isActive() {
		return host != null;
	}

}
