package com.aborium.spaceadaptionsyndrom.entities;

import com.aborium.spaceadaptionsyndrom.equipment.Thruster;

/**
 * Players fly around in space, protected by a spacesuit. Movement is limited by
 * the spacesuits fuel
 * 
 * @author zorfmorf
 * 
 */
public class Player extends Entity {
	
	private String id;

	private String name;

	private float fuel;
	
	private Thruster verticalThruster;
	
	private Thruster horizontalThruster;
	
	private Thruster rotationalThruster;
	
	public Player(String id, String name) {
		this.name = name;
		this.id = id;
		this.fuel = 100;
		
		this.verticalThruster = new Thruster();
		this.horizontalThruster = new Thruster();
		this.rotationalThruster = new Thruster();
	}
	
	@Override
	public void update(float dt) {
		
		if(fuel > 0) { 
		
			if(horizontalThruster.isActive()) {
				float v = horizontalThruster.getThrust() * dt;
				this.setxMov(this.getxMov() + v);
				this.fuel = this.fuel - v;
			}
			
			if(verticalThruster.isActive()) {
				float v = verticalThruster.getThrust() * dt;
				this.setyMov(this.getyMov() + v);
				this.fuel = this.fuel - v;
			}
			
			if(rotationalThruster.isActive()) {
				float v = rotationalThruster.getThrust() * dt;
				this.setRotation(this.getRotation() + v);
				this.fuel = this.fuel - v;
			}
			
			fuel = Math.max(0, fuel);
		
		}
		
		super.update(dt);
	}

	public String getId() {
		return id;
	}

	public String getName() {
		return name;
	}
	
	public float getFuel() {
		return fuel;
	}
	
	public void setFuel(float fuel) {
		this.fuel = fuel;
	}

	public Thruster getVerticalThruster() {
		return verticalThruster;
	}

	public Thruster getHorizontalThruster() {
		return horizontalThruster;
	}

	public Thruster getRotationalThruster() {
		return rotationalThruster;
	}
}
