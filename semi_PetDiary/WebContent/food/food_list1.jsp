<%@page import="java.util.List"%>
<%@page import="com.pet.ft.model.PetBizImpl"%>
<%@page import="com.pet.ft.model.PetBiz"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.pet.ft.dto.BusinessDto"%>
<%@page import="com.pet.ft.model.BusinessDao"%>
<%@page import="com.pet.ft.model.BusinessDaoImpl"%>
<%@page import="com.pet.ft.dto.BusinessDto"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.pet.ft.dto.MemberDto"%>
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
<script type="text/javascript" src="/semi_PetDiary/resources/js/script.js"></script>
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
		font-size: 28px;
		margin: 5px;
		border:0px outset;
		border-color:black;
		border-radius:4px;
		float:center;
		position: relative;
		bottom: 50px;
		left: 280px;
		
	}

	
	#imgbox{
		width: 272px;
		height: 200px;
		float: right;
		position: relative;
		top: 0px;
		right: 0px;
	}
	.foodimg{
		width: 100%;
		height: 100%;
	}
	#listbox{
		width: 1000px;
		height: 200px;
    	position: relative;
    	left: 207px;
    	background-color: #D8D8D8;
    	
}
#bookbutton {
	 width: 120px;
  height: 20px;
  font-family: 'Roboto', sans-serif;
  font-size: 11px;
  text-transform: uppercase;
  letter-spacing: 2.5px;
  font-weight: 500;
  color: #000;
  background-color: #fff;
  border: none;
  border-radius: 45px;
  box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease 0s;
  cursor: pointer;
  outline: none;
  }

#bookbutton:hover {
  background-color: salmon;
  box-shadow: 0px 15px 20px rgba(251, 194, 173, 0.4);
  color: #fff;
  transform: translateX(+5px);
}

#menu{
	height: 100px;
	width: 389px;
	position: relative;
	top:-90px;
	right: -335px;
}
.foodMap{
	text-align:center;
}
.food_map{
			margin: 8px; 
		padding: 2px;
		border:none;
		font-size:16px;
		width:200px;
		background-color:salmon;
		color:wheat;
		cursor:pointer;
		border-radius:10px;	
	
}

</style>
</head>
<body>
 <%@include file="../main/header.jsp"%>
	<%
HashMap<String, Integer> map= (HashMap<String, Integer>)request.getAttribute("map");
MemberDto dto = (MemberDto)request.getAttribute("dto");
%>
 
	<div class="foodMap">
		<input class="food_map" type="button" value="등록된 가게 보기" onclick="foodMapPop();"/>
	</div>
		<div class="foodlist">
			<section>
				<c:choose>
					<c:when test="${empty list }">
						<p>등록된 식당이 없습니다.</p>
					</c:when>
					<c:otherwise>
						<c:forEach items="${list }" var="bdto">
						<article>
							<a href="pet.do?command=bookform&business_num=${bdto.business_num}"></a>
							
								<div class="foodlist">
									<div id="listbox">
										<div id="imgbox"><img class="foodimg" src="${bdto.business_etc}"/></div>
										<div><h3>${bdto.business_name}</h3></div>
										<div>${bdto.business_addr}</div>
										<div>${bdto.member_phone}</div>
										<div><!-- 주차 여부 표시 -->
											<c:if test="${bdto.business_park eq'Y'}">주차가능</c:if>
											<c:if test="${bdto.business_park eq'N'}">주차불가</c:if>
										</div>
										<div><!-- 예약부분(예약가능시 버튼 활성화) -->
											<c:if test="${bdto.business_book eq'N'}">예약불가</c:if>
											<c:if test="${bdto.business_book eq'Y'}">
												<input id="bookbutton" type="button" value="예약" onclick="location.href='/semi_PetDiary/pet.do?command=bookform&business_num=${bdto.business_num}'" />
											</c:if>
										<div id="menu"><!--메뉴박스 부분. -->
											<c:set var="a" value="${bdto.business_num}" />
											<c:forEach items="${list1 }" var="bdto">
												<c:if test="${bdto.business_num == a}">
													${bdto.menu_name} : ${bdto.menu_price }</br>
												</c:if>
											</c:forEach>
										</div>
										</div>
									</div>
								</div>
							</article>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</section>	
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

	<script type="text/javascript">

		function foodMapPop(){
			var popup = window.open('./food/food_map.jsp', '등록된 가게 지도', 'width=700px,height=600px,scrollbars=yes');
		}
		
		
	
	</script>


</body>
</html>