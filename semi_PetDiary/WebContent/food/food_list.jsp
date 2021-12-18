<%@page import="java.util.List"%>
<%@page import="com.pet.ft.model.PetDao"%>
<%@page import="com.pet.ft.model.PetDaoImpl"%>
<%@page import="com.pet.ft.dto.BusinessDto"%>
<%@page import="com.pet.ft.model.PetBizImpl"%>
<%@page import="com.pet.ft.model.PetBiz"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charser=UTF-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">

.foodlist{
    	 border-top: none;
 		 display: grid;
    	 padding: 30px;
    	 margin: 10px;
    	 border-top: 4px;
}
	.paginate a{
		color:black;
		border:2px outset ;
		border-color:salmon;
		border-radius:4px;
		float:center;
	}
	.pic{
		width: 150px;
		height: 150px;
	}

 <%--식당지도--%>
.food_search .food_map{
		margin:10px;
		padding: 2px;
		font-size:16px;
		width:200px;
		border:none;
		background-color:wheat;
		color:salmon;
		cursor:pointer;
		border-radius:10px;	
		
	}
.food_search{
	text-align:center;
}

</style>
</head>
<body>
 <%@include file="../main/header.jsp"%>
 <%List<BusinessDto> list = (List<BusinessDto>)request.getAttribute("list"); %>
 
 
 		<%--식당지도 --%>
 		<div class="food_search">
			<input class="food_map" type="button" value="지도상에서 가게보기" onclick="mapPop();"/>
		</div>
 
 
<%
		for(BusinessDto bdto : list){
%>		
		<div class="foodlist">	
		
				
			<div class="foodlist_content">
			<img class="pic" alt="사진" src="">
				<div>번호 : <%=bdto.getBusiness_num() %></div>			
				<div>번호 : <%=bdto.getBusiness_role() %></div>			
			

				<div>이름 : <%=bdto.getBusiness_name() %></div>
				<div>주소 : <%=bdto.getBusiness_addr() %></div>
				<div>전화번호 : <%=bdto.getMember_phone() %></div>
				<div>메뉴 : <%=bdto.getMenu_name() %></div>
				<div>가격  : <%=bdto.getMenu_price() %></div>
				<div>주차 : <%=bdto.getBusiness_park() %></div>
				<input type="button" value="예약" onclick="location.href='/semi_PetDiary/pet.do?command=bookform&business_num=<%=bdto.getBusiness_num() %>'" />
			</div>
		</div>
<%
		}
%>
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

		<%--식당지도 --%>
	<script type="text/javascript">
		function mapPop(){
			var popup = window.open('./food/food_map.jsp', '지도', 'width=700px,height=800px,scrollbars=yes');
		}
		
	
	</script>





</body>
</html>