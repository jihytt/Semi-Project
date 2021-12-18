<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캘린더</title>
<style type="text/css">
	
	#wrap { border: 1px solid #ccc; position : absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); text-align: center; }
	
	#head { font-size: 20px; text-align: center; padding-bottom: 20px; }

	select { color: #999; border: 1px solid white; }
	
	#start, #end { padding: 5px; font-size: 15px; font-weight: 700; }
	
	#start_date, #end_date { padding-bottom: 10px; font-size: 15px; }
	
	#insert { width:400px; margin-top: 30px; margin-bottom: 30px; }
	
	#insert input[type='text'] { border:#ccc 1px solid; border-radius:10px; height: 20px; width: 240px; margin: 10px; }

	table { bordor-collapse: collapse; }
	
	th, td { border: 1px solid salmon; padding: 5px; }
	
	textarea { border : 1px solid #ccc; border-radius:10px; margin: 10px; }
	
	#insert input[type='button'] { border: salmon 2px solid; border-radius:5px; height: 25px;  background-color: white; cursor: pointer;}
	
	#insert input[type='submit'] { border: salmon 2px solid; color: white; border-radius:5px;  height: 25px; background-color: salmon; cursor: pointer;}

</style>
<script src="https://kit.fontawesome.com/95780683f0.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

</script>
</head>
<body>

<%
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	int lastDay = Integer.parseInt(request.getParameter("lastDay"));
		
	Calendar cal = Calendar.getInstance();
	int hour = cal.get(Calendar.HOUR_OF_DAY);
	int min = cal.get(Calendar.MINUTE);
	
	int member_no = (int) session.getAttribute("member_no");
%>
	<div id="wrap">
	<form id="insert" action="/semi_PetDiary/pet.do" method="post">
		<input type="hidden" name="command" value="calendar_insert"/>
		<input type="hidden" name="member_no" value="<%=member_no%>"/>
		<div id="head"><i class="far fa-calendar-plus" style="color : salmon"></i>&nbsp;일정 등록하기</div>
			<input type="text" name="calendar_title" placeholder=" 일정 제목을 입력해 주세요. " required="required"/>
			<div id="start">
				<div><i class="fas fa-seedling" style="color: #91dc85;"></i>&nbsp;&nbsp;시작</div>
			</div>
			<div id="start_date">
				<select name="s_year" id="s_year">
					<option value="<%=year%>"><%=year %></option>
				</select>년
				<select name="s_month" id="s_month">
<%
					for (int i = 1; i < 13; i++) {
%>						
					<option value="<%=i %>" <%=(month==i)? "selected": "" %> ><%=i %></option>
<%
					}
%>
				</select>월
				<select name="s_date" id="s_date">
<%
					for (int i = 0; i <= lastDay; i++) {
%>
					<option value="<%=i %>" <%=(date==i)? "selected": "" %>><%=i %></option>	
<%
					}
%>
				</select>일
				<select name="s_hour" id="s_hour">
<%
					for (int i = 0; i < 24; i++) {
							
%>					
					<option value="<%=i %>" <%=(hour==i)? "selected":"" %>><%=i %></option>
<%
					}
%>	
				</select>시
				<select name="s_min" id="s_min">
<%
					for (int i = 0; i < 60; i+=10) {
%>					
					<option value="<%=i %>" <%=(min==i)? "selected":"" %>><%=i %></option>
<%
					}
%>
				</select>분
		</div>
		<div id = "end">
			<div><i class="fas fa-seedling" style="color: #91dc85;"></i>&nbsp;&nbsp;종료</div>
		</div>
			<div id="end_date">
				<select name="e_year">
	
					<option value="<%=year%>"><%=year %></option>
		
					</select>년
					<select name="e_month">
<%
					for (int i = 1; i < 13; i++) {
%>						
					<option value="<%=i %>" <%=(month==i)? "selected": "" %> ><%=i %></option>
<%
					}
%>
	
				</select>월
				<select name="e_date">
<%
					for (int i = 0; i <= lastDay; i++) {
%>
					<option value="<%=i %>" <%=(date==i)? "selected": "" %>><%=i %></option>	
<%
					}
%>
				</select>일
				<select name="e_hour">
<%
					for (int i = 0; i < 24; i++) {
							
%>					
					<option value="<%=i %>" <%=(hour==i)? "selected":"" %>><%=i %></option>
<%
					}
%>	
				</select>시
				<select name="e_min">
<%
					for (int i = 0; i < 60; i+=10) {
%>					
					<option value="<%=i %>" <%=(min==i)? "selected":"" %>><%=i %></option>
<%
					}
%>
				</select>분
			</div>
			<div>
				<input type="text" name="calendar_necessity" maxlength="150" placeholder=" 필수품 " required="required"/>
			</div>
			<div>
				<input type="text" name="calendar_item" maxlength="150" placeholder=" 세면/화장도구 " required="required"/>
			</div>
			<div>
				<textarea name="calendar_content" cols="33" rows="10" maxlength="1000" placeholder=" 상세 내용을 입력해주세요. " required="required" style="resize: none;"/></textarea>
			</div>
			<div>
				<input type="submit" value="등록"/>
				<input type="button" value="취소" onclick="history.back()"/>	
			</div>
	</form>
	</div>
</body>
</html>