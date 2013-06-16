package com.sith.event;

import com.sith.SithAPI;
import com.sith.perception.Perception;
import com.sith.util.HTTPUtil;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class EventHandler{
	HTTPUtil httpUtil=new HTTPUtil();


	public boolean addEvent(String eventID, String eventName,String eventAdmin, String startDate,String startTime,String endDate, String endTime, String location, String description, String perceptionSchema, String commentEnabled){
		Map<String,String> parms=new HashMap<String,String>();
		parms.put("eventID",eventID);
		parms.put("eventName",eventName);
		parms.put("eventAdmin",eventAdmin);
		parms.put("desc",description);
		parms.put("location",location);
		parms.put("startDate",startDate);
		parms.put("startTime",startTime);
		parms.put("endDate",endDate);
		parms.put("endTime",endTime);
		parms.put("perceptionSchema",perceptionSchema);
		parms.put("commentEnabled",commentEnabled);

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

	public boolean updateEvent(String oldEventID,String eventID, String eventName,String eventAdmin, String startDate,String startTime,String endDate, String endTime, String location, String description, String perceptionSchema, String commentEnabled){
		Map<String,String> parms=new HashMap<String,String>();
		parms.put("oldEventID",oldEventID);
		parms.put("eventID",eventID);
		parms.put("eventName",eventName);
		parms.put("eventAdmin",eventAdmin);
		parms.put("desc",description);
		parms.put("location",location);
		parms.put("startDate",startDate);
		parms.put("startTime",startTime);
		parms.put("endDate",endDate);
		parms.put("endTime",endTime);
		parms.put("perceptionSchema",perceptionSchema);
		parms.put("commentEnabled",commentEnabled);


		String result=null;
		try{
			result=httpUtil.doPut(SithAPI.UPDATE_EVENT,parms);
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

	public boolean setCommentEnabled(String eventID, String commentEnabled){
		Map<String,String> parms=new HashMap<String,String>();
		parms.put("eventID",eventID);
		parms.put("commentEnabled",commentEnabled);

		try{
			String result=httpUtil.doPut(SithAPI.SET_COMMENT_ENABLED,parms);
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

	public boolean addUserToEvent(String userID,String eventID){

		String result=null;
		try{
			result=httpUtil.doGet(SithAPI.ADD_USER_TO_EVENT+"?eventID="+eventID+"&userID="+userID+"&status=participant");
			if(!result.equals("")){
				if("{\"result\":true}".equals(result)){
					return true;
				}
				return false;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}

	public boolean removeUserFromEvent(String userID,String eventID){

		String result=null;
		try{
			result=httpUtil.doGet(SithAPI.REMOVE_USER_FROM_EVENT+"?userID="+userID+"&eventID="+eventID);
			if(!result.equals("")){
				if("{\"result\":true}".equals(result)){
					return true;
				}
				return false;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}

	public boolean addComment(String eventID, String userID,String perceptionValue, String text){
		Map<String,String> parms=new HashMap<String,String>();
		parms.put("eventID",eventID);
		parms.put("userID",userID);
		parms.put("perceptionValue",perceptionValue);
		parms.put("text",text);

		String result=null;
		try{
			result=httpUtil.doPost(SithAPI.PUBLISH_COMMENT,parms);
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
		Event event=null;

		String result=null;
		try{
			result=httpUtil.doGet(SithAPI.GET_EVENT_BY_ID+"?eventID="+eventID);
			JSONObject jsonObject=new JSONObject(result);
			event= new Event(jsonObject.getString("eventID"),jsonObject.getString("eventName"),jsonObject.getString("eventAdmin"),jsonObject.getString("description"),jsonObject.getString("startDate"),jsonObject.getString("endDate"),jsonObject.getString("startTime"),jsonObject.getString("endTime"),jsonObject.getString("location"),jsonObject.getString("perceptionSchema"),jsonObject.getString("commentEnabled"));
			return event;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}

	public ArrayList<Perception> getComments(String eventID){
		ArrayList<Perception> comments=null;

		String result=null;
		try{
			result=httpUtil.doGet(SithAPI.GET_EVENT_COMMENTS+"?eventID="+eventID);
			System.out.println(result);
			JSONArray jsonArray=new JSONArray(result);
			comments=new ArrayList<Perception>();
			for(int i=0;i<jsonArray.length();i++){
				JSONObject jsonObject=jsonArray.getJSONObject(i);
				Perception perception= new Perception(jsonObject.getString("userID"),jsonObject.getString("eventID"),jsonObject.getString("perceptionValue"),jsonObject.getString("text"));
				comments.add(perception);
			}return comments;
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;


	}

	public Participant getParticipant(String name){
		if(name.equals("aslg")){
			return new Participant("aslg");
		}
		else{
			return new Participant("andunslg");
		}
	}

	public ArrayList<Participant> getParticipants(String eventID){
		ArrayList<Participant> participants=null;

		String result=null;
		try{
			result=httpUtil.doGet(SithAPI.GET_PARTICIPANTS+"?eventID="+eventID);
			JSONArray jsonArray=new JSONArray(result);
			participants=new ArrayList<Participant>();
			for(int i=0;i<jsonArray.length();i++){
				JSONObject jsonObject=jsonArray.getJSONObject(i);
				Participant participant= new Participant(jsonObject.getString("userID"));
				participants.add(participant);
			}
			return participants;
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}

	public boolean deleteEvent(String eventID){

		String result=null;
		try{
			result=httpUtil.doGet(SithAPI.DELETE_EVENT+"?eventID="+eventID);
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

}
