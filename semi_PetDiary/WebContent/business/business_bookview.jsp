<%@page import="com.pet.ft.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/semi_PetDiary/resources/js/script.js"></script>

<script type="text/javascript">
	$(function(){
		var i = $("div[id=table]").parent
	})
</script>

<style type="text/css">

	body{
		background-color: #FFF6E3;
	}

	#table {display: table; width: 30%; margin: 100px auto; padding: 80px 20px 50px 20px; background-color: #ffc0b6; border-radius: 25px;}
	#main-background{width: 100%; height: 1219px;}
	.row {display: table-row; margin: 20px 0px 0px 0px;}
	.cell {display: table-cell; padding: 3px;}
	.td{background-color: white;}
	span{width:240px; height:30px; vertical-align: middle; }
	.col1 {width: 4%;}
	.col2 {width: 1%; background-color: #ffc0b6;}
	.col3 {width: 4%;}
	
	#main{    
		font-size: 30px;
	    position: relative;
	    bottom: 30px;
	    }
	
	hr{
		bottom: 10px;
	    border: 1px solid bisque;
	    position: relative;
	}
	
	#top{
		position: relative;
	    font-size: 40px;
	    left: 799px;
	    top: 40px;
	}
</style>
</head>

<%@ include file="/main/header.jsp" %>

<body>

<%
	int book_num = Integer.parseInt(request.getParameter("book_num"));
	String dateTime = (String) request.getAttribute("dateTime");
	MemberDto dto = (MemberDto) session.getAttribute("dto");
%>

	<div id="main-background">
	
		<div id="top"><i class="fas fa-paw"></i>&nbsp;<b><span>Pet Diary</span></b></div>
	
		<div id="table">
			<div>
				<b><span id="main">예약조회 및 취소</span></b>
			</div>	
			<hr/>
			<div class="row">
				<b><span class="cell col1">예약번호</span></b>
				<span class="cell col2"></span>
				<b><span class="cell col3">예약날짜</span></b>
			</div>
			<div class="row td">
				<span class="cell col1"><%=book_num %></span>
				<span class="cell col2"></span>
				<span class="cell col3"><%=dateTime %></span>
			</div>
			<br/>
			<div class="row">
				<b><span class="cell col1">예약자 성명</span></b>
				<span class="cell col2"></span>
				<b><span class="cell col3">예약자 전화번호</span></b>
			</div>
			<div class="row td">
				<span class="cell col1"><%=dto.getMember_name() %></span>
				<span class="cell col2"></span>
				<span class="cell col3"><%=dto.getMember_phone() %></span>
			</div>
			<br/>
			<div class="row">
				<b><span class="cell col1">예약자 아이디</span></b>
				<span class="cell col2"></span>
			</div>
			<div class="row td">
				<span class="cell col1"><%=dto.getMember_id() %></span>
				<span class="cell col2"></span>
			</div>
			<input type="button" value="예약취소" onclick="location.href='pet.do?command=bookdelete&book_num=<%=book_num %>'" />
		</div>
	</div>

<%@ include file="/main/footer.jsp" %>
</body>
</html>