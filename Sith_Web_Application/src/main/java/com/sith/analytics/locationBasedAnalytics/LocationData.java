package com.sith.analytics.locationBasedAnalytics;

public class LocationData {
    private String longitude;
    private String latitude;
    private String perception;
    private int perceptionCount;
    private String event;
    private String locationName;

    public String getLocationName() {
        return locationName;
    }

    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }

    public LocationData(String perception, String longitude, String latitude, int perceptionCount) {
        this.perception = perception;
        this.longitude = longitude;
        this.latitude = latitude;
        this.perceptionCount = perceptionCount;
    }
    public LocationData(String longitude, String latitude) {
        this.longitude = longitude;
        this.latitude = latitude;
    }

    public String getEvent() {
        return event;
    }

    public void setEvent(String event) {
        this.event = event;
    }

    public LocationData(){

    }
    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public String getPerception() {
        return perception;
    }

    public void setPerception(String perception) {
        this.perception = perception;
    }

    public int getPerceptionCount() {
        return perceptionCount;
    }

    public void setPerceptionCount(int perceptionCount) {
        this.perceptionCount = perceptionCount;
    }
}
