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
    <input type="hidden" name="command" value="trip_insert_res">
    <input type="hidden" name="member_no" value="1">
    <table border="1">
        <tr>
            <th>시작 날짜</th>
            <td><input type="date" name="calendar_startdate" id="start_date"></td>
        </tr>
        <tr>
            <th>종료 날짜</th>
            <td><input type="date" name="calendar_enddate" disabled="enabled" id="end_date"></td>
        </tr>
        <tr>
            <th>필수품</th>
            <td><input type="text" name="calendar_necessity" id="necessity"></td>
        </tr>
        <tr>
            <th>세면도구/화장품</th>
            <td><input type="text" name="calendar_item"></td>
        </tr>
        <tr>
            <th>여행 제목</th>
            <td><input type="text" name="calendar_title"></td>
        </tr>
        <tr>
            <th>여행 내용</th>
            <td><textarea rows="10" cols="60" name="calendar_content"></textarea></td>
        </tr>
        <tr>
            <td colspan="6">
                <input type="submit" id="submit" value="글 작성">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
