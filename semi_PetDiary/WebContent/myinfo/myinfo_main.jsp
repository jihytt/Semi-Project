<%@page import="com.pet.ft.dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

function PopUpSubmit() {
	var openNewWindow = window.open('', 'picture', 'width=1200, height=840 location = no');

	openNewWindow.location.href = "/semi_PetDiary/pet.do?command=picture_main";
	
	}

</script>

<style type="text/css">

.title {
    color: salmon;
    font-weight: 600;
    overflow: hidden;
    text-overflow: ellipsis;
  	white-space: nowrap;
  	font-size: 15pt;
 }
.content {
    margin-top: 15px;
     overflow: hidden;
}

.myinfo_content{
    float: left;
    border: 1px solid #bbb;
    width: 400px;
    height: 200px;
    background-color: white;
    margin: 20px;
    margin-left: 0;
    margin-bottom: 0;
    padding: 50px;

}


.container{
	width: 1047px;
    height: 754px;
    margin: 0 auto;
}

#myinfo_list{
	background-color: #f5f6f8;

}
.title_container{
 	padding-bottom: 20px;
    background-color: white;
    height: 24px;
    border-bottom: 1px solid #bbb;
}
.myinfo_content_mid{
	margin: auto;
}

.myinfo_button{
    border: 2px solid salmon;
    background-color: white;
    color: salmon;
    padding: 5px;
    margin-top: 10px;
    border-radius: 4px;

}

.myinfo_button:hover{
    background-color: salmon;
    color: white;
}
.link{
	color:black;
}
.content_in{
	color: #828282;

}
img{
background: transparent;
}



</style>
</head>
<body>
<%@include file="/main/header.jsp"%>
<%
HashMap<String, Integer> map= (HashMap<String, Integer>)request.getAttribute("map");
MemberDto dto = (MemberDto)request.getAttribute("dto");
%>

<div id="myinfo_list">
	<div class="title_container">
		<div class="container" style="height : 50px">
				<h3>마이페이지</h3>
		</div>	
	</div>
	<div class="container">
		<div class="myinfo_content">
				<div class="title">내 정보</div>
				<div class="content"><b>아이디</b>   <sapn class="content_in"><%=dto.getMember_id()%></sapn></div>
				<div class="content"><b>이름</b>    <sapn class="content_in"><%= dto.getMember_name()%></sapn></div>
				<div class="content"><b>전화번호</b>    <sapn class="content_in"><%=dto.getMember_phone() %></sapn></div>
				<div class="content"><b>이메일</b>    <sapn class="content_in"><%=dto.getMember_email() %></sapn> </div>
				<input class="myinfo_button" type="button" value="수정" onclick="location.href='/semi_PetDiary/pet.do?command=myinfo_update'">
				<input class="myinfo_button" type="button" value="Business계정 신청" onclick="location.href='/semi_PetDiary/pet.do?command=myinfobusup&member_no=<%=dto.getMember_no()%>'">
		</div>
		<div class="myinfo_content">
				<div class="title"><b>내 다이어리</b></div>
				<div class="content"><b>내 반려 동물 수</b>   <span class="content_in"><%=map.get("CountMyinfoPet") %></span></div>
				<div class="content"><b>내 사진 첩</b>   <span class="content_in"><%=map.get("CountPicture") %></span></div>
				<input class="myinfo_button" type="button" id = "picture"value="사진 조회" onclick="PopUpSubmit()">
				
				<br/>
				<div class="content"><b> 내가 세운 여행 계획</b>   <span class="content_in"><%=map.get("CountMyinfoCalendar") %></span></div>
				<input class="myinfo_button" type="button" value="여행계획 보기" onclick="location.href='/semi_PetDiary/pet.do?command=travelmain'">
		
		
		</div>
		<div class="myinfo_content" >
				<div class="title"><b>내 게시글</b></div>
				<div class="content"><b>내가 쓴 글</b>   <span class="content_in"><%=map.get("CountMyinfoCommunity")%></span></div>
				<br/>
				<div class="content"><b>내가 쓴 댓글</b>   <span class="content_in"><%=map.get("CountMyinfoComment") %></span></div>
				<input class="myinfo_button" type="button" value="게시글 조회" onclick="location.href='/semi_PetDiary/pet.do?command=MyCommunityList'">
				
		</div>
		<div class="myinfo_content" >
				<div class="title"><b>내 예약현황 및 결제내역</b>   </div>
				<div class="content"><b>내 예약현황</b>   <span class="content_in"><%=map.get("CountMyinfoBook") %></span></div>
				<br/>				
				<div class="content"><b>내 결제내역</b>   <span class="content_in"><%=map.get("CountMyinfoOrder") %></span></div>
				<input class="myinfo_button" type="button" value="예약 조회"onclick="location.href='/semi_PetDiary/paging.do?command=book'">
				
		</div>
		
	</div>
 </div>



<%@include file="/main/footer.jsp"%>

</body>
</html>