package com.aborium.spaceadaptionsyndrom.equipment;

public class Thruster {
	
	private boolean active;
	
	private float thrust;
	
	public Thruster() {
		this.active = false;
		this.thrust = 1;
	}
	
	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public float getThrust() {
		return thrust;
	}

}
