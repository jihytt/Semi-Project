<%@page import="java.io.File"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    String fileSeperator = File.separator;

%>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/semi_PetDiary/resources/javascript/script.js"></script>
<html>
<head>
    <title>Title</title>
</head>
<body>
<c:choose>
    <c:when test="${empty list }">
        <a href="../picture/picture_insert.jsp">사진 등록하러 가기</a>
    </c:when>
    <c:otherwise>
        <c:forEach items="${list }" var="dto">
            <img class="iselectPic" src="${fn:replace(dto.picture_directory,'..','\\semi_PetDiary')}<%= fileSeperator%>${dto.picture_name }" width="500" height="500">
            
        </c:forEach>
    </c:otherwise>
</c:choose>
</body>
</html>
