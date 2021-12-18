package com.pet.ft.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import static com.pet.ft.controller.Util.isTwo;

import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.util.List;

import com.google.gson.Gson;
import com.pet.ft.dto.BookDto;
import com.pet.ft.dto.BusinessDto;
import com.pet.ft.model.BusinessDao;
import com.pet.ft.model.BusinessDaoImpl;
import com.pet.ft.model.PetBiz;
import com.pet.ft.model.PetBizImpl;


@WebServlet("/chatbot.do")
public class chatbot_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public chatbot_servlet() {

    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String command = request.getParameter("command");
		PetBiz biz = new PetBizImpl();
		BusinessDao bdao = new BusinessDaoImpl();
		System.out.println("[command] : " + command);
		
		HttpSession session = request.getSession();
		// 챗봇 클릭 시 uuid 세션 얻고 챗봇창으로 이동하게??
		if("opendialog".equals(command)) {
			String openApiURL = "http://aiopen.etri.re.kr:8000/Dialog";
	        String accessKey = "b75624ad-9e2a-40da-9280-02e21b2e93dd";
	        String domain = "chatbot";
	        String access_method = "internal_data";
	        String method = "open_dialog";
	        Gson gson = new Gson();
	 
	        Map<String, Object> APIrequest = new HashMap<>();
	        Map<String, String> argument = new HashMap<>();
	 
	        argument.put("name", domain);
	        argument.put("access_method", access_method);
	        argument.put("method", method);
	 
	        APIrequest.put("access_key", accessKey);
	        APIrequest.put("argument", argument);
	 
	 
	        URL url;
	        Integer responseCode = null;
	        String responBody = null;
	        try {
	                url = new URL(openApiURL);
	                HttpURLConnection con = (HttpURLConnection)url.openConnection();
	                con.setRequestMethod("POST");
	                con.setDoOutput(true);
	 
	                DataOutputStream wr = new DataOutputStream(con.getOutputStream());
	                wr.write(gson.toJson(APIrequest).getBytes("UTF-8"));
	                wr.flush();
	                wr.close();
	                responseCode = con.getResponseCode();
	                InputStream is = con.getInputStream();
	                byte[] buffer = new byte[is.available()];
	                int byteRead = is.read(buffer);
	                responBody = new String(buffer);
	              
	                JSONParser parser = new JSONParser();
	                try {
	                	
	                	JSONObject res_object = (JSONObject) parser.parse(responBody);
						JSONObject return_object = (JSONObject) res_object.get("return_object");
						String uuid = (String) return_object.get("uuid");
						
						session.setAttribute("uuid", uuid);
						response.sendRedirect("/semi_PetDiary/chatbot/chatbot_main.jsp");
						
					} catch (ParseException e) {
						e.printStackTrace();
					}
	 
	        } catch (MalformedURLException e) {
	                e.printStackTrace();
	        } catch (IOException e) {
	                e.printStackTrace();
	        }
			
		}
		
		if("dialog".equals(command)) {
			int member_no = (int) session.getAttribute("member_no");
			String openApiURL = "http://aiopen.etri.re.kr:8000/Dialog";
		    String accessKey = "b75624ad-9e2a-40da-9280-02e21b2e93dd";
			String uuid = (String) session.getAttribute("uuid");
			String method = "dialog";
			String text = request.getParameter("message");
			System.out.println(text);
			Gson gson = new Gson();
			 
	        Map<String, Object> APIrequest = new HashMap<>();
	        Map<String, String> argument = new HashMap<>();
			
	        argument.put("uuid", uuid);
	        argument.put("method", method);
	        argument.put("text", text);
	 
	        APIrequest.put("access_key", accessKey);
	        APIrequest.put("argument", argument);
	 
	 
	        URL url;
	        Integer responseCode = null;
	        String responBody = null;
	        
	        
	        try {
	                url = new URL(openApiURL);
	                HttpURLConnection con = (HttpURLConnection)url.openConnection();
	                con.setRequestMethod("POST");
	                con.setDoOutput(true);
	 
	                DataOutputStream wr = new DataOutputStream(con.getOutputStream());
	                wr.write(gson.toJson(APIrequest).getBytes("UTF-8"));
	                wr.flush();
	                wr.close();
	 
	                responseCode = con.getResponseCode();
	                InputStream is = con.getInputStream();
	                byte[] buffer = new byte[is.available()];
	                int byteRead = is.read(buffer);
	                responBody = new String(buffer);


	                int a = responBody.indexOf("\"system_text\":") + "system_text".length() + 4;
	                int b = responBody.indexOf("n\"") - 1;
	                
	                System.out.print(responBody.substring(a, b));
	                String result = responBody.substring(a, b);
	                 
	                JSONObject obj = new JSONObject();
	                obj.put("senderName", "챗봇");
	                obj.put("message", result);
	                
	                response.getWriter().print(obj);
	                
	                if(result.indexOf("예약 완료되었습니다.") != -1) {
	                	System.out.println("확인");
	                	
	            		String res = result.replaceAll(" ", "");
	            		
	            		System.out.println(res.substring(0,res.indexOf("월")));
	            		
	            		String month = res.substring(0,res.indexOf("월"));
	            		String day = res.substring(res.indexOf("월") + 1, res.indexOf("일"));
	            		String hour = res.substring(res.indexOf("일", 6) + 1, res.indexOf("시"));
	            		String minute = "00";
	            		String business_name = res.substring(res.indexOf("시") + 1, res.indexOf("매장"));
	            		if(res.indexOf("분") != -1) {
	            			minute = res.substring(res.indexOf("시") + 1, res.indexOf("분"));
	            			business_name = res.substring(res.indexOf("분") + 1, res.indexOf("매장"));
	            		}
	            		
	            		month = isTwo(month);
	            		day = isTwo(day);
	            		hour = isTwo(hour);
	            		minute = isTwo(minute);
	            		
	            		String book_date = "2021" + month + day;
	            		String book_time = hour + ":" + minute;
	            		
	            		System.out.println(book_date + " "+ book_time);
	            		
	            		System.out.println(business_name);
	            		
	            		List<BusinessDto> list = biz.businessList();
	            		for(BusinessDto dto : list) {
	            			if(dto.getBusiness_name().equals(business_name)) {
	            				System.out.println("오케!");
	            				
	            				BookDto bokdto = new BookDto(0, book_date, book_time, dto.getBusiness_role(), dto.getBusiness_num(), (int)session.getAttribute("member_no"), null, null, null, null);
	            				
	            				int ires = bdao.bookInsert(bokdto);
	            		        pet_sms.SendSMS(book_date, book_time, dto.getBusiness_num(), (int)session.getAttribute("member_no"));
	            				System.out.println(ires);
	            			}
	            		}
	                }
	                
	        } catch (MalformedURLException e) {
	                e.printStackTrace();
	        } catch (IOException e) {
	                e.printStackTrace();
	        }
		}
		
		
	}
	
	
	private void dispatch(HttpServletRequest request, HttpServletResponse response, String path) throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(path);
		dispatch.forward(request, response);
	}

}
