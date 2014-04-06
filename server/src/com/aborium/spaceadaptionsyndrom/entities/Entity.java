package com.aborium.spaceadaptionsyndrom.entities;

/**
 * An entity is positioned in space and has all necessary properties to move
 * over time.
 * 
 * @author zorfmorf
 * 
 */
public class Entity {

	private double xPos;

	private double yPos;

	private float xMov;

	private float yMov;

	private float orientation;

	private float rotation;

	public void update(float dt) {
		this.xPos = this.xPos + this.xMov * dt;
		this.yPos = this.yPos + this.yMov * dt;
		this.orientation = this.orientation + this.rotation * dt;
	}

	public double getxPos() {
		return xPos;
	}

	public void setxPos(double xPos) {
		this.xPos = xPos;
	}

	public double getyPos() {
		return yPos;
	}

	public void setyPos(double yPos) {
		this.yPos = yPos;
	}

	public float getxMov() {
		return xMov;
	}

	public void setxMov(float xMov) {
		this.xMov = xMov;
	}

	public float getyMov() {
		return yMov;
	}

	public void setyMov(float yMov) {
		this.yMov = yMov;
	}

	public float getOrientation() {
		return orientation;
	}

	public void setOrientation(float orientation) {
		this.orientation = orientation;
	}

	public float getRotation() {
		return rotation;
	}

	public void setRotation(float rotation) {
		this.rotation = rotation;
	}

}
