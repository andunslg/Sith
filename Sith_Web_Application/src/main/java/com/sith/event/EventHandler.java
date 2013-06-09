package com.sith.event;

import com.sith.SithAPI;
import com.sith.util.HTTPUtil;
import org.json.simple.parser.JSONParser;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EventHandler{
	HTTPUtil httpUtil=new HTTPUtil();
	JSONParser parser=new JSONParser();

	public boolean addEvent(String eventID, String eventName,String eventAdmin, String startTime, String endTime, String date, String location, String description, String perceptionSchema){
		Map<String,String> parms=new HashMap<String,String>();
		parms.put("eventID",eventID);
		parms.put("eventName",eventName);
		parms.put("eventAdmin",eventAdmin);
		parms.put("desc",description);
		parms.put("location",location);
		parms.put("date",date);
		parms.put("startTime",startTime);
		parms.put("endTime",endTime);
		parms.put("perceptionSchema",perceptionSchema);

		String result=null;
		try{
			result=httpUtil.doPost(SithAPI.ADD_EVENT,parms);
			if(!result.equals("")){
				if("{\"response\":true}".equals(result)){
					return true;
				}
				return false;
			}
		}catch(Exception e){
			e.printStackTrace();
		}

		return false;
	}

	public boolean isEventAvailable(String eventID){
		//Check availability via API
		return true;
	}

	public Event getEvent(String eventID){

		Event sampleEvent=new Event("event1","CSE_Programming_Challange","aslg","This is programming challenge","1300","1700","20-06-2013","CSLR","Happy:Sleepy:Bored:Interested:Neutral");
		Event sampleEvent1=new Event("event2","Software_Engineering_Project","prabhath","This is SE project","0800","1200","22-06-2013","Seminar Room","Happy:Sleepy:Bored:Interested:Neutral");
		Event sampleEvent2=new Event("event3","FYP","sachintha","This is FYP","0800","1200","22-10-2013","FYP Lab","Happy:Sleepy:Bored:Interested:Neutral");
		Event sampleEvent3=new Event("event4","WSO2_Con","tgts","This is WSO2 CON","0800","1200","04-11-2013","USA","Happy:Sleepy:Bored:Interested:Neutral");
		if(eventID.equals("event1")){
			return sampleEvent;
		}else if(eventID.equals("event2")){
			return sampleEvent1;
		}else if(eventID.equals("event3")){
			return sampleEvent2;
		}else{
			return sampleEvent3;
		}


	}

	public ArrayList<String> getComments(String eventID){

		ArrayList<String> list=new ArrayList<String>();
		list.add("Prabhath::this is cool");
		return list;

	}

	public Participant getParticipant(String name){
		if(name.equals("aslg")){
			return new Participant("aslg","Andun Sameera","2.35PM","Happy");
		}else{
			return new Participant("prabhath","Prabhath Pathirana","2.35PM","Happy");
		}
	}

	public List<Participant> getParticipants(String eventID){
		ArrayList<Participant> participants=new ArrayList<Participant>();

		participants.add(new Participant("prabhath","Prabhath Pathirana","2.35PM","Happy"));
		participants.add(new Participant("aslg","Andun Sameera","2.35PM","Happy"));
		return participants;
	}

}
