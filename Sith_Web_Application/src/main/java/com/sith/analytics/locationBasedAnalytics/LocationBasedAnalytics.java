package com.sith.analytics.locationBasedAnalytics;

import com.sith.SithAPI;
import com.sith.util.HTTPUtil;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;

public class LocationBasedAnalytics {

    HTTPUtil httpUtil=new HTTPUtil();
    private ArrayList<LocationData> happyCount;
    private ArrayList<LocationData> sadCount;
    private ArrayList<LocationData> neutralCount;
    private ArrayList<LocationData> horribleCount;
    private ArrayList<LocationData> excitingCount;

    public ArrayList<LocationData> getPerceptionCount(String perception, String timeLevel, String latmin,String longmin,String latmax, String longmax){
        ArrayList<LocationData> locationData =null;

        String result=null;
        try{
            result=httpUtil.doGet(SithAPI.GET_ALL_MAP_DATA+"?emotion="+perception+"&timelevel="
                    +timeLevel+"&latmin="+latmin+"&lngmin="+longmin+"&latmax="+latmax+"&lngmx="+longmax);
            JSONArray jsonArray=new JSONArray(result);
            locationData =new ArrayList<LocationData>();
            for(int i=0;i<jsonArray.length();i++){
                JSONObject jsonObject=jsonArray.getJSONObject(i);
                LocationData perceptionOnLoc = new LocationData(perception,
                        jsonObject.getString("lat"),jsonObject.getString("lo"), Integer.parseInt(jsonObject.getString("count")));
                locationData.add(perceptionOnLoc);
            }
            return locationData;
        }catch(Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<LocationData> getPieChartPerceptionCount(String perception, String latmin,String longmin,String latmax, String longmax){
        ArrayList<LocationData> locationData =null;
        String result=null;
        try{
            result=httpUtil.doGet(SithAPI.GET_ALL_CURRENT_EVENT_MAP_DATA+"?emotion="+perception);
            JSONArray jsonArray=new JSONArray(result);
            locationData =new ArrayList<LocationData>();
            for(int i=0;i<jsonArray.length();i++){
                JSONObject jsonObject=jsonArray.getJSONObject(i);
                LocationData perceptionOnLoc = new LocationData();
                perceptionOnLoc.setEvent(jsonObject.getString("subid"));
                perceptionOnLoc.setLatitude(jsonObject.getString("lat"));
                perceptionOnLoc.setLongitude(jsonObject.getString("lo"));
                perceptionOnLoc.setPerceptionCount(Integer.parseInt(jsonObject.getString("count")));
                perceptionOnLoc.setPerception(perception);
                perceptionOnLoc.setPerception(jsonObject.getString("location"));
            }
            return locationData;
        }catch(Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<LocationData> getHappyCount(String latmin,String longmin,String latmax, String longmax) {
        return getPerceptionCount("happy","0",latmin,longmin,latmax,longmax);
    }
    public ArrayList<LocationData> getSadCount(String latmin,String longmin,String latmax, String longmax) {
        return getPerceptionCount("sad","0",latmin,longmin,latmax,longmax);
    }
    public ArrayList<LocationData> getNeutralCount(String latmin,String longmin,String latmax, String longmax) {
        return getPerceptionCount("neutral","0",latmin,longmin,latmax,longmax);
    }
    public ArrayList<LocationData> getHorribleCount(String latmin,String longmin,String latmax, String longmax) {
        return getPerceptionCount("horrible","0",latmin,longmin,latmax,longmax);
    }
    public ArrayList<LocationData> getExcitingCount(String latmin,String longmin,String latmax, String longmax) {
        return getPerceptionCount("exciting","0",latmin,longmin,latmax,longmax);
    }

    public ArrayList<LocationData> getPieChartHappyCount(String latmin,String longmin,String latmax, String longmax) {
        return getPieChartPerceptionCount("happy",latmin,longmin,latmax,longmax);
    }
    public ArrayList<LocationData> getPieChartSadCount(String latmin,String longmin,String latmax, String longmax) {
        return getPieChartPerceptionCount("sad",latmin,longmin,latmax,longmax);
    }
    public ArrayList<LocationData> getPieChartNeutralCount(String latmin,String longmin,String latmax, String longmax) {
        return getPieChartPerceptionCount("neutral",latmin,longmin,latmax,longmax);
    }
    public ArrayList<LocationData> getPieChartHorribleCount(String latmin,String longmin,String latmax, String longmax) {
        return getPieChartPerceptionCount("horrible",latmin,longmin,latmax,longmax);
    }
    public ArrayList<LocationData> getPieChartExcitingCount(String latmin,String longmin,String latmax, String longmax) {
        return getPieChartPerceptionCount("exciting",latmin,longmin,latmax,longmax);
    }

    public HashMap<String,PerceptionsOnLocation>  getPerceptionsOnLocation(String latmin,String longmin,String latmax, String longmax){
        HashMap<String,PerceptionsOnLocation> locationListMap = new HashMap<String, PerceptionsOnLocation>();
        for(LocationData p:getPieChartHappyCount(latmin,longmin,latmax,longmax)){
            String key = p.getEvent();

            if(locationListMap.containsKey(key)){
                int newCount = 0;
                PerceptionsOnLocation existingData = locationListMap.get(key);
                newCount = existingData.getHappyCount()+ p.getPerceptionCount();
                existingData.setHappyCount(newCount);
                locationListMap.put(key, existingData);
            }else {
                PerceptionsOnLocation newData = new PerceptionsOnLocation();
                newData.setHappyCount(p.getPerceptionCount());
                newData.setLatitude(p.getLatitude());
                newData.setLongitude(p.getLongitude());
                locationListMap.put(key,newData);
            }
        }
        for(LocationData p:getPieChartSadCount(latmin,longmin,latmax,longmax)){
            String key = p.getEvent();

            if(locationListMap.containsKey(key)){
                int newCount = 0;
                PerceptionsOnLocation existingData = locationListMap.get(key);
                newCount = existingData.getSadCount()+ p.getPerceptionCount();
                existingData.setSadCount(newCount);
                locationListMap.put(key, existingData);
            }else {
                PerceptionsOnLocation newData = new PerceptionsOnLocation();
                newData.setSadCount(p.getPerceptionCount());
                locationListMap.put(key,newData);
            }
        }
        for(LocationData p:getPieChartHorribleCount(latmin,longmin,latmax,longmax)){
            String key = p.getEvent();

            if(locationListMap.containsKey(key)){
                int newCount = 0;
                PerceptionsOnLocation existingData = locationListMap.get(key);
                newCount = existingData.getHorribleCount()+ p.getPerceptionCount();
                existingData.setHorribleCount(newCount);
                locationListMap.put(key, existingData);
            }else {
                PerceptionsOnLocation newData = new PerceptionsOnLocation();
                newData.setHorribleCount(p.getPerceptionCount());
                locationListMap.put(key,newData);
            }
        }
        for(LocationData p:getPieChartExcitingCount(latmin,longmin,latmax,longmax)){
            String key = p.getEvent();

            if(locationListMap.containsKey(key)){
                int newCount = 0;
                PerceptionsOnLocation existingData = locationListMap.get(key);
                newCount = existingData.getExcitedCount()+ p.getPerceptionCount();
                existingData.setExcitedCount(newCount);
                locationListMap.put(key, existingData);
            }else {
                PerceptionsOnLocation newData = new PerceptionsOnLocation();
                newData.setExcitedCount(p.getPerceptionCount());
                locationListMap.put(key,newData);
            }
        }
        for(LocationData p:getPieChartNeutralCount(latmin,longmin,latmax,longmax)){
            String key = p.getEvent();

            if(locationListMap.containsKey(key)){
                int newCount = 0;
                PerceptionsOnLocation existingData = locationListMap.get(key);
                newCount = existingData.getNeutralCount()+ p.getPerceptionCount();
                existingData.setNeutralCount(newCount);
                locationListMap.put(key, existingData);
            }else {
                PerceptionsOnLocation newData = new PerceptionsOnLocation();
                newData.setNeutralCount(p.getPerceptionCount());
                locationListMap.put(key,newData);
            }
        }
        return locationListMap;
    }

}
