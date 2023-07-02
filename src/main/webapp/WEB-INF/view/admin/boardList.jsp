<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>날짜</th>
			<th>작성자</th>
		</tr>
		<c:forEach items="${boardList}" var="list">
			<tr>
				<c:if test="${list.board_grpstep == 0 }">
				<td>${list.board_num}</td>
				<td><a href="reply?board_num=${list.board_num}">${list.board_title}</a></td>
				<td>${list.board_date}</td>
				<td>${list.user_id}</td>
				</c:if>
			</tr>
		</c:forEach>
		
	</table>
	
</body>
</html>