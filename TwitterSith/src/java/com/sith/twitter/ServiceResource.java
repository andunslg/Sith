/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sith.twitter;

import java.text.ParseException;
import java.util.Timer;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.Path;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Produces;

/**
 * REST Web Service
 *
 * @author Prabhath
 */
@Path("service")
public class ServiceResource {
    
    ExecutorService executor = Executors.newFixedThreadPool(100);
    
    

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of ServiceResource
     */
    public ServiceResource() {
    }

    /**
     * Retrieves representation of an instance of com.sith.twitter.ServiceResource
     * @return an instance of java.lang.String
     */
    @GET
    @Produces("text/html")
    public String getXml() {
        //TODO return proper representation object
        return "<h1>Get some REST!<\\h1>";
    }

 
    
    @POST
    @Consumes("application/x-www-form-urlencoded")
    @Produces("text/plain")
    public String postHandler(@FormParam("topic") String topic,@FormParam("start") String start,@FormParam("end") String end,@FormParam("id") String id,@FormParam("schema") String perceptionSchema) {
      
        Timer t1=new Timer();
        try {
            long duration=Util.getTimeInMillies(end)-Util.getTimeInMillies(start);
            t1.schedule(new TwitterClinet(duration, id, topic,perceptionSchema,executor), Util.getDate(start));
        } catch (ParseException ex) {
            Logger.getLogger(ServiceResource.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "true";
    }
}
