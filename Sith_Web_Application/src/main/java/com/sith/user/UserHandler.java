package com.sith.user;

import com.sith.event.Event;

import java.util.ArrayList;

public class UserHandler{

	public ArrayList<Event> getUserEventList(String userID){
		ArrayList<Event> events=new ArrayList<Event>();
		Event sampleEvent=new Event("cse_pc1","Programming Challange 1","aslg","Programming Challange 1 for Batch 11th","13","17","20-06-2013","Level 2 Lab CSE UOM","Awesome:Wonderful:Excited:Happy:Interested:Neutral:Bored:Sleepy:Sad:Angry:Disgusting:Horrible");
		events.add(sampleEvent);
		sampleEvent=new Event("cse_sep","Software Engineering Project","aslg","Software Engineering Project for 10th Batch","08","12","04-06-2013","CSLR CSE UOM","Awesome:Wonderful:Excited:Happy:Interested:Neutral:Bored:Sleepy:Sad:Angry:Disgusting:Horrible");
		events.add(sampleEvent);
		return events;
	}

	public boolean registerToEvent(String eventID, String userID){
		return true;
	}
}
