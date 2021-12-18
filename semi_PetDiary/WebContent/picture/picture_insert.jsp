<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<html>
<head>
    <title>Title</title>
    <style type="text/css">
        input[type=submit] {
            background-color: salmon;
            color: white;
            border: none;
            border-radius: 6px;
            padding: 5px 5px 5px 5px;
        }
    </style>
</head>
<body>
<form id="imageUpload" method="post" action="/semi_PetDiary/pet.do?command=picture_insert_upload" enctype="multipart/form-data">
    <input type="file" name="img" accept="image/*" multiple>
    <input type="submit" value="업로드하기">
</form>
</body>
</html>
