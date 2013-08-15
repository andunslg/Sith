package com.sith.analytics.locationBasedAnalytics;

public class PerceptionsOnLocation {
    private String latitude;
    private String longitude;
    private int happyCount;
    private int neutralCount;
    private int sadCount;
    private int horribleCount;
    private int excitedCount;
    private String eventName;
    private String eventLocationName;

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public String getEventLocationName() {
        return eventLocationName;
    }

    public void setEventLocationName(String eventLocationName) {
        this.eventLocationName = eventLocationName;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }


    public int getHappyCount() {
        return happyCount;
    }

    public void setHappyCount(int happyCount) {
        this.happyCount = happyCount;
    }

    public int getNeutralCount() {
        return neutralCount;
    }

    public void setNeutralCount(int neutralCount) {
        this.neutralCount = neutralCount;
    }

    public int getSadCount() {
        return sadCount;
    }

    public void setSadCount(int sadCount) {
        this.sadCount = sadCount;
    }

    public int getHorribleCount() {
        return horribleCount;
    }

    public void setHorribleCount(int horribleCount) {
        this.horribleCount = horribleCount;
    }

    public int getExcitedCount() {
        return excitedCount;
    }

    public void setExcitedCount(int excitedCount) {
        this.excitedCount = excitedCount;
    }
}
