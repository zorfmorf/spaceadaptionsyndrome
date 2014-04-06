package com.aborium.spaceadaptionsyndrom;

public class Main {

	public static void main(String[] args) {
		
		System.out.println("Starting server");
		
		Server server = new Server();
		
		while(server.isActive()) {
			server.service();
		}
		
		System.out.println("Shutting down");

	}

}
