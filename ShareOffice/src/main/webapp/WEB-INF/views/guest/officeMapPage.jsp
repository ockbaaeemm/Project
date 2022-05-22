<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1, shrink-to-fit=no">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dcba11bad3364b22a9a962b80ee0acfb&libraries=services"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
.shadow-sm {
    box-shadow: 0 .125rem .25rem rgba(166, 138, 100,.075)!important;
}
</style>
<script type="text/javascript">


var geocoder = null;
var map = null;
var officeNo = 0;

function OfficeInfoVo(){}


function initMap(){
	var mapContainer = document.getElementById("map"), // 지도를 표시할 div 
	mapOption = {
	    center: new kakao.maps.LatLng(37.4997900799939, 127.031119235961), // 지도의 중심좌표
	    level: 8 // 지도의 확대 레벨
	};  

	//지도를 생성합니다    
	map = new kakao.maps.Map(mapContainer, mapOption); 
	
	geocoder = new kakao.maps.services.Geocoder();	
	
}








var imageSrc = "../resources/img/location (3).png"; 



function createMarker(){
	//주소-좌표 변환 객체를 생성합니다
	   
	//var address_list = ["서울 강남구 강남대로 406 지하1층 감성타코", "서울 강남구 테헤란로 109 강남제일빌딩", "서울 서초구 서초대로77길 7 서초빌딩 1층"];

	$.ajax({
		url : './getLocationList',
		type : 'GET',
		//dataType : 'json',
		data : 'searchKeyword=',
		success : function(locationData){
			if(locationData.result == 'success') {
				for(officeInfo of locationData.locationList) {
					//주소로 좌표를 검색합니다
					
					var address = officeInfo.office_address;
					
					
					geocoder.addressSearch(address, addrSearchCallback(officeInfo));
				}
				
			}		
		}
	});	
}


function addrSearchCallback(officeInfo){
	return function(result, status){
		// 정상적으로 검색이 완료됐으면 
		 if (status === kakao.maps.services.Status.OK) {
			 var imageSize = new kakao.maps.Size(35, 35); 
			 var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		     var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		
		    // 결과값으로 받은 위치를 마커로 표시합니다
		    var marker = new kakao.maps.Marker({
		        map: map,
		        position: coords,
		        image : markerImage
		    });
		    //map.setCenter(coords);
		    
		    kakao.maps.event.addListener(marker, 'click', showDetail(officeInfo));
		    
		} 		
	};
}


//전역변수






function showDetail(officeInfo){
	return function(){
		
		//document.getElementById("selectedOfficeInfoBox").setAttribute("class" , "col");
		
		document.getElementById("selectedOfficeInfoBox").style.visibility = "visible";
		
		
		var boxAddr = document.getElementById("info_addr");
		boxAddr.innerText = officeInfo.office_address;
		var boxName = document.getElementById("info_name");
		boxName.innerText = officeInfo.office_name;
		var boxTag = document.getElementById("info_tag");
		boxTag.innerText = officeInfo.office_tags;
		
        officeNo = officeInfo.office_no; 
		
		//....
		
		var imgBox = document.getElementById("info_img");
		imgBox.src = '/soUpload/officeImage/' + officeInfo.office_thumbnail;
		
		document.URL;
		
		
		
		//alert(officeInfo.office_name);
		/*
		var selectedOfficeInfoBox = document.getElementById("selectedOfficeInfoBox");
		
		selectedOfficeInfoBox.innerHTML = "";
		
		var testNameBox = document.createElement("div");
		testNameBox.innerText = officeInfo.office_name;	
		selectedOfficeInfoBox.appendChild(testNameBox);
		
		
		var testAddrBox = document.createElement("div");
		testAddrBox.innerText = officeInfo.office_address;	
		selectedOfficeInfoBox.appendChild(testAddrBox);
		*/
	};
	
}




function moveFocus(){
	
	var address = document.getElementById("search__address_keyword").value;
	
	geocoder.addressSearch(address , function(result, status){

		// 정상적으로 검색이 완료됐으면 
		 if (status === kakao.maps.services.Status.OK) {
		     var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		     var moveLatLon = new kakao.maps.LatLng(coords.Ma, coords.La);
		    
		    // 지도 중심을 부드럽게 이동시킵니다
		    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
		    map.panTo(moveLatLon);   
		} 		
		
		

		
	} );	
	
    	
}


window.addEventListener("DOMContentLoaded" , function(){
	initMap();
	createMarker();
});

function officeDetailPage()  {
	if (officeNo == 0 ){
		return
	}

	  window.location.href = 'officeDetailPage?office_no='+ officeNo;
	};
	




</script>
<link href="../resources/css/commons.css" rel="stylesheet">
    <meta charset="utf-8">
    <title>주소로 장소 표시하기</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">    
</head>
<body>
<div class="container-fluid px-0" style="overflow-x : hidden">
<jsp:include page="../commons/navbar.jsp"></jsp:include>
		<div class="row " style="padding-top: 2em;background-image:url('../resources/img/back4.jpg'">
			<div class="col" style="margin:0.5rem">
				<div class="row" style="">
				    
					<p class=" text-fs-23 bold " style="text-align: center;"><i class="bi bi-search" style="color:#464444"> </i>오피스 찾기</p>
				</div>
				<div class="row mt-3">
					<div class="col" style="margin: 0; padding-right: 0.5rem">
						<input type="text" id="search__address_keyword"
							class="form-control form-control-sm"
							placeholder="검색할 지역명을 입력해주세요." onkeypress="javasript:if(event.keyCode==13){moveFocus()}">
					</div>
				

				</div>
				<!-- 지도 출력 -->
				<div class="row mt-3">
					<div class="col">
						<p style="margin-top: -0.75em">
							<em class="link"> <a href="javascript:void(0);"
								onclick="window.open('http://fiy.daum.net/fiy/map/CsGeneral.daum', '_blank', 'width=981, height=650')">

							</a>
							</em>
						</p>
						<div id="map" style="width: 100%; height: 21em;"></div>
					</div>
				</div>
				<!-- 마커 클릭 시 오피스 정보 -->
				<div class="row">
					<div class="col" id="selectedOfficeInfoBox" style="padding:0rem;visibility:hidden;margin:0rem ">
				   <!-- <c:forEach></c:forEach> -->
						<div class="card shadow bg-body rounded" style="margin-top:0.3rem; padding-bottom:0rem;   ">
							<div class="row" style="background-color: #f8f9fa;">
								<div class="col-4" style="margin-right:0.5rem;margin:0.5rem;padding-right:0;">
									<img src="" id="info_img" style="padding:-0.5rem;width:100%;height:100%;">
								</div>
								<div class="col" style="">
								    <div class="card-body" style="padding-top:0.5rem;padding-bottom:0.5rem;margin:0;text-align:left;">
										<div class="row">
											<div class="col text-fs-17 font-medium2" id="info_name" onclick="officeDetailPage()"></div>
										</div>
										<div class="row text-fs-13">
											<div class="col">
												<p class="card-text">
													#<small class="text-muted" id="info_tag"></small>
												</p>
											</div>
										</div>
										<div class="row mt text-fs-13" style="">
						 	                 <div class="col ">
							                	<p style="margin:0"><i class="bi bi-geo-alt"></i><span id="info_addr"></span></p>
							                </div>						 
						                 </div>		
						                 <div class="row mt-1 text-fs-13 font-light" style="margin:0;">
											<div class="col-3" style="text-align:left;padding:0;">
						                       <p style="margin-bottom:0.3rem"><i class="bi bi-star-fill" style="color:#EDB867;"></i>4.7</p>
						                    </div>		
				                   
					                       	<div class="col " style="text-align:right;">
								               <p class="text-muted" style="margin:0">
									              <span class="fw-bold text-fs-16"id="info_price">50,000</span><span  class="text-fs-13">원/일</span></p>
						                    </div>						                     
						                 </div>	
						              </div>   
								</div>
							
							</div>
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