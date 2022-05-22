<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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

<style>
.border-top-gray {border-top:0.25rem solid #ddd;}

.btn-outline-gold {border:0.063rem solid #A68A64; color: #A68A64}
</style>

<script>

function useRental(obj, rental_no) {

	var xhr = new XMLHttpRequest();

	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			var data = JSON.parse(xhr.responseText);
			
			if(data.result == "success") {
				var li = obj.closest(".rental-li");
				li.querySelector(".canBtn").remove();
				obj.remove();
				
				var bigSpan = document.createElement("span");
				bigSpan.setAttribute("class", "ms-5")
				var i = document.createElement("i");
				i.setAttribute("class", "bi bi-check-lg text-green-dsoft btn-medium2");
				i.setAttribute("style", "padding-right:.2rem");
				var textSpan = document.createElement("span");
				textSpan.setAttribute("class", "btn-medium2 text-gray-c_25 px-0");
				textSpan.innerText = " 사용 완료";
				bigSpan.appendChild(i);
				bigSpan.appendChild(textSpan);
				li.appendChild(bigSpan);					
			}
		}
		
	};	
	
	xhr.open("get" , "./useRental?rental_no=" + rental_no , true);
	xhr.send();
}


function cancelRental(obj, rental_no) {

	var xhr = new XMLHttpRequest();

	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			var data = JSON.parse(xhr.responseText);
			
			if(data.result == 'success') {
				var li = obj.closest(".rental-li");
				li.querySelector(".useBtn").remove();
				obj.remove();
				
				var bigSpan = document.createElement("span");
				bigSpan.setAttribute("class", "ms-5")
				var i = document.createElement("i");
				i.setAttribute("class", "bi bi-x-octagon text-red-soft btn-medium2");
				i.setAttribute("style", "padding-right:.2rem");
				var textSpan = document.createElement("span");
				textSpan.setAttribute("class", "btn-medium2 text-gray-c_25 px-0");
				textSpan.innerText = " 취소 완료";
				bigSpan.appendChild(i);
				bigSpan.appendChild(textSpan);
				li.appendChild(bigSpan);	
			}
		}
		
	};	
	
	xhr.open("get" , "./cancelRental?rental_no=" + rental_no , true);
	xhr.send();	
}



</script>

</head>
<body>
<div class="container-fluid px-0" style="overflow-x : hidden">
<jsp:include page="../commons/navbar.jsp"></jsp:include>

<div class="row mb-5" style="padding-top: 2rem;">	
	<div class="col">
		<div class="row">
			<div class="col text-center text-fs-25 bold text-gray-c_25"><i class="bi bi-file-earmark-text text-gold"></i> 예약상세</div>
		</div>
		<div class="row mt-3">
			<div class="col text-fs-13 ms-1">주문번호 : ${resultMap.orderInfo.order_no } (<fmt:formatDate value="${resultMap.orderInfo.order_date }" pattern="yy-MM-dd" />)</div>
		</div>
		<div class="row border-top-gray">
			<div class="col-4">
				<img class="img-fluid" src="/soUpload/officeImage/${resultMap.orderInfo.office_thumbnail }" style="width:100%; height:100%">
			</div>
			<div class="col py-3 px-0">
				<div class="row">
					<div class="col text-fs-20 bold text-gray-c_25">${resultMap.orderInfo.office_name }</div>
				</div>
				<div class="row mt-4">
					<div class="col text-fs-11"><i class="bi bi-person text-gold"></i> 예약자: ${resultMap.guestVo.member_nick }, ${resultMap.guestVo.member_phone }</div>
				</div>
				<div class="row text-fs-11 mt-1">
					<div class="col"><i class="bi bi-calendar-check text-gold"></i> 예약일: 
					<c:forEach items="${resultMap.rentalList }" var="rental">
						<span><fmt:formatDate value="${rental.rental_date }" pattern="MM/dd(E)" /></span>
					</c:forEach>
					</div>
				</div>
				<div class="row text-fs-11 mt-1">					
					<div class="col text-fs-11"><i class="bi bi-people-fill text-gold"></i> 예약인원: ${resultMap.orderInfo.order_personnel }</div>					
				</div>									
				<div class="row mt-3">
					<div class="col"></div>
					<div class="col float-right bold text-fs-15 ms-5">￦ <fmt:formatNumber type="number" maxFractionDigits="3" value="${resultMap.totalPrice }" /></div>
				</div>					
			</div>				
		</div>
		<div class="row border-top-gray pt-3">
			<div class="col ms-1">
				<ul>
					<c:forEach items="${resultMap.rentalList }" var="rental">
						<li class="mt-1 rental-li">
						<span class="btn-medium2 text-gray-c_23 me-3"><i class="bi bi-alarm text-gold"> </i><fmt:formatDate value="${rental.rental_date }" pattern="MM/dd(E)" /></span>
						<span class="btn-medium2 text-gray-c_23 me-5"><i class="bi bi-wallet2 text-gold"> </i><fmt:formatNumber type="number" maxFractionDigits="3" value="${rental.rental_price}" /></span>
						<c:choose>
							<c:when test="${rental.rental_status == 'U' }">
								<span class="btn-medium2 text-gray-c_25 ms-5"><i class="bi bi-check-lg text-green-dsoft"></i> 사용 완료</span>
							</c:when>
							<c:when test="${rental.rental_status == 'C' }">
								<span class="btn-medium2 ms-5"><i class="bi bi-x-octagon text-red-soft"></i> 취소 완료</span>
							</c:when>
							<c:when test="${rental.rental_status == 'P' }">								
								<span class="btn-medium2 btn-outline-gold bold canBtn float-right ms-1 me-1" onclick="cancelRental(this, ${rental.rental_no})">취소</span>
								<span class="btn-medium2 btn-outline-gold bold useBtn float-right" onclick="useRental(this, ${rental.rental_no})">사용</span>
							</c:when>												
						</c:choose>
						</li>
					</c:forEach>
				</ul>
			</div>			
		</div>
	</div>
</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>