package com.sith.analytics.locationBasedAnalytics;

public class PerceptionsOnLocation {
    private String latitude;
    private String longitude;
    private int happyCount;
    private int neutralCount;
    private int sadCount;
    private int horribleCount;
    private int excitedCount;

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
