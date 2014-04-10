package com.aborium.spaceadaptionsyndrom.event;

public class ClientMessage extends ClientEvent {
	
	private String message;

	public ClientMessage(String id, String message) {
		super(id, EventType.MESSAGE);
		this.message = message;
	}

	public String getMessage() {
		return message;
	}

}
