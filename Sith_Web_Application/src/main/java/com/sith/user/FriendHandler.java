package com.sith.user;

import com.sith.SithAPI;
import com.sith.event.Event;
import com.sith.event.EventHandler;
import com.sith.util.HTTPUtil;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Prabhath
 * Date: 8/21/13
 * Time: 7:08 PM
 * To change this template use File | Settings | File Templates.
 */
public class FriendHandler {

    private HTTPUtil httpUtil=new HTTPUtil();
    private EventHandler eventHandler= new EventHandler();

    public List<String> search(String userID,String searchString){
        ArrayList<String> friends=null;
        String result=null;

        try{
            result=httpUtil.doGet(SithAPI.GET_FRIENDS_LIST+"?userID="+userID+"&query="+searchString);
            JSONArray jsonArray=new JSONArray(result);
            friends=new ArrayList<String>();
            for(int i=0;i<jsonArray.length();i++){
                JSONObject jsonObject=jsonArray.getJSONObject(i);
                String friendID=jsonObject.getString("userName");

                if(friendID!=null){
                    friends.add(friendID);
                }
                else {
                    //Remove events from registration list
                }
            }

            return friends;
        }catch(Exception e){
            e.printStackTrace();
        }
        return null;

    }

    public List<String> getAllFriends(String userID){
        ArrayList<String> friends=null;
        String result=null;

        try{
            result=httpUtil.doGet(SithAPI.GET_FRIENDS_LIST+"?userID="+userID);
            JSONArray jsonArray=new JSONArray(result);
            friends = new ArrayList<String>();
            for(int i=0;i<jsonArray.length();i++){
                JSONObject jsonObject=jsonArray.getJSONObject(i);
                String friendID=jsonObject.getString("userName");

                if(friendID!=null){
                    friends.add(friendID);
                }
                else {
                    //Remove events from registration list
                }
            }

            return friends;
        }catch(Exception e){
            e.printStackTrace();
        }
        return null;

    }

    public boolean removeFriend(String userID,String friendID){
        Map<String,String> map=new HashMap<String,String>();
        map.put("userID",userID);
        map.put("friendID",friendID);
        String result=null;
        try {
            result=httpUtil.doPost(SithAPI.REMOVE_FRIEND,map);
        }catch (Exception e){

        }
        //TODO
        return true;
    }

    public boolean addFriend(String userID,String friendID){
        Map<String,String> map=new HashMap<String,String>();
        map.put("userID",userID);
        map.put("friendID",friendID);
        String result=null;
        try {
            result=httpUtil.doPost(SithAPI.ADD_FRIEND,map);
        }catch (Exception e){

        }
        //TODO
        return true;
    }


}
