<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>작성글 목록</title>
<script>
	function listpage(page) {
		document.searchform.pageNum.value = page;
		document.searchform.submit();
	}
</script>
</head>
<body>
<h1>작성글 목록</h1>
<table>
	<tr>
		<form action="list" method="post" name="searchform">
			<td>
				<input type="hidden" name="pageNum" value="1">
				<input type="hidden" name="board_id" value="${param.board_id}">
				<select name="searchtype">
					<option value="">선택하세요</option>
					<option value="board_title">제목</option>
					<option value="user_id">작성자</option>
					<option value="board_content">내용</option>
				</select>
				<script>
					searchform.searchtype.value="${param.searchtype}";
				</script>
			</td>
			<td colspan="3">
				<input type="text" name="searchcontent" value="${param.searchcontent}">
			</td>
			<td><input type="submit" value="검색"></td>
			<td><input type="button" value="전체게시물보기" onclick="location.href='list?board_id=${board_id}'"></td>
		</form>
	</tr>
	<c:if test="${listCount > 0 }">
		<tr>
			<td colspan="5">글개수 : ${listCount}</td>
		</tr>
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>날짜</th>
		<th>조회수</th>
	</tr>
	<c:forEach items="${boardlist}" var="board">
		<tr>
			<td>${boardno}</td>
			<c:set var="boardno" value="${boardno -1 }"/>
			<td><a href="detail?board_num=${board.board_num}">${board.board_title}</a></td>
			<td>${board.user_id}</td>
			<td>
				<fmt:formatDate value="${board.board_date}" pattern="yyyyMMdd" var="rdate"/>
				<c:if test="${today == rdate}"> <fmt:formatDate value="${board.board_date}" pattern="HH:mm:ss"/></c:if>
				<c:if test="${today != rdate}"> <fmt:formatDate value="${board.board_date}" pattern="yyyy-MM-dd HH:mm"/></c:if>
			</td>
			<td>${board.board_readcnt}</td>
		</tr>
	</c:forEach>
	<tr>
		<td colspan="5">	
			<c:if test="${pageNum > 1 }">
				<a href="javascript:listpage('${pageNum - 1 }')">[이전]</a>
			</c:if>
			<c:if test="${pageNum <= 1}">[이전]</c:if>
			
			<c:forEach var="a" begin="${startpage}" end="${endpage}">
				<c:if test="${a == pageNum}">[${a}]</c:if>
				<c:if test="${a != pageNum}">
					<a href="javascript:listpage('${a}')">[${a}]</a>
				</c:if>
			</c:forEach>
		
			<c:if test="${pageNum < maxpage}">
				<a href="javascript:listpage('${pageNum + 1}')">[다음]</a>
			</c:if>	
			<c:if test="${pageNum >= maxpage}">[다음]</c:if>
		</td>
	</tr>
	</c:if>
	<%-- 등록된 게시물이 있는 경우  --%>
	
	<%-- 등록된 게시물이 없는 경우 --%>
	<c:if test="${listCount == 0 }">
		<tr>
			<td colspan="5">등록된 게시물이 없습니다.</td>
		</tr>
	</c:if>
	<tr>
		<td colspan="5"><a href="write">[건의 하기]</a></td>
	</tr>
</table>
</body>
</html>