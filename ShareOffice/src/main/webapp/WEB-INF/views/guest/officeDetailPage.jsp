<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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

<!-- star-rating -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
<link rel="stylesheet" href="../resources/css/fontawesome-stars.css">
<script type="text/javascript" src="../resources/js/jquery.barrating.min.js"></script>

<style type="text/css">
 a {text-decoration: none; color:#A68A64;}
 a:link {
  color : #A68A64;
}
a:hover {
  color : #A68A64;
}
 a:active {
  color : #A68A64;
}
i {text-decoration: none; color:#A68A64;
   text-bold;

}



</style>
<script>

var priceArray =[];
var min = Math.min.apply(null,priceArray);

$(function() {
    $('.reviewRating').barrating({
      theme: 'fontawesome-stars',
      readonly: true,
    });
    $('.reviewRating').barrating('set', 5);
 });



</script>
</head>
<body>
<div class="container-fluid px-0" style="overflow-x : hidden">
<jsp:include page="../commons/navbar.jsp"></jsp:include>

	<div class="row" style="padding-top:1rem;">
		<div class="col">
		  <div class="row">
		     <div class="col"><a href="javascript:history.back();"class="btn" style="color: #A68A64;padding-top:0;"><i class="bi bi-arrow-left bold"></i></a></div>
		     <div class="col-7 " style="text-align: center"><p class="fs-16 bold">오피스 상세 보기</p></div>
		     <div class="col"></div>
		      
		  </div>
		
			<!-- 이미지 -->
			<div class="row">
				<div id="carouselExampleDark" class="carousel carousel-dark slide" data-bs-ride="carousel">
					<div class="carousel-inner">
						<c:forEach items="${office.officeImageList }" var="imageVo"
							varStatus="image">
							<c:choose>
								<c:when test="${image.index == 0 }">
									<div class="carousel-item active" data-bs-interval="10000">									  
									   <div class="row">
									      <img src="/soUpload/officeImage/${imageVo.image_url }" width=100%, height=300em class="d-block w-100" alt="">
									 	</div> 	
									 	<div class="row">
									 	  <div class="col text-center"> <span class="badge rounded-pill text-center" style="background-color:#A68A64;">${image.count} / ${imageCount}</span> 
									 	  </div>
									 	</div>							    
									</div>
								</c:when>
								<c:otherwise>
									<div class="carousel-item">
									     <div class="row">
									          <img src="/soUpload/officeImage/${imageVo.image_url }" width=100%, height=300em class="d-block w-100" alt="">
									 	</div> 	
									 	<div class="row">
									 	       <div class="col text-center"> <span class="badge rounded-pill text-center" style="background-color:#A68A64;">${image.count} / ${imageCount}</span> 
									 	  </div>
									 	</div>				
									</div>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</div>
			
					
					<button class="carousel-control-prev" type="button"
						data-bs-target="#carouselExampleDark" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Previous</span>
					</button>
					<button class="carousel-control-next" type="button"
						data-bs-target="#carouselExampleDark" data-bs-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Next</span>
					</button>
					
				</div>
			</div>
			
			<!-- 설명 -->
			<div class="row mt-3 text-fs-16" style="margin: 0.5em">
				<div class="col ">
					<!-- 오피스 간단 소개 -->
					<div class="row mt-3 font-medium2" >
						 <div class="col card-title" style="margin-bottom:0.7rem;"><p class="text-fs-23 "style="margin-bottom:0;">${office.officeVo.office_name }</p></div>
						 <div class="col-3 text-fs-16 font-medium" style="margin:0.7rem;margin-bottom:0.7rem;text-align:right;">
						      <p style="margin-bottom:0.3rem" onClick="javascript:window.scrollTo(0,document.body.scrollHeight)"><i class="bi bi-star-fill" style="color:#EDB867"></i> ${officeAvgRating }</p>
						  </div>
					</div>
					<div class="row" >
						<p style="margin-bottom:0.2rem;">${office.officeVo.office_simpleContent }</p>
					</div>
					<div class="row">
						<p class="fs-7 text-muted text-fs-13" style="margin-bottom:0.4rem;">#${office.officeVo.office_tags }</p>
					</div>
					<div class="row">
					    <div class="col-6">공간 이용료</div>
                        <div class="col fs-3, fw-bold"style="text-align: right;">                      
                           <p class="card-text text-fs-16" > <fmt:formatNumber value="${minOfficePrice}" pattern="#,###"/> ~ <span class="font-light text-fs-13 ">원/일</span></p> 
                       </div>	
                       <!--  
                       <div class="col-2" style="text-align: right;">  
                           <small class="text-muted text-fs-13">원/일</small>
                       </div>	
                       -->	
					</div>
					<div class="row mt-3 ">
						<div class="col d-grid">
							<a href="./orderPage?office_no=${office.officeVo.office_no }" class="btn" style="background-color: #A68A64; color: #ffffff;">예약 하러 가기</a>
						</div>
					</div>
					
					<div class="row mt-4">
					   <ul class="nav nav-tabs"></ul>
					</div>
					
			
                    <!-- 오피스 상세 소개 -->
					<div class="row mt-4">
						<div class="col">
							<p class="fs-6 font-medium2">오피스 소개</p>
						</div>
						<br>
						<p>${office.officeVo.office_detailContent }</p>
					</div>
					<div class="row mt-4">
						<div class="col">
							<p class="fs-6 font-medium2">운영 시간</p>
							<table class="table table-borderless">
								<thead class="fw-lighter text-muted">
									<tr class="text-center font-light" >
										<th scope="col" style="font-weight:500">운영일</th>
										<th scope="col" style="font-weight:500">운영 시간</th>
										<th scope="col" style="font-weight:500">이용 가격(원)</th>
									</tr>
								</thead>

								<c:forEach items="${office.businessDayList }" var="businessDayVo">
									<tbody>
										<tr class="table-light text-center">
											<td>${businessDayVo.business_day}</td>
											<td>${businessDayVo.business_time_start}-${businessDayVo.business_time_finish}</td>
											<td> <fmt:formatNumber value="${businessDayVo.business_day_price}" pattern="#,###"/> </td>
											
										</tr>
									</tbody>
								</c:forEach>
							</table>
						</div>
					</div>
					<div class="row mt-4">
					    <div class="col"> 
						      <p class="fs-6 font-medium2">추가 정보</p>
						</div>
						<p><i class="bi bi-people "></i> 최대 가능 인원: ${office.officeVo.office_personnel } 명</p>
						<p><i class="bi bi-calendar-check"></i> 최소 예약 일수: ${office.officeVo.office_min_booking_day } 일</p>
						<p><i class="bi bi-telephone"></i> 오피스 전화번호: ${office.officeVo.office_changedPhone }</p>			
					</div>
					<div class="row mt-4" >
					    <div class="col">
					      <div class="row">
						     <p class="fs-6 font-medium2">편의시설</p>		
					     </div>
						 
						  			
						   <c:forEach items="${office.facilityCategoryList }" var="facilityVo">							  
							    <div class="row">   
							      <c:if test="${facilityVo.facility_no eq '1'  }">	
							        
							         <div class="col-1 me-2"><img src="../resources/img/wifi (1).png" width=25em, height=25em></div>
							   	     <div class="col"> <p>${facilityVo.facility_name }</p></div>							         			   	
							       </c:if>	
							     </div> 
							     <div class="row">										             
							        <c:if test="${facilityVo.facility_no eq '2'  }">	
							           	
							           <div class="col-1 me-2"> <img src="../resources/img/desktop.png" width=25em, height=25em></div>  		   								   	
							   	       <div class="col"> <p>${facilityVo.facility_name }</p></div>								   	       
							        </c:if>
							      </div>   
							      <div class="row">
							         <c:if test="${facilityVo.facility_no eq '3'  }">
							           		
							           <div class="col-1 me-2"> <img src="../resources/img/fax.png" width=25em, height=25em></div>		   								   	
                                       <div class="col"> <p>${facilityVo.facility_name }</p></div>				   	       
							        </c:if>
							       </div>
							       <div class="row">
							         <c:if test="${facilityVo.facility_no eq '4'  }">	
							           								          
							           <div class="col-1 me-2"> <img src="../resources/img/printer.png" width=25em, height=25em></div>		   								   	
                                       <div class="col"> <p>${facilityVo.facility_name }</p></div>				   	       
							        </c:if>
							       </div>
							       <div class="row">
							         <c:if test="${facilityVo.facility_no eq '5'  }">	       								         
							           <div class="col-1 me-2"> <img src="../resources/img/whiteBoard.png" width=25em, height=25em></div>		   								   	
                                       <div class="col"> <p>${facilityVo.facility_name }</p></div>				   	       
							        </c:if>
							       </div>
							       <div class="row">
							         <c:if test="${facilityVo.facility_no eq '6'  }">	
							           <div class="col-1 me-2"> <img src="../resources/img/projector (1).png" width=25em, height=25em></div>		   								   	
                                       <div class="col"> <p>${facilityVo.facility_name }</p></div>				   	       
							        </c:if>
							       </div>
							       <div class="row">
							         <c:if test="${facilityVo.facility_no eq '7'  }">	
							           <div class="col-1 me-2"> <img src="../resources/img/air-purifier.png" width=25em, height=25em></div>		   								   	
                                       <div class="col"> <p>${facilityVo.facility_name }</p></div>				   	       
							        </c:if>
							       </div>
							       <div class="row">
							         <c:if test="${facilityVo.facility_no eq '8'  }">	
							           <div class="col-1 me-2"> <img src="../resources/img/lockers.png" width=25em, height=25em></div>		   								   	
                                       <div class="col"> <p>${facilityVo.facility_name }</p></div>				   	       
							        </c:if>
							       </div>
							       <div class="row">
							         <c:if test="${facilityVo.facility_no eq '9'  }">	
							           <div class="col-1 me-2"> <img src="../resources/img/kitchen.png" width=25em, height=25em></div>		   								   	
                                       <div class="col"> <p>${facilityVo.facility_name }</p></div>				   	       
							        </c:if>
							       </div>
							       <div class="row">
							         <c:if test="${facilityVo.facility_no eq '10'  }">	
							           <div class="col-1 me-2"> <img src="../resources/img/parking.png" width=25em, height=25em></div>		   								   	
                                       <div class="col"> <p>${facilityVo.facility_name }</p></div>				   	       
							        </c:if>
							       </div>
							 
				
						   </c:forEach>	
						 				     
						</div>
					</div>
					

	
					
					<!-- 지도 출력 -->
					<div class="row mt-4">
					   <div class="col">
							<div class="row"><p class="font-medium2">오피스 위치</p></div>
							<div class="row"><p><i class="bi bi-geo-alt"></i>${office.officeVo.office_address }, ${office.officeVo.office_address_detail }</p></div>
					   </div>					   					 
					</div>
					<div id="map" style="width:100%;height:21em;"></div>
					
					<div class="row mt-4">
					   <ul class="nav nav-tabs"></ul>
					</div>
					<!-- 리뷰보러가기 -->			
					<div class="row mt-4 mb-4 ">
						<div class="col" >
						   <div class="row font-medium2">
						     <div class="col"> <a href="./officeReviewPage?office_no=${office.officeVo.office_no}">이용 후기<span class="text-fs-13">						       
						     (${reviewCount})</span></a><i class="bi bi-chevron-right"></i> </div>			     				  
						   </div>
							<div class="row mt-3">
								<div class="col">
								
									<c:choose>
										<c:when test="${office.reviewListThree.size() <= 0 }">
							                 <div class="row mt-2">
							                     <div class="col text-center"><p class="fs-7 text-muted">등록된 이용 후기가 없습니다.</p></div>
							                 </div>
										</c:when>
										<c:otherwise>
									<c:forEach items="${office.reviewListThree}" var="review" >
									
										<div class="card shadow-sm bg-body rounded" style="">
											<div class="row">
												<div class="col">
													<div class="card-body">
														<div class="row">
															<div class="col-8">
																<select class="reviewRating">
                                                                 <c:forEach begin="1" end="${review.review_rating }">
                                                                        <option value="5">5</option>
                                                                 </c:forEach>
                                                                 </select>
															</div>
															<div class="col">
																<p class="card-text">
																	<small class="text-muted text-fs-13"><fmt:formatDate value="${review.review_date}" pattern="yyyy/MM/dd"/></small>
																</p>
															</div>

														</div>
														<div class="row">
															<div class="col-4">
																<img src="/soUpload/reviewImage/${review.review_image }"
																	class="rounded-start" style="width:100%; height:100%;">
															</div>
															<div class="col-7 text-left">
																<c:choose>
																	<c:when
																		test="${fn:length(review.review_title) > 10}">
																		<c:out
																			value="${fn:substring(review.review_title,0,9)}" />....
                                                                      </c:when>
																	<c:otherwise>
																		<c:out value="${review.review_title}" />
																	</c:otherwise>
																</c:choose>
																<br>
																<c:choose>
																	<c:when
																		test="${fn:length(review.review_content) > 10}">
																		<c:out
																			value="${fn:substring(review.review_content,0,9)}" />....
                                                                    </c:when>
																	<c:otherwise>
																		<c:out value="${review.review_content}" />
																	</c:otherwise>
																</c:choose>

															</div>
															<div class="col-1" style="padding-left:0;">
																<a href="./officeReviewDetailPage?review_no=${review.review_no }"><i class="bi bi-chevron-right"></i></a>
															</div>
														</div>
													</div>
												</div>

											</div>
										</div>
										
									</c:forEach>										
										</c:otherwise>
									</c:choose>
								
								

								</div>
							</div>

						</div>
					</div>
                   


                    <!-- Top 위로 스크롤 -->
					<div class="cursor-pointer" onClick="javascript:window.scrollTo(0,0)" style="position: fixed; bottom: 5rem; right: 0.5rem; z-index:99999;">
						 <i class="bi bi-chevron-double-up pl-2"></i>
						 <span class="block font-medium2" style="color : #A68A64">TOP</span>
					</div>


				</div>
			</div>

		</div>
	</div>
	
<%--<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0a89f71e1f43b65b9072477b5fb3f976&libraries=services"></script> --%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dcba11bad3364b22a9a962b80ee0acfb&libraries=services"></script>
<script>
var mapContainer = document.getElementById("map"), // 지도를 표시할 div 
mapOption = {
    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
    level: 3 // 지도의 확대 레벨
};  

//지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addressSearch('${office.officeVo.office_address}', function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });
 
        
        //마커가 지도 위에 표시되도록 설정합니다.
       marker.setMap(map);
       
        // 링크 바꿈 
        var iwContent = '<div style="padding:0.6rem;">${office.officeVo.office_name}<br><a class="font-medium2 text-fs-13 text-center" href="https://map.kakao.com/link/map/${office.officeVo.office_name}!,' + result[0].y + "," + result[0].x + '" style="color:#A68A64" target="_blank">큰지도보기  | </a> <a class="font-medium2 text-fs-13 text-center" href="https://map.kakao.com/link/to/${office.officeVo.office_name}!,' + result[0].y + "," + result[0].x + '" style="color:#A68A64" target="_blank">  길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
            iwPosition = new kakao.maps.LatLng(geocoder); //인포윈도우 표시 위치입니다
        
         // 인포윈도우로 장소에 대한 설명을 표시합니다
         var infowindow = new kakao.maps.InfoWindow({
             position : iwPosition, 
             content : iwContent 
            });
        
        
        
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});    


</script>
<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>