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
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/semi_PetDiary/resources/js/script.js"></script>
<script type="text/javascript">

	$(function(){
		$("select[name=location]").change(function(){
			var crole = $(this).val();	
			var no = $(this).parents("span").find("input").val();
		    location.href="/semi_PetDiary/pet.do?command=change&no=" + no + "&role=" + crole;
		});
	});

</script>
<style type="text/css">

	body{
		background-color: #FFF6E3;
	}

	h2{width:200px; margin: 10px auto;}
	#main-background{width: 100%; height: 1219px;}
	#table {display: table; width: 70%; margin: 20px auto;}
	.row {display: table-row;}
	.main{background-color: salmon; color:white; text-align: center;}
	.cell {display: table-cell; padding: 3px; border: 0.5px solid #DDD; text-align: center;}
	.col1 {width: 1%;}
	.col2 {width: 1%;}
	.col3 {width: 1%;}
	.col4 {width: 1%;}
	.col5 {width: 1%;}
	.col6 {width: 2%;}
	.col7 {width: 3%;}
	
	.paginate{margin: 0px auto; width: 200px; text-align: center;}
	.paginate a	{color:black;}
/* 	.sizePage{border: 1px solid black;}
	.current-page {color: skyblue;} */
</style>
</head>
<body>

<%@ include file="/main/header.jsp" %>

	<div id="main-background">
		<h2>전체 회원 조회</h2>
				
				
			<div id="table">
				<div class="row main">
					<span class="cell col1">회원번호</span>
					<span class="cell col2">회원이름</span>
					<span class="cell col3">ID</span>
					<span class="cell col4">EMAIL</span>
					<span class="cell col5">등급</span>
					<span class="cell col6">전화번호</span>
					<span class="cell col7">주소</span>
				</div>
			
				<c:forEach items="${list }" var="dto" varStatus="stat">
					<div class="row">
						<span class="cell col1">
							${dto.member_no }
						</span>
						<span class="cell col2">${dto.member_name }</span>
						<span class="cell col3">${dto.member_id }</span>
						<span class="cell col4">${dto.member_email }</span>
						<span class="cell col5">
							<input type="hidden" value="${dto.member_no }" />
							<select name="location">
								<c:set var="role" value="${dto.member_role }" />
								<c:choose>
									<c:when test="${role eq 'ADMIN'}">
										<option value="ADMIN" selected>ADMIN</option>
										<option value="USER">USER</option>
										<option value="EMPLOYEE">EMPLOYEE</option>
									</c:when>
									<c:when test="${role eq 'EMPLOYEE'}">
										<option value="ADMIN">ADMIN</option>
										<option value="USER">USER</option>
										<option value="EMPLOYEE" selected>EMPLOYEE</option>
									</c:when>
									<c:otherwise>
										<option value="ADMIN">ADMIN</option>
										<option value="USER" selected>USER</option>
										<option value="EMPLOYEE">EMPLOYEE</option>
									</c:otherwise>
								</c:choose>
							</select>
						</span>
						<span class="cell col6">${dto.member_phone }</span>
						<span class="cell col7">${dto.member_address }</span>
					</div>
				</c:forEach>
			</div>
			
			<jsp:include page="/main/paging.jsp" flush="true">
				<jsp:param name="servletPath" value="${servletPath }"/>
				<jsp:param name="recordsPerPage" value="${paging.recordsPerPage }"/>
				<jsp:param name="firstPageNo" value="${paging.firstPageNo }"/>
				<jsp:param name="prevPageNo" value="${paging.prevPageNo }"/>
				<jsp:param name="startPageNo" value="${paging.startPageNo }"/>
				<jsp:param name="currentPageNo" value="${paging.currentPageNo }"/>
				<jsp:param name="endPageNo" value="${paging.endPageNo }"/>
				<jsp:param name="nextPageNo" value="${paging.nextPageNo }"/>
				<jsp:param name="finalPageNo" value="${paging.finalPageNo }"/>
			</jsp:include>
		</div>
	
<%@ include file="/main/footer.jsp" %>

</body>
</html>