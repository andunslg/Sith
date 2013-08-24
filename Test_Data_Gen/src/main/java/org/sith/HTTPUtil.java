package org.sith;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;


public class HTTPUtil{

	public String doGet(String url) throws Exception{
		HttpClient client=new DefaultHttpClient();
		HttpGet request=new HttpGet(url);
		HttpResponse response=client.execute(request);

		BufferedReader rd=new BufferedReader
				(new InputStreamReader(response.getEntity().getContent()));

		String line="";
		String s="";
		while((line=rd.readLine())!=null){
			s+=line;
		}
		return s;
	}

	public String doPost(String url, Map<String,String> values) throws Exception{
		HttpClient client=new DefaultHttpClient();
		HttpPost post=new HttpPost(url);

		List<NameValuePair> nameValuePairs=new ArrayList<NameValuePair>();
		Iterator<String> i=values.keySet().iterator();
		String temp=null;
		while(i.hasNext()){
			temp=i.next();
			nameValuePairs.add(new BasicNameValuePair(temp,
					values.get(temp)));
		}

		post.setEntity(new UrlEncodedFormEntity(nameValuePairs));

		HttpResponse response=client.execute(post);
		BufferedReader rd=new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
		String line="";
		String s="";
		while((line=rd.readLine())!=null){
			s+=line;
		}
		return s;
	}

	public String doPut(String url, Map<String,String> values) throws Exception{
		HttpClient client=new DefaultHttpClient();
		HttpPut put=new HttpPut(url);

		List<NameValuePair> nameValuePairs=new ArrayList<NameValuePair>();
		Iterator<String> i=values.keySet().iterator();
		String temp=null;
		while(i.hasNext()){
			temp=i.next();
			nameValuePairs.add(new BasicNameValuePair(temp,
					values.get(temp)));
		}

		put.setEntity(new UrlEncodedFormEntity(nameValuePairs));

		HttpResponse response=client.execute(put);
		BufferedReader rd=new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
		String line="";
		String s="";
		while((line=rd.readLine())!=null){
			s+=line;
		}
		return s;
	}

}
