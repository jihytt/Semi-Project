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
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/semi_PetDiary/resources/javascript/paging.js"></script>
</head>
<body>
<%
    //int member_no = Integer.parseInt(request.getParameter("member_no"));
    int member_no = 1;
    PetBiz biz = new PetBizImpl();
    List<PetDto> list = biz.selectPetList(member_no);
    int totalCount = biz.getCount(1);     //member_no가 들어가야함
    String petName = list.get(0).getPet_name();
    String petSpecies = list.get(0).getPet_species();
    String petBreed = list.get(0).getPet_breed();
    String petBirth = list.get(0).getPet_birthday().substring(0, 10);
    String petGender = list.get(0).getPet_gender();
    String petVaccin = list.get(0).getPet_vaccination().substring(0, 10);
    String path = list.get(0).getPet_path();
%>
<div>
  <img id="petImg" src="<%=path%>" alt="반려동물 사진" width="500px" height="500px">
</div>
<div>
    <div class="myPetInfo">
        <p id = "petName">
            이름 <%=petName%>
        </p>
        <p id = "petSpecies">
            종   <%=petSpecies%>
        </p>
        <p id = "petBreed">
            품종 <%=petBreed%>
        </p>
        <p id="petBirthday">
            생년월일 <%=petBirth%>
        </p>
        <p id="petGender">
            성별 <%=petGender%>
        </p>
        <p id="petVaccination">
            예방 접종 예정일 <%=petVaccin%>
        </p>
    </div>
    <input type="button" id="petDel" value="삭제" onclick="">
    <input type="button" id="petUp" value="수정" onclick="">

</div>
</body>
</html>
