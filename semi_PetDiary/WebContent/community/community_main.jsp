<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.pet.ft.dto.CommunityDto"%>
<%@page import="com.pet.ft.controller.pet_util" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charser=UTF-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/semi_PetDiary/resources/css/stylesheet.css" rel="stylesheet">
<style type="text/css">
.community_row{
	display: flow-root;
	position: relative;
	margin-left: 25px;
}

.commnunity_entity{
float: left;
    margin: 2px;
    margin-right: 20px;
    border: 2px solid salmon;
    width: 350px;
    height: 400px;

}

.commnunity_entity:hover{
background-color: #ddd;

}

.commnunity_entity:active{
background-color: #fff;

}


#community_search{
height: 40px;

}

#pagaing {
height: 50px;
bottom: 0;
text-align: center
}
.paging_number{
	color: black;
	font-size: 12pt;
	text-decoration:none;
}
.community_icon{

}

.date {
    color: #999;
    margin-bottom: 10px;
    float : right;
    padding-right: 10px;
}
.title {
    color: salmon;
    font-weight: 600;
    overflow: hidden;
    text-overflow: ellipsis;
  	white-space: nowrap;
    padding-top: 10px;
    padding-left: 10px;
 }
.content {
    margin-top: 5px;
     overflow: hidden;
    text-overflow: ellipsis;
  	width: 350px;
  	height: 280px;
    padding-left: 10px;
    padding-right: 10px;
}
.accessory {
    border-top: 1px solid #eee;
    padding-top:10px;
    margin-top:10px;
    color: #999;
    font-size: 14px;
    padding-left: 10px;
}

.write{
    position: absolute;
    border: 2px solid salmon;
    background-color: white;
    color: salmon;
    padding: 5px;
    margin-top: 2px;
    margin-left: 25px;
    border-radius: 4px;
}

.write:hover{
    position: absolute;
    border: 2px solid salmon;
    background-color: salmon;
    color: white;
    padding: 5px;
    margin-top: 2px;
    margin-left: 25px;
    border-radius: 4px;
}
.filter{
    position: absolute;
    width: 110px;
    padding: .3em .5em;
    border: 2px solid salmon;
    font-family: inherit;
    background: url(resources/image/arrow.jpg) no-repeat 95% 50%;
    appearance: none;
    left: 90px;
    margin-top: 3px;
    border-radius: 4px;
    color : salmon;
}
.filter:focus{

outline-color: salmon;
}

.search_content{
    position: absolute;
    left: 205px;
    padding: .3em .5em;
    border: 2px solid salmon;
    font-family: inherit;
    appearance: none;
    margin-top: 3px;
    border-radius: 4px;
    color: salmon;
}
.search_button{
    position: absolute;
    left: 380px;
    border: 2px solid salmon;
    background-color: white;
    color: salmon;
    padding: 5px;
    margin-top: 2px;
    margin-left: 25px;
    border-radius: 4px;
}

.search_button:hover{
    background-color: salmon;
    color: white;
}

</style>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body style="padding-top : 90px;">
<%@include file="/main/header.jsp"%>

<%List<CommunityDto> list = (List<CommunityDto>)request.getAttribute("list");
  int paging = Integer.parseInt(request.getParameter("paging"));
  int count = 0;
  SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy.MM.dd"); //원하는 데이터 포맷 지정
%>

	<div>
		<div id="community_search">
			<button class="write" onclick="location.href='/semi_PetDiary/pet.do?command=community_insert_form'">글 작성</button>
			<form action="/semi_PetDiary/pet.do?" method="post">			
				<input type="hidden" name="command" value="community_search">
				<select class="filter" name="filter">
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="comment_content">댓글내용</option>
				</select>			
				<input type="text"class="search_content" name="search_content"/>
				<input class="search_button"type="submit" value="검색">
			</form>
		</div>
	</div>
	<div id="community_table">
			
		<div class="community_row">
	<%for(CommunityDto dto : list){
		String strDate = simpleDateFormat.format(dto.getCommunity_regdate()); //지정한 포맷으로 변환%>
				<div class="commnunity_entity" onclick="location.href='/semi_PetDiary/pet.do?command=community_detail&seq=<%=dto.getCommunity_seq()%>&community_no=<%=dto.getCommunity_no()%>'">
					<div class = "title" class="commnuity_title">
						<%=dto.getCommunity_title() %>
					</div>
					<div class = "date" class="commnuity_regdate">
						<%=pet_util.FromMemberNoTogetName(dto.getMember_no()) %>   /   <%=strDate%>
					</div>
				<div class = "content"  class="commnuity_content">
					
				<%if(dto.getCommunity_content().indexOf("<img")>0){ %>
					
						<%="<img style='width : 320px; height : 200px; object-fit : cover; margin :3px;' "+dto.getCommunity_content().split("<img")[1].split(">")[0]+">" %>
									
				<%String content = dto.getCommunity_content();				
					while(content.indexOf("<img")>=0){
						content = content.replace("<img"+content.split("<img")[1].split(">")[0]+">","");
					}%>
					<%=content %>
				<%}else{%>
					<%=dto.getCommunity_content() %>			
			<% }%>
					</div>
					<div class="accessory">
					댓글 : 	<a class="" href="#"> <img alt="" src=""> </a><%=pet_util.CommunityCommentCount(dto.getCommunity_no())%>
					좋아요 : <a class="" href="#"> <img alt="" src=""> </a><%=pet_util.LikesCount(dto.getCommunity_seq()) %>
					조회 :  <a class="" href="#"> <img alt="" src=""> </a> <%=dto.getCommunity_views() %>
					</div>
				</div>
	<%}	%>	
		</div>
		<div id="pagaing">
			<ul class="pagination">
			<%
			for(int i =0; i<=(int)request.getAttribute("maxpage")/8;i++){

				if(i+1==paging){
			%>
				<li class="active"><a style="background-color: salmon;border-color: salmon;"  href='/semi_PetDiary/pet.do?command=community&paging=<%=(i+1)%>'><%=i+1 %></a></li>
			<%}else{%>
					
				<li><a href='/semi_PetDiary/pet.do?command=community&paging=<%=(i+1)%>'><%=i+1 %></a></li>
				<%}
			}%>
			</ul>
		</div>
		
	</div>

</body>
</html>