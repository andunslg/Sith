package com.sith.login;

import com.sith.SithAPI;
import com.sith.util.HTTPUtil;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

public class Authenticator{

	HTTPUtil httpUtil=new HTTPUtil();

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


	public boolean authenticateUser(String userName, String password) throws Exception{
		Map<String,String> map=new HashMap<String,String>();
		map.put("userName",userName);
		map.put("password",password);
		String result=httpUtil.doPost(SithAPI.LOGIN,map);
		if(!result.equals("")){
			JSONObject jsonObject=new JSONObject(result);
			Boolean name=(Boolean)jsonObject.get("result");
			return name;
		}
		return false;
	}
}
