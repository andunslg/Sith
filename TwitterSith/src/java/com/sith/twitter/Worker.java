/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sith.twitter;

import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Prabhath
 */
public class Worker implements Runnable {

    private String userName;
    private String id;
    private String content;
    private String perceptionSchema;

    public Worker(String userName, String id, String content,String perceptionSchema) {
        this.userName = userName;
        this.id = id;
        this.content = content;
        this.perceptionSchema=perceptionSchema;
    }

    @Override
    public void run() {
        try {


//                    jsonString=StihHTTPClient.doGet(SithAPI.getViralHeatURI(content));
//                
//                Mapper mapper=new Mapper(perceptionSchema);
//                String perceptionValue=mapper.getPerceptionValue(jsonString);
            //TODO remove
            
            Mapper mapper=Mapper.getInstance();

            String perceptionValue = mapper.getPolarity(content,perceptionSchema);

            Map<String, String> map = new HashMap<String, String>();
            map.put("userID", userName);
            map.put("eventID", id);
            map.put("perceptionValue", perceptionValue);


            StihHTTPClient.doPost(SithAPI.SEND_PERCEPTION, map);
        } catch (Exception ex) {
            Logger.getLogger(TwitterClinet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
}
