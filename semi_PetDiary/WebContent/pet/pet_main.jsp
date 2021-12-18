<%@ page import="java.util.List" %>
<%@ page import="com.pet.ft.dto.PetDto" %>
<%@ page import="com.pet.ft.model.PetBizImpl" %>
<%@ page import="com.pet.ft.model.PetBiz" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<html>
<head>
    <title>Title</title>
    <style type="text/css">
    	.pet_info_main{
            height: 100%;
        }
        .iframe {
            box-sizing: border-box;
            border: none;
            width: 100%;
            height: 600px;
        }
        .pet_update > a:visited, .pet_update > a:link {
            text-decoration: none;
            color: black;
        }
        .pet_update {
            position: absolute;
            bottom: 20%;
            left: 45%;
        }
        div > p {
            padding-top: 50px;
            border: 1px solid salmon;
        }
        .pet_info {
            box-sizing: border-box;
            display: inline-block;
            vertical-align:middle;
            width: 30%;
            height: 600px;
            margin-top: 5%;
            margin-left: 2%;
        }
        .pet_info_style {
            box-sizing: border-box;
            border-collapse: collapse;
            margin-top: 10%;
            margin-left: 10%;
            font-size: 0.9em;
            font-family: sans-serif;
            min-width: 400px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
            border-radius: 6px ;
        }
        #petImg{box-sizing: border-box;
            width: 100%;}
        .pet_info_style tr th {
            background-color: salmon;
            color: #ffffff;
            text-align: left;
            width: 70px;
        }
        .pet_info_style tr:first-child th:first-child {
            border-radius: 6px 0 0 0 ;
        }
        .pet_info_style tr:last-child th:first-child {
            border-radius: 0 0 0 6px;
        }
        .pet_info_style th,
        .pet_info_style td {
            padding: 12px 15px;
            text-align: center;
        }
        .pet_info_style tr {
            border-bottom: 1px solid #dddddd;
        }
        .pet_info_style tr:last-child {
            border-bottom: none;
        }
        .pet_update {
            margin-top: 5%;
            margin-right: 8%;
            float: right;
        }
        input[type=button] {
            background-color: salmon;
            color: white;
            border: 1px solid salmon;
            border-radius: 6px;
            padding: 5px 5px 5px 5px;
        }

        #empty {
            margin-top: 100px;
            margin-bottom: 32.5%;
        }
    </style>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/semi_PetDiary/resources/javascript/paging.js"></script>
</head>
<body>

<%@include file="../main/header.jsp"%>
<%
    int member_no = (int) session.getAttribute("member_no");
    PetBiz biz = new PetBizImpl();
    List<PetDto> list = biz.selectPetList(member_no);
    if (list.isEmpty()) {
%>
    <div id="empty" align="center">
        <h1>반려 동물을 등록해주세요</h1>
        <input type="button" value="추가" onclick="window.open('pet/pet_insert.jsp', ',update','left=50, top=50, width=520, height=750')">
    </div>
<%
}
else {
    int totalCount = biz.getCount(member_no);     //member_no가 들어가야함
    int petNo = list.get(0).getPet_no();
    String petName = list.get(0).getPet_name();
    String petSpecies = list.get(0).getPet_species();
    String petBreed = list.get(0).getPet_breed();
    String petBirth = list.get(0).getPet_birthday();
    String petGender = list.get(0).getPet_gender();
    String petVaccin = list.get(0).getPet_vaccination();
    String path = list.get(0).getPet_path();
%>
    <div class="pet_info_main">
        <div class="pet_info">
            <img id="petImg" src="<%=path%>" alt="반려동물 사진" width="500px" height="500px">
        </div>
        <div class="pet_info">
            <table class="pet_info_style">
                <tr>
                    <th>이름</th>
                    <td id="petName"><%=petName%></td>
                </tr>
                <tr>
                    <th>종</th>
                    <td id="petSpecies"><%=petSpecies%></td>
                </tr>
                <tr>
                    <th>품종</th>
                    <td id="petBreed"><%=petBreed%></td>
                </tr>
                <tr>
                    <th>태어난 날</th>
                    <td id="petBirthday"><%=petBirth%></td>
                </tr>
                <tr>
                    <th>성별</th>
                    <td id="petGender"><%=petGender%></td>
                </tr>
                <tr>
                    <th>예방 접종 예정일</th>
                    <td id="petVaccination"><%=petVaccin%></td>
                </tr>
            </table>
          </div>
        <div class="pet_info">
            <iframe src="/semi_PetDiary/pet.do?command=calendar_calMain" class="iframe" >
            </iframe>
        </div>
    </div>
<div class="pet_update">
    <input type="button" value="추가" onclick="window.open('pet/pet_insert.jsp', 'insert', 'left=50, top=50, width=520, height=750')">
    <input type="button" id="petDel" value="삭제" onclick="location.href='/semi_PetDiary/pet_servlet?command=pet_delete&pet_no=<%=petNo%>'">
    <input type="button" id="petUp" value="수정" onclick="window.open('/semi_PetDiary/pet_servlet?command=pet_update_form&pet_no=<%=petNo%>', 'update', 'left=50, top=50, width=520, height=750')">
    <%
        for (int i = 1; i <= totalCount; i++) {
    %>
    <a href="#" class="pet_paging" onclick="pet(<%=i%>)">[<%=i%>]</a>
    <%
            }
        }
    %>
</div>
<%@include file="../main/footer.jsp"%>
</body>
</html>