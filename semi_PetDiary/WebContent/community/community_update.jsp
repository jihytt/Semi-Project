<%@page import="com.pet.ft.dto.CommunityDto"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charser=UTF-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/semi_PetDiary/resources/css/stylesheet.css" rel="stylesheet">
<style type="text/css">
#community_update_contentbox{
	position : relative;
	align-self : center;
	border : 1px solid black;
	height: 800px;
	width: 800px;
	margin: 0 auto;
	margin-top : 50px;
}

#community_update_title{
	height: 100px;
	text-align: center;
}

#community_update_input_box{
    margin: 0 auto;
    width: 800px;
    border : 1px solid black;
}


.update_button{
	float:right;
    border: 2px solid salmon;
    background-color: white;
    color: salmon;
    padding: 5px;
    margin-top: 2px;
    border-radius: 4px;
    margin-left: 10px;
}

.update_button:hover{
    background-color: salmon;
    color: white;
}


</style>

<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<script type="text/javascript">

$(document).ready(function() {
	//여기 아래 부분
	$('#summernote').summernote({
		  height: 630,                 // 에디터 높이
		  minHeight: null,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",					// 한글 설정
		  placeholder: '최대 3000자까지 쓸 수 있습니다'	//placeholder 설정
          
	});
});

</script>
</head>
<%CommunityDto cdto =(CommunityDto)request.getAttribute("cdto");%>

<body>
<%@include file="/main/header.jsp"%>
	<form action="/semi_PetDiary/pet.do" method="post" >
		<input type="hidden" name="command" value="community_update">
		<input type="hidden" name="community_no" value="<%=cdto.getCommunity_no()%>">
		<input type="hidden" name="seq" value="<%=cdto.getCommunity_seq()%>">
		<div id="community_update_fullbox">
			<div id ="community_update_contentbox">
				<div id="community_update_title">
					<input style="width:780px;height:50px"type="text" name="title" value="<%=cdto.getCommunity_title()%>">
				</div>	
				<div id="community_update_content">
					<textarea style="resize: none;" id="summernote"rows="30" cols="108" name="content" ><%=cdto.getCommunity_content()%></textarea>
				</div>
				<div id="community_update_button">
					<input class="update_button" type="button" onclick="location.href='/semi_PetDiary/pet.do?command=community'"value="돌아가기">
					<input class="update_button" type="submit" value="작성">
				</div>
			</div>
		</div>
	</form>
</body>
</html>