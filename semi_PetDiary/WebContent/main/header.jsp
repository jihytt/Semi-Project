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
    </script>
  </head>
  <body>
    <nav class="header">
      <div class="header_logo">
        <i class="fas fa-paw"></i>
        <a href="/semi_PetDiary/pet.do?command=myinfo">Pet Diary</a>
      </div>
      <ul class="header_menu">
        <li>
          <a href="/semi_PetDiary/pet.do?command=pet_main&member_no=1">다이어리</a>
        </li>
        <li><a href="#">나와 닮은 동물 찾기</a></li>
        <li>
          <a href="/semi_PetDiary/pet.do?command=hospitalmain">병원상담</a>
        </li>
        <li><a href="/semi_PetDiary/paging.do?command=foodlist">음식/카페</a></li>
        <li><a href="/semi_PetDiary/pet.do?command=community">커뮤니티</a></li>
        <li><a href="/semi_PetDiary/pet.do?command=weather_main">날씨</a></li>
        <li>
          <form action="#" method="post">
            <input type="text" id="searchBox" />
            <input type="submit" value="검색" />
          </form>
        </li>
      </ul>

      <ul class="header_login">
        <% if(session.getAttribute("member_no") == null) { %>

        <li><a href="/semi_PetDiary/pet.do?command=login_login">로그인</a></li>
        <li>
          <a href="/semi_PetDiary/pet.do?command=login_signup">회원가입</a>
        </li>

        <% } else { %>
        <li>
          <a href="/semi_PetDiary/pet.do?command=login_logout">로그아웃</a>
        </li>
        <% } %>
      </ul>

		<ul class="header_icons">
			<li><a href="/semi_PetDiary/pet.do?command=business"><i class="fas fa-user-circle"></i></a></li>

		</ul>
			<a href="#" class="header_toggleBtn">
					<i class="fas fa-bars"></i>
			</a>

	</nav>	
	
	<a class="chatbot"><img src="${pageContext.request.contextPath}/resources/image/chatbot.png" onclick="openchat();" alt="Icons made by www.flaticon.com" height="60px"></a>
	
</body>
</html>
