package com.pet.ft.controller;

import java.io.IOException;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.pet.ft.model.PetBiz;
import com.pet.ft.dto.MemberDto;
import com.pet.ft.model.PetBizImpl;
import com.pet.ft.model.PetDao;
import com.pet.ft.model.PetDaoImpl;

import java.net.URLEncoder;
import java.util.Properties;
import java.util.Random;
import java.net.URL;
import java.net.HttpURLConnection;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;



@WebServlet("/login_do")
public class login_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public login_servlet() {
        super();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);		
}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String command = request.getParameter("command");
		System.out.println("login_servlet 의 command : " + command);
		
		HttpSession session = request.getSession();
		MemberDto dto = new MemberDto();
		PetDao dao = new PetDaoImpl();
		PetBiz biz = new PetBizImpl();
		
		String loginDirectory = "login/login_";
		
		if("login_idchk".equals(command)) {
			String member_id = request.getParameter("member_id");
			dto = dao.SignUpIdChk(member_id);
			boolean idnotused = true;
			if (dto != null) {
				idnotused = false;
			}
	        JSONObject obj = new JSONObject();
            obj.put("idnotused", idnotused);
            
            response.getWriter().print(obj);

		}


		// 회원가입 메일 발송 smtp
		if ("login_emailchk".equals(command)) {
			String member_email = request.getParameter("member_email");
			dto = dao.SignUpEmailChk(member_email);
			
			boolean emailnotused = true;
			
			if(dto == null){
	
				String from = "semiproject.pet@gmail.com";
				String fromName = "관리자";
				String to = request.getParameter("member_email");
	
				Properties props = new Properties();
				props.put("mail.smtp.user", from);
				props.put("mail.smtp.host", "smtp.gmail.com");
				props.put("mail.smtp.port", "465");
				props.put("mail.smtp.starttls.enable", "true");
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.debug", "true");
				props.put("mail.smtp.socketFactory.port", "465");
				props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
				props.put("mail.smtp.socketFactory.fallback", "false");
	
				StringBuffer temp =new StringBuffer();
				Random ran = new Random();
				for(int i=0;i<10;i++)
				{
					int rIndex = ran.nextInt(3);
					switch (rIndex) {
						case 0:
						// a-z
						temp.append((char)((int)(ran.nextInt(26)) + 97));
						break;
						case 1:
						// A-Z
						temp.append((char)((int)(ran.nextInt(26)) + 65));
						break;
						case 2:
						// 0-9
						temp.append((ran.nextInt(10)));
						break;
					}
				 }
	
				String AuthenticationKey = temp.toString(); // 인증번호 인증을 위한 키 등록
	
						
				Session mailSession = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
	
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(from,"testpet03");
						}
				});
				
				// 이메일 전송
				try {
					InternetAddress addr = new InternetAddress();
					addr.setPersonal(fromName, "UTF-8");
					addr.setAddress(from);
	
	
					Message msg = new MimeMessage(mailSession);
	
	
					msg.setFrom(addr);
	
					msg.setSubject(MimeUtility.encodeText("[펫 다이어리] 회원가입 이메일 인증번호", "UTF-8","B"));
	
					msg.setContent("이메일 인증번호는 [" + temp + "] 입니다.", "text/html; charset=UTF-8");
					msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
	
					Transport.send(msg);
	
				} catch (Exception e) {
					e.printStackTrace();
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('오류가 발생했습니다.');");
					script.println("history.back();");
					script.println("</script>");
					script.close();
					return;
				}
	
				HttpSession saveKey = request.getSession();
				saveKey.setAttribute("AuthenticationKey", AuthenticationKey);
	
		        JSONObject obj = new JSONObject();
	            obj.put("emailnotused", emailnotused);
	            
	            response.getWriter().print(obj);
				
			} else {
				// 중복된 이메일이 있을 때
				emailnotused = false;
				
		        JSONObject obj = new JSONObject();
	            obj.put("emailnotused", emailnotused);
	            
	            response.getWriter().print(obj);
				
				}

		}
		// 회원가입 이메일 인증번호 확인
		if("login_emailAuth".equals(command)) {
			String AuthenticationKey = (String)request.getSession().getAttribute("AuthenticationKey");
			String memberemailauth = request.getParameter("member_email_auth");

			if(AuthenticationKey.equals(memberemailauth)){
		        JSONObject obj = new JSONObject();
	            obj.put("result", true);
	            
	            response.getWriter().print(obj);
				//request.setAttribute("AuthenticationKey", AuthenticationKey);
				//request.setAttribute("memberemailauth", memberemailauth);
				//dispatch(request, response, loginDirectory+"emailAuth.jsp");
			} else {
		        JSONObject obj = new JSONObject();
	            obj.put("result",false);
	            
	            response.getWriter().print(obj);
				//response.sendRedirect(loginDirectory+"failedAuth.jsp");
			}
		}
		
		// 네이버 로그인 처리
				if ("naver_login".equals(command)) {
					
					String clientId = "n8OVzf4XjGNAd8jAA6Hi";//애플리케이션 클라이언트 아이디값";
				    String clientSecret = "B9Pqf7aDXD";//애플리케이션 클라이언트 시크릿값";
				    String code = request.getParameter("code");
				    String state = request.getParameter("state");
				    String redirectURI = URLEncoder.encode("http://152.70.250.165:8787/semi_PetDiary/login.do?command=naver_login", "UTF-8");
				    String apiURL;
				    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
				    apiURL += "client_id=" + clientId;
				    apiURL += "&client_secret=" + clientSecret;
				    apiURL += "&redirect_uri=" + redirectURI;
				    apiURL += "&code=" + code;
				    apiURL += "&state=" + state;
				    String access_token = "";
				    String refresh_token = "";
				    System.out.println("apiURL="+apiURL);
				    
				    try {
				        URL url = new URL(apiURL);
				        HttpURLConnection con = (HttpURLConnection)url.openConnection();
				        con.setRequestMethod("GET");
				        int responseCode = con.getResponseCode();
				        BufferedReader br;
				        System.out.print("responseCode="+responseCode);
				        if(responseCode==200) { // 정상 호출
				          br = new BufferedReader(new InputStreamReader(con.getInputStream()));
				        } else {  // 에러 발생
				          br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
				        }
				        String inputLine;
				        StringBuffer res = new StringBuffer();
				        while ((inputLine = br.readLine()) != null) {
				          res.append(inputLine);
				        }
				        br.close();
				        if(responseCode==200) {
				        	System.out.println(res.toString());
				        	JSONParser parsing = new JSONParser();
				        	Object obj = parsing.parse(res.toString());
				        	JSONObject jsonObj = (JSONObject)obj;
				        	
				        	access_token = (String)jsonObj.get("access_token");
				        	refresh_token = (String)jsonObj.get("refresh_token");
				        	
				        	session.setAttribute("access_token", access_token);

				        }
				      } catch (Exception e) {
				        e.printStackTrace();
				      }
				    
				   response.sendRedirect("/semi_PetDiary/login.do?command=naver_confirm");
				}
			
				
			if("naver_confirm".equals(command)) {
				
				String token = (String)session.getAttribute("access_token");
				String header = "Bearer " + token;
				try {
					String apiurl = "https://openapi.naver.com/v1/nid/me";
					URL url = new URL(apiurl);
					HttpURLConnection con = (HttpURLConnection)url.openConnection();
					con.setRequestMethod("GET");
					con.setRequestProperty("Authorization", header);
					int responseCode = con.getResponseCode();
					BufferedReader br;
					
					if(responseCode==200) { // 정상 호출
						br = new BufferedReader(new InputStreamReader(con.getInputStream()));
					} else {  // 에러 발생
						br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
					}
					
					String inputLine;
					StringBuffer res = new StringBuffer();
					 while ((inputLine = br.readLine()) != null) {
					res.append(inputLine);
					}
					br.close();
					JSONParser parsing = new JSONParser();
					Object obj = parsing.parse(res.toString());
					JSONObject jsonObj = (JSONObject)obj;
					JSONObject resObj = (JSONObject)jsonObj.get("response");
					
					String naver_id = (String)resObj.get("id"); // id 아니고 고유번호
					String naver_email = (String)resObj.get("email");
					String naver_name = (String)resObj.get("name");
					String naver_phone = (String)resObj.get("mobile");
					
					String member_id = "@naver" + naver_id;
					
					dto = dao.SignUpIdChk(member_id);
					
					if (dto==null) {
						// 추가 정보 입력 회원가입
						request.setAttribute("member_id", member_id);
						request.setAttribute("member_email", naver_email);
						request.setAttribute("member_name", naver_name);
						request.setAttribute("member_phone", naver_phone);
						dispatch(request, response, "login/login_social.jsp");
						
					} else {
						// 로그인
						dto = dao.SocialLogin(member_id);
						session.setAttribute("dto", dto);
						session.setAttribute("member_no", dto.getMember_no());
						session.setMaxInactiveInterval(3600);
						
						response.sendRedirect("main/main.jsp");
					}
						
				
				} catch (Exception e) {
					e.printStackTrace();
				}	
			}
			
			if ("social_signUp".equals(command)) {
				String member_id = request.getParameter("member_id");
				String member_name = request.getParameter("member_name");
				String member_email = request.getParameter("member_email");
				String member_phone = request.getParameter("member_phone");
				String member_addr = request.getParameter("member_addr");
				String member_addr_detail = request.getParameter("member_addr_detail");
				
				String member_address = member_addr + " " + member_addr_detail;
				
				dto = new MemberDto();
				dto.setMember_id(member_id);
				dto.setMember_name(member_name);
				dto.setMember_email(member_email);
				dto.setMember_phone(member_phone);
				dto.setMember_address(member_address);
				
				int res = dao.SocialSignUp(dto);
				
				if (res > 0) {
					// 회원가입 후 바로 로그인 상태로 메인화면 이동
					session.setAttribute("dto", dto);
					session.setAttribute("member_no", dto.getMember_no());
					jsResponse(response, "회원가입이 완료되었습니다.", "main/main.jsp");
				} else {
					jsResponse(response, "회원가입 실패", "login/login_login.jsp");
				}
			}
			
			if("kakao_login".equals(command)) {
				

				String client_id = "39cbfc25bdd943573118565016e1297d";
				String redirect_uri = URLEncoder.encode("http://152.70.250.165:8787/semi_PetDiary/login.do?command=kakao_login", "UTF-8");
				String code = request.getParameter("code");
				String state = request.getParameter("state");
				
				String kakao_apiURL = "https://kauth.kakao.com/oauth/token?grant_type=authorization_code&client_id=" + client_id + "&redirect_uri=" + redirect_uri
									+ "&code=" + code + "&state=" + state;
				
				try {
			        URL url = new URL(kakao_apiURL);
			        HttpURLConnection con = (HttpURLConnection)url.openConnection();
			        con.setRequestMethod("GET");
			        int responseCode = con.getResponseCode();
			        BufferedReader br;
			        System.out.print("responseCode="+responseCode);
			        if(responseCode==200) { // 정상 호출
			          br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			        } else {  // 에러 발생
			          br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			        }
			        String inputLine;
			        StringBuffer res = new StringBuffer();
			        while ((inputLine = br.readLine()) != null) {
			          res.append(inputLine);
			        }
			        br.close();
			        if(responseCode==200) {
			        	System.out.println(res.toString());
			        	JSONParser parsing = new JSONParser();
			        	Object obj = parsing.parse(res.toString());
			        	JSONObject jsonObj = (JSONObject)obj;
			        	
			        	String access_token = (String)jsonObj.get("access_token");
			        	String refresh_token = (String)jsonObj.get("refresh_token");
			        	
			        	session.setAttribute("k_access_token", access_token);

			        }
			      } catch (Exception e) {
			        e.printStackTrace();
			      }
			    
			   response.sendRedirect("/semi_PetDiary/login.do?command=kakao_confirm");
			}
			
			if("kakao_confirm".equals(command)) {
				String token = (String)session.getAttribute("k_access_token");
				String header = "Bearer " + token;
				
				try {
					String kakao_apiURL = "https://kapi.kakao.com/v1/user/access_token_info";
					URL url = new URL(kakao_apiURL);
					HttpURLConnection con = (HttpURLConnection)url.openConnection();
					con.setRequestMethod("GET");
					con.setRequestProperty("Authorization", header);
					int responseCode = con.getResponseCode();
					BufferedReader br;
					
					if(responseCode==200) { // 정상 호출
						br = new BufferedReader(new InputStreamReader(con.getInputStream()));
					} else {  // 에러 발생
						br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
					}
					
					String inputLine;
					StringBuffer res = new StringBuffer();
					 while ((inputLine = br.readLine()) != null) {
					res.append(inputLine);
					}
					br.close();
					
					System.out.println(response.toString());
					
					JSONParser parsing = new JSONParser();
					Object obj = parsing.parse(res.toString());
					JSONObject jsonObj = (JSONObject)obj;
					System.out.println(jsonObj);
					long kakao_id = (long) jsonObj.get("id");
					
					String member_id = "@kakao" + kakao_id;
					
					dto = dao.SignUpIdChk(member_id);
					
					if (dto==null) {
						// 추가 정보 입력 회원가입
						request.setAttribute("member_id", member_id);
						dispatch(request, response, "login/login_kakao.jsp");
						
					} else {
						// 로그인
						dto = biz.SocialLogin(member_id);
						session.setAttribute("dto", dto);
						session.setAttribute("member_no", dto.getMember_no());
						session.setMaxInactiveInterval(3600);
						
						response.sendRedirect("main/main.jsp");
					}
						
				} catch (Exception e) {
					e.printStackTrace();
				}	
				
			}
			
			if ("login_findId".equals(command)) {

				String member_name = request.getParameter("member_name"); 
				String member_email = request.getParameter("member_email");
				  
				dto = biz.findId(member_name, member_email);
				
				if(dto != null) {
				//	request.setAttribute("member_id", dto.getMember_id());
				//	dispatch(request, response, "login/login_findId.jsp");
			        JSONObject obj = new JSONObject();
		            obj.put("member_id", dto.getMember_id());
		            
		            response.getWriter().print(obj);
				} else {
			        JSONObject obj = new JSONObject();
		            obj.put("member_id", "null");
		            
		            response.getWriter().print(obj);
				//	response.sendRedirect("login/login_failedToFind.jsp");
				}
				
			}
			
			if ("login_findPw".equals(command)) {
				String member_name = request.getParameter("member_name");
				String member_email = request.getParameter("member_email");
				String member_id = request.getParameter("member_id");
				dto = biz.findPw(member_name, member_email, member_id);
				
				if(dto != null){
						
					String from = "semiproject.pet@gmail.com";
					String fromName = "관리자";
					String to = request.getParameter("member_email");
						
					Properties props = new Properties();
					props.put("mail.smtp.user", from);
					props.put("mail.smtp.host", "smtp.gmail.com");
					props.put("mail.smtp.port", "465");
					props.put("mail.smtp.starttls.enable", "true");
					props.put("mail.smtp.auth", "true");
					props.put("mail.smtp.debug", "true");
					props.put("mail.smtp.socketFactory.port", "465");
					props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
					props.put("mail.smtp.socketFactory.fallback", "false");
								
					StringBuffer temp =new StringBuffer();
					Random ran = new Random();
					for(int i=0;i<10;i++)
					{
						int rIndex = ran.nextInt(3);
						switch (rIndex) {
							case 0:
							// a-z
							temp.append((char)((int)(ran.nextInt(26)) + 97));
							break;
							case 1:
							// A-Z
							temp.append((char)((int)(ran.nextInt(26)) + 65));
							break;
							case 2:
							// 0-9
							temp.append((ran.nextInt(10)));
							break;
						}
					 }
							
					String AuthenticationKey = temp.toString();
							
							
					Session mailSession = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
						protected PasswordAuthentication getPasswordAuthentication() {
							return new PasswordAuthentication(from,"testpet03");
							}
						});
							
					// 이메일 전송
					try {
						InternetAddress addr = new InternetAddress();
						addr.setPersonal(fromName, "UTF-8");
						addr.setAddress(from);
										
						Message msg = new MimeMessage(mailSession);
						msg.setFrom(addr);
								
						msg.setSubject(MimeUtility.encodeText("[펫 다이어리] 임시 비밀번호 전송", "UTF-8","B"));
										
						msg.setContent("변경된 비밀번호는 [" + temp + "] 입니다.", "text/html; charset=UTF-8");
						msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
										
						Transport.send(msg);
									
					} catch (Exception e) {
						e.printStackTrace();
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('오류가 발생했습니다.');");
						script.println("history.back();");
						script.println("</script>");
						script.close();
						return;
					}
								
					// 비밀번호 변경
					String member_pw = AuthenticationKey;
					
					int res = biz.resetPw(member_name, member_email, member_id, member_pw);
					
					boolean resCheck;
					if (res > 0) {
						resCheck = true;
					} else {
						resCheck= false;
					}
					
				
					JSONObject obj = new JSONObject();
	                obj.put("result", true);
	                
	                response.getWriter().print(obj);

				} else {
					JSONObject obj = new JSONObject();
	                obj.put("result", false);
	                
	                response.getWriter().print(obj);	                
				}
				
			}
			
			
		
	}
	
	private void jsResponse(HttpServletResponse response, String msg, String url) throws IOException {
		String responseText = "<script>"
							+ "alert('"+msg+"');"
							+ "location.href='"+url+"';"
							+ "</script>;";
		response.getWriter().append(responseText);
	}
	
	private void dispatch(HttpServletRequest request, HttpServletResponse response, String path) throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(path);
		dispatch.forward(request, response);
	}

}
