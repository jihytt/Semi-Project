<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charser=UTF-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.title{
	background-color: salmon;
	color:white; 
}
textarea {
	width: 480px;
	height: 200px;
	resize: none;
}

.report_button{
    border: 2px solid salmon;
    background-color: white;
    color: salmon;
    padding: 5px;
    margin-top: 2px;
    margin-left: 10px;
    border-radius: 4px;
}

.report_button:hover{
    background-color: salmon;
    color: white;
}

</style>
<body>
	<div class="title"><h3>신고 처리</h3></div>
	<div>
		<form action="/semi_PetDiary/pet.do">
			<input type="hidden" name="command" value="community_reportinsert">
			<textarea name="content"placeholder="신고할 내용을 입력해주세요..." rows="20" cols="30"></textarea>
			<input type="hidden" name="seq" value="<%=(int)request.getAttribute("seq")%>">
			<input class="report_button" type="submit" value="신고하기">
		</form>
	</div>


</body>
</html>