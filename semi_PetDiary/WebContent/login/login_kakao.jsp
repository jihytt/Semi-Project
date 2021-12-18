<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카카오로 회원 가입하기</title>
<style type="text/css">
	
	body{ background-color: #FFF6E3;}
	
	table{ display:flex; display: -webkit-box; display: -ms-flexbox; overflow-x: auto; overflow-y: hidden; }
	
	#wrap { position : absolute; top: 50%; left: 50%; line-height: 50px; transform: translate(-50%, -50%); }
	
	#top { position : absolute; padding-bottom : 50px; font-size: 25px; font-weight: 700; left: 50%; transform: translate(-50%, -50%); }
	
	#top2 { text-align: center; padding-top: 20px; font-size: 14px; line-height: 30px; }

	tbody { display:flex; }
	
	th { width: 100px; text-align: left; font-weight: normal; }

	th,td{ display:block }

	
	#head { text-align: center; font-size: 20px; }
	
	#kakao input[type='text'] { border:#dbdbdb 1px solid; height: 35px; width: 250px; }
	
	#kakao input[type='button'] { border: wheat 1px solid; color: #744D29; height: 33px; width:100px; font-weight: 700; font-size: 13.5px; border-radius: 50px; background-color: #ffe3bf; cursor: pointer; }
	
	#kakao input[type='submit'] { border: salmon 1px solid; color: white; height: 35px; width:120px; font-weight: 700; border-radius: 50px; background-color: salmon; cursor: pointer; }
	
	#kakao input[value=' 취소 '] { border: #C9C6C6 1px solid; color: #858585; height: 35px; width:60px; font-weight: 500; border-radius: 50px; background-color: white; cursor: pointer; }
	
	#signup { text-align: center; }

</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

	var nameExp = /^[가-힣]{2,15}$/;
	
	function emailCheck(){
		
		var email = document.getElementsByName("member_email")[0];
		var emailExp = /^[A-Za-z0-9_.]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;

		if (email.value.trim() == "" || email.value == null){
			alert("이메일을 입력해 주세요.");
		} else if(!emailExp.test(email.value)) {
			alert("이메일 형식이 올바르지 않습니다.");
		} else {
			$.ajax({
				type : "POST",
				url : "/semi_PetDiary/login.do?command=login_emailchk&member_email="+encodeURIComponent(email.value),
				dataType : "json",
				success : function(result){
					var res = JSON.stringify(result.emailnotused);
					if (res=="true"){
						alert("인증 메일이 발송되었습니다. \n메일함 ( " + email.value + " ) 확인 후 인증 번호를 입력해 주세요.");
						document.getElementsByName("member_email")[0].title = "y";
					} else {
						alert(email.value + " 은 이미 가입된 이메일입니다. \n다른 이메일을 입력해 주세요.");
						document.getElementsByName("member_email")[0].focus();
					}
				},
				error : function(){
					alert("error");
				}
			});
		}
	}
	
	function emailauthCheck(){
		var email = document.getElementsByName("member_email")[0];
		var emailauth = document.getElementsByName("member_email_auth")[0];

		if (emailauth.value.trim() == "" || emailauth.value == null){
			alert("인증번호를 입력해 주세요.");
		} else if (email.title == "n"){
			alert("이메일 인증을 버튼을 먼저 눌러주세요.");
		}
		else {
			$.ajax({
				type : "POST",
				url : "/semi_PetDiary/login.do?command=login_emailAuth&member_email_auth="+encodeURIComponent(emailauth.value),
				dataType : "json",
				success : function(result){
					var res = JSON.stringify(result.result);
					if (res=="true"){
						alert("인증이 완료되었습니다. \n회원가입을 계속 진행해 주세요.");
						document.getElementsByName("member_email_auth")[0].title = "y";
					} else {
						alert("인증번호가 일치하지 않습니다. 인증번호를 확인해 주세요.");
					}
				}
			});
		}
	}
	
	function emailCheckInit(form) {
		var n2 = document.getElementsByName("member_email")[0].title;
		if(n2=="y") {
			$("#member_email").attr("title","n");
		}
	}
	
	function emailauthCheckInit(form) {
		var n3 = document.getElementsByName("member_email_auth")[0].title;
		if(n3=="y") {
			$("#member_email_auth").attr("title","n");
		}
	}

	function searchAddr() {
		  var pop = window.open("/semi_PetDiary/login/login_addrChk.jsp","pop","width=570,height=420"); 
	}
	
	function jusoCallBack(roadAddrPart1, roadAddrPart2,addrDetail){
			// 팝업페이지에서 주소입력한 정보를 받아서 현 페이지에 정보를 등록함
			document.getElementById("member_addr").value = roadAddrPart1;
			document.getElementById("member_addr_detail").value = roadAddrPart2 +" "+ addrDetail;
	}
	
	function checkForm(){
		var n2 = document.getElementsByName("member_email")[0].title;
		var n3 = document.getElementsByName("member_email_auth")[0].title;
		var name = document.getElementsByName("member_name")[0];
		var phone = document.getElementsByName("member_phone")[0];
		var addrDetail = document.getElementsByName("member_addr_detail")[0];
		if (addrDetail.value.trim() == "" || addrDetail.value == null) {
			alert("주소를 정확히 입력해주세요.");
			return false;
		} else if (n2=="n") {
			alert("이메일 인증이 필요합니다.");
			return false;
		} else if (n3=="n") {
			alert("인증번호를 확인해 주세요.");
			return false;
		} else if (name.value.trim() == "" || name.value == null) {
			alert("이름을 입력해 주세요.");
			return false;
		} else if (!nameExp.test(name.value)) {
			alert("이름은 2~15자의 한글로만 입력해 주세요.");
			return false;
		} else if (phone.value.trim() == "" || phone.value == null){
			alert("전화번호를 입력해 주세요.");
			return false;
		} else if (!phoneExp.test(phone.value)) {
			alert("전화번호 형식을 확인해 주세요.");
			return false;
		} else {
			return true;
		}
	}
</script>
</head>
<body>
<%@include file="/main/header.jsp"%>

<%
	String member_id = (String) request.getAttribute("member_id");

%>
	<div id="wrap">
	<br/>
	<div id="top"><i class="fas fa-paw"></i>&nbsp;<span>Pet Diary</span></div>
	<div id="top2">
		<p>카카오 아이디로 로그인</p>
		<p>펫 다이어리 회원가입을 위한 추가 정보를 입력해 주세요.</p>
	</div>
	<br/>
	
	<form id="kakao" name="join" action="/semi_PetDiary/login.do" method="get" onsubmit="return checkForm()">
		<input type="hidden" name="command" value="social_signUp"/>
		<input type="hidden" name="member_id" value="<%=member_id%>"/>

		<table>
			<tr>
				<th>이름</th>
				<th>이메일</th>
				<th>&nbsp;</th>
				<th>전화번호</th>
				<th>주소</th>
			</tr>
			<tr>
				<td>
					<input type="text" name="member_name" placeholder=" 이름" required="required"/>
				</td>
				<td>
					<input type="text" name="member_email"  id="member_Email" placeholder=" 이메일" title="n" required="required" onkeyup="emailCheckInit(kakao);"/>
					&nbsp;
					<input type="button" value=" 이메일 인증 " onclick="emailCheck();"/>
					<br/>
					<input type="text" name="member_email_auth" id="member_email_auth" placeholder=" 인증번호를 입력하세요." title="n" required="required" onkeyup="emailauthCheckInit(kakao);"/>
					&nbsp;
					<input type="button" value=" 인증 확인 " onclick="emailauthCheck();" />
				</td>
				<td>
					<input type="text" name="member_phone" placeholder=" ex) 010-1234-5678" maxlength="13" required="required"/></td>
				<td>
					<input type="text" name="member_addr" id="member_addr" placeholder=" 기본 주소" required="required" readonly="readonly" onclick=""/>
					&nbsp;
					<input type="button" value=" 주소 검색 " onclick="searchAddr();"/> <br/>
					<input type="text" name="member_addr_detail" id="member_addr_detail" placeholder=" 상세 주소" required="required" readonly="readonly"/>
				</td>
			</tr>	
		</table>
		<br/>
		<div id="signup">
			<input type="submit" value=" 회원가입 "/>
			<input type="button" value=" 취소 " onclick="location.href='/semi_PetDiary/main/main.jsp'"/>
		</div>
	</form>
	</div>
	
</body>
</html>