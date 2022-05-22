<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<style>
th, td {
  vertical-align : middle;
}
</style>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>관리자 쿠폰 목록 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="../resources/css/commons.css" rel="stylesheet">

</head>
<body>
<jsp:include page="../commons/admin.jsp"></jsp:include>

<div class="row" style="padding:5rem">
	<div class="col m-3">
	   <div class="row">
               <h1>발급 쿠폰 목록</h1>
	   
	    </div>
	  

	   <div class="row mt-2">
	      <div class="col">
	 
			<table class="table table-hover " style="word-wrap:break-word;word-break:break-all;table-layout: fixed;text-align: center;">
				<thead>
					<tr>
						<th width="5%" scope="col">No</th>
						<th width="30%" scope="col">Image</th>
						<th width="25%" scope="col">Name</th>
						<th width="10%" scope="col">Total</th>
						<th width="10%" scope="col">Price</th>
						<th width="10%" scope="col">Until</th>
						<th width="10%" scope="col"></th>
					</tr>
				</thead>
			   
				<tbody>
				    <c:forEach items="${CouponVo }" var="coupon">
					<tr style="height:10rem;" >
						<th scope="row" >${coupon.CouponVoList.coupon_no }</th>
						<td style="word-break:break-all"> <img class="" src="/soUpload/couponImage/${coupon.CouponVoList.coupon_image }"  style="height:9rem" alt="쿠폰이미지"></td>
						<td>${coupon.CouponVoList.coupon_name }</td>
						<td>${coupon.CouponVoList.coupon_count }</td>
						<td>${coupon.CouponVoList.coupon_discount }원</td>
						<td>~<fmt:formatDate value="${coupon.CouponVoList.coupon_useDate }" pattern="yy.MM.dd"/>까지</td>
						<td style="text-align: right"><button type="button" class="btn btn-secondary ml-1 ">수정</button>
						<button type="button" class="btn btn-secondary ml-1 ">삭제</button></td>
					</tr>
				   </c:forEach>
				</tbody>
		    
			</table>
	
       </div>
     </div>

	
		
		
		
	</div>
</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>