<%@page import="com.pet.ft.dto.CalendarDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charser=UTF-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캘린더</title>
<style type="text/css">

	body { background-color: #FFF6E3; }
	
	#top { text-align : center; color : #4D3417; padding-bottom : 50px; font-size: 25px; font-weight: 700; text-align: center; }
	
	hr { border: 1px solid #91dc85; }
	
	#w_wrap { position : absolute; background-color: white; border: 1px solid wheat; border-radius: 20px; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 610px; height: 430px; overflow: scroll; -ms-overflow-style: none; scrollbar-width: none;}
	
	#w_wrap::-webkit-scrollbar { display: none; }
	
	#wrap { padding: 30px; line-height: 20px; }	
	
	#wrap i { width: 20px; text-align: center; font-size: 18px; }
	
	#head {float: left; width: 200px; text-align: center; font-size: 18px; font-weight: 700; color: #4D3417;}
	
	#list { height:20px; padding-top: 20px; padding-bottom: 20px; background-color:rgba(0, 0, 0, 0.01); border-radius: 20px; }
	
	#title {float: left; padding-left: 10px;}
	
	#title a {text-decoration: none; color: black;}
	
	#title:hover { font-weight: 700; }
	
	#date {float: left; text-align: center;}
	
	#delete {float: left;}
	
	input[value='삭제'] { border: #91dc85 1px solid; border-radius:5px; background-color: #91dc85; color: white; cursor: pointer; }
	
	input[value='닫기'] { position:absolute; border: #91dc85 3px solid; border-radius:20px; width: 60px; height: 30px; background-color: white; bottom: 5%; cursor: pointer; }

	#close { text-align: center; }
	
</style>
<script src="https://kit.fontawesome.com/95780683f0.js" crossorigin="anonymous"></script>
<script type="text/javascript">
</script>
</head>
<body>
<%
	String year = (String) request.getAttribute("year");
	String month = (String) request.getAttribute("month");
	String date = (String) request.getAttribute("date");
	int member_no = (int) session.getAttribute("member_no");
%>
	
	<div id="top"><i class="fas fa-paw"></i>&nbsp;<span>Pet Diary</span></div>
	<div id="w_wrap">
		<div id="wrap">	
			<br/>
			<div>
				<div id="head" style="width:150px">일정</div>
				<div id="head" style="width:180px">시작</div>
				<div id="head" style="width:180px">종료</div>
				<div>&nbsp;&nbsp;<i class="far fa-trash-alt" style="color: #7D6F55"></i></div>
			</div>
			<br/>
			<hr>
			<br/>
			<c:forEach items="${list }" var="dto">
				<div id="list">
					<div id="title" style="width:140px"><a href="/semi_PetDiary/pet.do?command=calendar_calDetail&&calendar_no=${dto.calendar_no }&year=${year }&month=${month }&date=${date }"><i class="fas fa-pen" style="color:#91dc85"></i>&nbsp;&nbsp;${dto.calendar_title }</a></div>
					<div id="date" style="width:180px">
					<%=month %>월 <%=date %>일
						<c:out value="${fn:substring(dto.calendar_startdate, 8, 10)} :"/>
						<c:out value="${fn:substring(dto.calendar_startdate, 10, 12)} ~"/>
					</div>
					<div id="date" style="width:180px">
						<%=month %>월 <%=date %>일
						<c:out value="${fn:substring(dto.calendar_enddate, 8, 10)} :"/>
						<c:out value="${fn:substring(dto.calendar_enddate, 10, 12)}"/>
					</div>
					<div id="delete" style="width: 20px">
						<input type="button" value="삭제" onclick="location.href='/semi_PetDiary/pet.do?command=calendar_calDelete&calendar_no=${dto.calendar_no }&year=${year }&month=${month }&date=${date }&member_no=<%=member_no%>'"/>
					</div>
				</div>
				<br/>
			</c:forEach>
			<div id="close">
				<input type="button" value="닫기" onclick="window.close()"/>
			</div>
		</div>
	</div>		
</body>
</html>