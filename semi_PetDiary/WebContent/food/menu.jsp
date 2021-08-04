<%@page import="com.pet.ft.dto.BusinessDto"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charser=UTF-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<div class="foodlist">
			<section>
				<c:choose>
					<c:when test="${empty list1 }">
						<p>등록된 메뉴가 없습니다.</p>
					</c:when>
					<c:otherwise>
						<c:forEach items="${list1 }" var="bdto">
						<article>
							<a href="pet.do?command=bookform&business_num=${bdto.business_num}"></a>
							
								<div class="foodlist">
									<div>
									<c:forEach items="${list }" var="bdto">
												${bdto.menu_name} : ${bdto.menu_price }
											</c:forEach>
									</div>
								</div>
							</article>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</section>	
			</div>
</body>
</html>