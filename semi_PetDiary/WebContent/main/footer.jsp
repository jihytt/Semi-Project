<%@ page language="java" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<style type="text/css">
	footer {
		background-color: white;
		border-top: 1px solid #c4c4c4;
		width: 100%;
		position: relative;
		bottom: 0;
		
	}
	
	.footerlogo img {
		position: absolute;
		bottom: 100px;
		padding-left: 10px;
	}

	.aboutus {
		padding-left: 10px;
		position: absolute;
		bottom: 0;
		min-width: 100%;
		color: white;
		z-index: 1;
	}

	.social {
		bottom: 10px;
		position: absolute;
		text-align: center;
		padding-right: 30px;
		z-index: 1;
		margin-left: 1700px;
		color: white;
	}
	
	.quick {
		position: absolute;
		bottom: 0;
		background-color: salmon;
		color: white;
		height: 100px;
		width: 100%;
		text-align: center;
	}
	
	.quick div span {
		padding : 20px;
	}
	
	h1 {
		font-size: 22px; 
	}
	
	.social div img {
		width: 40px;
		height: 40px;
		padding: 5px;
	}
</style>

<body>
	<footer>
		<div class="footerlogo">
			<img src="../resources/image/footerlogo.png">
		</div>
		<div class="aboutus">
			<h1>ABOUT US</h1>
			<div>
				<span>서울특별시 강남구 테헤란로14길 6 남도빌딩</span><br/>
				<span>semiproject.pet@gmail.com</span><br/>
				<span>TEAM 화이팅!</span><br/>
			</div>
		</div>
		<div class="social">
			<h1>SOCIAL</h1>
			<div>
				<span><a href="#"><img src="../resources/image/instagram.png"></a></span>
				<span><a href="#"><img src="../resources/image/facebook.png"></a></span>
				<span><a href="#"><img src="../resources/image/google.png"></a></span>
			</div>
		</div>
		<div class="quick">
			<h3>QUICK LINKS</h3>
				<div>
					<span>HOME</span>
					<span>다이어리</span>
					<span>병원 찾기</span>
					<span>반려동물 출입가능 시설 찾기</span>
					<span>예약내역</span>
				</div>
		</div>
	</footer>
</body>
</html>