package com.sith.Analytics.LocationBasedAnalytics;

import com.sith.SithAPI;
import com.sith.event.Participant;
import com.sith.util.HTTPUtil;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

public class LocationBasedAnalytics {

    HTTPUtil httpUtil=new HTTPUtil();
    private ArrayList<LocationData> happyCount;
    private ArrayList<LocationData> sadCount;
    private ArrayList<LocationData> neutralCount;
    private ArrayList<LocationData> horribleCount;
    private ArrayList<LocationData> excitingCount;

    public ArrayList<LocationData> getPerceptionCount(String perception, String timeLevel){
        ArrayList<LocationData> locationDatas =null;

        String result=null;
        try{
            result=httpUtil.doGet(SithAPI.GET_ALL_MAP_DATA+"?emotion="+perception+"&timelevel="+timeLevel);
            JSONArray jsonArray=new JSONArray(result);
            locationDatas =new ArrayList<LocationData>();
            for(int i=0;i<jsonArray.length();i++){
                JSONObject jsonObject=jsonArray.getJSONObject(i);
                Participant participant= new Participant(jsonObject.getString("userID"));
                LocationData perceptionOnLoc = new LocationData(perception,jsonObject.getString("lo"),
                        jsonObject.getString("lat"), Integer.parseInt(jsonObject.getString("count")));
                locationDatas.add(perceptionOnLoc);
            }
            return locationDatas;
        }catch(Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<LocationData> getHappyCount() {
        ArrayList<LocationData> t= new ArrayList<LocationData>();

        for(int i=0;i<10;i++){
            Random r = new Random();
            String latitude = String.valueOf(6.8111 + (7.1234 - 6.8111) * r.nextDouble());
            String longitude = String.valueOf(79.33 + (80.11 - 79.33) * r.nextDouble());
            int rm = Math.abs(r.nextInt(100));
            for(int j=1;j<=rm;j++){
                LocationData p = new LocationData(latitude,longitude);

                t.add(p);
            }

        }
        return t;

//        return getPerceptionCount("happy","1");
    }

    public ArrayList<LocationData> getPieChartHappy() {
        ArrayList<LocationData> t= new ArrayList<LocationData>();

        for(int i=0;i<10;i++){
            Random r = new Random();
            String latitude = String.valueOf(6.8111 + (7.1234 - 6.8111) * r.nextDouble());
            String longitude = String.valueOf(79.33 + (80.11 - 79.33) * r.nextDouble());
            int rm = Math.abs(r.nextInt(100));
            LocationData p = new LocationData(latitude,longitude);
            p.setPerceptionCount(rm);
            t.add(p);
        }
        return t;

//        return getPerceptionCount("happy","1");
    }

    public ArrayList<LocationData> getSadCount() {
        ArrayList<LocationData> t= new ArrayList<LocationData>();

        for(int i=0;i<10;i++){
            Random r = new Random();
            String latitude = String.valueOf(6.9111 + (7.3 - 6.9111) * r.nextDouble());
            String longitude = String.valueOf(79.4 + (81.11 - 79.4) * r.nextDouble());
            int rm = Math.abs(r.nextInt(100));
            for(int j=1;j<rm;j++){
                LocationData p = new LocationData(latitude,longitude);
                t.add(p);
            }

        }
        return t;
//        return getPerceptionCount("sad","1");
    }

    public ArrayList<LocationData> getPieChartSad() {
        ArrayList<LocationData> t= new ArrayList<LocationData>();

        for(int i=0;i<10;i++){
            Random r = new Random();
            String latitude = String.valueOf(6.9111 + (7.3 - 6.9111) * r.nextDouble());
            String longitude = String.valueOf(79.4 + (81.11 - 79.4) * r.nextDouble());
            int rm = Math.abs(r.nextInt(100));
            LocationData p = new LocationData(latitude,longitude);
            p.setPerceptionCount(rm);
            t.add(p);

        }
        return t;
//        return getPerceptionCount("sad","1");
    }

    public ArrayList<LocationData> getNeutralCount() {
        ArrayList<LocationData> t= new ArrayList<LocationData>();

        for(int i=0;i<10;i++){
            Random r = new Random();
            String latitude = String.valueOf(7.1 + (7.5 - 7.1) * r.nextDouble());
            String longitude = String.valueOf(80.7 + (82.7 - 79.33) * r.nextDouble());
            int rm = Math.abs(r.nextInt(100));
            for(int j=1;j<rm;j++){
                LocationData p = new LocationData(latitude,longitude);
                t.add(p);
            }

        }
        return t;
//        return getPerceptionCount("neutral","1");
    }

    public ArrayList<LocationData> getPieChartNeutral() {
        ArrayList<LocationData> t= new ArrayList<LocationData>();

        for(int i=0;i<10;i++){
            Random r = new Random();
            String latitude = String.valueOf(7.1 + (7.5 - 7.1) * r.nextDouble());
            String longitude = String.valueOf(80.7 + (82.7 - 79.33) * r.nextDouble());
            int rm = Math.abs(r.nextInt(100));
            LocationData p = new LocationData(latitude,longitude);
            p.setPerceptionCount(rm);
            t.add(p);

        }
        return t;
//        return getPerceptionCount("neutral","1");
    }

    public ArrayList<LocationData> getHorribleCount() {
        ArrayList<LocationData> t= new ArrayList<LocationData>();

        for(int i=0;i<10;i++){
            Random r = new Random();
            String latitude = String.valueOf(6.8111 + (7.1234 - 6.8111) * r.nextDouble());
            String longitude = String.valueOf(79.33 + (80.11 - 79.33) * r.nextDouble());
            int rm = Math.abs(r.nextInt(100));
            for(int j=1;j<rm;j++){
                LocationData p = new LocationData(latitude,longitude);
                t.add(p);
            }

        }
        return t;
//        return getPerceptionCount("horrible","1");
    }
    public ArrayList<LocationData> getPieChartHorrible() {
        ArrayList<LocationData> t= new ArrayList<LocationData>();

        for(int i=0;i<10;i++){
            Random r = new Random();
            String latitude = String.valueOf(6.8111 + (7.1234 - 6.8111) * r.nextDouble());
            String longitude = String.valueOf(79.33 + (80.11 - 79.33) * r.nextDouble());
            int rm = Math.abs(r.nextInt(100));
            LocationData p = new LocationData(latitude,longitude);
            p.setPerceptionCount(rm);
            t.add(p);
        }
        return t;
//        return getPerceptionCount("horrible","1");
    }

    public ArrayList<LocationData> getExcitingCount() {
        ArrayList<LocationData> t= new ArrayList<LocationData>();

        for(int i=0;i<10;i++){
            Random r = new Random();
            String latitude = String.valueOf(6.9 + (7.1234 - 6.9) * r.nextDouble());
            String longitude = String.valueOf(78.5 + (81.11 - 79.1) * r.nextDouble());
            int rm = Math.abs(r.nextInt(100));
            for(int j=1;j<rm;j++){
                LocationData p = new LocationData(latitude,longitude);
                t.add(p);
            }

        }
        return t;
//        return getPerceptionCount("exciting","1");
    }
    public ArrayList<LocationData> getPieChartExciting() {
        ArrayList<LocationData> t= new ArrayList<LocationData>();

        for(int i=0;i<10;i++){
            Random r = new Random();
            String latitude = String.valueOf(6.9 + (7.1234 - 6.9) * r.nextDouble());
            String longitude = String.valueOf(78.5 + (81.11 - 79.1) * r.nextDouble());
            int rm = Math.abs(r.nextInt(100));
            LocationData p = new LocationData(latitude,longitude);
            p.setPerceptionCount(rm);
            t.add(p);

        }
        return t;
//        return getPerceptionCount("exciting","1");
    }

    public HashMap<String,PerceptionsOnLocation>  getPerceptionsOnLocation(){
        HashMap<String,PerceptionsOnLocation> locationListMap = new HashMap<String, PerceptionsOnLocation>();
        for(LocationData p:getPieChartHappy()){
            String key = p.getLongitude()+"/"+p.getLatitude();

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
        for(LocationData p:getPieChartSad()){
            String key = p.getLongitude()+"/"+p.getLatitude();

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
        for(LocationData p:getPieChartHorrible()){
            String key = p.getLongitude()+"/"+p.getLatitude();

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
        for(LocationData p:getPieChartExciting()){
            String key = p.getLongitude()+"/"+p.getLatitude();

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
        for(LocationData p:getPieChartNeutral()){
            String key = p.getLongitude()+"/"+p.getLatitude();

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
