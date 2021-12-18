<%@page import="com.pet.ft.dto.BusinessDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8");%>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

function PopUpSubmit(RTC) {
	var frm = document.getElementById(RTC);
		window.open('', 'viewer', 'width=1400, height=960, location = no');
		frm.action = "/semi_PetDiary/pet.do";
		frm.target = "viewer";
		frm.method = "post";
		frm.submit();
		setTimeout(() => {
			window.location.reload() 
		}, 700);
	}


</script>

<style type="text/css">
	.hospital_container{
		 width:100%; background-color:#f8f7f2; min-height:500px; padding:50px 0;
	}
	.hospital_name{
		width:100%; font-size:30px; color:black; font-weight:400; text-align:left; margin-left:120px;
	}
	.detail_box{
		width:100%; margin:30px auto;
	}
	.detail_box_img{
		float:left; width:53%; position:absolute; margin-left:120px; 
	}
	.detail_box_img .himg{
		max-height:270px;min-height:270px; border-radius:20px; max-width:400px; min-width:400px;
	}
	.detail_box_text{
		float:right; width:52%; border-top:3px solid #646361; position:relative;
	}
	.text_wrap{
		width:100%; padding:0px 0;
	}
	.text_wrap li{
		float:left; width:100%; padding:18px 0; border-bottom:1px solid #dddbd6; 
	}
	.text_wrap li:first-child{
		margin-top:1.7px;
	}
	.text_wrap li dl{
		width:100%;
	}
	.text_wrap li dt{
		float:left; width:21%; font-size:16px; font-style:strong; color:#626262; padding-left:30px; font-weight:bold;
	}
	.text_wrap li dd{
		font-size:14px; color: #a1a1a1; line-height:18px; text-align:left; overflow:hidden;
		text-overflow:ellipsis; -webkit-line-clamp:1; -webkit-box-orient:vertical;
		word-break:break-all; display:-webkit-box;		
	}
	.bookBtn{
		padding:5px 15px;
		background-color:wheat;
		cursor:pointer;
		border: 3px outset white;
		border-radius:5px;
		color: salmon;
		font-weight:bold;
	}
	.book{
		margin-top:7px;
	}	
</style>


</head>
<body>
<%
	
	int member_no = 0;
	if(session.getAttribute("member_no")!=null){
		member_no = (int)session.getAttribute("member_no");
	}
	BusinessDto dto = (BusinessDto)request.getAttribute("dto");
%>
  <%@include file="../main/header.jsp"%>
		
	<div class="hospital_container">
		<h3 class="hospital_name"><%=dto.getBusiness_name() %></h3>
		<div class="detail_box">
			<div class="detail_box_img">
				<img class="himg" src="<%=dto.getBusiness_etc() %>" />
			</div>
			<div class="detail_box_text">
			
  <form action="pet.do" method="post">
		<input type="hidden" name="command" value="counselInsert"/>
		<input type="hidden" name="business_num" value="<%=dto.getBusiness_num() %>"/>
		
				<ul class="text_wrap">
					<li>
						<dl>
							<dt>상담일자</dt>
							<dd><input type="text" name="book_date"/>  yyyymmdd형식으로 입력해주세요.</dd>
						</dl>
			    	</li>
					<li>
						<dl>
							<dt>상담유형</dt>
							<dd>
								<input type="radio" name="book_counsel" value="화상상담"/>화상상담
								<input type="radio" name="book_counsel" value="챗봇"/>챗봇
							</dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt class="book">예약신청</dt>
							<dd>
							
								<input class="bookBtn" type="submit"  value="예약신청 Click"/>
						    </dd>
						</dl>
					</li>
					
				</ul>
				
 </form>
 				<ul class="text_wrap">
					<li>
						<dl>
							<dt>화상상담</dt>
							<dd>
							
							<%if(member_no== dto.getMember_no()&&request.getAttribute("room_id")!=null){ %>
								<form  id="EndRTC"method="post">
							  		<input type="hidden" value="EndRTC" name="command">
							  		<input type="hidden" value="<%=(int)session.getAttribute("member_no") %>" name="member">
							  		<input type="hidden" value="<%= dto.getBusiness_num() %>" name="business">
							  		<input class="bookBtn" type="button" onclick="PopUpSubmit('EndRTC')" value="화상상담실 닫기">
								</form>
						  <%}else if(member_no== dto.getMember_no()){ %>
							<form  id="OpenRTC" method="post">
						  		<input type="hidden" value="OpenRTC" name="command">
						  		<input type="hidden" value="<%=(int)session.getAttribute("member_no") %>" name="member">
						  		<input type="hidden" value="<%= dto.getBusiness_num() %>" name="business">
						  		<input class="bookBtn" type="button" onclick="PopUpSubmit('OpenRTC')" value="화상 상담 시작하기">
							</form>
							<%}else if(request.getAttribute("room_id")!=null&&member_no !=0){ %>
							<form id="ConnectRTC" method="post">
						  		<input type="hidden" value="ConnectRTC" name="command">
						  		<input type="hidden" value="<%=(int)session.getAttribute("member_no") %>" name="member">
						  		<input type="hidden" value="<%= dto.getBusiness_num() %>" name="business">	
						  		<input type="hidden" value="<%=(String)request.getAttribute("room_id")%>" name="room_id" >
								<input class="bookBtn" type="button" onclick="PopUpSubmit('ConnectRTC')" value="화상 상담 연결하기">		
							</form>
							<%} %>
							
							</dd>
							
						</dl>
			    	</li>
					
				</ul>
				
				
	
 
			</div>
		</div>
	
	</div>
	

	
			</div>
		</div>
	</div>
</body>
</html>