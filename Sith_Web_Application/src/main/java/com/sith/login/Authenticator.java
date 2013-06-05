package com.sith.login;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import java.util.HashMap;
import java.util.Map;

public class Authenticator {

    HTTPUtil httpUtil=new HTTPUtil();
    JSONParser parser = new JSONParser();

    public boolean addUser(String userName,String password) throws Exception{
        Map<String,String> map=new HashMap<String,String>();
        map.put("userName",userName);
        map.put("password",password);
        String result=httpUtil.doPost(SithAPI.SIGNUP,map);
        if(!result.equals("")){
            Object o= parser.parse(result);
            JSONObject jsonObject = (JSONObject) o;
            Boolean name = (Boolean) jsonObject.get("result");
            return name;
        }
        return false;
    }


    public boolean authenticateUser(String userName,String password) throws Exception{
        Map<String,String> map=new HashMap<String,String>();
        map.put("userName",userName);
        map.put("password",password);
        String result=httpUtil.doPost(SithAPI.LOGIN,map);
        if(!result.equals("")){
            Object o= parser.parse(result);
            JSONObject jsonObject = (JSONObject) o;
            Boolean name = (Boolean) jsonObject.get("result");
            return name;
        }
        return false;
    }
}
