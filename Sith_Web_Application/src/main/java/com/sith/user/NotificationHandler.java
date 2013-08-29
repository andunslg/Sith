package com.sith.user;
import com.sith.SithAPI;
import com.sith.util.HTTPUtil;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * Created with IntelliJ IDEA.
 * User: Sachintha
 * Date: 8/19/13
 * Time: 10:59 PM
 * To change this template use File | Settings | File Templates.
 */
public class NotificationHandler {
   HTTPUtil httpUtil = new HTTPUtil();

   public JSONArray getAllNotifications(String userID){
     //  ArrayList<String> notifs=null;
       String result = "";
       try {
           result = httpUtil.doGet(SithAPI.GET_NOTIFICATIONS+"?userID="+userID+"&status=pending");
           JSONArray notifs=new JSONArray(result);
//           notifs = new ArrayList<String>();
//           for (int i=0;i<jsonArray.length();i++){
//               JSONObject obj = jsonArray.getJSONObject(i);
//               notifs.add(obj.getString("text"));
//           }
           return notifs;
       } catch (Exception e) {
           e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
       }
       return null;
   }
}
