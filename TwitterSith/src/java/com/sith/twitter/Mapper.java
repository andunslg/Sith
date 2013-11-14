
package com.sith.twitter;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 *
 * @author Prabhath
 */
public class Mapper {
    
 
    private JSONParser jSONParser;
    
    private List<String> positiveCorpus=new ArrayList<String>();
    private List<String> negativeCorpus=new ArrayList<String>();
    
    private static Mapper mapper=new Mapper();
    

    private Mapper() {
          
        jSONParser=new JSONParser();
        
        String csvFile = "positive.csv";
	BufferedReader br = null;
	String line = "";
	String cvsSplitBy = ",";
 
	try {
 
		br = new BufferedReader(new InputStreamReader(Mapper.class.getResourceAsStream("positive.csv")));
		while ((line = br.readLine()) != null) { 
		        // use comma as separator
			String[] country = line.split(cvsSplitBy);
 
			for(String s:country){
                            if(!s.equals("")){
                               positiveCorpus.add(s.toLowerCase()); 
                            }
                        }
		}
 
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (br != null) {
			try {
				br.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
        
        
        
        csvFile = "negative.csv";
	br = null;
	line = "";
	cvsSplitBy = ","; 
	try { 
		br = new BufferedReader(new InputStreamReader(Mapper.class.getResourceAsStream("positive.csv")));
		while ((line = br.readLine()) != null) {
 
		        // use comma as separator
			String[] country = line.split(cvsSplitBy);
 
			for(String s:country){
                            if(!s.equals("")){
                               negativeCorpus.add(s.toLowerCase()); 
                            }
                        }
		}
 
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (br != null) {
			try {
				br.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
        
    }
    
    /*
     * Singleton method
     */
     public static Mapper getInstance( ) {
      return mapper;
     }
    
    public String getPerceptionValue(String jsonString,String schema){
        String toReturn=null;
        String[] perceptionSchema=schema.split(":");
        try {
            Object o=jSONParser.parse(jsonString);
            JSONObject jSONObject=(JSONObject)o;
            String category=(String) jSONObject.get("mood");
//            String probability=(String)jSONObject.get("prob");
            
            if(category.equalsIgnoreCase("neutral")){
                toReturn=perceptionSchema[1];
            }else if(category.equalsIgnoreCase("positive")){
                toReturn=perceptionSchema[0];
            }else{
                toReturn=perceptionSchema[2];
            }
         
        } catch (ParseException ex) {
            Logger.getLogger(Mapper.class.getName()).log(Level.SEVERE, null, ex);
        }
        System.out.println(toReturn);
        return toReturn;
    }
    
    public String getPolarity(String s,String schema){
        String[] perceptionSchema=schema.split(":");
        String[] tokens=s.split(" ");
        int value=0;
        
        for(String t:tokens){
            if(t.length()<=2){
                continue;
            }
            if(positiveCorpus.contains(t)){
                value++;
            }else if(negativeCorpus.contains(t)){
                value--;
            }
        }
        
        if(value>0){
            return perceptionSchema[0];
        }else if(value==0){
            return perceptionSchema[1];
        }
        return perceptionSchema[2];
    }
    
    
    
}
