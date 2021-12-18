<%@page import="java.io.File"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/semi_PetDiary/resources/javascript/script.js"></script>
<html>
<head>
    <title>Title</title>
    <style type="text/css">
        table {
            border: none;
            border-collapse: collapse;
            margin: 25px 0;
            font-size: 0.9em;
            font-family: sans-serif;
            min-width: 400px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
            border-radius: 6px ;
        }
        table tr th{
            background-color: salmon;
            color: #ffffff;
            text-align: left;
            width: 70px;
        }
    </style>
</head>
<body>
<%
    String src = request.getParameter("src");
String fileSeperator = File.separator;
if (src == null) {
    src =  fileSeperator + "semi_PetDiary" + fileSeperator + "resources" + fileSeperator + "Upload" + fileSeperator + "default" + fileSeperator + "sample.jpg";
}
%>
<form method="post" name="frm" action="/semi_PetDiary/pet_servlet" onsubmit="return petCheck()">
    <input type="hidden" name="command" value="pet_insert">
    <table border="1">
        <col width="100"/>
        <col width="100"/>
        <col width="100"/>
        <col width="100">
        <tr>
            <td colspan="3">
                <a href="/semi_PetDiary/pet_servlet?command=picture_insert_select">
                <img id="selectedPic" src="<%=src%>" alt="선택된 사진" width="500" height="500">
                </a>
                <input type="hidden" name="path" value="<%=src%>">
            </td>
        </tr>
        <tr>
            <th>이름</th>
            <td colspan="2"><input type="text" name="name"></td>
        </tr>
        <tr>
            <th>종</th>
            <td colspan="2">
                <select name="species">
                    <option value="강아지">강아지</option>
                    <option value="고양이">고양이</option>
                </select>
            </td>
        </tr>
        <tr>
            <th>품종</th>
            <td colspan="2"><input type="text" name="breed"></td>
        </tr>
        <tr>
            <th>생년월일</th>
            <td colspan="2"><input type="date" name="birthday"></td>
        </tr>
        <tr>
            <th>성별</th>
            <td><input type="radio" name="gender" checked="checked" value="M">M</td>
            <td><input type="radio" name="gender" value="F">F</td>
        </tr>
        <tr>
            <th>예방 접종 일자</th>
            <td><input type="date" name="vaccination"></td>
        </tr>
        <tr>
            <td colspan="3" align="right">
                <input type="submit" id="iPet" disabled="disabled" value="작성">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
