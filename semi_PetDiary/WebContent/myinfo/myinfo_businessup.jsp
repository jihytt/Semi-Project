<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사업신청</title>
<link href="/semi_PetDiary/resources/css/stylesheet.css" rel="stylesheet">
<style type="text/css">

	#wrapform {
		position : absolute;
		top: 50%;
		left: 50%;
		line-height: 25px;
		transform: translate(-50%, -50%);
	}
	#h1 {
		position : absolute;
		padding-bottom : 50px;
		left: 50%;
		transform: translate(-50%, -50%);
	}
	
	#join input[type='text'] { 
	    border:#ccc 1px solid;
	    border-radius:5px;
	    height: 25px;
	    width: 250px;
	}
	
	#join input[type='button'] { 
		border: salmon 2px solid;
		border-radius:5px;
	    height: 25px;
	    background-color: white;
	}
	
	#join input[type='submit'] { 
		border: salmon 2px solid;
		color: white;
		border-radius:5px;
	    height: 25px;
	    background-color: salmon;
	}
	

</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">


	function searchAddr() {
		  var pop = window.open("/semi_PetDiary/login/login_addrChk.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	}
	
	function jusoCallBack(roadAddrPart1, roadAddrPart2,addrDetail){
			// 팝업페이지에서 주소입력한 정보를 받아서 현 페이지에 정보를 등록함
			document.getElementById("member_addr").value = roadAddrPart1;
			document.getElementById("member_addr_detail").value = roadAddrPart2 +" "+ addrDetail;
	}
		
	
		
</script>
</head>
<body>
<%@include file="/main/header.jsp"%>
	
	<form id="join" name="join" action="/semi_PetDiary/pet.do" method="post">
		<input type="hidden" name="command" value="myinfo_business"/>
		<table>
			<div id="wrapform">
				<br/>
				<div>
					<div>업체 이름</div>
					<div>
						<input type="text" name="Business_name"  required="required"/>
					</div>
				</div>
				<div>
					<div>업체 구분</div>
					<div>
						<select name="Business_role" required="required">
							<option value="H"> 병원	</option>
							<option value="S"> 음식점/카페</option>							
						</select>
					</div>
				</div>
				<div>
					<div>이용 가능 시간</div>
					<div>						
						<select name="Business_time1"  required="required">
							<option value="" selected disabled hidden>선택</option>
						<%for(int i = 0;i<24;i++){ %>
							<% if(i <10){ %>
							<option value = "<%="0"+i%>"><%="0"+i%></option>
							<%}else{ %>
							<option value = "<%=i%>"><%=i%> </option>
						<%}} %>			
						</select>
						:			
						<select name="Business_time2" required="required">						
							<option value="" selected disabled hidden>선택</option>
							<option value="00">00</option>
							<option value="30">30</option>							
						</select>
						~			
						<select name="Business_time3" required="required">
							<option value="" selected disabled hidden>선택</option>
						<%for(int i = 0;i<24;i++){ %>
							<% if(i <10){ %>
							<option value = "<%="0"+i%>"><%="0"+i%></option>
							<%}else{ %>
							<option value = "<%=i%>"><%=i%> </option>
						<%}} %>			
						</select>
						:			
						<select name="Business_time4" required="required">
							<option value="" selected disabled hidden>선택</option>
							<option value="00">00</option>
							<option value="30">30</option>							
						</select>
						
					</div>
				</div>
				<div>
					<div>주차 가능 여부</div>
					<div>
						<select name="Business__park">
							<option value="" selected disabled hidden>선택</option>
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select>
					</div>
				</div>
				<div>
					<div>업체 주소</div>
					<div>
						<input type="text" name="Business_addr" id="member_addr" placeholder=" 기본 주소" required="required" readonly="readonly" onclick=""/>
						<input type="button" value=" 주소 검색 " onclick="searchAddr();"/> <br/>
						<input type="text" name="Business_addr_detail" id="member_addr_detail" placeholder=" 상세 주소" required="required" readonly="readonly" onclick=""/>
					</div>
					
				<div>
					<div>사업자 번호</div>
					<div>
						<input type="text" name="Business_no"  required="required"/>
					</div>
				</div>
				</div>
				<br/>
				<div>
					<div id="signup">
						<input type="submit" value=" 신청 "/>
						<input type="button" value=" 취소 "/>
					</div>
				</div>
			</div>
		</table>
	</form>
	


<%@include file="/main/footer.jsp"%>
</body>
</html>