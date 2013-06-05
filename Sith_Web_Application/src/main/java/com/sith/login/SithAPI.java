package com.sith.login;

import com.sith.model.Participant;

import java.util.ArrayList;
import java.util.List;

public class SithAPI {

    public static String LOGIN="http://192.248.8.246:3000/authenticateUser";
    public static String SIGNUP="http://192.248.8.246:3000/registerAnnonymousUser";

    public List<String> getComments(String eventID){

        ArrayList<String> list=new ArrayList<String>();
        list.add("Prabhath::this is cool");
        return list;

    }

    public List<Participant> getParticipants(String eventID){
         ArrayList<Participant> participants=new ArrayList<Participant>();

        participants.add(new Participant("Prabhath","2.35PM","Happy"));

        return participants;
    }


}
