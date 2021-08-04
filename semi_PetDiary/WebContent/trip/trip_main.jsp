<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%@include file="../main/header.jsp"%>

<table border="1" id="trip_plan">
    <c:choose>
        <c:when test="${empty list }">
            <tr>
                <td colspan="5">------------작성된 일정이 없습니다.-----------</td>
            </tr>
        </c:when>
        <c:otherwise>
            <c:forEach items="${list }" var="dto">
                <tr>
                    <th>여행 제목</th>
                    <td><a href="pet.do?command=trip_detail&calendar_no=${dto.calendar_no }">${dto.calendar_title }</a></td>
                </tr>
                <tr>
                </tr>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</table>
<input type="button" value="글 작성" onclick="location.href='pet.do?command=trip_insert_form'">
<%@include file="../main/footer.jsp"%>
</body>
</html>
