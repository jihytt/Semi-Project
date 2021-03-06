<%@page import="com.pet.ft.dto.CalendarDto"%>
<%@page import="java.util.List"%>
<%@page import="com.pet.ft.model.PetDao"%>
<%@page import="com.pet.ft.model.PetDaoImpl"%>
<%@page import="com.pet.ft.controller.pet_util"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캘린더</title>
<style type="text/css">

	#wrap { position : absolute; }
	
	select { border : 1px solid white; }
	
	#calendar { margin: 0 auto; padding-top: 60px; }
	
	#sform { top: 140px; left: 65%; }
	
	caption { font-weight: 700; }
	
	table { border-collapse:collapse; /*셀 사이 간격 없애기*/}
	
	th, td { border: 1px solid #E5E3D8; width: 80px; text-decoration : none; }
	
	th { height: 40px; font-size: 14px; background-color: #F3F3F3; font-weight: 700;}
	
	td { height: 70px; vertical-align: top; }
		 
	caption { margin-bottom: 10px; font-size: 20px; }
	
	a { text-decoration: none; color: salmon; }
		
	.date { font-size: 15px; padding: 3px; }
	
	#view { font-size: 12px; width: 60px; border-radius: 5px; vertical-align: middle; text-align: center; margin: 5px; }
	
	input[value='보기'] { border: salmon 1px solid; color: white; border-radius:5px; height: 25px; background-color: salmon; }	
		
</style>
<script src="https://kit.fontawesome.com/95780683f0.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">

	window.onload = function(){
	
		var view = document.getElementsByName('view');
		
		// 달력에 표시되는 일정 제목 배경 색상 배정
		for (var i = 0; view.length; i++){
			var color = "#";
			var letters = ['ffffb3', 'FEC2C2', 'D8ECB5', 'BEED67', 'C8ECFC', 'BCACFD', 'FFD2BC', 'FFA5BD', 'FCE6AF', 'B7F9F4', 'DECDFE', 'BA9DF4'];
			if (i < letters.length) {
				color += letters[i];
			} else {
				color += letters[Math.floor(Math.random() * letters.length)];
			}
			view[i].style.background = color;
		}
	}
	
	// 달력 위의 일정 제목 클릭 시 팝업창 열기
	function calendar_list(year, month, d, member_no) {
		var year = year;
		var month = month;
		var date = d;
		var member_no = member_no;
		
		var popupWidth = 670;
		var popupHeight = 520;
		var popupX = (window.screen.width / 2) - (popupWidth / 2);
		var popupY= (window.screen.height / 2) - (popupHeight / 2);
			
		open("/semi_PetDiary/pet.do?command=calendar_list&year="+year+"&month="+month+"&date="+date+"&member_no="+member_no, "", 'height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY + 'resizable=no');
	}

</script>
</head>
<body>

<%

	PetDao dao = new PetDaoImpl();

	Calendar cal = Calendar.getInstance();; // 표준시간대를 이용해서 달력을 가져온다.
	// singleton : 객체를 단 한번만 생성
	
	// 연도, 월 설정
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH) +1;
	
	
	String paramYear = request.getParameter("year");
	String paramMonth = request.getParameter("month");
	
	if (paramYear != null && paramYear != "") {
		year = Integer.parseInt(paramYear);
	}
	
	if (paramMonth !=null && paramYear != "") {
		month = Integer.parseInt(paramMonth);
	}
	
	// 달이 12보다 커지면 연도 증가, 월은 1월로
	if (month > 12){
		year++;
		month = 1;
	}
	
	// 달이 1보다 작아지면 연도 감소, 월은 12월로
	if (month < 1){
		year--;
		month = 12;
	}
	
	// year년 month월 1일로 Calendar 객체 설정
	cal.set(year,month-1,1);
	
	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK); // 1일의 요일
	int lastDay = cal.getActualMaximum(Calendar.DATE);  // 마지막 날
	
	String yyyyMM = year + pet_util.isTwo(String.valueOf(month));
	
	int member_no = (int) session.getAttribute("member_no");

	// 회원의 해당 월의 일정 list를 불러옴
	List<CalendarDto> list = dao.CalViewList(member_no, yyyyMM);
%>
	<div id = "wrap">
		<div id= "sform">
			<!-- 연월 선택 시 해당 달력으로 이동 -->
			<form method="post" action="/semi_PetDiary/calendar/calendar_main.jsp">
			<i class="far fa-calendar-alt"></i>
				<select name="year">
<%			
					for (int i = year-3; i <= year+3; i++){
%>
					<option value="<%=i %>" <%=(year==i)? "selected":"" %> ><%=i %></option>
<%
					}
%>					
					</select>년
					<select name="month">
<%
					for (int i = 1; i < 13; i++) {
%>						
					<option value="<%=i %>" <%=(month==i)? "selected": "" %> ><%=i %></option>
<%
					}
%>
				</select>월
				<input type="submit" value="보기"/>
			</form>
		</div>
		<br/>
		<table id = "calendar">
			<!-- 아이콘 클릭 시 해당 달력으로 이동 -->
			<caption>
				<a href="/semi_PetDiary/calendar/calendar_main.jsp?year=<%=year-1%>&month=<%=month%>" style="color:#FFB2A9"><i class="fas fa-angle-double-left"></i></a>
				<a href="/semi_PetDiary/calendar/calendar_main.jsp?year=<%=year%>&month=<%=month-1%>" style="color:salmon"><i class="fas fa-angle-left"></i></a>
				<span class="y"><%=year %>년</span> <span class="m"><%=month%>월</span>
				<a href="/semi_PetDiary/calendar/calendar_main.jsp?year=<%=year%>&month=<%=month+1%>" style="color:salmon"><i class="fas fa-angle-right"></i></a>
				<a href="/semi_PetDiary/calendar/calendar_main.jsp?year=<%=year+1%>&month=<%=month%>" style="color:#FFB2A9"><i class="fas fa-angle-double-right"></i></a>
			</caption>
			
			<!-- 달력 날짜 표시 -->
			<tr id="day">
				<th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th>
			</tr>
			<tr>			
<%
		int count = 0;

		// 1일 전까지 공백칸 채우기
		for (int i = 0; i < dayOfWeek-1; i++) {
			out.print("<td></td>");
			count++;
		}
		
		for(int d = 1; d <= lastDay; d++) {
			count++;
			
			String color="black";
			if (count == 7) {
				color = "blue";
			} else if (count == 1) {
				color = "red";
			}
%>				
			<td id="dates">
				<!-- 날짜 클릭 시 일정 등록 창으로 이동 -->
				<a class="date" style="color:<%=color%>; cursor: pointer" onclick="location.href='/semi_PetDiary/pet.do?command=calendar_insertform&year=<%=year%>&month=<%=month%>&date=<%=d%>&lastDay=<%=lastDay %>'"><%=d%></a>
				<div>
				<!-- 해당 날짜에 등록된 일정이 있으면 달력에 출력 -->
				<a id="calendar_list" style="cursor: pointer; color: black" onclick="calendar_list('<%=year%>','<%=month%>','<%=d%>','<%=member_no%>')">			
					<%=pet_util.getCalView(d, list)%>
				</a>
				</div>	
			</td>
	
<%

		if(count == 7) {
			out.print("</tr><tr>");
			count = 0;
			}
		}	
		
		// 마지막 날짜 이후 공백칸 채우기
		for (int i = 0; i < (7-(dayOfWeek-1 + lastDay)%7)%7; i++){
			out.print("<td></td>");
		}	
%>
			</tr>
		</table>		
	</div>	
</body>
</html>