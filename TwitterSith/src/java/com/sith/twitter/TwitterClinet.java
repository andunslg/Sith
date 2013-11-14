/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sith.twitter;

import java.util.TimerTask;
import java.util.concurrent.ExecutorService;
import java.util.logging.Level;
import java.util.logging.Logger;
import twitter4j.FilterQuery;
import twitter4j.TwitterStream;
import twitter4j.TwitterStreamFactory;
import twitter4j.conf.ConfigurationBuilder;

/**
 *
 * @author Prabhath
 */
public class TwitterClinet extends TimerTask{
    

    private String id;
    private String topic;
    private String perceptionSchema;
    private ExecutorService executor;
    private TwitterStream twitterStream;
    private long duration;

    public TwitterClinet(long duration, String id, String topic,String perceptionSchema,ExecutorService executor) {
        this.duration=duration;
        this.id=id;
        this.topic=topic;
        this.perceptionSchema=perceptionSchema;
        this.executor=executor;
    }

    @Override
    public void run() {
        initStreamListner(); 
        try {
            Thread.sleep(1000);
        } catch (InterruptedException ex) {
            Logger.getLogger(TwitterClinet.class.getName()).log(Level.SEVERE, null, ex);
        }
        twitterStream.shutdown();
    }

    private void initStreamListner() {
        
        
        
        ConfigurationBuilder cb = new ConfigurationBuilder();
        cb.setDebugEnabled(true);
        cb.setOAuthConsumerKey("Z7EZAnIwboh80BJluvoqtA");
        cb.setOAuthConsumerSecret("5llFlzzBNALD4INOQ3Vi5VJlOHK72OZoFgLXhltGo");
        cb.setOAuthAccessToken("1516794607-8YV7qHDmQh1nzW6UvIyD8cYt2PfCEL2KmKy5v1j");
        cb.setOAuthAccessTokenSecret("zbuGzCDRq04hBNKo1sucCY5gPFWZxL1aj35JWKl8fA");

        twitterStream = new TwitterStreamFactory(cb.build()).getInstance();
        


        FilterQuery fq = new FilterQuery();
    
        String keywords[] = {topic};

        fq.track(keywords);

        
        twitterStream.addListener(new AdvancedListner(id,executor,perceptionSchema));
        twitterStream.filter(fq);
        
        
    }
    
}
