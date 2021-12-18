<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
	window.onload = function(){
		document.getElementById("open").click();
	}

</script>

<body>
	<form action="https://152.70.250.165:3000/" method="post">
  		<input type="hidden" value="OpenRTC" name="command">
  		<input type="hidden" value="<%=(int)request.getAttribute("member") %>" name="member">
  		<input type="hidden" value="<%= (int)request.getAttribute("business") %>" name="business">
  		<input type="submit" id= "open" value="화상 상담 시작하기">
	</form>
</body>
</html>