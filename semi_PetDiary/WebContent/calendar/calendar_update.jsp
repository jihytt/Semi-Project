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
	
	#wrap1 { position : absolute; background-color: white; border: 1px solid wheat; border-radius: 20px; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 610px; height: 430px; }
	
	#wrap2 { position : absolute;  top: 50%; left: 50%; transform :translate(-50%, -50%); padding: 30px; width: 610px; }
	
	table { margin: auto; border-spacing: 10px; }
	
	table th { text-align: left; font-weight: 500; font-size: 15px;}
	
	textarea { border : 1px solid #AB9582; border-radius:10px; background-color: #FEFCF8; }
	
	#date { text-align: center; font-size: 18px; font-weight: 700; color : #4D3417; }

	#wrap2 input[type='text'] { background-color:#FEFCF8; border:#AB9582 1px solid; border-radius:10px; height: 20px; width: 150px; }
	
	#wrap2 input[value='취소'] { border: #91dc85 2px solid; border-radius:10px; width: 50px; height: 25px; background-color: white;}
	
	input[value='완료'] { border: #91dc85 2px solid; color: white; border-radius:10px; width: 50px; height: 25px; background-color: #91dc85; }
	
	#btn { text-align: center; }
	
</style>
<script src="https://kit.fontawesome.com/95780683f0.js" crossorigin="anonymous"></script>
<script type="text/javascript">

	function back(){
		history.back();
	}
</script>
</head>
<body>
<%
	String year = (String) request.getAttribute("year");
	String month = (String) request.getAttribute("month");
	String date = (String) request.getAttribute("date");

%>
	<div id="top"><i class="fas fa-paw"></i>&nbsp;<span>Pet Diary</span></div>
	<div id="wrap1">
		<div id="wrap2">
		<form id="update" action="/semi_PetDiary/pet.do" method="post">
			<div id="date"><i class="fas fa-edit" style="color: #91dc85"></i>&nbsp;&nbsp;<%=year %>년 <%=month %>월 <%=date %>일</div>
			<br/>
			<input type="hidden" name="command" value="calendar_calUpdateform"/>
			<input type="hidden" name="calendar_no" value="${dto.calendar_no }"/>
			<input type="hidden" name="member_no" value="${dto.member_no }"/>
			<input type="hidden" name="year" value="<%=year %>"/>
			<input type="hidden" name="month" value="<%=month %>"/>
			<input type="hidden" name="date" value="<%=date %>"/>
			<table>
				<tr>
					<th>일정 :</th>
					<td>
						<input type="text" name="calendar_title" value="${dto.calendar_title }"/>
					</td>
				</tr>
				<tr>
					<th>시작 :</th>
					<td>
						<input type="text" name="calendar_startdate" value="<%=month %>월 <%=date %>일 <c:out value="${fn:substring(dto.calendar_startdate, 8, 10)}:"/><c:out value="${fn:substring(dto.calendar_startdate, 10, 12)}"/>" readonly="readonly"/>
					</td>
				</tr>
				<tr>
					<th>종료 :</th>
					<td>
						<input type="text" name="calendar_enddate" value="<%=month %>월 <%=date %>일 <c:out value="${fn:substring(dto.calendar_enddate, 8, 10)}:"/><c:out value="${fn:substring(dto.calendar_enddate, 10, 12)}"/>" readonly="readonly"/>
					</td>
				</tr>
				<tr>
					<th>필수품 :</th>
					<td>
						<input type="text" name="calendar_necessity" value="${dto.calendar_necessity }"/>
					</td>
				</tr>
				<tr>
					<th>세면/화장도구 :</th>
					<td>
						<input type="text" name="calendar_item" value="${dto.calendar_item }"/>
					</td>
				</tr>
				<tr>
					<th>상세 내용 :</th>
					<td>
						<textarea name="calendar_content" style="resize: none;" cols="30" rows="7">${dto.calendar_content }</textarea>
					</td>
				</tr>
			</table>
			<br/>
			<div id="btn">
				<input type="submit" value="완료"/>
				<input type="button" value="취소" onclick="history.back();" />
			</div>
		</form>	
		<br/>
		</div>
	</div>
</body>
</html>