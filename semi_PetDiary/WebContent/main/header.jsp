<%@ page language="java" pageEncoding="UTF-8"%> <%
request.setCharacterEncoding("UTF-8"); response.setCharacterEncoding("UTF-8");
%>
<link href="/semi_PetDiary/resources/css/stylesheet.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">

<html>
  <head>
    <title>Title</title>
    <style type="text/css">
    	.chatbot { position: fixed; right: 3%; top: 80%; height: 90px; width: 90px; z-index: 50; background-color: #D9F6B4; border-radius: 50px 50px 50px 50px; box-shadow: 5px 5px 5px rgba(0,0,0,0.26); text-align: center; }
				.mapBtn{
			border: 2px solid white;
			background-color:wheat;
			border-radius:30px;
			padding:3px 7px;
			color:salmon;
			font-weight:bolder;
			cursor:pointer;
		}
		.chatbot img{ position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); cursor: pointer; }
    </style>
    <script  src="https://kit.fontawesome.com/95780683f0.js" crossorigin="anonymous"></script>
    <script>
    	function openchat(){
    		var popupWidth = 400;
    		var popupHeight = 530;
    		var popupX = (window.screen.width / 2) - (popupWidth / 2);
    		var popupY= (window.screen.height / 2) - (popupHeight / 2);
    		
    		var member_no = "<%=session.getAttribute("member_no")%>";
    		if (member_no == "null") {
    			alert("로그인 후 챗봇을 이용하실 수 있습니다.");
    		} else {
    		window.open('/semi_PetDiary/chatbot.do?command=opendialog','', 'height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY + 'resizable=no');
    		}
    	}
    	//지도검색
    	function allMapPop(){
			var popup = window.open('/semi_PetDiary/main/allMap.jsp', '지도', 'width=800px,height=620px,scrollbars=yes');
		}
    	
    </script>
  </head>
  <body>
    <nav class="header">
      <div class="header_logo">
        <i class="fas fa-paw"></i>
        <a href="/semi_PetDiary/">Pet Diary</a>
      </div>
      <ul class="header_menu">
        <li>
          <a href="/semi_PetDiary/pet.do?command=pet_main&member_no=1">다이어리</a>
        </li>
        <li><a href="#" onclick="window.open('https://152.70.250.165:7443/semi_PetDiary/teachable/teachable_man.jsp', '_blank', 'width=600px, height=690px left=300px, top=100px')">나와 닮은 동물 찾기</a></li>
        <li>
          <a href="/semi_PetDiary/pet.do?command=hospitalmain">병원상담</a>
        </li>
        <li><a href="/semi_PetDiary/paging.do?command=foodlist">음식/카페</a></li>
        <li><a href="/semi_PetDiary/pet.do?command=community">커뮤니티</a></li>
        <li><a onclick="window.open('/semi_PetDiary/pet.do?command=weather_main','날씨','width=650px, height=400px');return false">날씨</a></li>
		 <input type="button" class="mapBtn" value="지도검색" onclick="allMapPop();"> 

       </ul>

      <ul class="header_login">
        <% if(session.getAttribute("member_no") == null) { %>

        <li><a href="/semi_PetDiary/login.do?command=login_login">로그인</a></li>
        <li>
          <a href="/semi_PetDiary/login.do?command=login_signup">회원가입</a>
        </li>

        <% } else { %>
        <li>
          <a href="/semi_PetDiary/login.do?command=login_logout">로그아웃</a>
        </li>
        <% } %>
      </ul>

		<ul class="header_icons">
			<li><a href="/semi_PetDiary/pet.do?command=myinfo"><i class="fas fa-user-circle"></i></a></li>

		</ul>
			<a href="#" class="header_toggleBtn">
					<i class="fas fa-bars"></i>
			</a>

	</nav>	
	
	<a class="chatbot"><img src="${pageContext.request.contextPath}/resources/image/chatbot.png" onclick="openchat();" alt="Icons made by www.flaticon.com" height="60px"></a>
	
</body>
</html>
