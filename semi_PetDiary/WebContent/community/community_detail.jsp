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

.date {
	margin-left : 10px;
    color: #999;
    margin-bottom: 10px;
	display: inline;

}
.writer {
	margin-left : 10px;
    color: salmon;
    font-weight: 600;
 }
.content {
	margin-left : 10px;
    margin-top: 5px;
}


#community_detail_contentbox{
	position : relative;
	align-self : center;
	border : 2px solid salmon;
	height: 800px;
	width: 800px;
	margin: 0 auto;
	margin-top : 20px;
    padding-bottom: 40px;
}

#community_detail_content{

    margin: 20px;
    margin-bottom : 0px;
    overflow: auto;
    height: 705px;
}	

#community_detail_title{
margin-top : 15px;
	height: 30px;
	text-align: center;	
    font-weight: 600;
    font-size: 15pt;
}

#community_detail_writer{
	text-align: right;	
    font-weight: 600;
    font-size: 10pt;
    border-bottom: 1px solid #ddd;
}

#community_comment_input_box{
    margin: 0 auto;
    width: 800px;
    border: 2px solid salmon;
    height: 210px;
	margin-top : 20px;
	border-bottom: 1px solid #ddd
}

#community_comment_List{
    margin: 0 auto;
    width: 800px;
	border : 2px solid salmon; 
	border-top: none;
	margin-bottom: 30px;
}

.comment_content_input{
	resize: none;
}

.comment_content_box{
    margin: 0 auto;
    
    width: 750px;
}
.comment_input_box{
	margin-top : 20px;
	resize : none
}
.detail_button{
    border: 2px solid salmon;
    background-color: white;
    color: salmon;
    padding: 5px;
    margin-top: 2px;
    margin-left: 10px;
    border-radius: 4px;
}

.detail_button:hover{
    background-color: salmon;
    color: white;
}


.comment_update{
    border: 2px solid salmon;
    background-color: white;
    color: salmon;
    padding: 5px;
    margin-top: 2px;
    margin-left: 10px;
    border-radius: 4px;
}

.comment_update:hover{
    background-color: salmon;
    color: white;
}


.filter_button{
    border: 2px solid salmon;
    background-color: white;
    color: salmon;
    padding: 5px;
    margin-top: 2px;
    margin-left: 10px;
    border-radius: 4px;
}

.filter_button:hover{
    background-color: salmon;
    color: white;
}
#like{
    border: 2px solid salmon;
    background-color: white;
    color: salmon;
    padding: 5px;
    margin-top: 2px;
    margin-left: 10px;
    border-radius: 4px;
	float:left;
}

</style>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

<%
CommunityDto cdto =(CommunityDto)request.getAttribute("cdto");
List<CommunityDto> list = (List<CommunityDto>)request.getAttribute("commentList");
%>

	$(function(){
		$('.comment_update').click(function(){
			var seq =$(this).siblings("input[name=seq]").val();
			var content =$(this).siblings("input[name=comment_content]").val();
			var community_no =<%=cdto.getCommunity_no()%>;
			var community_seq =<%=cdto.getCommunity_seq()%>;
			$(this).parent().replaceWith("<div style='border-bottom:1px solid #bbb; padding-top:10px; padding-bottom:10px;'><div style='margin: 0 auto; width: 750px;'><form action='/semi_PetDiary/pet.do' method='get'> <input type='hidden' name='community_seq' value='"+community_seq+"'>  <input type='hidden' name='command' value='community_comment_update'> <input type='hidden' name='community_no' value='"+community_no+"'> <input type='hidden' name='seq' value='"+seq+"'> <textarea class='comment_content_input' name='content' rows='10' cols='100'>"+content+"</textarea> <input style='margin-left: 0px;'class='comment_update'type='submit' value='수정'> </form></div></div>");
		})
	})
	
	
	function PopUpSubmit(Id) {
		var frm = document.getElementById(Id);
			window.open('', 'report', 'width = 500, height = 330, top = 100, left = 200, location = no, resizable=no');
			frm.action = "/semi_PetDiary/pet.do";
			frm.target = "report";
			frm.method = "post";
			frm.submit();
	}
	function like(){
    	if(document.getElementById("like").style.backgroundColor=='white'){
            document.getElementById("like").style.backgroundColor='salmon';
	        document.getElementById("like").style.color='white';
    	}else{
            document.getElementById("like").style.backgroundColor='white';
	        document.getElementById("like").style.color='salmon';	        		
    	}
		$.ajax({
	        url:"/semi_PetDiary/pet.do?command=community_like&seq=<%=cdto.getCommunity_seq()%>",
	        type:'GET',
	        success:function(data){
	        },
	        error:function(jqXHR, textStatus, errorThrown){
	            alert("에러 발생~~ \n" + textStatus + " : " + errorThrown);
	            self.close();
	        }
      })
	}
	
</script>
</head>
<body>
<% SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy.MM.dd hh:mm"); //원하는 데이터 포맷 지정 
String strDate = simpleDateFormat.format(cdto.getCommunity_regdate()); %>
<%@include file="/main/header.jsp"%>
	<div id="community_detail_fullbox">
		<div id ="community_detail_contentbox">
		
			<div >
			<%if(session.getAttribute("member_no")!=null){ %>
				<input id="like" type="button" onclick="like()"style="background-color: <%if(request.getAttribute("likes")==null) {%>white;color:salmon<% }else{%>salmon;color:white<%}%>; "value="좋아요">
					<form id = "report">
						<input type ="button" style="width: 40px; float: left;" class="detail_button" value="신고" onclick="PopUpSubmit('report')">
						<input type="hidden" value="community_reportform" name="command"/>
						<input type="hidden" value="<%=cdto.getCommunity_seq()%>" name="seq">
					</form>	
			<%if((int)session.getAttribute("member_no")==cdto.getMember_no()){ %>
				<input class="detail_button" style="left:50px" type="button" value="수정" onclick="location.href='/semi_PetDiary/pet.do?command=community_updateform&seq=<%=cdto.getCommunity_seq()%>'"> 
				<input class="detail_button "style="left:100px"  type="button" value="삭제" onclick="location.href='/semi_PetDiary/pet.do?command=community_delete&seq=<%=cdto.getCommunity_seq()%>'"> 
				<%} %>
			<%} %>
				<button class="filter_button" onclick="location.href='/semi_PetDiary/pet.do?command=community_detail&seq=<%=cdto.getCommunity_seq()%>&community_no=<%=cdto.getCommunity_no()%>&filter=on'">비속어 필터링 OFF </button>
			</div>		
			<div id="community_detail_title">
				<%=cdto.getCommunity_title() %>
			</div>	
			<div id="community_detail_writer">
				작성자 : <%=pet_util.FromMemberNoTogetName(cdto.getMember_no()) %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 작성일자 : <%=strDate %>&nbsp;&nbsp;&nbsp;&nbsp;
			</div>	
			<div id="community_detail_content">
				<%=cdto.getCommunity_content() %>
			</div>
		</div>
		<%if(session.getAttribute("member_no")!=null) {%>
		<div id="community_comment_box">
			<div id="community_comment_input_box">
				<form  action="/semi_PetDiary/pet.do" method="post">
					<input type='hidden' value="community_comment" name="command" >
					<input type='hidden' value="<%=cdto.getCommunity_no() %>" name="community_no" >
					<input type='hidden' value="<%=cdto.getCommunity_seq() %>" name="seq" >
					<input type='hidden' value="<%=(int)session.getAttribute("member_no") %>" name="member_no" >
					<div class="comment_content_box">
						<textarea class="comment_input_box" class="comment_content_input" name="comment" rows="10" cols="100"></textarea>
					</div>
					<div style="margin-left: 15px;"class="comment_button_box">
						<input class="detail_button" type="submit" value="작성">						
					</div>
				</form>
			</div>
		</div>
		<%} %>
		<div id="community_comment_List">
		<%
			for(CommunityDto commentdto : list){
		%>		
			<div style="  border-bottom: 1px solid #bbb;margin-bottom: 10px; padding-bottom: 20px;">
				<div class="writer"><%=pet_util.FromMemberNoTogetName(commentdto.getMember_no()) %></div>
				<div class="content"><%=commentdto.getCommunity_content() %></div>
				<div class="date"><%=simpleDateFormat.format(commentdto.getCommunity_regdate())%></div>
				<%if(session.getAttribute("member_no")!=null){ %>
				<form id = "report">
					<input style="width: 30px; float: right; position: relative; bottom: 20px; right: 10px;" class="detail_button" value="신고" onclick="PopUpSubmit('')">
					<input type="hidden" value="community_reportform" name="command"/>
					<input type="hidden" value="<%=commentdto.getCommunity_seq()%>" name="seq">
				</form>
					<%if((int)session.getAttribute("member_no")==commentdto.getMember_no()){ %>
				<input style=" float: right; position: relative; bottom: 20px; right: 10px;" class="comment_update" type="button" value="수정""> 
				<input style=" float: right; position: relative; bottom: 20px; right: 10px;" class="detail_button" type="button" value="삭제" onclick="location.href='/semi_PetDiary/pet.do?command=community_comment_delete&seq=<%=commentdto.getCommunity_seq()%>&community_seq=<%=cdto.getCommunity_seq() %>'"> 			
				<input type="hidden" name="seq"class="comment_seq" value="<%=commentdto.getCommunity_seq()%>"> 
				<input type="hidden" name="comment_content"class="comment_content" value="<%=commentdto.getCommunity_content()%>"/> 
					<%} %>
				<%} %>
			</div>
			<%
			}
			%>					
		</div>
		
	</div>
</body>
</html>