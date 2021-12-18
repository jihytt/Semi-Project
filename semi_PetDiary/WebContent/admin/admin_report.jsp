<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/semi_PetDiary/resources/js/script.js"></script>
<script type="text/javascript">

	$(function(){
		$("input[name=submit]").click(function(){
			var seq = $(this).parents('span').find('input').val();
			location.href="/semi_PetDiary/pet.do?command=delete&seq=" + seq;
		});
	});

</script>

<style type="text/css">
	
	body{
		background-color: #FFF6E3;
	}
	
	h2{width:200px; margin: 10px auto;}
	#main-background{width: 100%;height: 1219px;}
	#table {display: table; width: 80%; margin: 20px auto;}
	.row {display: table-row;}
	.main{background-color: salmon; color:white; text-align: center;}
	.cell {display: table-cell; padding: 3px; border: 0.5px solid #DDD; text-align: center;}
	.col1 {width: 1%;}
	.col2 {width: 2%;}
	.col3 {width: 1%;}
	.col4 {width: 2%;}
	.col5 {width: 1%;}
	.col6 {width: 2%;}
	.col7 {width: 1%;}
	
	.paginate{margin: 0px auto; width: 200px; text-align: center;}
	.paginate a	{color: black;}
		
</style>
</head>
<body>

<%@ include file="/main/header.jsp" %>

	<h2>신고글 조회</h2>
	<div id="main-background">
		<div id="table">
			<div class="row main">
				<span class="cell col1">게시글 번호</span>
				<span class="cell col2">제목</span>
				<span class="cell col3">작성자</span>
				<span class="cell col4">신고내용</span>
				<span class="cell col5">신고횟수</span>
				<span class="cell col6">작성일자</span>
				<span class="cell col7">권한</span>
			</div>
			<c:choose>
				<c:when test="${empty list }">
					<span class="cell col1"> x </span>
					<span class="cell col2"> x </span>
					<span class="cell col3"> x </span>
					<span class="cell col4"> x </span>
					<span class="cell col5"> x </span>
					<span class="cell col6"> x </span>
					<span class="cell col7"> x </span>
				</c:when>
			
				<c:otherwise>
					<c:forEach items="${list }" var="dto" varStatus="stat">
						<c:if test="${dto.community_report == 'N'}">
						<div class="row">
							<span class="cell col1">${dto.community_seq }</span>
							<span class="cell col2">${dto.community_title }</span>
							<span class="cell col3">${dto.memberVO.member_id }</span>
							<span class="cell col4">${dto.community_reportcontent }</span>
							<span class="cell col5">${dto.community_reportcount }</span>
							<span class="cell col6">${dto.community_regdate }</span>
							<span class="cell col7">
								<input type="hidden" value="${dto.community_seq }"/>
								<input type="button" name="submit" value="삭제"/>
							</span>
						</div>
					</c:if>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
		
		<jsp:include page="/main/paging.jsp" flush="true">
			<jsp:param name="servletPath" value="${servletPath }"/>
			<jsp:param name="recordsPerPage" value="${paging.recordsPerPage }"/>
			<jsp:param name="firstPageNo" value="${paging.firstPageNo }"/>
			<jsp:param name="prevPageNo" value="${paging.prevPageNo }"/>
			<jsp:param name="startPageNo" value="${paging.startPageNo }"/>
			<jsp:param name="currentPageNo" value="${paging.currentPageNo }"/>
			<jsp:param name="endPageNo" value="${paging.endPageNo }"/>
			<jsp:param name="nextPageNo" value="${paging.nextPageNo }"/>
			<jsp:param name="finalPageNo" value="${paging.finalPageNo }"/>
		</jsp:include>
	</div>

<%@ include file="/main/footer.jsp" %>

</body>
</html>