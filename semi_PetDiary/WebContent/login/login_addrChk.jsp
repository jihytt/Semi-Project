<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<% 
	String inputYn = request.getParameter("inputYn"); 
	String roadAddrPart1 = request.getParameter("roadAddrPart1"); 
	String roadAddrPart2 = request.getParameter("roadAddrPart2"); 
	String addrDetail = request.getParameter("addrDetail"); 
%>
</head>
<script type="text/javascript">

function init(){
	var url = location.href;
	// !!! 프로젝트에 올릴 때 변경 !!!
	var confmKey = "U01TX0FVVEgyMDIxMDUwODIyNDkwNDExMTE0MDc=";
	var resultType = "4"; 
	var inputYn= "<%=inputYn%>";
	if(inputYn != "Y"){
		document.form.confmKey.value = confmKey;
		document.form.returnUrl.value = url;
		document.form.resultType.value = resultType;
		document.form.action="https://www.juso.go.kr/addrlink/addrLinkUrl.do";
		document.form.submit();
	}else{
		opener.jusoCallBack("<%=roadAddrPart1%>","<%=roadAddrPart2%>","<%=addrDetail%>");
		window.close();
	}
}
</script>
<body onload="init();">
	<form id="form" name="form" method="post">
		<input type="hidden" id="confmKey" name="confmKey" value=""/>
		<input type="hidden" id="returnUrl" name="returnUrl" value=""/>
		<input type="hidden" id="resultType" name="resultType" value=""/>
		
	</form>
</body>
</html>