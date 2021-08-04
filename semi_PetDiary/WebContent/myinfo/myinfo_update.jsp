<%@page import="com.pet.ft.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보 수정</title>
<style type="text/css">

	#wrap { position : absolute; top: 50%; left: 50%; line-height: 50px; transform: translate(-50%, -50%); }
	
	#top { color : #4D3417; padding-bottom : 20px; font-size: 30px; font-weight: 700; text-align: center; }
	
	table{ display:flex; display: -webkit-box; display: -ms-flexbox; overflow-x: auto; overflow-y: hidden; }

	#top2 { color : #4D3417; text-align: center; font-size: 18px; font-weight: 700; padding-bottom: 20px; }

	tbody { display:flex }
	
	th { color : #4D3417; width: 100px; text-align: left; font-weight: normal; }
	
	th,td{ display:block; }
	
	#updatebtn { margin: auto; width: 300px; }
	
	#updatebtn #de { float: left; }
	
	#updatebtn #up { float: right; margin-right: 20px; }
	
	#wrap input[type='text'], input[type='password'] { border:#dbdbdb 1px solid; border-radius: 10px; height: 35px; width: 250px; }

	#wrap input[type='button'] { border: wheat 1px solid; color: #744D29; height: 30px; width:100px; font-weight: 700; font-size: 13.5px; border-radius: 50px; background-color: #ffe3bf; cursor: pointer; }
	
	#wrap input[type='submit'] { border: salmon 1px solid; color: white; height: 35px; width:90px; font-weight: 700; border-radius: 50px; background-color: salmon; cursor: pointer; }

	#wrap input[value='취소'] { border: #C9C6C6 1px solid; color: #858585; height: 35px; width:55px; font-weight: 500; border-radius: 50px; background-color: white; cursor: pointer; }
	
	#wrap input[value='회원 탈퇴']{ border: white 1px solid; background-color: white; color: #767777; cursor: pointer; text-align: left; }
	
</style>
<script src="https://kit.fontawesome.com/95780683f0.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	
	var idpwExp = /^[a-zA-Z0-9]{5,20}$/;
	var phoneExp = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/;

	function emailCheck(){
		
		var email = document.getElementsByName("member_email")[0];
		var emailExp = /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
	
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
		var email = document.getElementsByName("member_email")[0].title;
		if(email=="y") {
			$("#member_email").attr("title","n");
		}
	}
	
	function emailauthCheckInit(form) {
		var auth = document.getElementsByName("member_email_auth")[0].title;
		if(auth=="y") {
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
		var email = document.getElementsByName("member_email")[0].title;
		var auth = document.getElementsByName("member_email_auth")[0].title;
		var pw = document.getElementsByName("member_pw")[0];
		var name = document.getElementsByName("member_name")[0];
		var phone = document.getElementsByName("member_phone")[0];
		if (email=="n"){
			alert("이메일 변경 시 인증이 필요합니다.");
			return false;
		} else if (auth=="n"){
			alert("이메일 변경 시 메일로 발송된 인증번호를 입력해 주세요.");
			return false;
		} else if (pw.value.trim() == "" || pw.value == null) {
			alert("비밀번호를 입력해 주세요.");
			return false;
		} else if (!idpwExp.test(pw.value)) {
			alert("비밀번호는 6~20자의 영문 대소문자와 숫자로만 입력해 주세요.");
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
	
	function myinfo_delete() {
		var result = confirm("회원 탈퇴 시 회원님의 모든 정보가 삭제됩니다. \n탈퇴하시겠습니까?");
		if(result){
			var member_no = document.getElementsByName("member_no")[0].value;
			location.href="/semi_PetDiary/pet.do?command=myinfo_delete&member_no="+member_no;
		} else {
			alert("취소되었습니다.")
		}
	}
	
	function back() {
		history.back();
	}

</script>
</head>
<body>
<%@include file="/main/header.jsp"%>

<%
	MemberDto dto = (MemberDto) session.getAttribute("dto");
	int member_no = (int) session.getAttribute("member_no");
%>

	<div id="wrap">
		<div id="top"><i class="fas fa-paw"></i>&nbsp;<span>Pet Diary</span></div>
		<form id="update" action="/semi_PetDiary/pet.do" method="post" onsubmit="return checkForm()">
			<input type="hidden" name="command" value="myinfo_updateform"/>
			<input type="hidden" name="member_no" value="<%=member_no%>"/>
				<div id="wrapform">
				<div id="top2"><i class="fas fa-user-edit" style="color:salmon">&nbsp;&nbsp;</i>내 정보 수정</div>
				<table>
					<tr>
						<th>아이디</th>
						<th>비밀번호</th>
						<th>이름</th>
						<th>이메일</th>
						<th>&nbsp;</th>
						<th>전화번호</th>
						<th>주소</th>
					</tr>
					<tr>
						<td>
							<input type="text" name="member_id" value="<%=dto.getMember_id() %>" readonly="readonly"/>
						</td>
						<td>
							<input type="password" name="member_pw" maxlength="20" value="<%=dto.getMember_pw() %>" required="required"/>
						</td>
						<td>
							<input type="text" name="member_name" value="<%=dto.getMember_name() %>" required="required" readonly="readonly" onkeyup="readonly();"/>
						</td>
						<td>
							<input type="text" name="member_email"  id="member_email" value="<%=dto.getMember_email() %>" title="y" required="required" onkeyup="emailCheckInit(update);"/>
							<input type="button" value="이메일 인증" onclick="emailCheck();"/>
							<br/>
							<input type="text" name="member_email_auth" id="member_email_auth" placeholder=" 이메일 변경 시에만 입력" title="y" onkeyup="emailauthCheckInit(update);"/>
							<input type="button" value="인증 확인" onclick="emailauthCheck();" />
						</td>
						<td>
							<input type="text" name="member_phone" value="<%=dto.getMember_phone() %>" maxlength="13" required="required"/></td>
						<td>
							<input type="text" name="member_addr" id="member_addr" value="<%=dto.getMember_address() %>" required="required" readonly="readonly"/>
							<input type="button" value="주소 검색" onclick="searchAddr();"/> <br/>
							<input type="text" name="member_addr_detail" id="member_addr_detail" placeholder=" 주소 변경 시에만 입력" readonly="readonly"/>
						</td>
					</tr>	
				</table>
				<br/>
				<div id="updatebtn">
					<input id="de" type="button" value= "회원 탈퇴" onclick="myinfo_delete();"/>
					<input id="up" type="button" value="취소" onclick="back();"/>
					<input id="up" type="submit" value="수정 완료"/>
				</div>
			</div>
		</form>
	</div>

</body>
</html>