package com.aborium.spaceadaptionsyndrom;

import java.util.concurrent.ConcurrentHashMap;

import com.aborium.spaceadaptionsyndrom.entities.Entity;
import com.aborium.spaceadaptionsyndrom.entities.Player;

public class Game {
	
	private ConcurrentHashMap<String, Entity> entities;
	
	public Game() {
		this.entities = new ConcurrentHashMap<String, Entity>();
	}
	
	public void update(float dt) {
		
		for(Entity entity : this.entities.values()) {
			entity.update(dt);
		}
		
	}
	
	public void addNewPlayer(String id, String name) {
		Entity entity = new Player(name, id);
		this.entities.put(id, entity);
	}
	
	/**
	 * @return String representation of game state
	 */
	public String getState() {
		//TODO:	implement
		return null;
	}

}
