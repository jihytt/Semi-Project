<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.pet.ft.controller.pet_util"%>
<%@page import="com.pet.ft.dto.CommunityDto"%>
<%@page import="com.pet.ft.model.PetBizImpl"%>
<%@page import="com.pet.ft.model.PetBiz"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.pet.ft.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style type="text/css">
	h2{width:200px; margin: 10px auto;}
	#table {display: table; width: 60%; margin: 20px auto; margin-bottom: 10%}
	.row {display: table-row;}
	.main{background-color: salmon; color:white; text-align: center;}
	.cell {display: table-cell; padding: 3px; border: 0.5px solid #DDD; text-align: center;}
	.col1 {width: 1%;}
	.col2 {width: 5%;}
	.col3 {width: 3%;}
	.col4 {width: 1%;}
	.col5 {width: 1%;}
	.col6 {width: 1%;}
	.col7 {width: 1%;}
	.col8 {width: 1%;}
	.row:active{
		background-color: #bbb;
	}
</style>


<body>
<%
List<CommunityDto> list = (List<CommunityDto>)request.getAttribute("list"); 
SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy.MM.dd"); //원하는 데이터 포맷 지정
%>
<%@ include file="/main/header.jsp" %>


	<h2>내 게시글 조회</h2>
		
			
		<div id="table">
			<div class="row main">
				<span class="cell col1">게시글 번호</span>
				<span class="cell col2">제목</span>
				<span class="cell col3">작성일자</span>
				<span class="cell col4">신고횟수</span>
				<span class="cell col5">조회수</span>
				<span class="cell col6">좋아요수</span>
				<span class="cell col7">댓글수</span>
			</div>
		
	
		<%for(CommunityDto dto : list){ %>	
				<%if(dto.getCommunity_report().equals("N")){%>
				<div class="row" onclick="location.href='pet.do?command=community_detail&seq=<%=dto.getCommunity_seq()%>&community_no=<%=dto.getCommunity_no()%>'">
					<span class="cell col1"><%=dto.getCommunity_seq() %></span>
					<span class="cell col2"><%=dto.getCommunity_title() %></span>
					<span class="cell col3"><%=simpleDateFormat.format(dto.getCommunity_regdate()) %></span>
					<span class="cell col4"><%=dto.getCommunity_reportcount() %></span>
					<span class="cell col5"><%=dto.getCommunity_views() %></span>
					<span class="cell col6"><%=pet_util.LikesCount(dto.getCommunity_seq()) %></span>
					<span class="cell col7"><%=pet_util.CommunityCommentCount(dto.getCommunity_seq()) %></span>
				</div>		
				<%} %>
		<%} %>
		</div>
	

<%@ include file="/main/footer.jsp" %>
</body>
</html>