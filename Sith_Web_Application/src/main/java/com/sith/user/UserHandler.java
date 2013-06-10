package com.sith.user;

import com.sith.SithAPI;
import com.sith.event.Event;
import com.sith.event.EventHandler;
import com.sith.util.HTTPUtil;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

public class UserHandler{
	private HTTPUtil httpUtil=new HTTPUtil();
	private EventHandler eventHandler= new EventHandler();
	public ArrayList<Event> getUserEventList(String userID){
		ArrayList<Event> events=null;
		String result=null;

		try{
			result=httpUtil.doGet(SithAPI.GET_USER_EVENT_LIST+"?userID="+userID);
			JSONArray jsonArray=new JSONArray(result);
			events=new ArrayList<Event>();
			for(int i=0;i<jsonArray.length();i++){
				JSONObject jsonObject=jsonArray.getJSONObject(i);
				String eventID=jsonObject.getString("eventID");
				Event event=eventHandler.getEvent(eventID);
				if(event!=null){
					events.add(event);
				}
				else {
					//Remove events from registrtion list
				}
			}

			return events;
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;

	}

	public String checkDeletedEvents(String userID){
		String events="";
		String result=null;

		try{
			result=httpUtil.doGet(SithAPI.GET_USER_EVENT_LIST+"?userID="+userID);
			JSONArray jsonArray=new JSONArray(result);
			for(int i=0;i<jsonArray.length();i++){
				JSONObject jsonObject=jsonArray.getJSONObject(i);
				String eventID=jsonObject.getString("eventID");
				if(eventHandler.getEvent(eventID)==null){
					if(events.equals("")){
						events+=eventID;
					}
					else{
						events+=","+eventID;
					}
				}
			}
			return events;
		}catch(Exception e){
			e.printStackTrace();
		}
		return events;

	}

}
