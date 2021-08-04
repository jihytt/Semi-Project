package com.pet.ft.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.pet.ft.model.BusinessDao;
import com.pet.ft.model.BusinessDaoImpl;

public class pet_sms {

	
	public static String SendSMS(String book_date, String book_time, int business_num, int member_no) throws IOException {
		BusinessDao bdao = new BusinessDaoImpl();
		String business_name = bdao.businessOne(business_num).getBusiness_name();
		String phone= pet_util.FromMemberNoTogetPhone(member_no).replaceAll("-", "");
		String Name= pet_util.FromMemberNoTogetName(member_no);
		String massage = null;
		if(book_time==null) {
			massage = Name+"님 "+book_date.substring(4, 6)+"월"+book_date.substring(7, 8)+"일"+business_name+"에 예약되었습니다.";	
		}else {
			massage = Name+"님 "+book_date.substring(4, 6)+"월"+book_date.substring(7, 8)+"일"+book_time+" "+business_name+"에 예약되었습니다.";	
		}
		
		
		String targetUrl = "https://api.solapi.com/messages/v4/send";
		String parameters = " {\"message\":{\"to\":\""+phone+"\",\"from\":\"01077915161\",\"text\":\""+massage+"\",\"type\":\"SMS\"}}";

		URL url = new URL(targetUrl); //URL 생성
		HttpURLConnection con = (HttpURLConnection)url.openConnection(); //URL에 연결 객체 생성

	    con.setRequestMethod("POST");

		con.setRequestProperty("Authorization", APIInit.getHeaders());
		con.setRequestProperty("Content-Type", "application/json");

	    con.setDoOutput(true);
	    OutputStreamWriter osw = new OutputStreamWriter(con.getOutputStream());
	    BufferedWriter bw = new BufferedWriter(osw);
	    PrintWriter pw = new PrintWriter(bw);
	    pw.print(parameters);
	    pw.flush();
	    pw.close();
	      
	    int responseCode = con.getResponseCode();
	    BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
	    String line;
	    StringBuffer smsresponse = new StringBuffer();
	    while ((line = in.readLine()) != null) {
	      smsresponse.append(line);
	    }
	    in.close();

	    System.out.println("HTTP response code : " + responseCode);
	    System.out.println("HTTP body : " + smsresponse.toString());	    
	    	
	    JsonObject resjson = (JsonObject) JsonParser.parseString(smsresponse.toString());
	    String  statusMessage = resjson.get("statusMessage").getAsString();
		return statusMessage ;
	}
}
