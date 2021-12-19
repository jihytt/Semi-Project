
> ## 세미프로젝트 담당 파트 정리 1

<br/>

<img width="70%" src="https://user-images.githubusercontent.com/75427390/146675793-744508d9-2094-4b2a-bdbf-467e8c6a10f1.png">

<br/>

구현한 로그인 페이지에서 **로그인**, **로그아웃**, **아이디 찾기**, **임시 비밀번호 발급(비밀번호 변경)** 코드를 정리한 글입니다.

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
if("login_loginForm".equals(command)) {

    String member_id = request.getParameter("member_id");
    String member_pw = request.getParameter("member_pw");
    MemberDto dto = new MemberDto();
    dto = biz.Login(member_id, member_pw);

    if(dto != null) {

        HttpSession session = request.getSession();
    	session.setAttribute("dto", dto);
    	session.setAttribute("member_no", dto.getMember_no());
    	session.setMaxInactiveInterval(3600);

    	response.sendRedirect("main/main.jsp");
   	}
} else {
    jsResponse(response, "가입하지 않은 아이디거나, 잘못된 비밀번호입니다.", loginDirectory+"login.jsp");
   	}			
} 
```