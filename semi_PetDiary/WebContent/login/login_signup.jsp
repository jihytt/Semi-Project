<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href="/semi_PetDiary/resources/css/stylesheet.css" rel="stylesheet">
<style type="text/css">


	body{ background-color: #FFF6E3;}
	
	#wrap { position : absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); margin-top: 20px; width:400px; height: 600px; padding-top: 40px; }

	#top { position : absolute; color : #4D3417; padding-bottom : 50px; font-size: 30px; font-weight: 700; left: 50%; transform: translate(-50%, -50%); }
	div i { color: #4D3417; }
	#top2 { text-align: center; padding-top: 10px; }
	
	#form { line-height: 50px; }
	
	#signup { text-align: center; }
	
	#join input[type='text'], input[type='password'] { border:#D7BF9C 1px solid; height: 35px; width: 250px; }
	
	#join input[type='button'] { border: wheat 1px solid; background-color: #ffe3bf; color: #4f3a19; cursor: pointer; height: 30px; width:100px; font-weight: 700; font-size: 13.5px; border-radius: 50px; }
	
	#join input[value='취소'] { border: #C9C6C6 1px solid; color: #858585; height: 35px; width:60px; font-weight: 500; border-radius: 50px; background-color: white; cursor: pointer; }
	
	#join input[type='submit'] { border: salmon 1px solid; color: white; height: 35px; width:120px; font-weight: 700; border-radius: 50px; background-color: salmon; cursor: pointer; }
	

</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

    var idpwExp = /^[a-zA-Z0-9]{6,20}$/;
    var phoneExp = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/;
    var nameExp = /^[가-힣]{2,15}$/;
    
	
	function idCheckConfirm(){
		var n1 = document.getElementsByName("member_id")[0].title;
		if (n1 == "n") {
			alert("아이디 중복확인을 해주세요.");
			document.getElementsByName("member_id")[0].focus();
		}
	}
	
	function idCheck(){
		
		var id = document.getElementsByName("member_id")[0];
		
		if (id.value.trim() == "" || id.value == null){
			alert("아이디를 입력해 주세요.");
		} else if(!idpwExp.test(id.value)) {
			alert("아이디는 6~20자의 영문 대소문자와 숫자로만 입력해 주세요.");
		} else {
			
			$.ajax({
				type : "POST",
				url : "../login.do?command=login_idchk&member_id="+encodeURIComponent(id.value),
				dataType : "json",
				success : function(data){
					var res = JSON.stringify(data.idnotused);
					if (res=="true"){
						alert("생성 가능한 아이디입니다.");
						document.getElementsByName("member_id")[0].title = "y";
						document.getElementsByName("member_pw")[0].focus();
					} else {
						alert("중복된 아이디가 존재합니다.");
						document.getElementsByName("member_id")[0].focus();
					}
				},
				error : function(){
					alert("error");
				}
			});
		}
	}
	
	function idCheckInit(form) {
		var n1 = document.getElementsByName("member_id")[0].title;
		if(n1 =="y") {
			$("#member_Id").attr("title","n");
		}
	}
	
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
				url : "../login.do?command=login_emailchk&member_email="+encodeURIComponent(email.value),
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
		} else if(email.title == "n") {
			alert("이메일 인증을 버튼을 먼저 눌러주세요.");
		} else {
			$.ajax({
				type : "POST",
				url : "../login.do?command=login_emailAuth&member_email_auth="+encodeURIComponent(emailauth.value),
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
		  var pop = window.open("login_addrChk.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	}
	
	function jusoCallBack(roadAddrPart1, roadAddrPart2,addrDetail){
			// 팝업페이지에서 주소입력한 정보를 받아서 현 페이지에 정보를 등록함
			document.getElementById("member_addr").value = roadAddrPart1;
			document.getElementById("member_addr_detail").value = roadAddrPart2 +" "+ addrDetail;
	}

	
	function checkForm(){
		var n1 = document.getElementsByName("member_id")[0].title;
		var n2 = document.getElementsByName("member_email")[0].title;
		var n3 = document.getElementsByName("member_email_auth")[0].title;
		var pw = document.getElementsByName("member_pw")[0];
		var name = document.getElementsByName("member_name")[0];
		var phone = document.getElementsByName("member_phone")[0];
		var addrDetail = document.getElementsByName("member_addr_detail")[0];
		if (n1=="n") {
			alert("아이디 중복체크를 해주세요.");
			return false;
		} else if (n2=="n") {
			alert("이메일 인증이 필요합니다.");
			return false;
		} else if (n3=="n") {
			alert("인증번호를 확인해 주세요.");
			return false;
		}  else if (pw.value.trim() == "" || pw.value == null) {
			alert("비밀번호를 입력해 주세요.");
			return false;
		} else if (!idpwExp.test(pw.value)) {
			alert("비밀번호는 6~20자의 영문 대소문자와 숫자로만 입력해 주세요.");
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
		} else if (addrDetail.value.trim() == "" || addrDetail.value == null) {
			alert("주소를 정확히 입력해주세요.");
			return false;
		} else {
			return true;
		}
	}
	
</script>
</head>
<body>
<%@include file="/main/header.jsp"%>
	
	<form id="join" name="join" action="/semi_PetDiary/pet.do" method="post" onsubmit="return checkForm()">
		<input type="hidden" name="command" value="login_signupForm"/>
		<table>
			<div id="wrap">
				<br/>
			
				<div id="top"><i class="fas fa-paw"></i>&nbsp;<span>Pet Diary</span></div>
				<div id="top2" style="color: #4D3417">회원가입</div>
				
				<br/>
				
				<div id="form">
					<div>
						<div>
							<input type="text" name="member_id" id="member_Id" maxlength="20" placeholder="  아이디" title="n" required="required" onkeyup="idCheckInit(join);" />
							&nbsp;
							<input type="button" value=" 중복 확인 " onclick="idCheck();"/>
						</div>
					</div>
					<div>
						<div>
							<input type="password" name="member_pw" maxlength="20" placeholder="  비밀번호" required="required" onclick="idCheckConfirm();"/>
						</div>
					</div>
					<div>
						<div>
							<input type="text" name="member_name" placeholder="  이름" required="required" onclick="idCheckConfirm();"/>
						</div>
					</div>
					<div>
						<div>
							<input type="text" name="member_email"  id="member_email" placeholder="  이메일" title="n" required="required" onclick="idCheckConfirm();" onkeyup="emailCheckInit(join);"/>
							&nbsp;
							<input type="button" value=" 이메일 인증 " onclick="emailCheck();"/>
						</div>
					</div>
					<div>
						<div>
							<input type="text" name="member_email_auth" id="member_email_auth" placeholder="  인증번호를 입력하세요." title="n" required="required" onclick="idCheckConfirm();" onkeyup="emailauthCheckInit(join);"/>
							&nbsp;
							<input type="button" value=" 인증 확인 " onclick="emailauthCheck();" />
						</div>
					</div>
					<div>
						<div>
							<input type="text" name="member_phone" placeholder="  번호  ex) 010-1234-5678" maxlength="13" required="required" onclick="idCheckConfirm();"/>
						</div>
					</div>
					<div>
						<div>
							<input type="text" name="member_addr" id="member_addr" placeholder="  기본 주소" required="required" readonly="readonly" onclick=""/>
							&nbsp;
							<input type="button" value=" 주소 검색 " onclick="searchAddr();"/> <br/>
							<input type="text" name="member_addr_detail" id="member_addr_detail" placeholder="  상세 주소" required="required" readonly="readonly" onclick=""/>
						</div>
					</div>
					<br/>
					<div>
						<div id="signup">
							<input type="submit" value="가입 하기"/>
							<input type="button" value="취소" onclick="history.back();"/>
						</div>
					</div>
				</div>
			</div>
		</table>
	</form>
	


</body>
</html>