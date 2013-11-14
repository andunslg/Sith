package com.sith.twitter;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Prabhath
 */
public class SithAPI {
     
    public static String SEND_PERCEPTION="http://192.248.15.232:3000/publishEventPerception/";;
    
    public static String getViralHeatURI(String text){
        try {
            String s="http://www.viralheat.com/api/sentiment/review.json?api_key=5lnl8tp0BFBkNFUjit8&text="+URLEncoder.encode(text, "ISO-8859-1"); 
            return s;
        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(SithAPI.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
