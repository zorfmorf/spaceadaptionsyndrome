package com.aborium.spaceadaptionsyndrom;

import java.nio.ByteBuffer;
import java.util.List;

import com.aborium.spaceadaptionsyndrom.entities.Entity;
import com.aborium.spaceadaptionsyndrom.event.ClientEvent;
import com.aborium.spaceadaptionsyndrom.event.ClientMessage;
import com.aborium.spaceadaptionsyndrom.event.EventType;

/**
 * Static class for parsing Game information into message strings and back
 * @author zorfmorf
 *
 */
public class MessageParser {

	public static Byte[] parseGameState(List<Entity> entities) {
		//TODO: implement
		return null;
	}
	
	public static ByteBuffer createPackage(String message) {
		ByteBuffer buffer = ByteBuffer.allocate(256);
		if(message.length() > 255) {
			System.out.println("Message too long: " + message);
			return null;
		}
		
		for(int i = 0; i < message.length(); i++) {
			buffer.put((byte) message.charAt(i));
		}
		return buffer;
	}
	
	public static ClientEvent parseClientMessage(String id, ByteBuffer input) {
		String[] message = parseBytes(input);
		if(message != null && message.length > 1) {
			if(message[0].equals(EventType.MESSAGE.toString())) {
				return new ClientMessage(id, message[1]); 
			}
		}
		return null;
	}
	
	private static String[] parseBytes(ByteBuffer input) {
		StringBuilder builder = new StringBuilder();
		while (input.hasRemaining()) {
			
			builder.append((char) input.get());
		}
		return builder.toString().split("\\|");
	}
}
