<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="uri" value="${pageContext.request.servletPath}" />
<!DOCTYPE html>
<html>
<head>
<title><sitemesh:write property="title"/></title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Myeongjo:400" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Gothic+A1:700" rel="stylesheet">
<script type="text/javascript" 
   src="http://cdn.ckeditor.com/4.5.7/standard/ckeditor.js">
</script>
<sitemesh:write property="head"/>
<style>
	.underbar, footer {
		text-decoration: none;
		font-family: "GmarketSansMedium";
    font-weight: 800;
    font-size : 20px;
    font-style: normal;
	}
	body,h1,h2,h3,h4,h5 {
    font-family: 'Noto Serif KR', serif;
    font-weight: 500;
    font-style: normal;
    }
    @font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
</style>
</head>
<body>

<!-- Navbar (sit on top) -->
<div class="w3-top">
  <div class="w3-bar w3-white w3-wide w3-padding w3-card">
    <a style="font-size : 30px;" class="underbar" href="${path}/board/main">
    <img src="${path}/image/bm.png" class="w3-image" width="3%"> 볼링매니아</a>
    <!-- Float links to the right. Hide them on small screens -->
    <div class="w3-display-right w3-container">
      <c:if test="${empty sessionScope.login}">
     		<a class="underbar" href="${path}/user/login">로그인</a>
     		<a class="underbar" href="${path}/user/join">회원가입</a>
  		</c:if>
      <c:if test="${!empty sessionScope.login}">
     		<strong style="font-family:'GmarketSansMedium';">${sessionScope.login}님</strong>&nbsp;&nbsp;
     		<a class="underbar" href="${path}/user/mypage?user_id=${sessionScope.login}">내정보</a>&nbsp;
     		<a class="underbar" href="${path}/user/logout">로그아웃</a>
  		</c:if>
    </div>
  </div>
</div>

<!-- Page content -->
<div id="main" class="w3-content w3-padding" style="max-width:1564px; margin-top: 100px;">
<sitemesh:write property="body"/>
</div>

<footer class="w3-center w3-black w3-padding-16" style="position: fixed; bottom: 0; width: 100%;">
  <p>Powered by 볼링매니아</p>
</footer>

</body>
</html>
