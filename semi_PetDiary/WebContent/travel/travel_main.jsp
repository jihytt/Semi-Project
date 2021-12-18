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
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style type="text/css">

	.travel_header{
		padding-top:30px;
		width:100%;
		height:150px;
		text-align:center;
		background-color:wheat;
		color:salmon;
		
	}
	.travel_header p:first-child{
		font-size:50px;
		font-style:strong;
	}
	.travel_header p:last-child{
		padding-top:2px;
		font-size:21px;
		font-style:strong;
	}

	
	.travel_list{
		background-color: #f9f9f9;
        width: 1260px;
		height: 630px;
	}
	.travel_section {
    	 border-top: none;
 		 display: grid;
    	 grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
 		 gap: 3rem 1rem;
    	 padding: 3rem 0;
    	 margin: 0 1.5rem;
    	 border-top: 4px solid #ccc;
	}
	.travel_container {
  		display: flex;
  		flex-direction: column;
  		
	}
	.travel_image {
		border-radius:12px;
  		width: 100%;
  		height: 100%;
  		max-height:180px;
  		min-height:180px;
  		background-color:wheat;
	}
	.travel_bottom_section {
  		text-align:center;
 		margin-top:5px;
 		
 		 
	}
	
	.travel_details {
		  display: flex;
  	      flex-direction: column;
  	     
  	    
  	     
	}
	.travel_details .travel_title {
  		font-size: 1.1rem;
  		font-weight: bold;
  		margin-bottom: 0.5rem;
  		text-decoration: none;
  		color: grey;
	}
	.travel_title:hover{
		color:black;
	}
	

	.paginate{
		text-align:center;
		margin:5px auto 5px auto;
	}
	.paginate a{
		
		color:#3a3828;
		padding:1px 4px;
		font-style:bold;
		border:outset;
		border-color:#a3a1a4 ;
		border-radius:4px;
				
	}
	.paginate a:hover{
		color:white;
		background-color:#7b797a;
	}
	.travel_create{
		color:#e35140;
		background-color:#ffeedc;
		font-style:bold;
		font-size:14px;
		cursor:pointer;
		margin:9px;
		padding:6px 30px; 
		border-radius:4px;
		border-color:#cccccc;
		
	}
	
</style>

</head>
<body>


	<%@include file="../main/header.jsp"%>
	<div class="travelmain">
		<div class="travel_header">
			<p>여행일정 안내</p><br>
			<p>반려동물과 함께 하는 여행을 계획해보세요.</p><br>
			<input class="travel_create" type="button" value=" Create " onclick="location.href='pet.do?command=insertform'">
		</div>	

		<%--여행리스트 --%>	
		<div class="travel_list">
			<section class="travel_section">
				
				<c:choose>
					<c:when test="${empty list }">
						<p>등록된 일정이 없습니다.</p>
					</c:when>
					<c:otherwise>
						<c:forEach items="${list }" var="dto">
			 			<article class="travel_container">
         				 	<a href="pet.do?command=travelselect&travel_no=${dto.travel_no}"><img class="travel_image" src="./resources/image/travel.jpg"/></a>
           
          
         					<div class="travel_bottom_section">
           						<div class="travel_details">
              						<a href="pet.do?command=travelselect&travel_no=${dto.travel_no}" class="travel_title">${dto.travel_name}</a>
             						<p class="travel_date">${dto.travel_date}</p>
              					</div>
         					</div>
       					</article>
       			 		</c:forEach>
       				</c:otherwise>
       			</c:choose>
            </section>
		</div>

	</div>


</body>
</html>