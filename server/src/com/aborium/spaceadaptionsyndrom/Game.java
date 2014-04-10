package com.aborium.spaceadaptionsyndrom;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentLinkedQueue;

import com.aborium.spaceadaptionsyndrom.entities.Entity;
import com.aborium.spaceadaptionsyndrom.entities.Player;
import com.aborium.spaceadaptionsyndrom.event.ClientEvent;
import com.aborium.spaceadaptionsyndrom.event.ClientMessage;
import com.aborium.spaceadaptionsyndrom.event.EventType;

/**
 * The Game class is a singleton
 * 
 * @author zorfmorf
 * 
 */
public class Game {

	/**
	 * Contains all game elements. Handles concurrent access out of the box
	 */
	private ConcurrentHashMap<String, Entity> entities;

	private ConcurrentLinkedQueue<ClientEvent> eventQueue;
	
	private static Game reference;
	
	private Server server;

	/**
	 * The constructor is private to force usage of getReference
	 */
	private Game() {
		this.entities = new ConcurrentHashMap<String, Entity>();
		this.eventQueue = new ConcurrentLinkedQueue<ClientEvent>();
	}

	/**
	 * References to Game can only be aquired using this method ensuring that
	 * only instance can ever exist
	 * 
	 * @return
	 */
	public static synchronized Game getReference() {		
		if (reference == null) {
			reference = new Game();
		}
		return reference;
	}
	
	public void setServer() {
		this.server = Server.getReference();
	}

	/**
	 * Update position and state of all entities
	 * 
	 * @param dt
	 */
	public void update(float dt) {

		for (Entity entity : this.entities.values()) {
			entity.update(dt);
		}
		
		while(!eventQueue.isEmpty()) {
			ClientEvent event = eventQueue.poll();
			if(event != null) {
				
				//CONNECT
				if(event.getType() == EventType.CONNECT) {
					
					if(entities.containsKey(event.getId())) {
						System.out.println("Already exisiting player connected!!!");
					} else {
						this.entities.put(event.getId(), new Player(event.getId(), "Unnamed Player"));
					}
				}
				
				//DISCONNECT
				if(event.getType() == EventType.DISCONNECT) {
					this.entities.remove(event.getId());
				}
				
				//MESSAGE
				if(event.getType() == EventType.MESSAGE) {
					ClientMessage mssg = (ClientMessage) event;
					server.send(null, mssg.getMessage());
				}
				
			} else {
				System.out.println("Concurrency problem detected. EventQueue is empty althoug this is impossible");
			}
		}

	}

	/**
	 * @return String representation of game state
	 */
	public String getState() {
		// TODO: implement
		return null;
	}

	public void addEvent(ClientEvent e) {
		this.eventQueue.add(e);
	}

}
