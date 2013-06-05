package com.sith.model;

import java.security.PrivateKey;

public class Participant {
    private String name;
    private String time;
    private String mode;

    public String getMode() {
        return mode;
    }

    public Participant(String name, String time, String mode) {
        this.name = name;
        this.time = time;
        this.mode = mode;
    }

    public void setMode(String mode) {
        this.mode = mode;

    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }
}
