<%@page import="com.pet.ft.model.PetDao"%>
<%@page import="com.pet.ft.model.PetDaoImpl"%>
<%@page import="com.pet.ft.dto.BusinessDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8");%>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1">


<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="../resources/js/script.js"></script>


<style type="text/css">
	.hospital{
		
	}
	.hospital_header{
		padding-top:30px;
		width:100%;
		height:150px;
		text-align:center;
		background-color:wheat;
		color:salmon;
		
	}
	.hospital_header p:first-child{
		font-size:50px;
		font-style:strong;
	}
	.hospital_header p:last-child{
		padding-top:2px;
		font-size:21px;
		font-style:strong;
	}
	.hospital_search .hospital_map{
		margin: 10px 500px; 
		padding: 2px;
		font-size:16px;
		width:300px;
		height:40px;
		background-color:salmon;
		color:wheat;
		cursor:pointer;
		border-radius:12px;
		
	}
	
	.hospital_list{
		background-color: #f9f9f9;
        width: 1260px;
		height: 630px;
	}
	.hospital_section {
    	 border-top: none;
 		 display: grid;
    	 grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
 		 gap: 3rem 1rem;
    	 padding: 3rem 0;
    	 margin: 0 1.5rem;
    	 border-top: 4px solid #ccc;
	}
	.hospital_container {
  		display: flex;
  		flex-direction: column;
	}
	.hospital_image {
		border-radius:12px;
  		width: 100%;
  		height: 100%;
  		max-height:180px;
  		background-color:wheat;
	}
	.hospital_bottom_section {
  		display: flex;
 		 align-items: flex-end;
 		 margin-top: 1rem;
 		 
	}
	
	.hospital_details {
		  display: flex;
  	      flex-direction: column;
  	     
	}
	.hospital_details .hospital_title {
  		font-size: 1.1rem;
  		font-weight: bold;
  		margin-bottom: 0.5rem;
  		text-decoration: none;
  		color: grey;
	}
	.hospital_title:hover{
		color:black;
	}
	
	.hospital_phone {
	    margin-bottom: 0.1rem;
 	    text-decoration: none;
 	    color:black;
	}
	.paginate a{
		color:black;
		border:2px outset ;
		border-color:salmon;
		border-radius:4px;
		float:center;
		
		
	}
	


	
</style>

</head>
<body>


	<%@include file="../main/header.jsp"%>
	<div class="hospital">
		<div class="hospital_header">
			<p>동물병원 안내</p><br>
			<p>화상상담/챗봇 연결을 통해 반려견의 상태를 진단받을 수 있습니다.</p>
		</div>	
		<%--병원리스트 --%>	
		<div class="hospital_search">
			<input class="hospital_map" type="button" value="지도에서 병원찾기" onclick="mapPop();"/>
		</div>
		<div class="hospital_list">
			<section class="hospital_section">
				<c:choose>
					<c:when test="${empty list }">
						<p>등록된 병원이 없습니다.</p>
					</c:when>
					<c:otherwise>
						<c:forEach items="${list }" var="dto">
			 			<article class="hospital_container">
<<<<<<< HEAD
         				 	<a href="pet.do?command=hospitalselect&business_num=${dto.business_num}"><img class="hospital_image" src="./resources/image/tico1.png"/></a>       
         					<div class="hospital_bottom_section">
           						<div class="hospital_details">
              						<a href="pet.do?command=hospitalselect&business_num=${dto.business_num}" class="hospital_title">${dto.business_name}</a>
             						<p class="hospital_addr">${dto.business_addr}</p> 						
=======
         				 	<a href="pet.do?command=hospitalselect&business_num=${dto.business_num}"><img class="hospital_image" src="./resources/image/tico1.png"/></a>
           
          
         					<div class="hospital_bottom_section">
           						<div class="hospital_details">
              						<a href="pet.do?command=hospitalselect&business_num=${dto.business_num}" class="hospital_title">${dto.business_name}</a>
             						<p class="hospital_addr">${dto.business_addr}</p>
>>>>>>> ig
              					</div>
         					</div>
       					</article>
       			 		</c:forEach>
       				</c:otherwise>
       			</c:choose>
            </section>
		</div>

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
<<<<<<< HEAD
			
=======
>>>>>>> ig
	</jsp:include>
	
	
	<script type="text/javascript">
		function mapPop(){
			var popup = window.open('./hospital/map.jsp', '지도', 'width=700px,height=800px,scrollbars=yes');
		}
		
	
	</script>



</body>
</html>