package com.pet.ft.controller;

import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

import com.google.gson.Gson;
 
public class DExample {
 
    static public void main ( String[] args ) {
        String openApiURL = "http://aiopen.etri.re.kr:8000/Dialog";
        String accessKey = "b75624ad-9e2a-40da-9280-02e21b2e93dd";    // 발급받은 API Key
        String uuid = "451412521815927717";  // Open Dialog로 부터 생성된 UUID
        String method = "dialog";           // method 호출 방식
        System.out.print("입력해주세요 : ");
        Scanner sc = new Scanner(System.in);
        String text = sc.nextLine();          // method 호출 방식
        Gson gson = new Gson();
 
        Map<String, Object> request = new HashMap<>();
        Map<String, String> argument = new HashMap<>();
 
        ////////////////////////// OPEN DIALOG //////////////////////////
 
        argument.put("uuid", uuid);
        argument.put("method", method);
        argument.put("text", text);
 
        request.put("access_key", accessKey);
        request.put("argument", argument);
 
 
        URL url;
        Integer responseCode = null;
        String responBody = null;
        try {
                url = new URL(openApiURL);
                HttpURLConnection con = (HttpURLConnection)url.openConnection();
                con.setRequestMethod("POST");
                con.setDoOutput(true);
 
                DataOutputStream wr = new DataOutputStream(con.getOutputStream());
                wr.write(gson.toJson(request).getBytes("UTF-8"));
                wr.flush();
                wr.close();
 
                responseCode = con.getResponseCode();
                InputStream is = con.getInputStream();
                byte[] buffer = new byte[is.available()];
                int byteRead = is.read(buffer);
                responBody = new String(buffer);
				/*
				 * System.out.println("[responseCode] " + responseCode);
				 * System.out.println("[responBody]"); System.out.println(responBody);
				 * 
				 * System.out.print("응답 : ");
				 */
                
                int a = responBody.indexOf("\"system_text\":") + "system_text".length() + 4;
                int b = responBody.indexOf("n\"") - 1;
                
				System.out.print(responBody.substring(a, b));
                
                
        } catch (MalformedURLException e) {
                e.printStackTrace();
        } catch (IOException e) {
                e.printStackTrace();
        }
    }

}