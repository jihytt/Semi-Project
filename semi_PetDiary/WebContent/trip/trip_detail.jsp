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

<table border="1">
    <tr>
        <th width="100">여행 제목</th>
        <td>${dto.calendar_title }</td>
    </tr>
    <tr>
        <th>여행 기간</th>
        <td>${dto.calendar_startdate} ~ ${dto.calendar_enddate }</td>
    </tr>
    <tr>
        <th>필수품</th>
        <td>${dto.calendar_necessity }</td>
    </tr>
    <tr>
        <th>세면도구/화장품</th>
        <td>${dto.calendar_item }</td>
    </tr>
    <tr>
        <th>여행 내용</th>
        <td><textarea rows="100" cols="60" readonly="readonly">${dto.calendar_content }</textarea></td>
    </tr>
    <tr>
        <td colspan="2" align="right">
            <input type="button" value="삭제" onclick="location.href='pet.do?command=trip_delete&calendar_no=${dto.calendar_no }'">
            <input type="button" value="수정" onclick="location.href='pet.do?command=trip_update_form&calendar_no=${dto.calendar_no }'">
        </td>
    </tr>
</table>
</body>
</html>
