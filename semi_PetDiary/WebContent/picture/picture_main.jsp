<%@ page import="java.util.List" %>
<%@ page import="com.pet.ft.dto.PictureDto" %>
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
    <link rel="stylesheet" href="../resources/css/stylesheet.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="../resources/javascript/script.js"></script>
    <style type="text/css">
        #selectPictureOne > img {
            position: absolute;
            border: 1px solid salmon;
            margin: 100px 100px;
            width: 500px;
            height: 500px;
        }
        #selectPictureOne p a img{
            width: 50px;
            height: 50px;
        }

        #selectPictureList {
            position: absolute;
            border: 1px solid salmon;
            width: 500px;
            height: 500px;
        }
        #selectPictureList img {
            margin-top: 10px;
            margin-left: 10px;
            position: relative;
            border: 1px solid salmon;
            width: 200px;
            height: 200px;
        }

        #imageUpload {
            left: 1000px;
            position: absolute;
            text-align: right;
            bottom: 18%;
        }

        #bigPic {
            position: absolute;
            margin-left: 600px;
            bottom: 15%;
            width: 500px;
            height: 500px;
        }
        #request {
            margin-top: 100px;
            text-align: center;
        }
    </style>
</head>
<body>
<%
    PetBiz biz = new PetBizImpl();
    int i = 0;
    int member_no = (int) session.getAttribute("member_no");
    List<PictureDto> list = biz.selectPictureList(member_no);
    if (list.isEmpty()) {
%>
<h1 id="request">사진을 등록 해주세요!</h1>
<form id="imageUpload" method="post" action="../pet_servlet?command=picture_upload" enctype="multipart/form-data">
    <input type="file" name="img" accept="image/*" multiple>
    <input type="submit" value="업로드하기">
</form>
<%
} else {
%>
<div id="selectPictureList">
    <div>
    <form action="../pet_servlet" method="post">
        <input type="hidden" name="command" value="picture_delete">

        <%
            for (PictureDto dto : list) {
                i++;

        %>
        <input type="checkbox" name="picture_no" value="<%=dto.getPicture_no()%>"><img alt="사진" class="smallPic" src="<%=dto.getPicture_directory()%>/<%=dto.getPicture_name()%>">
        <input type="submit" value="삭제">

        <%
                if (i % 2 == 0){
        %>
        <br>
        <%
                }
            }
        %>
    </form>
    </div>
</div>
<div id="bigPic">
</div>
<form id="imageUpload" method="post" action="../pet_servlet?command=picture_upload" enctype="multipart/form-data">
    <input type="file" name="img" accept="image/*" multiple>
    <input type="submit" value="업로드하기">
</form>
<%
    }
%>
</body>
</html>
