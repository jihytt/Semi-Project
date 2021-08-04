<%@page import="com.pet.ft.dto.BusinessDto"%>
<%@page import="com.pet.ft.model.PetBizImpl"%>
<%@page import="com.pet.ft.model.PetBiz"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 모드</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">

	.viewMember, .viewBorder{
		position: fixed;
		border-bottom : 2px solid black;	
		background-color: skyblue;
		text-align: center;
		cursor:pointer
	}
	
	.viewMember{
		width:150px;
		height:150px;
		border-radius:75px;
		text-align:center;
		font-size:12px;
		vertical-align:middle;
		line-height:150px;
		margin: 150px 8
		00px;
	}
	
	.viewBorder{
		background-color:#0009;
		width:150px;
		height:150px;
		border-radius:75px;
		text-align:center;
		margin:0 auto;
		font-size:12px;
		vertical-align:middle;
		line-height:150px;
	}
	
	.viewMember:hover, .viewBorder:hover, .viewBook:hover{
		background-color:mistyrose;
	}
	
	.viewBorder {
		margin: 150px 1000px;
		background-color: #ff6670;
	}
	
	.viewBook{
		margin: 150px 50px;
		background-color: gray;
	}
	
	.datetime{
		margin: 250px 50px;
	}
	
</style>

</head>
<body>

<%@ include file="/main/header.jsp" %>

<%
	PetBiz biz = new PetBizImpl();
	int mRes = biz.totalMember();
	int rRes = biz.totalReport();
	
	System.out.println((int)session.getAttribute("member_no"));
	
%>

	<!-- <div class="viewMember" onclick="location.href='/semi_PetD	iary/pet.do?command=list'"> -->
	<div class="viewMember" onclick="location.href='/semi_PetDiary/paging.do?command=member'">
		<span>전체 회원 조회 : </span>&nbsp;
		<span class="dot"><%=mRes %></span>
	</div>

	<div class="viewBorder" onclick="location.href='/semi_PetDiary/paging.do?command=report'">
		<span>신고 글 조회 : </span>&nbsp;
		<span class="dot"><%=rRes %></span>
	</div>
	
<%@ include file="/main/footer.jsp" %>

</body>
</html>