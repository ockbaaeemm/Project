<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="../resources/css/commons.css" rel="stylesheet">

<script>
var bsOffcanvas = null;

function allCheck(obj) {		
	
	for(var cancelInput of document.querySelectorAll(".cancelNo")) {
		cancelInput.checked = obj.checked;	
	}			
}

function cancelRental() {
	var xhr = new XMLHttpRequest();
	var cancelBox_list = [];
	var rental_no_list = [];
	
	for(var e of document.querySelectorAll(".cancelNo")) {		
		if(e.checked) {
			rental_no_list.push(e.value);
			cancelBox_list.push(e.closest(".cancelBox"));
		}
	}
	
	if(rental_no_list == "") {
		bsOffcanvas.hide();
		
		alert("취소가능 예약 없음");
		return;
	}
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			var data = JSON.parse(xhr.responseText);
			
			if(data.result == "success") {
				for(var cancel_no of rental_no_list) {
					var cancel_date = document.querySelector("#rental_" + cancel_no);
					cancel_date.classList.add("text-gray-c_b7");
					cancel_date.setAttribute("style", "text-decoration:line-through");										
				}
				
				for(var cancelBox of cancelBox_list) {
					cancelBox.remove();
				}
				
				var cancelPrice = document.querySelector("#cancelPrice");
				cancelPrice.innerText = "(-) " + (parseInt(cancelPrice.innerText.slice(4, -1).split(",").join("")) + parseInt(data.cancelPrice)).toLocaleString() + "원";
				
				var totalPrice = document.querySelector("#totalPrice");
				totalPrice.innerText = "￦ " + (parseInt(totalPrice.innerText.slice(2, -1).split(",").join("")) - parseInt(data.cancelPrice)).toLocaleString() + "원";
				
				
			} else if(data.result == "error") {
				alert(data.message);
			}
			
		}
		
	};
	
	xhr.open("GET" , "../host/cancelRentalList?rental_no_list=" + rental_no_list , false);
	xhr.send();		
	
	bsOffcanvas.hide();
}

window.addEventListener("DOMContentLoaded" , function(){
	var myOffcanvas = document.getElementById('offcanvasBottom');
	bsOffcanvas = new bootstrap.Offcanvas(myOffcanvas);
	
	var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
	var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
	  return new bootstrap.Tooltip(tooltipTriggerEl)
	})
});
</script>
</head>
<body>
<div class="container-fluid px-0" style="overflow-x:hidden">
<jsp:include page="../commons/navbar.jsp"></jsp:include>

	<div class="row" style="padding-top: 2em;">

		<div class="col"></div> <!-- 왼쪽 여백 -->

		<div class="col-10">

			<div class="row">
				<div class="col text-center text-fs-23 bold">
					<i class="bi bi-pencil-square" style="margin-right:0.04rem;"></i>
					<span>예약상세</span>
				</div>
			</div>
			
			<div class="row mt-5">
				<div class="col fs-5">예약정보 <i class="bi bi-clipboard-check text-gold"></i></div>
			</div>
	
			<div class="row"> <div class="col"><hr></div> </div> <!-- 구분선 -->
			
			<div class="row"> <!-- 결제정보 -->
				<div class="col">
					<div class="row">
						<div class="col fw-light">
							<i class="bi bi-building text-gold"></i> 예약 오피스
						</div>
						<div class="col fw-light">
							<p class="text-right cursor-pointer" onclick="location.href='../guest/officeDetailPage?office_no=${orderData.officeVo.office_no}'">${orderData.officeVo.office_name }</p>
						</div>
					</div>
					<div class="row">
						<div class="col fw-light">
							<i class="bi bi-telephone-outbound text-gold"></i> 담당자
						</div>
						<div class="col fw-light">
							<p class="text-right">${orderData.officeVo.office_managerPhone }</p>
						</div>
					</div>					
					<div class="row">
						<div class="col fw-light">
							<i class="bi bi-person-plus text-gold"></i> 예약인원
						</div>
						<div class="col fw-light">
							<p class="text-right">${orderData.orderVo.order_personnel }명<p>
						</div>
					</div>

					<div class="row">
						<div class="col-4 fw-light">
							<div class="row">
								<div class="col">
									<i class="bi bi-calendar-week text-gold"></i> 예약날짜	
								</div>
							</div>
							<div class="row mt-3">
								<div class="col ms-2">
									<button class="rounded-full bg-gray-c_e1t btn text-fs-11 font-bold text-red-soft" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasBottom" aria-controls="offcanvasBottom">예약취소</button>
								</div>
							</div>
						</div>
						<div class="col-8 fw-light">
							<c:forEach items="${orderData.rentalVoList }" var="rentalVo">
								<c:choose>
									<c:when test="${rentalVo.rental_status == 'C' }">
										<p class="text-right text-gray-c_b7" style="text-decoration:line-through"><fmt:formatDate value="${rentalVo.rental_date }" pattern="yyyy년 MM월 dd일(E)"></fmt:formatDate></p>	
									</c:when>
									<c:otherwise>
										<p id="rental_${rentalVo.rental_no }" class="text-right"><fmt:formatDate value="${rentalVo.rental_date }" pattern="yyyy년 MM월 dd일(E)"></fmt:formatDate></p>
									</c:otherwise>
								</c:choose>
								
							</c:forEach>
						</div>
					</div>

					<div class="row"> <!-- 구분선 -->
						<div class="col divider" style="height:.25rem"></div>
					</div>

					<div class="row leading-tight" style="height:1.5rem">
						<div class="col text-fs-13 pt-1">결제수단</div>
						<div class="col">
							<img class="ms-1 float-right" src="../resources/img/kakaopay.png" style="height:60%">				
						</div>
					</div>
					<div class="row"> <!-- 구분선 -->
						<div class="col divider" style="height:.25rem"></div>
					</div>
					<div class="row mt-1">
						<div class="col">
							<div class="row">
								<div class="col fs-5">
									결제금액 <i class="bi bi-wallet2 text-gold"></i>
								</div>
							</div>
							<div class="row"> <div class="col"><hr></div> </div> <!-- 구분선 -->
							<div class="row">
								<div class="col">
									<div class="row">
										<div class="col">
											총 예약 금액
										</div>
										<div class="col">
											<p class="text-right"><fmt:formatNumber value="${orderData.originPrice }"/>원<p>
										</div>
									</div>
									<div class="row">
										<div class="col">
											<i class="bi bi-ticket-perforated text-gold"></i> 쿠폰 사용
										</div>
										<div class="col">
											<p class="text-right">(-) <fmt:formatNumber value="${orderData.couponPrice }"/>원<p>
										</div>
									</div>
									<div class="row">
										<div class="col">
											<i class="bi bi-x-octagon text-red-soft"></i> 결제 취소
										</div>
										<div class="col">
											<p id="cancelPrice" class="text-right">(-) <fmt:formatNumber value="${orderData.cancelPrice }"/>원<p>
										</div>
									</div>																		
									<div class="row"> <div class="col"><hr></div> </div> <!-- 구분선 -->
									<div class="row mb-3">
										<div class="col fs-4 text-medium2">
											총 결제 금액
										</div>
										<div class="col right fs-4">
											<p id="totalPrice" class="text-right">￦  <fmt:formatNumber value="${orderData.totalPrice }"/>원<p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

				</div>

			</div>			



			<div class="row" style="padding:1em;"></div>

		</div>

		<div class="col"></div> <!-- 왼쪽 여백 -->

	</div>


<div class="offcanvas offcanvas-bottom h-50" tabindex="-1" id="offcanvasBottom" aria-labelledby="offcanvasBottomLabel">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title" id="offcanvasBottomLabel">예약 취소 <i class="bi bi-info-circle text-gray-c_b7 text-fs-15" data-bs-toggle="tooltip" data-bs-placement="top" title="사용한 결제수단으로 환불"></i></h5>
    <span class="float-right"><input class="form-check-input" type="checkbox" onchange="allCheck(this)"> 전체 취소</span>    
  </div>
  <div class="offcanvas-body small">
  	<c:forEach items="${orderData.rentalVoList }" var="rentalVo">
  		<c:if test="${rentalVo.rental_status != 'C' }">
	     <div class="cancelBox row border rounded-5 mt-2 py-3 px-3" style="margin-right:.8rem; margin-left:0.01rem">
	    	<div class="col-1 pt-4 me-2">
	    		<input type="checkbox" class="cancelNo form-check-input" name="cancel_no" value="${rentalVo.rental_no }">
	    	</div>
	    	<div class="col">
	    		<div class="row text-fs-15 bold">
	    			<div class="cancelDate col"><fmt:formatDate value="${rentalVo.rental_date }" pattern="yyyy년 MM월 dd일(E)"></fmt:formatDate></div>
	    		</div>
	    		<div class="row mt-2 text-fs-13">
	    			<div class="col"><fmt:formatNumber value="${rentalVo.rental_price }"/> 원</div>
	    		</div>
	    	</div>
	    </div>
	   </c:if> 	
  	</c:forEach>
	<div class="row mt-3" style="margin-right:.15rem;">
    	<div class="col d-grid">
    		<button type="button" class="btn btn-dark" onclick="cancelRental()">선택완료</button>
    	</div>
    </div>         
  </div>
</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>