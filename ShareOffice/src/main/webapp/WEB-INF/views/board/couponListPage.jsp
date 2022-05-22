<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="now" value="<%=new java.util.Date()%>" />
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
<div class="container-fluid px-0" style="overflow-x : hidden">
<jsp:include page="../commons/navbar.jsp"></jsp:include>

<div class="row" style="padding-top:2em;">
   <div class="col">
         <c:forEach items="${CouponVo }" var="coupon">
      <div class="row">
       <div class="col" style="margin:0.5rem">
            <form action="./getCouponProcess" method="post">
               <div class="card shadow" style="padding:0.5em">
                  <div class="row">
					<div class="col" style="margin:1em">
	                  <img src="/soUpload/couponImage/${coupon.CouponVoList.coupon_image }" style="width:100%;"class="card-img-top" alt="쿠폰이미지">
					</div>
                  </div>
                 <ul class="list-group list-group-flush">
                   <li class="list-group-item">사용기간 및 발급가능일 : <fmt:formatDate value="${coupon.CouponVoList.coupon_useDate }" pattern="yy.MM.dd"/> 까지 </li>
                   <li class="list-group-item" id="count">남은수량 : ${coupon.CouponVoList.coupon_count - coupon.waste }</li>
                 
                 </ul>
                
                 <div class="row">
                 	<div class="col d-grid">
                 	
                    <input type="hidden" value="${coupon.CouponVoList.coupon_no }" name="coupon_no">
                    <input type="hidden" value="${sessionUser.member_no }" name="member_no">
                    <input type="hidden" value="Y" name="allot_useOrUnuse">
                  
                  <c:choose>
                     <c:when test="${coupon.myReserveCouponCount eq 1 }">
                          <c:if test="${!empty sessionUser }">
                        <input type="button" class="my-3 btn btn-secondary" disabled value="발급 완료">
                          </c:if>
                     
                     </c:when>
                     <c:when test="${coupon.CouponVoList.coupon_count - coupon.waste <= 0 }">
                          <c:if test="${!empty sessionUser }">
                        <input type="submit" class="my-3 btn btn-secondary" disabled value="쿠폰 소진">
                          <!-- 
                           <input type="button" onclick="alert('쿠폰이 소진 되었습니다.')" class="btn btn-primary float-end me-3" value="쿠폰발급">
                         -->
                          </c:if>
                     
                     </c:when>
                     
                     <c:when test="${coupon.CouponVoList.coupon_useDate < now }">
                          <c:if test="${!empty sessionUser }">
                        <input type="button" class="my-3 btn btn-secondary" disabled value="기한 만료">
                          </c:if>
                     
                     </c:when>
                     
                     <c:otherwise>
                        <c:if test="${!empty sessionUser }">
                        <input type="submit" class="my-3 btn" style="background-color: #A68A64; color: #ffffff;" value="쿠폰 발급">
                          </c:if>                              
                     </c:otherwise>
                  </c:choose>
                     
                     
                     <%--
                     <c:forEach items="${reserveCouponList[statusCoupon.index] }" var="reserve" varStatus="status">
                     <c:choose>
                        <c:when test="${reserve.reserveCouponList.values eq 1}" >
                             <c:if test="${!empty sessionUser }">
                           <input type="submit" class="btn btn-primary float-end me-3" disabled value="발급불가">
                             </c:if>
                        </c:when>
                        <c:otherwise>
                           <c:if test="${!empty sessionUser }">
                           <input type="submit" class="btn btn-primary float-end me-3" value="쿠폰발급">
                             </c:if>                              
                        </c:otherwise>
                     </c:choose>
                     </c:forEach>
                      --%>
                  
                 </div>   
                 </div>
               </div>
            </form>
      </div>
       </div>
         </c:forEach>
   </div>
</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>