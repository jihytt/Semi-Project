<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

%>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="../resources/javascript/script.js"></script>
<html>
<head>
    <title>Title</title>
</head>
<body>
<c:choose>
    <c:when test="${empty list }">
        <a href="./picture/picture_insert.jsp">사진 등록하러 가기</a>
    </c:when>
    <c:otherwise>
        <c:forEach items="${list }" var="dto">
            <img class="iselectPic" src="${dto.picture_directory }/${dto.picture_name }" width="500" height="500">
        </c:forEach>
    </c:otherwise>
</c:choose>
</body>
</html>
