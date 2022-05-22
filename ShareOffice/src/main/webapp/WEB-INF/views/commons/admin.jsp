<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid" style="padding-left: 550px;">
    <a class="navbar-brand" href="../admin/adminPage">관리자 모드</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link" href="hostManagement">호스트 관리</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="guestManagement">게스트 관리</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="officeManagement">오피스 관리</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="../admin/QnAPage">Q&A 관리</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="createCouponPage">쿠폰 발급</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="createdCouponListPage">발급 쿠폰 목록</a>
        </li>
        <li class="nav-item">
          <c:choose>
        	<c:when test="${!empty adminUser }">
        		<a class="nav-link" href="logoutAdmin">로그아웃</a>
        	</c:when>
        	<c:otherwise>
        		<a class="nav-link" href="loginAdmin">로그인</a>
        	</c:otherwise>
        </c:choose>  
        </li>
      </ul>
    </div>
  </div>
</nav>
</body>
</html>