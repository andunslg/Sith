package com.sith.user;
import com.sith.SithAPI;
import com.sith.util.HTTPUtil;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Sachintha
 * Date: 8/19/13
 * Time: 10:59 PM
 * To change this template use File | Settings | File Templates.
 */
public class UserNewsHandler {
    HTTPUtil httpUtil = new HTTPUtil();

    public JSONArray getUserNews(String userID){
        Map<String,String> map=new HashMap<String,String>();
        map.put("userID",userID);
        String result = "";
        try {
            result = httpUtil.doPost(SithAPI.GET_USER_NEWS,map);
            JSONArray news=new JSONArray(result);
            return news;
        } catch (Exception e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        return null;
    }
}
