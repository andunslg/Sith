package com.sith.login;

import java.util.HashMap;
import java.util.Map;

public class Authenticator {

    HTTPUtil httpUtil=new HTTPUtil();

    public boolean addUser(String userName,String password) throws Exception{
        Map<String,String> map=new HashMap<String,String>();
        map.put("userName",userName);
        map.put("password",password);
        String result=httpUtil.doPost(SithAPI.SIGNUP,map);
        System.out.println(result);
        return true;
    }


    public boolean authenticateUser(String userName,String password) throws Exception{
        Map<String,String> map=new HashMap<String,String>();
        map.put("userName",userName);
        map.put("password",password);
        String result=httpUtil.doPost(SithAPI.LOGIN,map);
        System.out.println(result);
        return true;
    }
}
