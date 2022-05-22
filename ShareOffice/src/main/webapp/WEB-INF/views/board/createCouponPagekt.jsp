<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		<div class="row">
			<div class="col"></div>	
			<div class="col text-center">쿠폰생성 페이지</div>	
			<div class="col"></div>	
		</div>
		<form action="createCouponProcess" method="post" enctype="multipart/form-data">
		<div class="row m-3">
		쿠폰이름
			<input type="text" class="form-control" name="coupon_name">
		쿠폰수량
			<input type="text" class="form-control" name="coupon_count">
		할인가격	
			<input type="text" class="form-control" name="coupon_discount">
		이미지	
			<input type="file" class="form-control" accept="image/*" name="image">
		사용기한 및 만료일자	
			<input type="date" class="form-control" name="coupon_useDate">
			
			<input type="submit" class="btn btn-primary" value="쿠폰생성">
		</div>
		</form>
	</div>
</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>