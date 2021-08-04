<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<div class="paginate">
	
	<c:if test="${param.currentPageNo ne param.firstPageNo }">
		<a href="javascript:goPage('${key }', '${servletPath}',${param.prevPageNo}, ${param.recordsPerPage})" class="prev">◀</a>
	</c:if>
	
	<span>
		<c:forEach var="i" begin="${param.startPageNo}" end="${param.endPageNo}" step="1">
			<c:choose>
				<c:when test="${i eq param.currentPageNo }">
					<b><font size=+1>
							<a class="sizePage" href="javascript:goPage('${key }', '${servletPath}',${i}, ${param.recordsPerPage})" class="choice"><span class="current-page">${i}</span></a>
					   </font>
					</b>
				</c:when>
				<c:otherwise>
					<a class="sizePage" href="javascript:goPage('${key }', '${servletPath}',${i}, ${param.recordsPerPage})">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</span>
	
	<c:if test="${param.currentPageNo ne param.finalPageNo }">
		<a href="javascript:goPage('${key }', '${servletPath}',${param.nextPageNo}, ${param.recordsPerPage})" class="next">▶</a>
	</c:if>
	
</div>
