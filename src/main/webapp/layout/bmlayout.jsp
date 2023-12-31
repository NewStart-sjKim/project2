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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<script src="https://kit.fontawesome.com/460016aa20.js" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css?family=Nanum+Myeongjo:400" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Gothic+A1:700" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous">
</script>
<script type="text/javascript" 
   src="http://cdn.ckeditor.com/4.5.7/standard/ckeditor.js">
</script>
<sitemesh:write property="head"/>
<style>

.day {
   width : 50px;
   text-align : center;
   border : 1px solid black;
   border-radius: 30px;
   padding : 10px;
}
.day_table {
        border-collapse: separate; /* 테두리 간격을 띄우기 위해 separate로 설정 */
        border-spacing: 50px; /* 테두리 간격을 50px로 지정 */
        margin : 0 auto;
    }

ol,ul {
   list-style : none;
}

.ul_class {
   margin : 8px 2px 0;
}

.li_class {
   width : 22%;
   height : 50px;
   background-color : #edfbdc;
   list-style-type: none;
   display: inline-block;
   margin : 0 2px 4px;
   font-size : 1.5rem;
   text-align : center;
   line-height: 50px;
   border : 1px solid #c8e1af;
   color : #333;
   cursor: pointer;
}



.choice {
   display : flex;
   padding : 15px 18px;
   
   align-items: center;
   justify-content: center;
   height: 10vh;
}

/* button {
   width : 22%;
   height : 50px;
   border-radius: 30px;
   font-size : 1.5rem;
   margin : 0px 10px 0px 10px;
   
} */

.selected {
    background-color: #06c755;
}

select {
  width: 200px;
  height: 30px;
}

option {
  padding: 100px;
}

.rain_ul {
   margin : 8px 2px 0;
}

.rain_li {
   width : 22%;
   height : 50px;
   background-color : #edfbdc;
   list-style-type: none;
   display: inline-block;
   margin : 0 2px 4px;
   font-size : 1.5rem;
   text-align : center;
   line-height: 50px;
   border : 1px solid #c8e1af;
   color : #333;   
   cursor: pointer;
}

.click {
   background-color : #06c755;
}

label {
   cursor: pointer;
}

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
<div class="w3-top" style="margin-bottom: 80px">
  <div class="w3-bar w3-white w3-wide w3-padding w3-card">
    <a style="font-size : 30px;" class="underbar" href="${path}/board/main">
    <img src="${path}/image/bm.png" class="w3-image" width="3%"> 볼링매니아</a>
    <div class="w3-display-middle w3-container">
    <a style="font-size : 30px;" class="underbar" href="${path}/game/gamelist">소셜매치</a>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a style="font-size : 30px;" class="underbar" href="${path}/reservation/reservation">예약하기</a>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a style="font-size : 30px;" class="underbar" href="${path}/board/noticeList">공지사항</a>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a style="font-size : 30px;" class="underbar" href="${path}/board/list?boardid=1">건의사항</a>
    </div>
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
<div id="main" class="w3-content w3-padding" style="min-height:90vh; max-width:1564px; margin-top: 100px; margin : 0px auto;">
<sitemesh:write property="body"/>
</div>
<footer class="w3-center w3-black w3-padding-16" style="margin-top: 70px; fixed; bottom: 0; width: 100%; height: 50px;">
  <strong>Powered by 볼링매니아</strong>
  <a href="${path}/admin/login"><i class="fas fa-user-cog"></i></a>
  
</footer>

</body>
</html>