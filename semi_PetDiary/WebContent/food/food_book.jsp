<%@page import="com.pet.ft.dto.BusinessDto"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charser=UTF-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.book{
width: 30%;
border: 1px dotted red;
margin-left:730px;
margin-top: 50px;
align-content: center;

}
.book_content{
margin-left:70px;
height: 50px;

}
</style>
</head>
<body>
<%@include file="../main/header.jsp"%>
<%BusinessDto bdto = (BusinessDto)request.getAttribute("bdto"); %>

	<form action="/semi_PetDiary/pet.do" method="post">
	<input type="hidden" name="command" value="bookinsert"/>

		<div class="book">
		<h3>예약업체 : <%=bdto.getBusiness_name() %></h3>
		<h3>예약페이지 입니다.</h3>
			<div>
				<input type="hidden" name = "business_num" value="<%=bdto.getBusiness_num() %>">
				<input type="hidden" name = "book_type" value="<%=bdto.getBusiness_role() %>">
			</div>
			<div>
				<div class="book_content"><span>예약일자</span><input type="date" name="book_date"></div>
			</div>		
			<div>
				<div class="book_content"><span>예약시간</span><input type="time" name="book_time"></div>
			</div>		
			<div>
				<input type="submit" value="예약확인">
				<input type="button" value="취소" onclick="">
			</div>		
		</div>
	</form>
</body>
</html>