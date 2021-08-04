<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="../resources/javascript/script.js"></script>
</head>
<body>
<form action="../pet.do" method="post">
    <input type="hidden" name="command" value="trip_update_res">
    <input type="hidden" name="calendar_no" value="${dto.calendar_no }">
    <table border="1">
        <tr>
            <th width="100">여행 제목</th>
            <td><input type="text" name="title" value="${dto.calendar_title }"></td>
        </tr>
        <tr>
            <th>시작 날짜</th>
            <td><input type="date" id="start_date" name="start_date"></td>
        </tr>
        <tr>
            <th>종료 날짜</th>
            <td><input type="date" id="end_date" disabled="disabled" name="end_date"></td>
        </tr>
        <tr>
            <th>필수품</th>
            <td><input type="text" name="necessity" value="${dto.calendar_necessity }"></td>
        </tr>
        <tr>
            <th>세면도구/화장품</th>
            <td><input type="text" name="item" value="${dto.calendar_item }"></td>
        </tr>
        <tr>
            <th>여행 내용</th>
            <td><textarea rows="100" cols="60" name="content">${dto.calendar_content }</textarea></td>
        </tr>
        <tr>
            <td colspan="2" align="right">
                <input type="submit" value="수정">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
