<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>

<div class="container w3-light-grey">
	<div class="w3-container">
    <table class="table table-bordered align-middle mt-5">
    	<tr>
    		<td class="text-center w3-black" style="width:25%;">등록일</td>
    		<td colspan="2">
    			<fmt:formatDate value="${board.board_date}" pattern="yyyy-MM-dd"/>
    		</td>
    	</tr>
        <tr>
            <td class="text-center w3-black">작성자</td>
            <td colspan="2">${board.user_id}</td>
        </tr>
        <tr>
            <td class="text-center w3-black">제목</td>
            <td>${board.board_title}</td>
        </tr>
        <tr>
            <td class="text-center w3-black">건의사항</td>
            <td>${board.board_content}</td>
        </tr>
    </table>
    
    
    <c:if test="${empty comm.comm_date and  not empty sessionScope.adminId}">
 	   <h2 class="text-center mt-2 mb-4">답변</h2>
		<form:form modelAttribute="comment" action="comment" method="post" class="reply-form">
		<table class="table table-bordered  align-middle">
			<tr>
				<td class="text-center w3-black" style="width:25%;">답변 내용 :</td>
		              <td><textarea class="form-control" rows="4" cols="50" name="comm_content"></textarea>
		              </td>
			</tr>
		      </table>    
		              <div class="mt-2 mb-3 text-center"><input class="btn btn-dark" type="submit" value="답변하기"></div>
		</form:form>
    </c:if>
    <c:if test="${empty comm.comm_date and empty sessionScope.adminId }">
    	<h2 class="text-center">답변 대기중입니다.</h2>
    </c:if>
    <c:if test="${not empty comm.comm_date}">
    <h2 class="text-center mt-2 mb-4">답변</h2>
    <table class="table table-bordered  align-middle">
    	<tr>
    		<td class="text-center w3-black" style="width:25%;">답변자</td>
    		<td>볼매관리자</td>
    	</tr>
    	<tr>
    		<td class="text-center w3-black">답변일</td>
    		<td><fmt:formatDate value="${comm.comm_date}" pattern="yyyy-MM-dd"/></td>
    	</tr>
    	<tr>
    		<td class="text-center w3-black">답변 내용</td>
    		<td>${comm.comm_content}</td>
    	</tr>
    </table>
    </c:if>
    </div>
</div>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    function detailDelete(board_num) {
        if (confirm('정말 삭제하시겠습니까?')) {
            deleteBoard(board_num);
        }
    }

    function deleteBoard(board_num) {
        $.ajax({
            url: "${path}/board/delete",
            method: "POST",
            data: { board_num: board_num },
            success: function(response) {
                if (response.success) {
                    alert("게시글이 삭제되었습니다.");
                    // 삭제 후 필요한 동작 수행 (예: 페이지 리로드)
                    window.location.href = "${path}/board/list";
                } else {
                    alert("게시글 삭제에 실패했습니다.");
                }
            },
            error: function() {
                alert("서버 요청 실패");
            }
        });
    }
    
</script>
