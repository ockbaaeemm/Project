<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>호스트/오피스 상세 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="../resources/css/commons.css" rel="stylesheet">

</head>
<body>
<div class="container-fluid px-0" style="overflow-x : hidden">
<jsp:include page="../commons/navbar.jsp"></jsp:include>

		<div class="row" style="padding-top: 2rem;">
			<div class="col">
			
				<div class="row">
					<div class="col">
						
						<div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
							  <div class="carousel-inner">
							  	<c:forEach items="${data.imageDetailVoList }" var="image" varStatus="sttttttttt">
							  	
							  	<c:choose>
							  		<c:when test="${sttttttttt.index == 0 }">
							    <div class="carousel-item active">
							      <img src="/soUpload/officeImage/${image.image_url}" width=100%, height=220rem class="d-block w-100" alt="...">
							    </div>
							  		</c:when>
							  		<c:otherwise>
							    <div class="carousel-item">
							      <img src="/soUpload/officeImage/${image.image_url}" width=100%, height=220rem class="d-block w-100" alt="...">
							    </div>
							  		</c:otherwise>
							  	</c:choose>
							  	
							    </c:forEach>
							  </div>
							  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
							    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
							    <span class="visually-hidden">Previous</span>
							  </button>
							  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
							    <span class="carousel-control-next-icon" aria-hidden="true"></span>
							    <span class="visually-hidden">Next</span>
							  </button>
						</div>
					</div>
				</div>
				
					<!-- <div class="row"></div>  -->
					<!-- <div class="col"></div>  -->
					
			<div class="row mt-3 text-fs-16" style="margin: 0.5rem;">
				<div class="col">
					<div class="row mt-3 font-medium2">
						<p class="text-fs-23">${data.officeInfoVo.office_name }</p>
					</div>
					
					<div class="row mt-4">
						<div class="col">
							<p class="fs-6 font-medium2">오피스 정보</p>
						</div>
						<br>
						<p class="mb-2 text-fs-15"><i class="bi bi-geo-alt"></i> 주소 : ${data.officeInfoVo.office_address } ${data.officeInfoVo.office_address_detail }</p>
						<p class="text-fs-15"><i class="bi bi-telephone"></i> 담당자 전화번호 : ${data.officeInfoVo.office_managerPhone }</p>
					</div>

					<div class="row mt-5">
						<div class="col">
							<p class="fs-6 font-medium2">오피스 설명</p>
						</div>
						<br>
						<p class="mb-2 text-fs-15 font-medium1"><i class="bi bi-pen"></i> 공간간단소개  <div class="text-fs-15">${data.officeInfoVo.office_simpleContent }</div></p>
						<p class="mb-2 text-fs-15"><i class="bi bi-file-text"></i> 공간상세소개  <div class="text-fs-15">${data.officeInfoVo.office_detailContent }</div></p>
						<p class="text-fs-15"><i class="bi bi-bookmark"></i> 태그   <div class="text-fs-15">#${data.officeInfoVo.office_tags }</div></p>
					</div>
					
					<div class="row mt-5">
						<div class="col">
							<p class="fs-6 font-medium2">예약옵션</p>
						</div>
						<br>
						<p class="mb-2 text-fs-15"><i class="bi bi-people"></i> 사용 가능 인원 : ${data.officeInfoVo.office_personnel } 명</p>
						<p class="text-fs-15"><i class="bi bi-calendar-check"></i> 최소 예약 일수 : ${data.officeInfoVo.office_min_booking_day } 일</p>
					</div>
				    
				 	<div class="row mt-5">
						<div class="col">
							<p class="fs-6 font-medium2">운영정보</p>
							<table class="table table-borderless">
								<thead class="fw-lighter text-muted">
									<tr class="text-center font-light" >
										<th scope="col" style="font-weight:500">운영일</th>
										<th scope="col" style="font-weight:500">운영 시간</th>
										<th scope="col" style="font-weight:500">이용 가격</th>
									</tr>
								</thead>

								<c:forEach items="${data.businessDayVoList }" var="day">
									<tbody>
										<tr class="table-light text-center">
											<td>${day.business_day}</td>
											<td>${day.business_time_start}-${day.business_time_finish}</td>
											<td> <fmt:formatNumber value="${day.business_day_price}" pattern="#,###"/> </td>
											
										</tr>
									</tbody>
								</c:forEach>
							</table>
						</div>
					</div>
				    
				    <div class="row mt-5">
				    <div class="col">
				     <p class="fs-6 font-medium2">편의시설</p>
				    </div>
				     <c:forEach items="${data.facilityCategoryVoList }" var="facility">
				     	<div class="row text-fs-14">
				     		<c:if test="${facility.facility_no eq '1' }">
				     			<div class="col-1 me-2"><img src="../resources/img/wifi (1).png" width=25em, height=25em></div>
				     			<div class="col"> <p>${facility.facility_name }</p></div>
				     		</c:if>
				     	</div>
				     	
				     	<div class="row text-fs-14">
				     		<c:if test="${facility.facility_no eq '2' }">
				     			<div class="col-1 me-2"><img src="../resources/img/desktop.png" width=25em, height=25em></div>
				     			<div class="col"> <p>${facility.facility_name }</p></div>
				     		</c:if>
				     	</div>

				     	<div class="row text-fs-14">
				     		<c:if test="${facility.facility_no eq '3' }">
				     			<div class="col-1 me-2"><img src="../resources/img/fax.png" width=25em, height=25em></div>
				     			<div class="col"> <p>${facility.facility_name }</p></div>
				     		</c:if>
				     	</div>
				     	
				     	<div class="row text-fs-14">
				     		<c:if test="${facility.facility_no eq '4' }">
				     			<div class="col-1 me-2"><img src="../resources/img/printer.png" width=25em, height=25em></div>
				     			<div class="col"> <p>${facility.facility_name }</p></div>
				     		</c:if>
				     	</div>
				     	
				     	<div class="row text-fs-14">
				     		<c:if test="${facility.facility_no eq '5' }">
				     			<div class="col-1 me-2"><img src="../resources/img/whiteBoard.png" width=25em, height=25em></div>
				     			<div class="col"> <p>${facility.facility_name }</p></div>
				     		</c:if>
				     	</div>
				     	
				     	<div class="row text-fs-14">
				     		<c:if test="${facility.facility_no eq '6' }">
				     			<div class="col-1 me-2"><img src="../resources/img/projector (1).png" width=25em, height=25em></div>
				     			<div class="col"> <p>${facility.facility_name }</p></div>
				     		</c:if>
				     	</div>
				     	
				     	<div class="row text-fs-14">
				     		<c:if test="${facility.facility_no eq '7' }">
				     			<div class="col-1 me-2"><img src="../resources/img/air-purifier.png" width=25em, height=25em></div>
				     			<div class="col"> <p>${facility.facility_name }</p></div>
				     		</c:if>
				     	</div>
				     	
				     	<div class="row text-fs-14">
				     		<c:if test="${facility.facility_no eq '8' }">
				     			<div class="col-1 me-2"><img src="../resources/img/lockers.png" width=25em, height=25em></div>
				     			<div class="col"> <p>${facility.facility_name }</p></div>
				     		</c:if>
				     	</div>
				     	
				     	<div class="row text-fs-14">
				     		<c:if test="${facility.facility_no eq '9' }">
				     			<div class="col-1 me-2"><img src="../resources/img/kitchen.png" width=25em, height=25em></div>
				     			<div class="col"> <p>${facility.facility_name }</p></div>
				     		</c:if>
				     	</div>
				     	
				     	<div class="row text-fs-14">
				     		<c:if test="${facility.facility_no eq '10' }">
				     			<div class="col-1 me-2"><img src="../resources/img/parking.png" width=25em, height=25em></div>
				     			<div class="col"> <p>${facility.facility_name }</p></div>
				     		</c:if>
				     	</div>				     					     					     					     	
				     	
				     </c:forEach>
				    </div>
				    
				    
				    <div class="row mt-5 mb-3">
				    <div class="col">
				    <p class="fs-6 font-medium2">승인상태</p>
				    </div>
				    <c:if test="${data.officeInfoVo.office_approve eq 'P' }">
				    	<p class="text-muted text-fs-15"><i class="bi bi-hourglass-split text-gold text-fs-19"></i> 승인대기중</p>
				    </c:if>
				    
				    <c:if test="${data.officeInfoVo.office_approve eq 'Y' }">
				    	<p class="text-muted text-fs-15"><i class="bi bi-check text-green-soft text-fs-19"></i> 승인완료</p>
				    </c:if>
				    
				    <c:if test="${data.officeInfoVo.office_approve eq 'N' }">
				    	<p class="text-fs-15"><i class="bi bi-x-circle-fill"></i> 승인거절</p>
				    	<p class="card-subtitle mb-4 text-muted text-fs-15">${data.officeInfoVo.office_approve_comment }</p>
				    </c:if>				    				    
				    </div>	
				    
				    
					<div class="d-grid gap-2" style="padding-bottom : 2rem;">
					  <button type="button" class="btn" style="background-color:#A68A64; color: #ffffff;" onclick="location.href='./updateOfficePage?office_no=${data.officeInfoVo.office_no }'">수정</button>
					  <button type="button" class="btn btn-outline-gold" onclick="location.href='./deleteOfficeProcess?office_no=${data.officeInfoVo.office_no }'">삭제</button>
					</div>
				    
				</div>
			</div>
		</div>
	</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>