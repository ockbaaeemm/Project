<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="../resources/css/commons.css" rel="stylesheet">

</head>
<body>
<div class="container-fluid px-0" style="overflow-x : 
hidden">
<jsp:include page="../commons/navbar.jsp"></jsp:include>

<div class="row" style="padding-top: 2em; margin-bottom: 1rem; margin-left: 1rem; margin-right: 1rem;">
	
	<div class="col">
		<div class="row">
			<div class="col text-center text-fs-23 bold" style="margin-bottom: 2rem;"><i class="bi bi-ticket-perforated"></i> 쿠폰함</div>
		</div>
		<%-- 내용작성 --%>

		<c:forEach items="${myCouponList }" var="myCoupon">
		<c:if test="${myCoupon.myCouponVo.allot_useOrUnuse == 'N' }">
			<div class="row shadow-sm bg-body rounded" style="border: solid 0.1rem; border-radius: 0.4rem; border-color: #dee2e6; margin-bottom: 1rem;">
				<div class="col-3 pr-0">
					<img class="img-fluid py-3" src="/soUpload/couponImage/${myCoupon.myCouponVo.coupon_image }">
				</div>
				<div class="col">
					<div class="row">
						<div class="col pt-1">
							<span class="text-fs-20 bold">${myCoupon.myCouponVo.coupon_discount }%</span>
							<span class="text-fs-13 float-right" style="color: #868e96">~<fmt:formatDate value="${myCoupon.myCouponVo.coupon_useDate}" pattern="yy/MM/dd"/> 까지</span>
						</div>
					</div>
					<div class="row">
						<div class="col mt-2 pb-1">${myCoupon.myCouponVo.coupon_name }</div>
					</div>
				</div>
			</div>
		</c:if>
		
		</c:forEach>	
	</div>
</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>