<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1, shrink-to-fit=no">
<title>호스트/오피스수정페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="../resources/css/commons.css" rel="stylesheet">

    <!-- Favicons -->
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
<link rel="manifest" href="/docs/5.1/assets/img/favicons/manifest.json">
<link rel="mask-icon" href="/docs/5.1/assets/img/favicons/safari-pinned-tab.svg" color="#7952b3">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon.ico">
<meta name="theme-color" content="#7952b3">


    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 48rem) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>
    
    
    <script>
		function checkDay(e){
			
			var priceBox = e.parentElement.parentElement.parentElement.querySelector('.price');
			var startTimeBox = e.parentElement.parentElement.parentElement.querySelector('.start-time');
			var endTimeBox = e.parentElement.parentElement.parentElement.querySelector('.end-time');

			if(e.checked == true){
				priceBox.setAttribute("name" , "business_day_price");
				startTimeBox.setAttribute("name" , "business_time_start");				
				endTimeBox.setAttribute("name" , "business_time_finish");
				
			}else{
				priceBox.removeAttribute("name");
				startTimeBox.removeAttribute("name");				
				endTimeBox.removeAttribute("name");				
			}
		}
		
		function loadBusinessDayData() {
			var xhr = new XMLHttpRequest();
			
			var office_no = parseInt('${data.officeInfoVo.office_no}');
			
			xhr.onreadystatechange = function(){
				if(xhr.readyState == 4 && xhr.status == 200){
					var data = JSON.parse(xhr.responseText);
				
					createBusinessDayBox(data.businessDayVoList);				
				}
			}
			xhr.open("get", "./getBusinessDayData?office_no=" + office_no, true);
			xhr.send();
		}
		
		function createBusinessDayBox(businessDayVoList) {
			
			var checkedDayMap = new Map();
			for(var businessDayVo of businessDayVoList) {
				var checkedDayInfoList = [];
				checkedDayInfoList.push(businessDayVo.business_time_start);
				checkedDayInfoList.push(businessDayVo.business_time_finish);
				checkedDayInfoList.push(businessDayVo.business_day_price);
				checkedDayMap.set(businessDayVo.business_day, checkedDayInfoList);
			}
			
	   		var week_list = ["월", "화", "수", "목", "금", "토", "일"];
	   	
	   		for(var week of week_list) {
	   			var row = document.createElement("div");
		   		row.setAttribute("class", "row");
		   		var dayCol = document.createElement("div");
		   		dayCol.setAttribute("class", "col-2 px-0");
		   		var formCheck = document.createElement("div");
		   		formCheck.setAttribute("class", "form-check");
		   		formCheck.setAttribute("style", "padding-left:3rem");
		   		var dayInput = document.createElement("input");
		   		dayInput.setAttribute("type", "checkbox");
		   		dayInput.setAttribute("class", "form-check-input");
		   		dayInput.setAttribute("name", "business_day");	   		
		   		dayInput.setAttribute("onchange", "checkDay(this)");
		   		dayInput.setAttribute("value", week);
		   		if(checkedDayMap.has(week)) {
		   			dayInput.checked = true;
		   		}
		   		var label = document.createElement("label");
		   		label.setAttribute("class", "form-check-label");
		   		label.innerText = week;
		   		formCheck.appendChild(dayInput);
		   		formCheck.appendChild(label);
		   		dayCol.appendChild(formCheck);
		   		
		   		var startCol = document.createElement("div");
		   		startCol.setAttribute("class", "col-2 px-0");
		   		var startSelect = document.createElement("select");
		   		startSelect.setAttribute("class", "form-control start-time");
		   			
		   		for(var i=0;i<24;i++) {
		   			var option = document.createElement("option");
		   			option.value = i;
		   			if(i > 9) {
		   				option.innerText = i + ":00";	
		   			} else {
		   				option.innerText = "0" + i + ":00";
		   			}
		   			if(checkedDayMap.has(week) && checkedDayMap.get(week)[0] == i) {
		   				option.selected = true;		
		   				startSelect.setAttribute("name" , "business_time_start");
		   			}
		   			startSelect.appendChild(option);
		   		}
		   		startCol.appendChild(startSelect);
		   		
		   		var waveCol = document.createElement("div");
		   		waveCol.setAttribute("class", "col-1 px-0");
		   		waveCol.setAttribute("style", "width:1.25rem");
		   		waveCol.innerText = "~";
		   		
		   		var endCol = document.createElement("div");
		   		endCol.setAttribute("class", "col px-0");
		   		var endSelect = document.createElement("select");
		   		endSelect.setAttribute("class", "form-control end-time");
		   		
		   		for(var i=0;i<24;i++) {
		   			var option = document.createElement("option");
		   			option.value = i;
		   			if(i > 9) {
		   				option.innerText = i + ":00";	
		   			} else {
		   				option.innerText = "0" + i + ":00";
		   			}
		   			if(checkedDayMap.has(week) && checkedDayMap.get(week)[1] == i) {
		   				option.selected = true;
		   				endSelect.setAttribute("name" , "business_time_finish");
		   			}
		   			endSelect.appendChild(option);
		   		}
		   		endCol.appendChild(endSelect);
		   		
		   		var priceCol = document.createElement("div");
		   		priceCol.setAttribute("class", "col-1 px-0");
		   		priceCol.innerText = "가격";
		   		
		   		var priceInputCol = document.createElement("div");
		   		priceInputCol.setAttribute("class", "col px-0");
		   		var priceInput = document.createElement("input");
		   		priceInput.setAttribute("type", "number");
		   		priceInput.setAttribute("class", "form-control price");
		   		if(checkedDayMap.has(week)) {
		   			priceInput.value = checkedDayMap.get(week)[2];
		   			priceInput.setAttribute("name" , "business_day_price");
		   		}
		   		priceInputCol.appendChild(priceInput);
		   		
		   		
		   		row.appendChild(dayCol);
		   		row.appendChild(startCol);
		   		row.appendChild(waveCol);
		   		row.appendChild(endCol);
		   		row.appendChild(priceCol);
		   		row.appendChild(priceInputCol);
		   		
		   		document.querySelector("#businessDayContainer").appendChild(row);
	   		}	   		
		}
	
		window.addEventListener("DOMContentLoaded" , function(){
			loadBusinessDayData();		
		});		
		
		function findAddr(){
			new daum.Postcode({
		        oncomplete: function(data) {
					
					// 도로명 주소 변수
					var roadAddr = data.roadAddress;
					// 지번 주소 변수
					var jibunAddr = data.jibunAddress;
					
		            if(roadAddr !== ''){
		                document.getElementById("inputAddress").value = roadAddr;
		            } 
		            else if(jibunAddr !== ''){
		                document.getElementById("inputAddress").value = jibunAddr;
		            }
		        }
		    }).open();
		}
		
	</script>

</head>
<body class="bg-light">
<div class="container-fluid px-0" style="overflow-x : hidden">
<jsp:include page="../commons/navbar.jsp"></jsp:include>

<div class="row" style="padding-top: 2rem;">
	<div class="col">
		<%-- 내용작성 --%>
	<form action="../host/updateOfficeProcess" method="post" enctype="multipart/form-data">
    
	<div class="container">
		
	    
	    <div class="row g-5 text-fs-16">

	      <div class="col-md-7 col-lg-8">
	        <h4 class="mb-3 text-fs-23 bold text-center">오피스 수정하기</h4>
	        <hr class="my-4">
	          <div class="row">
	            <div class="col-sm-6">
	            	 <p class="fs-6 font-medium2 mb-2">오피스명</p>
	              <input type="text" class="form-control mb-4" name="office_name" value="${data.officeInfoVo.office_name }">
	              <div class="invalid-feedback">
	                	공간명을 입력하세요.
	              </div>
	            </div>
	
	            <div class="col-sm-6">
	           		<p class="fs-6 font-medium2 mb-2">공간 간단소개</p>
	              <input type="text" class="form-control mb-4" name="office_simpleContent" value="${data.officeInfoVo.office_simpleContent }">
	              <div class="invalid-feedback">
	                	공간간단소개를 입력하세요.
	              </div>
	            </div>
	            
	            <div class="col-sm-6">
	              <p class="fs-6 font-medium2 mb-2">공간 상세소개</p>
	              <textarea rows="10" cols="80" class="form-control mb-4" name="office_detailContent">${data.officeInfoVo.office_detailContent }</textarea>
	              <div class="invalid-feedback">
	                	공간소개를 입력하세요.
	              </div>
	            </div>
	            
	            <div class="col-sm-6">
	              <p class="fs-6 font-medium2 mb-2">공간태그</p>
	              <input type="text" class="form-control mb-4" name="office_tags" value="${data.officeInfoVo.office_tags }">
	              <div class="invalid-feedback">
	                	공간태그를 입력하세요.
	             </div>
				</div>
	            
	            <div class="col-sm-6 mb-4">
	              <p class="fs-6 font-medium2 mb-2">사용가능인원</p>
	              <input type="number" class="form-control" name="office_personnel" id="personnelInput" min="1" max="30" value="${data.officeInfoVo.office_personnel }" required/>
	              <small class="text-muted text-fs-13">최소인원은 1명입니다.</small>
	              <div class="invalid-feedback">
	                	사용가능인원을 선택하세요.
	              </div>
	            </div>
				
	            <div class="col-sm-6 mb-4">
	              <p class="fs-6 font-medium2 mb-2">최소예약일</p>
	              <input type="number" class="form-control" name="office_min_booking_day" id="personnelInput" min="1" max="1000" value="${data.officeInfoVo.office_min_booking_day }" required/>
	              <small class="text-muted text-fs-13">최소예약 가능일은 1일부터 입니다.</small>
	              <div class="invalid-feedback">
	                	최소예약일을 선택하세요.
	              </div>
	            </div>
	            
				<hr class="my-4">
				
				<div class="col-sm-6 mb-4">
	              <p class="fs-6 font-medium2 mb-2">대여공간 주소</p>
	              <div class="row">
	              <div class="col-8">
	             		<input id="inputAddress" type="text" class="form-control" name="office_address" readonly>
	              </div>
	              <div class="col" style="margin-left:0.3rem;">
	              <button type="button" class="btn btn-outline-gold text-fs-16" onclick="findAddr()">주소찾기</button>
	              </div>
	              </div>
	              <div class="invalid-feedback">
	               		주소를 입력하세요.
	              </div>
	            </div>

				<div class="col-sm-6 mb-4">
	              <p class="fs-6 font-medium2 mb-2">대여공간 상세주소</p>
	              <input type="text" class="form-control" name="office_address_detail" value="${data.officeInfoVo.office_address_detail }">
	              <div class="invalid-feedback">
	                	상세주소를 입력하세요. 
	             </div>
				</div>				
				
				<div class="col-sm-6 mb-4">
	              <p class="fs-6 font-medium2 mb-2">담당자 연락처</p>
	              <input type="text" class="form-control" name="office_managerPhone" value="${data.officeInfoVo.office_managerPhone }">
	              <div class="invalid-feedback">
	                	담당자 전화번호를 입력하세요.
	              </div>
	            </div>
				
				<div class="col-sm-6 mb-4">
	              <p class="fs-6 font-medium2 mb-2">담당자 가상 연락처</p>
	              <input type="text" class="form-control" name="office_changedPhone" value="${data.officeInfoVo.office_changedPhone }">
	              <div class="invalid-feedback">
	              
	              </div>
	            </div>
	            
	            <hr class="my-4">

			<div class="row mb-3">
				 <div class="col-sm-6" style="margin-bottom: 1.5rem;">
				 <p class="fs-6 font-medium2 mb-4">오피스 이미지</p>
				<div class="text-fs-6"><i class="bi bi-image"></i> 공간대표이미지</div>
 				<input type="file" accept="image/*" class="form-control" name="mainFiles" id="inputGroupFile02">
				</div>
				
				<div class="col-sm-6">
				<div class="text-fs-6"><i class="bi bi-images"></i> 공간상세이미지</div>
 				<input type="file" accept="image/*" class="form-control" name="subFiles" id="inputFiles" multiple>
				</div>	            
			</div>	
		
			
			<div class="row mt-4 pr-0">				
			   	<p class="fs-6 font-medium2 mb-4">오피스 운영시간 및 요금</p>
			   <div class="col-sm-6 ms-2 text-fs-15" id="day-root-box">
			   	
			   	<div class="row mb-1">
			   		<div class="col-2 px-0">
			          <div class="form-check" style="padding-top:0.3rem;">
			            <input type="checkbox" class="form-check-input" name="business_day" value="월" onchange="checkDay(this)">
			            <label class="form-check-label" >월</label>
			          </div>
			   		</div>
			   		
			   		<div class="col px-0">
			   			<select class="form-control start-time" onchange="checkStartTime(this)">
			   				<option value="0">00:00</option>
			   				<option value="1">01:00</option>
			   				<option value="2">02:00</option>
			   				<option value="3">03:00</option>
			   				<option value="4">04:00</option>
			   				<option value="5">05:00</option>
			   				<option value="6">06:00</option>
			   				<option value="7">07:00</option>
			   				<option value="8">08:00</option>
			   				<option value="9">09:00</option>
			   				<option value="10">10:00</option>
			   				<option value="11">11:00</ption>
			   				<option value="12">12:00</option>
			   				<option value="13">13:00</option>
			   				<option value="14">14:00</option>
			   				<option value="15">15:00</option>
			   				<option value="16">16:00</option>
			   				<option value="17">17:00</option>
			   				<option value="18">18:00</option>
			   				<option value="19">19:00</option>
			   				<option value="20">20:00</option>
			   				<option value="21">21:00</option>
			   				<option value="22">22:00</option>
			   				<option value="23">23:00</option>
			   				<option value="24">24:00</option>
			   			</select>
			   		</div>
			   		<div class="col-1" style="padding-left:0.5rem; padding-top:0.5rem;">~</div>
			   		<div class="col px-0">
			   			<select class="form-control end-time">
			   				<option value="0">00:00</option>
			   				<option value="1">01:00</option>
			   				<option value="2">02:00</option>
			   				<option value="3">03:00</option>
			   				<option value="4">04:00</option>
			   				<option value="5">05:00</option>
			   				<option value="6">06:00</option>
			   				<option value="7">07:00</option>
			   				<option value="8">08:00</option>
			   				<option value="9">09:00</option>
			   				<option value="10">10:00</option>
			   				<option value="11">11:00</option>
			   				<option value="12">12:00</option>
			   				<option value="13">13:00</option>
			   				<option value="14">14:00</option>
			   				<option value="15">15:00</option>
			   				<option value="16">16:00</option>
			   				<option value="17">17:00</option>
			   				<option value="18">18:00</option>
			   				<option value="19">19:00</option>
			   				<option value="20">20:00</option>
			   				<option value="21">21:00</option>
			   				<option value="22">22:00</option>
			   				<option value="23">23:00</option>
			   				<option value="24" selected>24:00</option>
			   			</select>
			   		</div>
			   		<div class="col-1 text-fs-13" style="padding-right:0.3rem; padding-top:0.4rem;">₩</div>
			   		<div class="col px-0 me-2">
						<input type="number" class="form-control price" style="padding-left:0.2rem; padding-right:0">
			   		</div>
			   	</div> 
			   
			   	<div class="row mb-1">
			   		<div class="col-2 px-0" style="padding-top:0.3rem;">
			          <div class="form-check">
			            <input type="checkbox" class="form-check-input" name="business_day" value="화" onchange="checkDay(this)">
			            <label class="form-check-label">화</label>
			          </div>
								   			
			   		</div>
			   		<div class="col px-0">
			   			<select class="form-control start-time" onchange="checkStartTime(this)">
			   				<option value="0">00:00</option>
			   				<option value="1">01:00</option>
			   				<option value="2">02:00</option>
			   				<option value="3">03:00</option>
			   				<option value="4">04:00</option>
			   				<option value="5">05:00</option>
			   				<option value="6">06:00</option>
			   				<option value="7">07:00</option>
			   				<option value="8">08:00</option>
			   				<option value="9">09:00</option>
			   				<option value="10">10:00</option>
			   				<option value="11">11:00</option>
			   				<option value="12">12:00</option>
			   				<option value="13">13:00</option>
			   				<option value="14">14:00</option>
			   				<option value="15">15:00</option>
			   				<option value="16">16:00</option>
			   				<option value="17">17:00</option>
			   				<option value="18">18:00</option>
			   				<option value="19">19:00</option>
			   				<option value="20">20:00</option>
			   				<option value="21">21:00</option>
			   				<option value="22">22:00</option>
			   				<option value="23">23:00</option>
			   				<option value="24">24:00</option>
			   			</select>
			   		</div>
			   		<div class="col-1" style="padding-left:0.5rem; padding-top:0.5rem;">~</div>
			   		<div class="col px-0">
			   			<select class="form-control end-time">
			   				<option value="0">00:00</option>
			   				<option value="1">01:00</option>
			   				<option value="2">02:00</option>
			   				<option value="3">03:00</option>
			   				<option value="4">04:00</option>
			   				<option value="5">05:00</option>
			   				<option value="6">06:00</option>
			   				<option value="7">07:00</option>
			   				<option value="8">08:00</option>
			   				<option value="9">09:00</option>
			   				<option value="10">10:00</option>
			   				<option value="11">11:00</option>
			   				<option value="12">12:00</option>
			   				<option value="13">13:00</option>
			   				<option value="14">14:00</option>
			   				<option value="15">15:00</option>
			   				<option value="16">16:00</option>
			   				<option value="17">17:00</option>
			   				<option value="18">18:00</option>
			   				<option value="19">19:00</option>
			   				<option value="20">20:00</option>
			   				<option value="21">21:00</option>
			   				<option value="22">22:00</option>
			   				<option value="23">23:00</option>
			   				<option value="24" selected>24:00</option>
			   			</select>
			   		</div>
			   		<div class="col-1 text-fs-13"  style="padding-right:0.3rem; padding-top:0.4rem;">₩</div>
			   		<div class="col px-0 me-2">
						<input type="number" class="form-control price" style="padding-left:0.2rem; padding-right:0">
			   		</div>
			   	</div>			   
			   	

			   	<div class="row mb-1">
			   		<div class="col-2 px-0">
			          <div class="form-check" style="padding-top:0.3rem;">
			            <input type="checkbox" class="form-check-input" name="business_day" value="수" onchange="checkDay(this)">
			            <label class="form-check-label">수</label>
			          </div>
								   			
			   		</div>
			   		<div class="col px-0">
			   			<select class="form-control start-time" onchange="checkStartTime(this)">
			   				<option value="0">00:00</option>
			   				<option value="1">01:00</option>
			   				<option value="2">02:00</option>
			   				<option value="3">03:00</option>
			   				<option value="4">04:00</option>
			   				<option value="5">05:00</option>
			   				<option value="6">06:00</option>
			   				<option value="7">07:00</option>
			   				<option value="8">08:00</option>
			   				<option value="9">09:00</option>
			   				<option value="10">10:00</option>
			   				<option value="11">11:00</option>
			   				<option value="12">12:00</option>
			   				<option value="13">13:00</option>
			   				<option value="14">14:00</option>
			   				<option value="15">15:00</option>
			   				<option value="16">16:00</option>
			   				<option value="17">17:00</option>
			   				<option value="18">18:00</option>
			   				<option value="19">19:00</option>
			   				<option value="20">20:00</option>
			   				<option value="21">21:00</option>
			   				<option value="22">22:00</option>
			   				<option value="23">23:00</option>
			   				<option value="24">24:00</option>
			   			</select>
			   		</div>
			   		<div class="col-1" style="padding-left:0.5rem; padding-top:0.5rem;">~</div>
			   		<div class="col px-0">
			   			<select class="form-control end-time">
			   				<option value="0">00:00</option>
			   				<option value="1">01:00</option>
			   				<option value="2">02:00</option>
			   				<option value="3">03:00</option>
			   				<option value="4">04:00</option>
			   				<option value="5">05:00</option>
			   				<option value="6">06:00</option>
			   				<option value="7">07:00</option>
			   				<option value="8">08:00</option>
			   				<option value="9">09:00</option>
			   				<option value="10">10:00</option>
			   				<option value="11">11:00</option>
			   				<option value="12">12:00</option>
			   				<option value="13">13:00</option>
			   				<option value="14">14:00</option>
			   				<option value="15">15:00</option>
			   				<option value="16">16:00</option>
			   				<option value="17">17:00</option>
			   				<option value="18">18:00</option>
			   				<option value="19">19:00</option>
			   				<option value="20">20:00</option>
			   				<option value="21">21:00</option>
			   				<option value="22">22:00</option>
			   				<option value="23">23:00</option>
			   				<option value="24" selected>24:00</option>
			   			</select>
			   		</div>
			   		<div class="col-1 text-fs-13" style="padding-right:0.3rem; padding-top:0.4rem;">₩</div>
			   		<div class="col px-0 me-2">
						<input type="number" class="form-control price" style="padding-left:0.2rem; padding-right:0">
			   		</div>
			   	</div>

			   	<div class="row mb-1">
			   		<div class="col-2 px-0">
			          <div class="form-check"  style="padding-top:0.3rem;">
			            <input type="checkbox" class="form-check-input" name="business_day" value="목" onchange="checkDay(this)">
			            <label class="form-check-label">목</label>
			          </div>
								   			
			   		</div>
			   		<div class="col px-0">
			   			<select class="form-control start-time" onchange="checkStartTime(this)">
			   				<option value="0">00:00</option>
			   				<option value="1">01:00</option>
			   				<option value="2">02:00</option>
			   				<option value="3">03:00</option>
			   				<option value="4">04:00</option>
			   				<option value="5">05:00</option>
			   				<option value="6">06:00</option>
			   				<option value="7">07:00</option>
			   				<option value="8">08:00</option>
			   				<option value="9">09:00</option>
			   				<option value="10">10:00</option>
			   				<option value="11">11:00</option>
			   				<option value="12">12:00</option>
			   				<option value="13">13:00</option>
			   				<option value="14">14:00</option>
			   				<option value="15">15:00</option>
			   				<option value="16">16:00</option>
			   				<option value="17">17:00</option>
			   				<option value="18">18:00</option>
			   				<option value="19">19:00</option>
			   				<option value="20">20:00</option>
			   				<option value="21">21:00</option>
			   				<option value="22">22:00</option>
			   				<option value="23">23:00</option>
			   				<option value="24">24:00</option>
			   			</select>
			   		</div>
			   		<div class="col-1" style="padding-left:0.5rem; padding-top:0.5rem;">~</div>
			   		<div class="col px-0">
			   			<select class="form-control end-time">
			   				<option value="0">00:00</option>
			   				<option value="1">01:00</option>
			   				<option value="2">02:00</option>
			   				<option value="3">03:00</option>
			   				<option value="4">04:00</option>
			   				<option value="5">05:00</option>
			   				<option value="6">06:00</option>
			   				<option value="7">07:00</option>
			   				<option value="8">08:00</option>
			   				<option value="9">09:00</option>
			   				<option value="10">10:00</option>
			   				<option value="11">11:00</option>
			   				<option value="12">12:00</option>
			   				<option value="13">13:00</option>
			   				<option value="14">14:00</option>
			   				<option value="15">15:00</option>
			   				<option value="16">16:00</option>
			   				<option value="17">17:00</option>
			   				<option value="18">18:00</option>
			   				<option value="19">19:00</option>
			   				<option value="20">20:00</option>
			   				<option value="21">21:00</option>
			   				<option value="22">22:00</option>
			   				<option value="23">23:00</option>
			   				<option value="24" selected>24:00</option>
			   			</select>
			   		</div>
			   		<div class="col-1 text-fs-13" style="padding-right:0.3rem; padding-top:0.4rem;">₩</div>
			   		<div class="col px-0 me-2">
						<input type="number" class="form-control price" style="padding-left:0.2rem; padding-right:0">
			   		</div>
			   	</div>
			   	
			   	<div class="row mb-1">
			   		<div class="col-2 px-0">
			          <div class="form-check" style="padding-top:0.3rem;" >
			            <input type="checkbox" class="form-check-input" name="business_day" value="금" onchange="checkDay(this)">
			            <label class="form-check-label">금</label>
			          </div>
								   			
			   		</div>
			   		<div class="col px-0">
			   			<select class="form-control start-time" onchange="checkStartTime(this)">
			   				<option value="0">00:00</option>
			   				<option value="1">01:00</option>
			   				<option value="2">02:00</option>
			   				<option value="3">03:00</option>
			   				<option value="4">04:00</option>
			   				<option value="5">05:00</option>
			   				<option value="6">06:00</option>
			   				<option value="7">07:00</option>
			   				<option value="8">08:00</option>
			   				<option value="9">09:00</option>
			   				<option value="10">10:00</option>
			   				<option value="11">11:00</option>
			   				<option value="12">12:00</option>
			   				<option value="13">13:00</option>
			   				<option value="14">14:00</option>
			   				<option value="15">15:00</option>
			   				<option value="16">16:00</option>
			   				<option value="17">17:00</option>
			   				<option value="18">18:00</option>
			   				<option value="19">19:00</option>
			   				<option value="20">20:00</option>
			   				<option value="21">21:00</option>
			   				<option value="22">22:00</option>
			   				<option value="23">23:00</option>
			   				<option value="24">24:00</option>
			   			</select>
			   		</div>
			   		<div class="col-1" style="padding-left:0.5rem; padding-top:0.5rem;">~</div>
			   		<div class="col px-0">
			   			<select class="form-control end-time">
			   				<option value="0">00:00</option>
			   				<option value="1">01:00</option>
			   				<option value="2">02:00</option>
			   				<option value="3">03:00</option>
			   				<option value="4">04:00</option>
			   				<option value="5">05:00</option>
			   				<option value="6">06:00</option>
			   				<option value="7">07:00</option>
			   				<option value="8">08:00</option>
			   				<option value="9">09:00</option>
			   				<option value="10">10:00</option>
			   				<option value="11">11:00</option>
			   				<option value="12">12:00</option>
			   				<option value="13">13:00</option>
			   				<option value="14">14:00</option>
			   				<option value="15">15:00</option>
			   				<option value="16">16:00</option>
			   				<option value="17">17:00</option>
			   				<option value="18">18:00</option>
			   				<option value="19">19:00</option>
			   				<option value="20">20:00</option>
			   				<option value="21">21:00</option>
			   				<option value="22">22:00</option>
			   				<option value="23">23:00</option>
			   				<option value="24" selected>24:00</option>
			   			</select>
			   		</div>
			   		<div class="col-1 text-fs-13" style="padding-right:0.3rem; padding-top:0.4rem;">₩</div>
			   		<div class="col px-0 me-2">
						<input type="number" class="form-control price" style="padding-left:0.2rem; padding-right:0">
			   		</div>
			   	</div>	
			   	
			   	<div class="row mb-1">
			   		<div class="col-2 px-0">
			          <div class="form-check" style="padding-top:0.3rem;">
			            <input type="checkbox" class="form-check-input" name="business_day" value="토" onchange="checkDay(this)">
			            <label class="form-check-label">토</label>
			          </div>
								   			
			   		</div>
			   		<div class="col px-0">
			   			<select class="form-control start-time" onchange="checkStartTime(this)">
			   				<option value="0">00:00</option>
			   				<option value="1">01:00</option>
			   				<option value="2">02:00</option>
			   				<option value="3">03:00</option>
			   				<option value="4">04:00</option>
			   				<option value="5">05:00</option>
			   				<option value="6">06:00</option>
			   				<option value="7">07:00</option>
			   				<option value="8">08:00</option>
			   				<option value="9">09:00</option>
			   				<option value="10">10:00</option>
			   				<option value="11">11:00</option>
			   				<option value="12">12:00</option>
			   				<option value="13">13:00</option>
			   				<option value="14">14:00</option>
			   				<option value="15">15:00</option>
			   				<option value="16">16:00</option>
			   				<option value="17">17:00</option>
			   				<option value="18">18:00</option>
			   				<option value="19">19:00</option>
			   				<option value="20">20:00</option>
			   				<option value="21">21:00</option>
			   				<option value="22">22:00</option>
			   				<option value="23">23:00</option>
			   				<option value="24">24:00</option>
			   			</select>
			   		</div>
			   		<div class="col-1" style="padding-left:0.5rem; padding-top:0.5rem;">~</div>
			   		<div class="col px-0">
			   			<select class="form-control end-time">
			   				<option value="0">00:00</option>
			   				<option value="1">01:00</option>
			   				<option value="2">02:00</option>
			   				<option value="3">03:00</option>
			   				<option value="4">04:00</option>
			   				<option value="5">05:00</option>
			   				<option value="6">06:00</option>
			   				<option value="7">07:00</option>
			   				<option value="8">08:00</option>
			   				<option value="9">09:00</option>
			   				<option value="10">10:00</option>
			   				<option value="11">11:00</option>
			   				<option value="12">12:00</option>
			   				<option value="13">13:00</option>
			   				<option value="14">14:00</option>
			   				<option value="15">15:00</option>
			   				<option value="16">16:00</option>
			   				<option value="17">17:00</option>
			   				<option value="18">18:00</option>
			   				<option value="19">19:00</option>
			   				<option value="20">20:00</option>
			   				<option value="21">21:00</option>
			   				<option value="22">22:00</option>
			   				<option value="23">23:00</option>
			   				<option value="24" selected>24:00</option>
			   			</select>
			   		</div>
			   		<div class="col-1 text-fs-13" style="padding-right:0.3rem; padding-top:0.4rem;">₩</div>
			   		<div class="col px-0 me-2">
						<input type="number" class="form-control price" style="padding-left:0.2rem; padding-right:0">
			   		</div>
			   	</div>	
			   	
			   	<div class="row">
			   		<div class="col-2 px-0">
			          <div class="form-check" style="padding-top:0.3rem;">
			            <input type="checkbox" class="form-check-input" name="business_day" value="일" onchange="checkDay(this)">
			            <label class="form-check-label">일</label>
			          </div>
								   			
			   		</div>
			   		<div class="col px-0">
			   			<select class="form-control start-time" onchange="checkStartTime(this)">
			   				<option value="0">00:00</option>
			   				<option value="1">01:00</option>
			   				<option value="2">02:00</option>
			   				<option value="3">03:00</option>
			   				<option value="4">04:00</option>
			   				<option value="5">05:00</option>
			   				<option value="6">06:00</option>
			   				<option value="7">07:00</option>
			   				<option value="8">08:00</option>
			   				<option value="9">09:00</option>
			   				<option value="10">10:00</option>
			   				<option value="11">11:00</option>
			   				<option value="12">12:00</option>
			   				<option value="13">13:00</option>
			   				<option value="14">14:00</option>
			   				<option value="15">15:00</option>
			   				<option value="16">16:00</option>
			   				<option value="17">17:00</option>
			   				<option value="18">18:00</option>
			   				<option value="19">19:00</option>
			   				<option value="20">20:00</option>
			   				<option value="21">21:00</option>
			   				<option value="22">22:00</option>
			   				<option value="23">23:00</option>
			   				<option value="24">24:00</option>
			   			</select>
			   		</div>
			   		<div class="col-1" style="padding-left:0.5rem; padding-top:0.5rem;">~</div>
			   		<div class="col px-0">
			   			<select class="form-control end-time">
			   				<option value="0">00:00</option>
			   				<option value="1">01:00</option>
			   				<option value="2">02:00</option>
			   				<option value="3">03:00</option>
			   				<option value="4">04:00</option>
			   				<option value="5">05:00</option>
			   				<option value="6">06:00</option>
			   				<option value="7">07:00</option>
			   				<option value="8">08:00</option>
			   				<option value="9">09:00</option>
			   				<option value="10">10:00</option>
			   				<option value="11">11:00</option>
			   				<option value="12">12:00</option>
			   				<option value="13">13:00</option>
			   				<option value="14">14:00</option>
			   				<option value="15">15:00</option>
			   				<option value="16">16:00</option>
			   				<option value="17">17:00</option>
			   				<option value="18">18:00</option>
			   				<option value="19">19:00</option>
			   				<option value="20">20:00</option>
			   				<option value="21">21:00</option>
			   				<option value="22">22:00</option>
			   				<option value="23">23:00</option>
			   				<option value="24" selected>24:00</option>
			   			</select>
			   		</div>
			   		<div class="col-1 text-fs-13" style="padding-right:0.3rem; padding-top:0.4rem;">₩</div>
			   		<div class="col px-0 me-2">
						<input type="number" class="form-control price" style="padding-left:0.2rem; padding-right:0">
			   		</div>
			   	</div>				   	
			   				   			   				   	
			   	
			 </div>
		</div>

	         <hr class="my-4">

			<div class="col-sm-6 mb-4">
			 <p class="fs-6 font-medium2 mb-2">편의시설</p>
	           <c:forEach items="${facilityCategoryList }" var="abc">	
	           <div class="row">
	           	<div class="col-1">						  
	          		<input type="checkbox" class="form-check-input" name="facility_no" value="${abc.facility_no }"></div>
						<c:if test="${abc.facility_no eq '1'  }">	
							<div class="col-1 me-2"><img src="../resources/img/wifi (1).png" width=20rem, height=20rem></div>
						    <div class="col"> <p>${abc.facility_name }</p></div>							         			   	
						</c:if>	
						<c:if test="${abc.facility_no eq '2'  }">	
							<div class="col-1 me-2"> <img src="../resources/img/desktop.png" width=20rem, height=20rem></div>  		   								   	
							<div class="col"> <p>${abc.facility_name }</p></div>								   	       
						</c:if>
						<c:if test="${abc.facility_no eq '3'  }">
							<div class="col-1 me-2"> <img src="../resources/img/fax.png" width=20rem, height=20rem></div>		   								   	
							<div class="col"> <p>${abc.facility_name }</p></div>				   	       
						</c:if>
						<c:if test="${abc.facility_no eq '4'  }">	
							<div class="col-1 me-2"> <img src="../resources/img/printer.png" width=20rem, height=20rem></div>		   								   	
							<div class="col"> <p>${abc.facility_name }</p></div>				   	       
						</c:if>
						<c:if test="${abc.facility_no eq '5'  }">	       								         
							<div class="col-1 me-2"> <img src="../resources/img/whiteBoard.png" width=20rem, height=20rem></div>		   								   	
							<div class="col"> <p>${abc.facility_name }</p></div>				   	       
						</c:if>
						<c:if test="${abc.facility_no eq '6'  }">	
							<div class="col-1 me-2"> <img src="../resources/img/projector (1).png" width=20rem, height=20rem></div>		   								   	
							<div class="col"> <p>${abc.facility_name }</p></div>				   	       
						</c:if>
						<c:if test="${abc.facility_no eq '7'  }">	
							<div class="col-1 me-2"> <img src="../resources/img/air-purifier.png" width=20rem, height=20rem></div>		   								   	
							<div class="col"> <p>${abc.facility_name }</p></div>				   	       
						</c:if>
						<c:if test="${abc.facility_no eq '8'  }">	
							<div class="col-1 me-2"> <img src="../resources/img/lockers.png" width=20rem, height=20rem></div>		   								   	
							<div class="col"> <p>${abc.facility_name }</p></div>				   	       
						</c:if>
						<c:if test="${abc.facility_no eq '9'  }">	
							<div class="col-1 me-2"> <img src="../resources/img/kitchen.png" width=20rem, height=20rem></div>		   								   	
							<div class="col"> <p>${abc.facility_name }</p></div>				   	       
						</c:if>
						<c:if test="${abc.facility_no eq '10'  }">	
							<div class="col-1 me-2"> <img src="../resources/img/parking.png" width=20rem, height=20rem></div>		   								   	
							<div class="col"> <p>${abc.facility_name }</p></div>				   	       
						</c:if>
					
				</div>
				</c:forEach>		 			 
	       
		</div>
		</div>
		
			</div>
		</div>
			 
	  		<div class="d-grid gap-2" style="padding-bottom : 2rem; margin-left:1.5rem; margin-right:1.5rem;">
				<input type="hidden" name="office_no" value="${data.officeInfoVo.office_no}">
	           <button class="btn" style="background-color:#A68A64; color: #ffffff; "type="submit">수정하기</button>
	           <button type="button" class="btn btn-outline-dark" onclick="location.href='./deleteOfficeProcess?office_no=${data.officeInfoVo.office_no }'">오피스삭제</button>
	        </div>   
	  </div>
	        </form>
	      </div> 
	    </div>
			
<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>