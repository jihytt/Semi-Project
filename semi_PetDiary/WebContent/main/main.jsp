<% request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8"); %> <%@ page
contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title>펫 다이어리</title>
    <link href="/semi_PetDiary/resources/css/main_view.css"  rel="stylesheet" type="text/css" />
    
    <script type="text/javascript">
      function registForm() {
        location.href = "/semi_PetDiary/pet.do?command=login_Signup";
      }
    </script>
  <style>
  	#intro{
		width: 100%;
	    height: 800px;
	    background-color: salmon;
  	}
  	
  	#about{
		width: 100%;
	    height: 800px;
	    background-color: antiquewhite;
  	}
  	#service{
  	padding-bottom:200px;
  	 }
  	
  	.main_content{
	width: 70%;
    height: 70%;
    margin: 0 auto;
    padding: 5%;
    display: flex;
  	}
  	.main_pet{
 		width: 500px;
 		height: 500px;
 		border-radius: 250px;
 		margin-top: 30px
  		
  	}
  	.main_content_title{
    font-size: 100pt;
    font-weight: bold;
    color: darkslategrey;
    margin-left: 100px;
    display: table;
	}
  	.main_content_text{
    font-size: 20pt;
    text-align: center;
    margin: 20px;
    margin-top: 40px;
    color: darkslategrey;
}
 .service_pet{
  		width: 250px;
  		height: 250px;
  		border-radius: 125px;
  		margin-top: 30px;
 }
 .main_services{
	width: 100%;
    height: 70%;
    padding-bottom: 150px
 }
 .service_content{
     margin: 25px;
     margin-left : 100px;
 }
 .service_content_title{
    font-size: 70pt;
    font-weight: bold;
    color: darkslategrey;
    display: block;
    text-align: center;
 }
 .service_content_text_title{
    font-size: 24pt;
    text-align: center;
    color: darkslategrey;
    font-weight: bold;
 
 }
 .service_content_text{
    font-size: 18pt;
    text-align: center;
    color: darkslategrey;
    width: 220px;
    margin-left: 15px;
    
 }
 
 
  </style>
  </head>
   
   <%@include file="/main/header.jsp"%>
  <body >
  <%String room =(String)pageContext.getAttribute("room");
  System.out.println("room : "+room);%>
    <div id="intro">
    	<div class="main_content">
    		<img class="main_pet" alt="" src="/semi_PetDiary/resources/image/main.jpg">
    		<div>
	    		<div class="main_content_title">Pet Diary</div>
	    		<div class="main_content_text">반려동물과 함께하는 삶을 편안하게</div>
    		</div>
    	</div>
    </div>
    <div id="about">
    	<div class="main_content" >
    		<div style="margin-top: 80px">
	    		<div class="main_content_title" style="font-size: 60pt;margin-left: 85px;">about us</div>
	    		<div class="main_content_text">우리는 팀 화이팅!(fighting!)입니다. <br/>반려동물과 즐거운 한때를 보내기 위해<br/>필요한 것들을 모두 모았습니다. <br/> PetDaiary와 함께 반려동물과의 <br/>가치있는 시간을 보내보세요 . </div>
    		</div>
    		<img class="main_pet" alt="" src="/semi_PetDiary/resources/image/about.png">
    	</div>
    </div>
    <div id="service">
    	<div class="main_services">
    		<div class="service_content_title">Services</div>
    		<div style="display: flex;">
    			<div class="service_content">	
    				<img class="service_pet"alt="" src="/semi_PetDiary/resources/image/main_service2.jpg">	
    				<div class="service_content_text_title">병원 진료</div>
    				<div class="service_content_text">화상상담을 통해서 빠르고 정확하게 진료를 받으세요</div>
    			</div>
    			<div class="service_content">
   					<img class="service_pet"  alt="" src="/semi_PetDiary/resources/image/main_service3.jpg">
 			    	<div class="service_content_text_title">가게 예약</div>
 			    	<div class="service_content_text">반려동물 걱정없이 식사를 즐기세요</div>
 			    	
    			</div>
    			<div class="service_content">	
    				<img class="service_pet"  alt="" src="/semi_PetDiary/resources/image/main_service1.jpg">
    				<div class="service_content_text_title">커뮤니티</div>
    				<div class="service_content_text">사람들과 정보를<br/> 나누세요</div>
    			</div>
    			<div class="service_content">	
    				<img class="service_pet"  alt="" src="/semi_PetDiary/resources/image/main_service4.jpg">
    				<div class="service_content_text_title">여행계획</div>
    				<div class="service_content_text">반려동물과 여행을 함께 가세요</div>
    			</div>
	    	</div>
    	</div>
    </div>
    
    
  </body>
    <%@include file="/main/footer.jsp"%>
</html>
