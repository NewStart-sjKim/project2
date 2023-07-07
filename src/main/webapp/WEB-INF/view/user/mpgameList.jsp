<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소셜매치 내역</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

	$(function(){
		$("#minfo").show()
		$("#oinfo").hide()
		$(".gLine").each(function(){
			$(this).hide()
		})
	})
	
	function list_disp(id){
		$("#"+id).toggle()
	}
</script>
</head>
<body>
<div class="container" style="magin-top:55px;">
	<div id="minfo" class="minfo" style="display : flex; justify-content : space-between;">
	  	<div style="flex-basis : 20%;">
			<h2>소셜매치 내역</h2>
 			<%@ include file="mypageSideBar2.jsp" %>
		</div>
	<table class="w3-table-all">
		<tr>
			<th>제목</th>
			<th>작성자</th>
			<th>내용</th>
			<th>매칭날짜</th>
			<th>신청인원</th>
			<th></th>
		</tr>
			<c:forEach var="g" items="${gmuser}" varStatus="stat">
		<tr>
			<td>${g.key.game_title}</td>
			<td>${g.key.user_id}</td>
			<td>${g.key.game_content}</td>
			<td>
				<fmt:formatDate value="${g.key.game_date}" pattern="yyyy년MM월dd일"/>
			</td>
				<td>
				<a href="javascript:list_disp('gLine${stat.index}')">
					${g.key.game_max}/${g.key.game_people}
				</a>
				</td>
			<td>
				<c:if test="${param.user_id == g.key.user_id}">
				<a href="mpdelete?gmnum=${g.key.game_num}">
					[삭제]
				</a>
				</c:if>
			</td>
		</tr>
		<tr id="gLine${stat.index}" class="gLine">
		<td>
		<table>
			<tr >
				<th>참가자 아이디</th>
				<th>참가자 성별</th>
				<th>참가자 나이</th>
				<th>참가자 에버리지</th>
				<th></th>
				<th></th>
			</tr>
			<c:forEach var="gm" items="${g.value}">
				<tr>
					<td>${gm.user_id}</td>
					<td>${gm.user_gender}</td>
					<td>${gm.user_age}</td>
					<td>${gm.user_avg}</td>
					<td>
						<c:if test="${param.user_id == gm.user_id}">
							<a href="mpudelete?gmnum=${g.key.game_num}&user_id=${sessionScope.loginUser.user_id}">[run]</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
		</td>
		</tr>
		</c:forEach>
	</table>
</div>
	</div>
</body>
</html>