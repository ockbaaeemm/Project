<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>

<%
 String strReferer = request.getHeader("referer");
 
 if(strReferer == null){
%>
 <script language="javascript">
  alert("정상적인 경로를 통해 다시 접근해 주세요.");
  document.location.href="loginAdmin";
 </script>
<%
  return;
 }
%>

<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>쿠폰 발급 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="../resources/css/commons.css" rel="stylesheet">

<style>
	
	#coupon{
		margin-top: 70px; 
		margin-left: 650px; 
		margin-right: 650px; 
		margin-bottom: 70px;
		
		padding-top: 3rem; 
		padding-bottom: 1rem;
		
		background-color: #f1f3f5; 
		border-radius: 1rem;
		box-shadow: 0px 5px 5px gray;
	}


</style>

</head>
<body>
<div class="container-fluid px-0" style="overflow-x : hidden">
<div style="width:1925px; margin:0 auto">
	<div class="container-fluid">
	<jsp:include page="../commons/admin.jsp"></jsp:include>


	<div class="row" id="coupon">
		<div class="col">
			<%-- 내용작성 --%>
			<div class="row">
				<div class="col"></div>	
				<h1 style="text-align: center">쿠폰 발급</h1>	
				<div class="col"></div>	
			</div>
			<form action="createCouponProcess" method="post" enctype="multipart/form-data">
			<div class="row" style="margin: 2.5rem;">
			쿠폰이름
				<input type="text" class="form-control mb-3" name="coupon_name">
			쿠폰수량
				<input type="text" class="form-control mb-3" name="coupon_count">
			할인비율	
				<input type="text" class="form-control mb-3" name="coupon_discount">
			이미지	
				<input type="file" class="form-control mb-3" accept="image/*" name="image">
			사용기한 및 만료일자	
				<input type="date" class="form-control" name="coupon_useDate">
				
				<input type="submit" class="btn btn-dark" value="쿠폰발급" style="margin-top: 2rem;">
			</div>
			</form>
		</div>
	</div>
  </div>
</div>
<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>