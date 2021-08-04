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

	#table {display: table; width: 30%; margin: 100px auto; padding: 80px 20px 50px 20px; background-color: #ffc0b6;}
	.row {display: table-row; margin: 20px 0px 0px 0px;}
	.cell {display: table-cell; padding: 3px;}
	.td{background-color: white;}
	span{width:240px; height:30px; vertical-align: middle; }
	.col1 {width: 4%;}
	.col2 {width: 1%; background-color: #ffc0b6;}
	.col3 {width: 4%;}
	#main{size: 40px;}
</style>
</head>

<%@ include file="/main/header.jsp" %>

<body>

<%
	int book_num = Integer.parseInt(request.getParameter("book_num"));
	String dateTime = (String) request.getAttribute("dateTime");
	String member_name = (String) session.getAttribute("member_name");
	String member_id = (String) session.getAttribute("member_id");
	String member_phone = (String) session.getAttribute("member_phone");
%>

		<div id="table">
			<div>
				<span id="main">예약조회 및 취소</span>
			</div>	
			<div class="row">
				<span class="cell col1">예약번호</span>
				<span class="cell col2"></span>
				<span class="cell col3">예약날짜</span>
			</div>
			<div class="row td">
				<span class="cell col1"><%=book_num %></span>
				<span class="cell col2"></span>
				<span class="cell col3"><%=dateTime %></span>
			</div>
			<br/>
			<div class="row">
				<span class="cell col1">예약자 성명</span>
				<span class="cell col2"></span>
				<span class="cell col3">예약자 전화번호</span>
			</div>
			<div class="row td">
				<span class="cell col1"><%=member_name %></span>
				<span class="cell col2"></span>
				<span class="cell col3"><%=member_phone %></span>
			</div>
			<br/>
			<div class="row">
				<span class="cell col1">예약자 아이디</span>
				<span class="cell col2"></span>
			</div>
			<div class="row td">
				<span class="cell col1"><%=member_id %></span>
				<span class="cell col2"></span>
			</div>
			<input type="button" value="예약취소" onclick="location.href='pet.do?command=bookdelete&book_num=<%=book_num %>'" />
		</div>

<%@ include file="/main/footer.jsp" %>
</body>
</html>