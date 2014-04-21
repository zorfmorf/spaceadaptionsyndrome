package com.aborium.spaceadaptionsyndrom;

public class Main {

	public static void main(String[] args) {
		
		System.out.println("Starting server");
		
		// init all the shit
		Server server = Server.getReference();
		Game game = Game.getReference();
		game.setServer(); //to avoid cyclic dependencies	
		
		float dt = 0;
		double before = 0;
		double after = 0;
		
		while(server.isActive()) {
			
			dt = (float) (after - before);
			before = System.currentTimeMillis();
			
			game.update(dt);
			server.service();
			
			after = System.currentTimeMillis();
		}
		
		System.out.println("Shutting down");

	}

}
