<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1, shrink-to-fit=no">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="../resources/css/commons.css" rel="stylesheet">

</head>
<body>
<jsp:include page="../commons/navbar.jsp"></jsp:include>

<div class="row" style="padding-top: 2em;">
	<div class="col" style="margin:2rem">
		<%-- 내용작성 --%>
		<%--
		 <c:if test="${!empty adminUser }">
	
		 </c:if>
		 --%>
		<a href="./createCouponPage" class="btn btn-primary float-end">쿠폰생성하기</a>
		
		<c:forEach items="${CouponVo }" var="coupon">
		<div class="card" style="width: 16rem;">
		   <img src="/soUpload/couponImage/${coupon.CouponVoList.coupon_image }" class="card-img-top" alt="쿠폰이미지">
		  <div class="card-body">
		    <h5 class="card-title">${coupon.CouponVoList.coupon_name }</h5>
		    <p class="card-text">${coupon.CouponVoList.coupon_discount }원</p>
		  </div>
		  <ul class="list-group list-group-flush">
		    <li class="list-group-item"><fmt:formatDate value="${coupon.CouponVoList.coupon_useDate }" pattern="yy.MM.dd"/>까지 </li>
		    <li class="list-group-item">총수량 : ${coupon.CouponVoList.coupon_count }</li>
		  </ul>
		  <div class="card-body">
		<!-- 
		    <a href="#" class="btn btn-primary" onclick="test1()">발급받기?</a>
		 -->
		  </div>	
		</div>
		</c:forEach>
		
		
		
	</div>
</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>