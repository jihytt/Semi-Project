<%@ page import="com.pet.ft.model.PetBiz" %>
<%@ page import="com.pet.ft.model.PetBizImpl" %>
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
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/semi_PetDiary/resources/javascript/script.js"></script>
    <script type="text/javascript">
        $(function () {
            $('.file_input input[type=file]').change(function() {
                var fileName = $(this).val();
                var fileCount = $(this).get(0).files.length;
                if($(this).get(0).files.length === 1){
                    $('.file_input input[type=text]').val(fileName);
                }
                else {
                    $('.file_input input[type=text]').val('파일 '+fileCount+'개');
                }
            });
        });
    </script>
    <style type="text/css">
        *{ margin: 0; padding: 0; }
        .picHeader { z-index: 9999; position:fixed; width:100%; font-size: 17px; font-weight: 500; padding: 15px 0; background: salmon; color: white; text-align: center; }
        #selectPictureList {position: absolute; top: 10%; width: 600px;height: 700px;}
        #selectPictureList img {margin-top: 10px; margin-left: 10px; position: relative;width: 200px;height: 200px;}
        #imageUpload {position: absolute; bottom: 25%; right: 10%; }
        #bigPic {position:absolute; left: 52%; top: 10%;width: 500px;height: 500px;}
        #imageUpload > input[type='file'] {border: none}
        input[type='submit'] { border: none; background-color: white; color: salmon}
        .input-file { padding-right: 1px; border-radius: 4px; background-color: salmon; color: white; height: 30px; line-height:30px;}
        .picture_paging { bottom: 10%; margin-left: 10px; bottom: 10%; margin-left: 10px; position: absolute;left: 50%;}
        #selectedPic {height: 500px;width: 500px;}
        .file_input label {position:relative;cursor:pointer;display:inline-block;
            vertical-align:middle;
            overflow:hidden;
            width:100px;
            height:30px;
            border-radius: 4px;
            background-color: salmon;
            color:#fff;
            text-align:center;
            line-height:30px;
        }
        .file_input label input[type='file'] {position:absolute; width:0;height:0;overflow:hidden;}
        .file_input input[type=text] {vertical-align: middle;display: inline-block;
            border-radius: 4px;
            width: 200px;
            height: 30px;
            line-height: 30px;
            font-size: 11px;
            padding: 0;
            border: 1px solid salmon;
        }
    </style>
</head>
<body>
<%
    int i = 0;
    PetBiz biz = new PetBizImpl();
    int member_no = (int) session.getAttribute("member_no");
    int count = biz.getPictureCount(member_no);
    int totalPage = count / 6;
    if (count % 6 != 0) {
        totalPage +=1;
    }
%>
<div class="header_wrap">
    <div class="picHeader">
        사진첩
    </div>
</div>
<div id="picWrap">
<c:choose>
    <c:when test="${empty list }">
        <form id="imageUpload" method="post" action="/semi_PetDiary/pet_servlet?command=picture_upload" enctype="multipart/form-data">
            <div class="file_input">
                <label>
                    파일 선택
                    <input type="file" name="img" accept="image/*" multiple>
                </label>
                <input type="text" readonly="readonly" title="File Route">
                <input type="submit" class="input-file" value="업로드">
            </div>
        </form>
    </c:when>
    <c:otherwise>
        <div id="selectPictureList">
            <div>
                <form action="/semi_PetDiary/pet_servlet" method="post">
                    <input type="hidden" name="command" value="picture_delete">
        <c:forEach items="${list }" var="dto">
            <input type="hidden" name="picture_no" value="${dto.picture_no }">
            <img alt="사진" class="smallPic" src="${fn:replace(dto.picture_directory,'..','/semi_PetDiary')}/${dto.picture_name }">
            <input type="submit" value="삭제">
        </c:forEach>
                </form>
            </div>
        </div>
    </c:otherwise>
</c:choose>
    <div id="bigPic">
        <img id="selectedPic" src="#" alt="선택된 사진" hidden="hidden" >
    </div>
</div>
<div class="picture_paging">
<%
    for (int j = 1; j <= totalPage; j++) {
%>
    <a onclick="location.href='/semi_PetDiary/pet_servlet?command=picture_main&max=<%=j*6%>'">[<%=j%>]</a>
<%
    }
%>
</div>
<form id="imageUpload" method="post" action="/semi_PetDiary/pet_servlet?command=picture_upload" enctype="multipart/form-data">
    <div class="file_input">
        <label>
            파일 선택
            <input type="file" name="img" accept="image/*" multiple>
        </label>
        <input type="text" readonly="readonly" title="File Route">
        <input type="submit" class="input-file" value="업로드">
    </div>
</form>
</body>
</html>