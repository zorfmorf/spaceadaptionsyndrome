package com.aborium.spaceadaptionsyndrom.event;


/**
 * Events are put into a queue whenever a client does something
 * @author zorfmorf
 *
 */
public class ClientEvent {
	
	private final String id;
	
	private final EventType type;
	
	public ClientEvent(String id, EventType type) {
		this.id = id;
		this.type = type;
	}

	public String getId() {
		return id;
	}

	public EventType getType() {
		return type;
	}

}
