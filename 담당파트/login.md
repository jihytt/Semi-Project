
> ## 세미프로젝트 담당 파트 정리 1

<br/>

<img width="70%" src="https://user-images.githubusercontent.com/75427390/146675793-744508d9-2094-4b2a-bdbf-467e8c6a10f1.png">

<br/>

로그인 페이지에서 **로그인**, **로그아웃**, **아이디 찾기**, **임시 비밀번호 발급(비밀번호 변경)** 코드를 정리한 글입니다.

<br/>

>### login 기능

<br/>

login_login.jsp

```jsp
<script type="text/javascript">

    // 회원가입 페이지로 이동
	function registForm(){
		location.href="/semi_PetDiary/login.do?command=login_signup";
	}
	
    // 사용자가 입력창에 공백, 또는 입력하지 않았을 때 알림창 뜨게 하기
	function checkForm(){
		var id = document.getElementsByName("member_id")[0];
		var pw = document.getElementsByName("member_pw")[0];
		
		if (id.value.trim() == "" || id.value == null) {
			alert("아이디를 입력해 주세요.");
			return false;
		} else if (pw.value.trim() == "" || pw.value == null) {
			alert("비밀번호를 입력해 주세요.");
			return false;
		} else {
			return true;
		}
	}
</script>

<div id="login">
	<form action="/semi_PetDiary/login.do" method="post" onsubmit="return checkForm()">
    // onsubmit return false면 action이 실행되지 않는다.
		<input type="hidden" name="command" value="login_loginForm"/>
		<div>
			<input type="text" name="member_id" maxlength="20" placeholder="아이디를 입력해 주세요." required="required"/>
			<input type="password" name="member_pw" maxlength="20" placeholder="비밀번호를 입력해 주세요." required="required"/>
			<input type="submit" value="로그인"/>
		</div>
	</form>
	<div>
		<div><a onclick="location.href='/semi_PetDiary/login/login_find.jsp'">아이디 | 비밀번호 찾기</a></div>
		<div><a onclick="registForm();">회원 가입</a></div>
	</div>
</div>	
```

<br/>

login_servlet.java

```java
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    if("login_loginForm".equals(command)) {
        // ID와 PW 값 받기
        String member_id = request.getParameter("member_id");
        String member_pw = request.getParameter("member_pw");

        MemberDto dto = new MemberDto();
        dto = biz.Login(member_id, member_pw);

        if(dto != null) {
            // 회원 정보가 존재하면 session에 담기
            HttpSession session = request.getSession();
            session.setAttribute("dto", dto);
            session.setAttribute("member_no", dto.getMember_no());
            session.setMaxInactiveInterval(3600); // 세션 유효시간 3600초

            response.sendRedirect("main/main.jsp"); // 메인 페이지로 이동
        }
    } else {
        jsResponse(response, "가입하지 않은 아이디거나, 잘못된 비밀번호입니다.", loginDirectory+"login.jsp");
        }			
    } 

    // 자주 사용해서 따로 만들어 놓았다. alert창+페이지 이동
    private void jsResponse(HttpServletResponse response, String msg, String url) throws IOException {
        String responseText = "<script>"
                            + "alert('"+msg+"');"
                            + "location.href='"+url+"';"
                            + "</script>;";
        response.getWriter().append(responseText);
    }
}    
```

<br/>

PetDaoImpl.java
```java
// String namespace = "com.pet.ft.mapper.";

@Override
public MemberDto Login(String member_id, String member_pw) {
	MemberDto dto = null;
	Map<String, Object> map = new HashMap<>();
	map.put("member_id", member_id);
	map.put("member_pw", member_pw);
			
	try(SqlSession session = getSqlSessionFactory().openSession(true)){
		dto = session.selectOne(namespace+"Login", map);
	}
	return dto;
}
```

<br/>

pet_mapper.xml

```xml
<select id = "Login" parameterType="Map" resultType="MemberDto">
 		SELECT MEMBER_NO, MEMBER_NAME, MEMBER_ID, MEMBER_PW, MEMBER_EMAIL, MEMBER_PHONE, MEMBER_ROLE, MEMBER_ADDRESS
 		FROM MEMBER
 		WHERE MEMBER_ID = #{member_id} and MEMBER_PW = #{member_pw}
</select>
```

<br/>

### **로그아웃**

<br/>

login_servlet.jsp
```java
if("login_logout".equals(command)) {
	if (session != null) { // 세션이 존재한다면
		session.invalidate(); // 세션 초기화
	} 
    response.sendRedirect("main/main.jsp");
}
```


<br/>

---

<br/>
<br/>

<img width="50%" src="https://user-images.githubusercontent.com/75427390/146682649-b2a781a6-4b46-483f-9b68-a9e196e6eaf9.png">

<br/>

> ### ID 찾기

<br/>

login_find.jsp

```jsp
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

	function findId(){
        // 사용자 입력값 가져오기
		var name = document.getElementsByName("member_name")[0].value;
		var email = document.getElementsByName("member_email")[0].value;

        // 유효성 검사
		if (name.trim() == "" || name == null){
			alert("아이디를 입력해 주세요.");
		} else if (email.trim() == "" || email == null) {
			alert("이메일을 입력해 주세요.");
		} else {
            // 비동기 통신으로 정보 조회
			$.ajax({
				type : "POST",
				url : "/semi_PetDiary/login.do?command=login_findId&member_name="+encodeURIComponent(name)+"&member_email="+encodeURIComponent(email),
				dataType : "json",
				success : function(result){
					if(result.member_id != "null") { // 데이터가 있을 시 화면에 출력
						$("#idResult").text("<  회원님의 아이디는 " + result.member_id + " 입니다.  >");
					} else {
						$("#idResult").text("<  정보가 일치하는 회원이 없습니다.  >");
					}
				},
				error : function(){
					alert("error");
				}
			});
		}
	}
</script>

<table>
	<tr>
		<th>이름 :</th>
		<th>이메일 :</th>
		<th>&nbsp;</th>
	</tr>
	<tr>
		<td><input type="text" name="member_name" id="member_name"/></td>
		<td><input type="text" name="member_email" id="member_email"/></td>
		<td>
			<input type="button" value=" 입력 " onclick="findId();"/>
			<input type="button" value=" 로그인 페이지로 이동 " onclick="location.href='/semi_PetDiary/login/login_login.jsp'"/>
		</td>
	</tr>
</table>
```

<br/>

login_servlet.java

```java
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    if ("login_findId".equals(command)) {

        String member_name = request.getParameter("member_name"); 
        String member_email = request.getParameter("member_email");
                
        dto = biz.findId(member_name, member_email);
                
        if(dto != null) {
            /*
            JSONObject obj = new JSONObject();
            obj.put("member_id", dto.getMember_id());
            */
            HashMap<String, Object> hashMap = new HashMap<>();
            hashMap.put("member_id", dto.getMember_id());
            JSONObject obj = new JSONObject(hashMap);
                        
            response.getWriter().print(obj); // request 객체를 보낸 곳으로 데이터를 전달
        } else {
            HashMap<String, String> hashMap = new HashMap<>();
            hashMap.put("member_id", "null"); // "null"은 구분을 위해 그냥 문자열로 작성한 것  
            JSONObject obj = new JSONObject(hashMap);
                        
            response.getWriter().print(obj);
        }			
    }
}
```
프로젝트 당시엔 주석 처리한 것과 같이 코드를 작성해서 JSON 객체를 생성했는데 노란줄 경고가 뜨는게 거슬려서 HashMap을 통해 데이터를 넣는 것으로 수정했다.

<br/>

PetDaoImpl.java
```java
@Override
public MemberDto findId(String member_name, String member_email) {
	MemberDto dto = null;
	Map<String, String> map = new HashMap<String, String>();
	map.put("member_name", member_name);
	map.put("member_email", member_email);
	try(SqlSession session = getSqlSessionFactory().openSession(true)){
		dto = session.selectOne(namespace+"findId", map);
	}
	return dto;
}
```

<br/>

pet_mapper.xml
```xml
<select id="findId" parameterType="Map" resultType="MemberDto">
  	SELECT * FROM MEMBER WHERE MEMBER_NAME= #{member_name} AND MEMBER_EMAIL = #{member_email}
</select>
```

<br/>

> ### 임시비밀번호로 변경 (이메일 발송)

<br/>
login_find.jsp

```jsp
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

	function findPw(){
        // 사용자 입력값 받기
		var name = document.getElementsByName("member_name")[1].value;
		var email = document.getElementsByName("member_email")[1].value;
		var id = document.getElementsByName("member_id")[0].value;
    
        // 유효성 검사
    	if (name.trim() == "" || name == null) {
			alert("이름을 입력해 주세요.");
		} else if (email.trim() == "" || email == null) {
			alert("이메일을 입력해 주세요.");
		} else if (id.trim() == "" || id == null) {
			alert("아이디를 입력해 주세요.");
		} else {
			$.ajax({
				type : "POST",
				url : "/semi_PetDiary/login.do?command=login_findPw&member_name="+encodeURIComponent(name)+"&member_email="+encodeURIComponent(email)+"&member_id="+encodeURIComponent(id),
				dataType : "json",
				success : function(result){
					var res = JSON.stringify(result.result);
					if(res == "true"){
						$("#pwResult").text("< 임시 비밀번호를 메일로 전송했습니다. >");
					} else {
						$("#pwResult").text("<  정보가 일치하는 회원이 없습니다.  >");
					}
				},
				error : function(){
					alert("메일 발송에 오류가 발생했습니다. 다시 시도해주세요.");
				}
			});
		}
	}    
</script>

<table>
	<tr>
		<th>이름 :</th>
		<th>아이디 :</th>
		<th>이메일 :</th>
		<th>&nbsp;</th>
	</tr>
	<tr>
		<td><input type="text" name="member_name"/></td>
		<td><input type="text" name="member_id"/></td>
		<td><input type="text" name="member_email"/></td>
		<td><input type="button" id="" value=" 임시 비밀번호 발송 " onclick="findPw();"></td>
	</tr>
</table>
```

<br/>

login_servlet.jsp
```java
if ("login_findPw".equals(command)) {
	String member_name = request.getParameter("member_name");
	String member_email = request.getParameter("member_email");
	String member_id = request.getParameter("member_id");

	dto = biz.findPw(member_name, member_email, member_id);
			
    // 데이터가 있으면 메일 발송
	if(dto != null){
				
		String from = "발신 이메일 주소";
		String fromName = "메일에 표시될 이름";
		String to = request.getParameter("member_email");

        // Properties 설정 - smtp 서버와 관련된 정보 설정		
		Properties props = new Properties();
		props.put("mail.smtp.user", from);				// 발신 이메일 주소
		props.put("mail.smtp.host", "smtp.gmail.com");  // 발송할 smtp 서버, gmail 이용. 네이버의 경우 smtp.naver.com
		props.put("mail.smtp.port", "465");			    // 통신 포트. gmail  - 465, naver - 587 
		props.put("mail.smtp.starttls.enable", "true"); // 로그인 하기 전 tls 보호 연결로 전환(암호화)
		props.put("mail.smtp.auth", "true");            // smtp 인증 사용 설정

        // gmail 인증용 Secure Socket Layer 설정
        // 암호화
    	props.put("mail.smtp.socketFactory.port", "465"); // 소켓 팩토리 사용 시 연결할 포트 설정
	    props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory"); // smtp 소켓 만드는데 사용
		props.put("mail.smtp.socketFactory.fallback", "false"); // true - 지정된 소켓 팩토리 클래스를 사용하여 소켓을 생성하지 못하면 java.net 사용해서 소켓 생성

        // 임시비밀번호 생성을 위한 랜덤 문자열 생성		
		StringBuffer temp =new StringBuffer(); // 랜덤 문자열을 담을 StringBuffer
		Random ran = new Random(); // Random 클래스 생성
		for(int i=0;i<10;i++) { // 10번 돌 수 있는 루프
			int rIndex = ran.nextInt(3); // 숫자, 영문 소문자, 영문 대문자를 구분할 랜덤 숫자 (0, 1, 2) 생성
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

        // 해당 문자열로 비밀번호를 바꾸기 위해 저장					
		String AuthenticationKey = temp.toString();

        // Properties에 저장된 설정 값으로 메일 세션 생성		
		Session mailSession = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            // 인증 정보 - 암호 인증을 사용하기 위해 호출함
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(from,"발신 이메일 비밀번호");
			}
		});
							
		// 이메일 전송
		try {
            // 보내는 계정 설정
			InternetAddress addr = new InternetAddress();
			addr.setPersonal(fromName, "UTF-8");
			addr.setAddress(from);

            // MimeMessage클래스에 메일과 관련된 내용 지정		
			Message msg = new MimeMessage(mailSession);
			msg.setFrom(addr);
			// UTF-9로 되어있는 메일 보내기 - 한글 깨짐 해결		
			msg.setSubject(MimeUtility.encodeText("[펫 다이어리] 임시 비밀번호 전송", "UTF-8","B")); // 메일 제목, "B" - Base64
					
			msg.setContent("변경된 비밀번호는 [" + temp + "] 입니다.", "text/html; charset=UTF-8"); // 메일 내용
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to)); // 수신자

            // 메세지 객체 msg 전송							
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
						
		HashMap<String, Object> hashMap = new HashMap<>();
		hashMap.put("result", resCheck);
		JSONObject obj = new JSONObject(hashMap);
	                
		response.getWriter().print(obj);
	
    } else {
		HashMap<String, Object> hashMap = new HashMap<>();
		hashMap.put("result", false);
		JSONObject obj = new JSONObject(hashMap);
	                
		response.getWriter().print(obj);	                
	}		
}		
		
```

<br/>

petDaoImpl.java
```java
// 비밀번호 변경
@Override
public int resetPw(String member_name, String member_email, String member_id, String member_pw) {
	int res=0;
	Map<String, String> map = new HashMap<String, String>();
	map.put("member_name", member_name);
	map.put("member_email", member_email);
	map.put("member_id", member_id);
	map.put("member_pw", member_pw);
	try(SqlSession session = getSqlSessionFactory().openSession(true)){
		res = session.update(namespace+"resetPw", map);
	}
	return res;
}
```

<br/>

pet_mapper.xml
```xml
<update id="resetPw" parameterType="Map">
  	UPDATE MEMBER
  	SET MEMBER_PW = #{member_pw}
  	WHERE MEMBER_NAME = #{member_name} AND MEMBER_EMAIL = #{member_email} AND MEMBER_ID = #{member_id}
</update>
```

<br/>