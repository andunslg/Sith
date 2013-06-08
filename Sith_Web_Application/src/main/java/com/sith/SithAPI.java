package com.sith;

import com.sith.event.Event;

import java.util.ArrayList;

public class SithAPI{
	public static SithAPI sithAPI=new SithAPI();

	public static String NODEAPI="http://192.248.8.246:3000/";
	public static String LOGIN=NODEAPI+"authenticateUser";
	public static String SIGNUP=NODEAPI+"registerAnnonymousUser";
	public static String GET_EVENT_LIST="";
	public static String ADD_EVENT=NODEAPI+"addEvent";

	public ArrayList<Event> getEventList(){
		ArrayList<Event> events=new ArrayList<Event>();
		Event sampleEvent=new Event("event1","CSE_Programming_Challange","aslg","This is programming challenge","1300","1700","20-06-2013","CSLR","Happy:Sleepy:Bored:Interested:Neutral");
		events.add(sampleEvent);
		sampleEvent=new Event("event2","Software_Engineering_Project","prabhath","This is SE project","0800","1200","22-06-2013","Seminar Room","Happy:Sleepy:Bored:Interested:Neutral");
		events.add(sampleEvent);
		sampleEvent=new Event("event3","FYP","sachintha","This is FYP","0800","1200","22-10-2013","FYP Lab","Happy:Sleepy:Bored:Interested:Neutral");
		events.add(sampleEvent);
		sampleEvent=new Event("event4","WSO2_Con","tgts","This is WSO2 CON","0800","1200","04-11-2013","USA","Happy:Sleepy:Bored:Interested:Neutral");
		events.add(sampleEvent);
		return events;
	}

	public static SithAPI getInstance(){
		return sithAPI;
	}


}
