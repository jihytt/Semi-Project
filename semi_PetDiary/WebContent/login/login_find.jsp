<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 / 비밀번호 찾기</title>
<style type="text/css">

	body{ background-color: #FFF6E3;}

	#wrap { position : absolute; top: 50%; left: 50%; line-height: 40px; transform: translate(-50%, -50%); }

	#top { text-align : center; color : #4D3417; padding-bottom : 50px; font-size: 30px; font-weight: 700; text-align: center; }
	
	#idResult, #pwResult { font-size : 14px; font-weight: 700; color: #A759E8; text-align: center; }
	
	#find { font-weight: 700; color: #4D3417; }
	
	table{ display:flex; display: -webkit-box; display: -ms-flexbox; overflow-x: auto; overflow-y: hidden; }

	tbody { display:flex }

	table tr th { font-size: 14px; }
	
	th {width: 100px; text-align: left; font-weight: normal; }
	
	th,td{display:block}
	
	table input[type='button']{ cursor: pointer; height:}
	
	table input[type='text'] { border:#AE906E 1px solid; border-radius:15px; height: 25px; width: 200px; }

	table input[value=' 입력 '] { border: salmon 2px solid; color: white; border-radius:20px; height: 30px; width: 50px; background-color: salmon;}
	
	table input[value= ' 임시 비밀번호 발송 '] { border: salmon 2px solid; color: white; border-radius:20px; height: 30px; width: 150px; background-color: salmon;}
	
	table input[value=' 로그인 페이지로 이동 '] { border: salmon 2px solid; color: #4D3417; border-radius:20px; height: 30px; width: 150px; background-color: white; }
	
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

	function findId(){
		var name = document.getElementsByName("member_name")[0].value;
		var email = document.getElementsByName("member_email")[0].value;
		if (name.trim() == "" || name == null){
			alert("아이디를 입력해 주세요.");
		} else if (email.trim() == "" || email == null) {
			alert("이메일을 입력해 주세요.");
		} else {
			$.ajax({
				type : "POST",
				url : "/semi_PetDiary/login.do?command=login_findId&member_name="+encodeURIComponent(name)+"&member_email="+encodeURIComponent(email),
				dataType : "json",
				success : function(result){
					if(result.member_id != "null"){
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
	
	function findPw(){
		var name = document.getElementsByName("member_name")[1].value;
		var email = document.getElementsByName("member_email")[1].value;
		var id = document.getElementsByName("member_id")[0].value;
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
</head>
<body>
<%@include file="/main/header.jsp"%>
<br/>
<div id="wrap">	
	<br/>
	<div id="top"><i class="fas fa-paw"></i>&nbsp;<span>Pet Diary</span></div>
	
	<div id = "find"><i class="fas fa-angle-down"></i>&nbsp;<span>아이디 찾기</span></div>
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
	<div id="idResult"></div>
	<br/>
	<div id= "find"><i class="fas fa-angle-down"></i>&nbsp;<span>비밀번호 찾기</span></div>
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
	<div id="pwResult"></div>
</div>

</body>
</html>