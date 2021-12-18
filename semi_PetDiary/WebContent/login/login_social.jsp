<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <% request.setCharacterEncoding("UTF-8"); %> <%
response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>네이버로 회원 가입하기</title>
<style type="text/css">
	
	body { background-color: #FFF6E3 }
	
	#wrap { position: absolute; top: 50%; left: 50%; line-height: 40px; transform: translate(-50%, -50%); }
	
	#top { color : #4D3417; padding-bottom : 50px; font-size: 30px; font-weight: 700; text-align: center; margin-bottom: 40px; }
	
    #top2 { text-align: center; color : #4D3417; font-size: 17px; font-weight: 700; }

    #naver input[type="text"] { border: #ccc 1px solid; border-radius: 20px; height: 30px; width: 280px; }

    #naver input[type="button"] { border: wheat 1px solid; color: #744D29; height: 28px; width:100px; font-weight: 700; font-size: 13.5px; border-radius: 50px; background-color: #ffe3bf; cursor: pointer; }
	
    #naver input[type="submit"] { border: salmon 1px solid; color: white; height: 35px; width:110px; font-weight: 700; border-radius: 50px; background-color: salmon; cursor: pointer; }

	#naver input[value='취소'] { border: #C9C6C6 1px solid; color: #858585; height: 35px; width:60px; font-weight: 500; border-radius: 50px; background-color: white; cursor: pointer; }

    #signup { margin: auto; width: 50%; }
</style>   
<script type="text/javascript">
      var nameExp = /^[가-힣]{2,15}$/;

      function searchAddr() {
        var pop = window.open(
          "/semi_PetDiary/login/login_addrChk.jsp",
          "pop",
          "width=570,height=420"
        );
      }

      function jusoCallBack(roadAddrPart1, roadAddrPart2, addrDetail) {
        // 팝업페이지에서 주소입력한 정보를 받아서 현 페이지에 정보를 등록함
        document.getElementById("member_addr").value = roadAddrPart1;
        document.getElementById("member_addr_detail").value =
          roadAddrPart2 + " " + addrDetail;
      }

      function checkForm() {
        var name = document.getElementsByName("member_name")[0];
        var addrDetail = document.getElementsByName("member_addr_detail")[0];
        if (addrDetail.value.trim() == "" || addrDetail.value == null) {
          alert("주소를 정확히 입력해주세요.");
          return false;
        } else {
          return true;
        }
      }
</script>
</head>
<body>
<%@include file="/main/header.jsp"%> 
<% String member_id = (String) request.getAttribute("member_id");
    String member_email = (String) request.getAttribute("member_email");
    String member_name = (String) request.getAttribute("member_name");
    String member_phone = (String) request.getAttribute("member_phone"); 
%>
    <div id="wrap">
      <div id="top"><i class="fas fa-paw"></i>&nbsp;<span>Pet Diary</span></div>
      <div id="top2">
      		<p>네이버 아이디로 로그인</p>	
			<p>회원가입 진행을 위한 추가 정보를 입력해 주세요.</p>
      </div>
	  <br/>
      <form id="naver" action="/semi_PetDiary/login.do" method="get" onsubmit="return checkForm()">
        <input type="hidden" name="command" value="social_signUp" />
        <input type="hidden" name="member_id" value="<%=member_id%>" />
        <input type="hidden" name="member_name" value="<%=member_name%>" />
        <input type="hidden" name="member_email" value="<%=member_email%>" />
        <input type="hidden" name="member_phone" value="<%=member_phone%>" />

        <div>주소 :</div>
        <div>
          <input type="text" name="member_addr" id="member_addr" placeholder=" 기본 주소" required="required" readonly="readonly" onclick=""/>
          &nbsp;
          <input type="button" value=" 주소 검색 " onclick="searchAddr();" />
          <br/>
          <input type="text" name="member_addr_detail" id="member_addr_detail" placeholder=" 상세 주소" required="required" readonly="readonly" onclick=""/>
        </div>
        <div>
          <br />
          <div id="signup">
            <input type="submit" value="회원가입" />
            <input type="button" value="취소" onclick="location.href='/semi_PetDiary/main/main.jsp'"/>
          </div>
        </div>
      </form>
    </div>
  </body>
</html>
