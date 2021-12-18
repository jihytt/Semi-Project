<%@ page import="com.pet.ft.dto.PetDto" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
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
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/semi_PetDiary/resources/javascript/script.js"></script>
</head>
<body>
<%
    String src = request.getParameter("src");
    PetDto dto = (PetDto) request.getAttribute("dto");
    int pet_no = dto.getPet_no();
    if (src == null) {
        src = dto.getPet_path();
    }
%>
<form method="post" action="/semi_PetDiary/pet_servlet">
    <input type="hidden" name="command" value="pet_update_res">
    <input type="hidden" name="pet_no" value="<%=pet_no%>">
    <table border="1">
        <col width="100"/>
        <col width="100"/>
        <col width="100"/>
        <col width="100">
        <tr>
            <td colspan="3">
                <!--<input type="button" name="picture" value="사진 선택하기" onclick="location.href='../pet_servlet?command=picture_update_select'">-->
                <a href="/semi_PetDiary/pet.do?command=picture_update_select&pet_no=<%=pet_no%>">
                <img id="selectedPic" src="<%=src%>" alt="선택된 사진" width="500" height="500">
                </a>
                <input type="hidden" name="path" value="<%=src%>">
            </td>
        </tr>
        <tr>
            <th>이름</th>
            <td colspan="2">${dto.pet_name }</td>
        </tr>
        <tr>
            <th>종</th>
            <td colspan="2">${dto.pet_species }</td>
        </tr>
        <tr>
            <th>품종</th>
            <td colspan="2">${dto.pet_breed }</td>
        </tr>
        <tr>
            <th>생년월일</th>
            <td colspan="2">${fn:substring(dto.pet_birthday, 0, 10) }</td>
        </tr>
        <tr>
            <th>성별</th>
            <td colspan="2">${dto.pet_gender }</td>
        </tr>
        <tr>
            <th>예방 접종 일자</th>
            <td colspan="2"><input type="date" id="uVaccin" name="vaccination"></td>
        </tr>
        <tr>
            <td colspan="3" align="right">
                <input type="submit" id="uPet" disabled="disabled" value="수정">
            </td>
        </tr>
    </table>
</form>
</body>
</html>