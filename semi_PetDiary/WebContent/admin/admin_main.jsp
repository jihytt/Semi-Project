<%@page import="com.pet.ft.dto.CommunityDto"%>
<%@page import="java.util.List"%>
<%@page import="com.pet.ft.dto.MemberDto"%>
<%@page import="com.pet.ft.dto.ProfileDto"%>
<%@page import="com.pet.ft.dto.BusinessDto"%>
<%@page import="com.pet.ft.model.PetBizImpl"%>
<%@page import="com.pet.ft.model.PetBiz"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 모드</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript">

	$(function () {
	
		$('.profile-camera').click(function (e) {
	
			$('#file').click();
		});
	});
	
		    
	
      function changeValue(obj){

    	  $('#send').click();

      }


</script>

<style type="text/css">

	body{
		background-color: #FFF6E3;
	}
	
	.member-profile,
	.viewA,
	.viewB{
		position: relative;
	    border: 1px solid lightslategrey;
		cursor:pointer;
		width:150px;
		height:150px;
		border-radius:75px;
		line-height:150px;
		vertical-align:middle;
		font-size:12px;
		text-align:center;
	}
	
	.viewMember{
        width: 470px;
	    height: 290px;
	    background-color: skyblue;
	    position: absolute;
	    left: 800px;
	    top: 239px;
	    border-radius: 20px;
	}
	
	.viewReport {
	    width: 470px;
	    height: 290px;
	    background-color: pink;
	    position: absolute;
	    left: 800px;
	    top: 540px;
	    border-radius: 20px;
}
	}
	
	.member-profile{
   	    background-color: ghostwhite;
	    margin: auto;
	    top: 195px;
	    width: 50px;
	    height: 50px;
	    left: 60px;
	    z-index: 1;
	}
	
	.viewA{
		margin: 250px 1200px;
	    background-color: green;
	    bottom: 1400px;
	    left: 220px;
	}
	
	.viewB{
		margin: 350px 1700px;
		background-color: gray;
		bottom: 1500px;
	}
	
	.dot-member:hover, 
	.dot-report:hover, 
	.viewBook:hover{
		background-color:mistyrose;
	}
	
	.member-box{
	    width: 350px;
	    height: 600px;
	    background-color: whitesmoke;
	    position: relative;
	    left: 300px;
   		top: 180px;
	    border-radius: 15px;
	    box-shadow: 2px 2px 20px #aaa;
	}
	
	.profile-box{
	    width: 200px;
    	height: 230px;
    	margin: 0px 0px 0px 150px;
	}
	
	.text-box{
	    width: 350px;
	    height: 370px;
	    background-color: white;
	    position: relative;
	    margin: 0px auto;
	    border-radius: 0px 0px 15px 15px;
        bottom: 55px;
	}
	
	.profile-camera{
	    object-fit: cover;
	    border-radius: 200px;
	    position: relative;
	    bottom: 30px;
        z-index: 1;
    	border: 2px solid lightgrey;
    	left: 285px;
	}
	
	#top { 
	    position: relative;
	    color: #4D3417;
	    font-size: 40px;
	    font-weight: 700;
	    top: 150px;
	    left: 355px;
	}
	
	.profile{
	    width: 230px;
	    height: 222px;
	    position: absolute;
	    left: 57px;
	    border-radius: 250px;
	    border: 4px solid lightgrey;
	}
	
	.text-box-no{
	    width: 200px;
	    margin: 0px auto;
	    position: relative;
	    top: 25px;
	    text-align: center;
	}
	
	.text-box-name{
	    width: 200px;
	    margin: 0px auto;
	    position: relative;
	    top: 45px;
	    text-align: center;
	}
	
	.text-box-id{
	    width: 200px;
	    margin: 0px auto;
	    position: relative;
	    top: 65px;
	    text-align: center;
	}
	
	.text-box-email{
	    width: 200px;
	    margin: 0px auto;
	    position: relative;
	    top: 85px;
	    text-align: center;
	}
	
	.text-box-phone{
	    width: 200px;
	    margin: 0px auto;
	    position: relative;
	    top: 105px;
	    text-align: center;
	}
	
	.header-main,
	.member-cell{
		display: inline-block;
		width:150px;
		position: relative;
	}
	
	.header-main{
        height: 40px;
    	line-height: 2.5;
    	left: 20px;
	}
	
	.member-cell{
		line-height: 1;
    /* left: 25px; */
	    text-align: center;
	    right: 18px;
	}
	
	.dot-member,
	.dot-report{
		left: 160px;
	    bottom: 10px;
	    position: relative;
	    color: lightslategrey;
	}
	
	hr{
	    border: 1px solid lightyellow;
	}
	
	#main-background{   
	width: 100%;
    position: relative;
    padding-bottom: 25%;}
	
</style>

</head>
<body>

<%@ include file="/main/header.jsp" %>


<%
	PetBiz biz = new PetBizImpl();
	int mRes = biz.totalMember();
	int rRes = biz.totalReport();
	
	//memberview
	List<MemberDto> mlist = biz.memberList(0, 5);
	
	//reportview
	List<CommunityDto> clist = biz.reportList(0, 5);
	
	int res = 0;
	int member_no = (int) session.getAttribute("member_no");
	MemberDto mdto = (MemberDto)session.getAttribute("dto");
	
	// update
	String fullpath = (String) request.getAttribute("fullpath");
	ProfileDto dto = new ProfileDto(fullpath, "Y", member_no);
	
	// view
	ProfileDto vdto = biz.profile(member_no);
	if(fullpath != null){
		res = biz.updateProfile(dto); // update
		vdto = biz.profile(member_no);
		if(vdto.getProfile_state().equals("N")){
			fullpath = "/semi_PetDiary/upload" + "\\" + "default.png";
		} else{
			System.out.println("널이 아닐때 y : " + fullpath);
		}
		
		System.out.println("1");
	} else {
		if(vdto.getProfile_state().equals("N")){
			fullpath = "/semi_PetDiary/upload" + "\\" + "default.png";
		} else{
			fullpath = vdto.getProfile_src();
			System.out.println("널일때 y : " + fullpath);
		}
		
		System.out.println("2");
	}
	
	System.out.println("admin-main");
%>

	<div id="main-background">
	
		<div id="top"><i class="fas fa-paw"></i>&nbsp;<span>Pet Diary</span></div>
		
		<div class="viewMember">
		
		<div class="header-main"><b>회원번호</b></div>
		
		<div class="header-main"><b>회원이름</b></div>
		
		<div class="header-main"><b>회원등급</b></div><br/>
		<hr>
		<br/>
<% 	for(MemberDto member : mlist){ %>			
			
			<div class="member-cell">
				<%= member.getMember_no() %>
			</div>
			
			<div class="member-cell">
				<%= member.getMember_name() %>
			</div>
			
			<div class="member-cell">
				<%= member.getMember_role() %>
			</div>
		 <br/><br/>
<% } %>	
		<b><span class="dot-member" onclick="location.href='/semi_PetDiary/paging.do?command=member'">전체 회원 수 : <%=mRes %></span></b>
		</div>

		<div class="viewReport">
		
		<div class="header-main"><b>게시글번호</b></div>
		
		<div class="header-main"><b>게시글제목</b></div>
		
		<div class="header-main"><b>작성자</b></div><br/>
		<hr>
		<br/>

<%
	for(CommunityDto border : clist){ %>			
			<div class="member-cell">
				<%= border.getCommunity_seq() %>
			</div>
			
			<div class="member-cell">
				<%= border.getCommunity_title() %>
			</div>
			
			<div class="member-cell">
				<%= border.getMemberVO().getMember_id() %>
			</div>
		 <br/><br/>
<% } %>	
		<b><span class="dot-report" onclick="location.href='/semi_PetDiary/paging.do?command=report'">신고 게시물 수 : <%=rRes %></span></b>
		</div>

		<div class="member-box">
			<div class="profile-box">
				<img class="profile" alt="프로필" src="<%=fullpath %>"/>
			</div>
			
			<img class="profile-camera" alt="" src="/semi_PetDiary/resources/image/profile-camera.jpg" width=50 height=50>
			
			<div class="text-box">
				
				<div class="text-box-no">
					<div>
						<b>관리자 번호</b> : <br/>
						<%=mdto.getMember_no() %>
					</div>
				</div>
			
				<div class="text-box-name">
					<div>
						<b>관리자 이름</b> : <br/>
						<%=mdto.getMember_name() %>
					</div>
				</div>
				
				<div class="text-box-id">
					<div>
						<b>관리자 아이디</b> : <br/>
						<%=mdto.getMember_id() %>
					</div>
				</div>
				
				<div class="text-box-email">
					<div>
						<b>관리자 이메일</b> : <br/>
						<%=mdto.getMember_email() %>
					</div>
				</div>
				
				<div class="text-box-phone">
					<div>
						<b>관리자 번호</b> : <br/>
						<%=mdto.getMember_phone() %>
					</div>
				</div>
				
				
				
			</div>
		</div>
		
		<form name="signform" action="pet.do?command=adminSend" method="post" enctype="Multipart/form-data">
			<input type="file" id="file" name="fileName" style="display:none;" onchange="changeValue(this)">
			<input type="submit" id="send" value="전송" style="display:none;" >
		</form>	
		
	</div>
	
<%@ include file="/main/footer.jsp" %>

</body>
</html>