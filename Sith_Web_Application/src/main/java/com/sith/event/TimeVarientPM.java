package com.sith.event;

/**
 * Created with IntelliJ IDEA.
 * User: Prabhath
 * Date: 10/1/13
 * Time: 2:37 PM
 * To change this template use File | Settings | File Templates.
 */
public class TimeVarientPM {

    private String name;
    private String value;
    private long timeStamp;

    public TimeVarientPM(String name, String value, long timeStamp) {
        this.name = name;
        this.value = value;
        this.timeStamp = timeStamp;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public long getTimeStamp() {
        return timeStamp;
    }

    public void setTimeStamp(long timeStamp) {
        this.timeStamp = timeStamp;
    }
}
