<%@page import="com.pet.ft.dto.CalendarDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캘린더</title>
<style type="text/css">
	body { background-color: #FFF6E3; }
	
	#top { text-align : center; color : #4D3417; padding-bottom : 50px; font-size: 25px; font-weight: 700; text-align: center; }

	#wrap1 { position : absolute; background-color: white; border: 1px solid wheat; border-radius: 20px; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 620px; height: 470px; }
	
	#wrap2 { padding: 30px; }
	
	table { border-collapse: separate; border-spacing: 0 15px; }
	
	#wrap1 tr { font-size: 18px; color : #4D3417; }
	
	#wrap1 tr th { padding-bottom: 25px; }
	
	#wrap1 tr td a { text-decoration: none; color: black; }
	
	#wrap1 td { font-size: 15px; line-height: 30px; }
	
	#wrap1 td i { color : #91dc85; }

	#date { text-align: center; }

	#wrap1 input[value='삭제'] { border: white 2px solid; border-radius:5px; background-color: #91dc85; color: white; }
	
	#wrap1 input[value='닫기'] { position: absolute; border: #91dc85 3px solid; border-radius:20px; width: 60px; height: 30px; background-color: white; bottom: 5%; }
	
	#close { padding: 30px; text-align: center; }
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
	<div id="wrap1">
		<div id="wrap2">
			<table>
				<col width="150"/>
				<col width="200"/>
				<col width="200"/>
				<col width="20"/>
				<tr>
					<th>일정</th>
					<th>시작</th>
					<th>종료</th>
				</tr>
					<c:forEach items="${list }" var="dto">
						<tr>
							<td><a href="/semi_PetDiary/pet.do?command=calendar_calDetail&&calendar_no=${dto.calendar_no }&year=${year }&month=${month }&date=${date }"><i class="fas fa-pen"></i>&nbsp;&nbsp;${dto.calendar_title }</a></td>
							<td id="date">
							<%=month %>월 <%=date %>일
							<c:out value="${fn:substring(dto.calendar_startdate, 8, 10)} :"/>
							<c:out value="${fn:substring(dto.calendar_startdate, 10, 12)} ~"/>
							</td>
							<td id="date">
							<%=month %>월 <%=date %>일
							<c:out value="${fn:substring(dto.calendar_enddate, 8, 10)} :"/>
							<c:out value="${fn:substring(dto.calendar_enddate, 10, 12)}"/>
							</td>
							<td>
								<input type="button" value="삭제" onclick="location.href='/semi_PetDiary/pet.do?command=calendar_calDelete&calendar_no=${dto.calendar_no }&year=${year }&month=${month }&date=${date }&member_no=<%=member_no%>'"/>
							</td>
						</tr>
					</c:forEach>
			</table>
			<div id="close">
				<input type="button" value="닫기" onclick="window.close()"/>
			</div>	
		</div>		
	</div>
</body>
</html>