package sith.login;

import sith.model.Participant;

import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Prabhath
 * Date: 6/5/13
 * Time: 12:04 AM
 * To change this template use File | Settings | File Templates.
 */
public class SithAPI {

    public static String LOGIN="";
    public static String SIGNUP="";

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
