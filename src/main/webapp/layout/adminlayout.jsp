<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />    

<!DOCTYPE html>
<html>
<head>
<title><sitemesh:write property="title" /></title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src= 
"https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>
<script type="text/javascript" 
   src="http://cdn.ckeditor.com/4.5.7/standard/ckeditor.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>   
<style>
html,body,h1,h2,h3,h4,h5 {font-family: "Raleway", sans-serif}
.login {
	color: white;
	text-decoration: none;
}
a{color:black};
</style>
<sitemesh:write property="head" />
</head>
<body class="w3-light-grey">

<!-- Top container -->
<div class="w3-bar w3-top w3-black w3-large" style="z-index:4">
  <button class="w3-bar-item w3-button w3-hide-large w3-hover-none w3-hover-text-light-grey" onclick="w3_open();"><i class="fa fa-bars"></i> &nbsp;Menu</button>
  <span class="w3-bar-item w3-right">
	<c:if test="${empty sessionScope.admin}">
	 <a href="${path}/admin/login" class=login>로그인</a>
	</c:if>   
	<c:if test="${!empty sessionScope.admin}">
	${sessionScope.admin.admin_name}님이 로그인 하셨습니다.&nbsp;&nbsp;
	 <a href="${path}/admin/logout" class=login>로그아웃</a>
	</c:if>   
  </span>
</div>
<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-white w3-animate-left" style="z-index:3;width:300px;" id="mySidebar"><br>
  <div class="w3-container w3-row">
    <div class="w3-col s4">
      <img src="${path}/image/bm.png" 
         class="w3-circle w3-margin-right" style="width:100px">
    </div>
    <div class="w3-col s8 w3-bar">
      <c:if test="${!empty sessionScope.admin}">
      <span>반갑습니다, <strong>${sessionScope.admin.admin_name}님</strong></span><br>
      </c:if>
      <c:if test="${empty sessionScope.admin}">
      <span><strong>로그인하세요</strong></span><br>
      </c:if>
    </div>
  </div>
  <hr>
  <div class="w3-bar-block">
    <a href="#" class="w3-bar-item w3-button w3-padding-16 w3-hide-large w3-dark-grey w3-hover-black" onclick="w3_close()" title="close menu"><i class="fa fa-remove fa-fw"></i>&nbsp; Close Menu</a>
    <a href="${path}/admin/list" 
    class="w3-bar-item w3-button w3-padding">
    <i class="fa fa-users fa-fw"></i>&nbsp; 회원관리</a>
    <a href="${path}/admin/reserveList" 
    class="w3-bar-item w3-button w3-padding">
    <i class="fa fa-eye fa-fw"></i>&nbsp; 예약관리</a>
    <hr>
    <a href="${path}/admin/noticeList"
     class="w3-bar-item w3-button w3-padding
     <c:if test='${url == "board" && boardid=="1"}'>w3-blue</c:if>">
    <i class="fa fa-eye fa-fw"></i>&nbsp; 공지작성</a>
    <a href="${path}/admin/boardList" 
    class="w3-bar-item w3-button w3-padding
    	<c:if test='${url == "board" && boardid=="2"}'>w3-blue</c:if>">
    <i class="fa fa-eye fa-fw"></i>&nbsp; 건의답변</a>
  </div>
  <%-- 수출입은행 환율 정보 표시 영역 --%>
  <div style="width:100%;">
     <div id="exchange" style="width:70%; margin: 6px;"></div>
  </div>
</nav>

<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:300px;margin-top:43px;">

  <!-- Header -->
  <!-- 
  <header class="w3-container" style="padding-top:22px">
    <h5><b><i class="fa fa-dashboard"></i>예약현황</b></h5>
  </header>
  <div class="w3-row-padding w3-margin-bottom">
    <div class="w3-half">
      <div class="w3-container w3-padding-16 w3-center">
         <input type="radio" name="pie" onchange="piegraph(2)"
          checked="checked">공지사항 &nbsp;&nbsp;
         <input type="radio" name="pie" onchange="piegraph(3)">건의사항 &nbsp;&nbsp;
         <div id="piecontainer" style="width:100%; border:1px solid #ffffff">
            <canvas id="canvas1" style="width:100%"></canvas>
         </div>
      </div>
    </div>
  </div>
  -->
  <div class="w3-panel">
  <sitemesh:write property="body" />
  </div>
  <hr>
  <!-- Footer -->
 <footer class="w3-center w3-black w3-padding-16" style="position: fixed; bottom: 0; width: 100%;">
  <p>Powered by 볼링매니아</p>
</footer>
  <!-- End page content -->
</div>

<script>
// Get the Sidebar
var mySidebar = document.getElementById("mySidebar");

// Get the DIV with overlay effect
var overlayBg = document.getElementById("myOverlay");

// Toggle between showing and hiding the sidebar, and add overlay effect
function w3_open() {
  if (mySidebar.style.display === 'block') {
    mySidebar.style.display = 'none';
    overlayBg.style.display = "none";
  } else {
    mySidebar.style.display = 'block';
    overlayBg.style.display = "block";
  }
}

// Close the sidebar with the close button
function w3_close() {
  mySidebar.style.display = "none";
  overlayBg.style.display = "none";
}
</script>
<script type="text/javascript" 
       src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js">
       </script>

</body>
</html>