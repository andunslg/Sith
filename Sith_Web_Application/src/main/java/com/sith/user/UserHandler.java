package com.sith.user;

import com.sith.SithAPI;
import com.sith.event.Event;
import com.sith.event.EventHandler;
import com.sith.util.HTTPUtil;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class UserHandler{
	private HTTPUtil httpUtil=new HTTPUtil();
	private EventHandler eventHandler= new EventHandler();

	public boolean addUser(String userName, String password) throws Exception{
		Map<String,String> map=new HashMap<String,String>();
		map.put("userName",userName);
		map.put("password",password);
		String result=httpUtil.doPost(SithAPI.SIGNUP,map);
		if(!result.equals("")){
			JSONObject jsonObject=new JSONObject(result);
			Boolean name=(Boolean)jsonObject.get("result");
			return name;
		}
		return false;
	}

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

	public  boolean isUserIDAvailable(String userID){
		return true;
	}

	public boolean updateUser(String oldUserName,String newUserName, String password) throws Exception{
		Map<String,String> map=new HashMap<String,String>();
		map.put("oldUserName",oldUserName);
		map.put("userName",newUserName);
		map.put("password",password);
		String result=httpUtil.doPut(SithAPI.UPDATE_USER,map);
		if(!result.equals("")){
			JSONObject jsonObject=new JSONObject(result);
			Boolean name=(Boolean)jsonObject.get("result");
			return name;
		}
		return false;
	}

	public boolean deleteUser(String userName) throws Exception{

		String result=httpUtil.doGet(SithAPI.DELETE_USER+"?userName="+userName);
		if(!result.equals("")){
			JSONObject jsonObject=new JSONObject(result);
			Boolean name=(Boolean)jsonObject.get("result");
			return name;
		}
		return false;
	}


}
