package com.sith.analytics.locationBasedAnalytics;

import com.sith.SithAPI;
import com.sith.util.HTTPUtil;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

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


    public ArrayList<LocationData> getSelfAnalytics(String userID,String perception){
        ArrayList<LocationData> locationData =null;
        String result=null;
        try{
            result=httpUtil.doGet(SithAPI.GET_SELF_MAP+"?userID="+userID+"&emotion="+perception);
            JSONArray jsonArray=new JSONArray(result);
            locationData =new ArrayList<LocationData>();
            for(int i=0;i<jsonArray.length();i++){
                JSONObject jsonObject=jsonArray.getJSONObject(i);
                LocationData perceptionOnLoc = new LocationData();
                perceptionOnLoc.setLatitude(jsonObject.getString("lat"));
                perceptionOnLoc.setLongitude(jsonObject.getString("lo"));
                perceptionOnLoc.setPerceptionCount(Integer.parseInt(jsonObject.getString("count")));
                locationData.add(perceptionOnLoc);
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
}
