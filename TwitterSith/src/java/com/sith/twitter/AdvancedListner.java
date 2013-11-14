
package com.sith.twitter;

import java.util.concurrent.ExecutorService;
import twitter4j.StallWarning;
import twitter4j.Status;
import twitter4j.StatusDeletionNotice;
import twitter4j.StatusListener;
import twitter4j.User;

/**
 *
 * @author Prabhath
 */
public class AdvancedListner implements StatusListener {

    private String id;
    private ExecutorService executor ;
    private String schema;


    public AdvancedListner(String id,ExecutorService executor,String perceptionSchema) {
        this.id = id;
        this.executor=executor;
        this.schema=perceptionSchema;
    }

    @Override
    public void onException(Exception arg0) {
        // TODO Auto-generated method stub
    }

    @Override
    public void onDeletionNotice(StatusDeletionNotice arg0) {
        // TODO Auto-generated method stub
    }

    @Override
    public void onScrubGeo(long arg0, long arg1) {
        // TODO Auto-generated method stub
    }

    @Override
    public void onStatus(Status status) {
        User user = status.getUser();

        // gets Username
        String username = status.getUser().getScreenName();
        System.out.println(username);
        String profileLocation = user.getLocation();
        System.out.println(profileLocation);
        long tweetId = status.getId();
        System.out.println(tweetId);
        String content = status.getText();
        System.out.println(content + "\n");

        executor.execute(new Worker(username, id, content,schema));
      

    }

    @Override
    public void onTrackLimitationNotice(int arg0) {
        // TODO Auto-generated method stub
    }

    @Override
    public void onStallWarning(StallWarning sw) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}
