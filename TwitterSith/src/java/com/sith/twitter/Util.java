/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sith.twitter;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author Prabhath
 */
public class Util {
    
    public static Date getDate(String s) throws ParseException{
        String[] temp1=s.split(" ");
        String[] temp2=temp1[1].split(":");
        DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
        Date d=df.parse(temp1[0]);
        Calendar cal = Calendar.getInstance();
        cal.setTime(d);
        cal.set(Calendar.HOUR_OF_DAY,Integer.parseInt(temp2[0]));
        cal.set(Calendar.MINUTE, Integer.parseInt(temp2[1]));    
        return cal.getTime();
    }
    
    public static long getTimeInMillies(String s) throws ParseException{
        String[] temp1=s.split(" ");
        String[] temp2=temp1[1].split(":");
        DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
        Date d=df.parse(temp1[0]);
        Calendar cal = Calendar.getInstance();
        cal.setTime(d);
        cal.set(Calendar.HOUR_OF_DAY,Integer.parseInt(temp2[0]));
        cal.set(Calendar.MINUTE, Integer.parseInt(temp2[1]));    
        return cal.getTimeInMillis();
    }
    
}
