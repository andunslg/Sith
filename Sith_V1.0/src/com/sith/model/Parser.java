package com.sith.model;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;



public class Parser {
	
	public static Subscription parseSubscription(String jsonString) throws JSONException {
	
		JSONObject jObject=null;
		if(jsonString.startsWith("[")){
			jObject = new JSONObject(jsonString.substring(1, jsonString.length()-1)); //To remove "[]"
		}else{
			jObject = new JSONObject(jsonString);
		}
		
		Event e=new Event();
		
		e.setSubscriptionID(jObject.getString("eventID"));
		e.setSubscriptionName(jObject.getString("eventName"));
		e.setStartTime(jObject.getString("startTime"));
		e.setEndTime(jObject.getString("endTime"));
		e.setLocation(jObject.getString("location"));
		e.setDescription(jObject.getString("description"));
		e.setMoods(Arrays.asList(jObject.getString("perceptionSchema").split(":")));
		e.setStartDate(jObject.getString("startDate"));
		e.setEndDate(jObject.getString("endDate"));
		return e;

	}
	
	public static Boolean parseResponse(String jsonString) throws JSONException{
		JSONObject jObject=null;
		if(jsonString.startsWith("[")){
			jObject = new JSONObject(jsonString.substring(1, jsonString.length()-1)); //To remove "[]"
		}else{
			jObject = new JSONObject(jsonString);
		}
		return new Boolean(jObject.getString("result"));
	}
	
	public static List<String> parseList(String jsonString,String attribute) throws JSONException{
		ArrayList<String> list=new ArrayList<String>();
		JSONArray resultSet=new JSONArray(jsonString);
		for(int i=0;i<resultSet.length();i++){
			list.add(resultSet.getJSONObject(i).getString(attribute));
		}
		return list;
		
	}

}
