<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1, shrink-to-fit=no">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="../resources/css/commons.css">
<link rel="stylesheet" href="../resources/css/style.css">
<link rel="stylesheet" href="../resources/css/calendarStyle.css">

<script>
	
	var officeNo = "${officeInfo.officeInfoVo.office_no }";
	var reservationCompleteDate = new Array();
	var businessDay = new Array();
	var businessDayMap = {};
	var tid = null;
	
	function getOfficeReservedDateAndBusinessDay(){
		var xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200) {
				var data = JSON.parse(xhr.responseText);
				
				//오피스 운영일 및 예약완료된 날짜 배열에 넣기
				for(e of data.officeBusinessDayInfo){
					businessDay.push(e.businessDayVo.business_day);
					//businessDayPrice.push(e.businessDayVo.business_day_price);
					businessDayMap[e.businessDayVo.business_day] = e.businessDayVo.business_day_price;
				}
				
				for(e of data.officeRentalList){
					if(e.rental_status != 'C') {
						reservationCompleteDate.push(new Date(e.rental_date));	
					}					
				}
				
				
				var today = new Date();
			    renderDate(today.getFullYear() , today.getMonth()+1);
			}
		};
		
		
		xhr.open("GET", "./getOfficeReservedDateAndBusinessDay?office_no=" + officeNo, true);
		xhr.send();

	}


	var today = new Date();

	function orderValidCheck(e) {
		
		e.preventDefault();

		//최대인원 체크
		var personnelInput = document.getElementById("personnelInput");
		
		if(personnelInput.value > parseInt("${officeInfo.officeInfoVo.office_personnel}")) {
			alert("최대 예약가능 인원수를 초과하였습니다.");
			console.log("최대인원 : "+"${officeInfo.officeInfoVo.office_personnel}");
	        return;
		}
		
		
		//예약 선택날짜 value 맨앞 , 지우기	
		var chooseDate = document.getElementById("choose-date");
		if(chooseDate.value[0] == ',') {
			chooseDate.value = chooseDate.value.substring(1, chooseDate.length);	
		}
		
		// 최소예약일 체크
		var totalResvDay = chooseDate.value.split(",").length;
		if(totalResvDay < parseInt('${officeInfo.officeInfoVo.office_min_booking_day}')) {
			alert("예약일이 최소 예약일보다 작습니다");
			return;
		};
		
		//인원 값 넘기기
		var orderPersonnel = document.getElementById("personnel");
		personnelInput.value = parseInt(orderPersonnel.innerText);
		
		//submit 실행
		var frm = document.getElementById("frm");
		frm.submit();		
		
	}
	

	
	function preventMax(input, max) {
		if(input.value > max) {
			input.value = max;
		}
	}
	
	function addTotalReservationDay() {
		
		var parseIntText = parseInt(document.getElementById("totalReservationDay").innerText);
		parseIntText += parseInt(1);
		document.getElementById("totalReservationDay").innerText = parseIntText;
		
	}
	
	function removeTotalReservationDay() {
		
		var parseIntText = parseInt(document.getElementById("totalReservationDay").innerText);
		parseIntText -= parseInt(1);
		document.getElementById("totalReservationDay").innerText = parseIntText;
		
	}
	
	function addPersonnel() {
		
		var parseIntText = parseInt(document.getElementById("personnel").innerText);
		
		if(parseIntText >= "${officeInfo.officeInfoVo.office_personnel }") {
			alert("최대 예약가능 인원은 " + "${officeInfo.officeInfoVo.office_personnel }" + "명 입니다.");
			return;
		} else {
			parseIntText += parseInt(1);
			document.getElementById("personnel").innerText = parseIntText;
		}
		
		
		
	}
	
	function reducePersonnel() {
		
		var parseIntText = parseInt(document.getElementById("personnel").innerText);
		parseIntText -= parseInt(1);
		if(parseIntText <= 1) {
			document.getElementById("personnel").innerText = 1;
		} else {
			document.getElementById("personnel").innerText = parseIntText;
		}
		
		
	}
	
	//calendar script
	
	function renderDate(selectedYear,selectedMonth){

	    //2022 12 -> 2023 1
	
	    var todayMonth = new Date();
	    todayMonth = new Date(todayMonth.getFullYear() , todayMonth.getMonth());
	    var confirmDate = new Date(selectedYear , selectedMonth - 1);
	
	    if(confirmDate < todayMonth){
	        alert("지난 달은 예약할 수 없습니다.");
	        return;
	    }

	
	    //맨위...
	    var prevMonth = selectedMonth - 1;
	    var prevYear = selectedYear;
	    var nextMonth = selectedMonth + 1;
	    var nextYear = selectedYear;
	
	    if(prevMonth < 1){
	        prevMonth = 12;
	        prevYear--;
	    }
	    if(nextMonth > 12){
	        nextMonth = 1;
	        nextYear++;
	    }
	
	    document.getElementById("month-prev").setAttribute("onclick" , "renderDate("+ prevYear +","+prevMonth+")");
	    document.getElementById("month-next").setAttribute("onclick" , "renderDate("+ nextYear +","+nextMonth+")");
	    document.getElementById("month-current").innerText = selectedYear + ". " + selectedMonth;
	    
	    //날짜 그리기...
	    var dateBox = document.getElementById("date");
	    dateBox.innerHTML = "";
	
	    var tempDate = new Date(selectedYear , selectedMonth - 1);
	
	    var dateIndex = 1;
	
	    var weekRow = document.createElement("div");
	    weekRow.setAttribute("class" , "row");
	    dateBox.appendChild(weekRow);
	
	    //초반 빈칸 채우기..
	    tempDate.setDate(dateIndex);
	    for(i = tempDate.getDay() ; i > 0  ; i--){
	        var colDate = document.createElement("div");
	        colDate.setAttribute("class" , "col p-2 m-1 rounded-3");
	        weekRow.appendChild(colDate);
	    }
	
	    //날짜 채우기..
	    while(true){
	        tempDate.setDate(dateIndex);
	
	        if(tempDate.getMonth() + 1 > selectedMonth || tempDate.getFullYear() > selectedYear){
	            break;
	        }
	
	        //만약 일요일이면 로우 생성
	        if(tempDate.getDay() == 0){
	            weekRow = document.createElement("div");
	            weekRow.setAttribute("class" , "row");
	            dateBox.appendChild(weekRow);
	        }
	
	
	        //엘리먼트 만들기..
	        var colDate = document.createElement("div");
	        colDate.setAttribute("class" , "col text-center p-2 m-1 rounded-3");
	        colDate.innerText = dateIndex;
	
	        if(tempDate.getDay() == 6){
	            var tempAttr = colDate.getAttribute("class");
	            tempAttr = tempAttr + " text-primary";
	            colDate.setAttribute("class" , tempAttr);
	        }else if(tempDate.getDay() == 0){
	            var tempAttr = colDate.getAttribute("class");
	            tempAttr = tempAttr + " text-danger";
	            colDate.setAttribute("class" , tempAttr);
	        }
	
	        //확인하다...!! 이미 예약이 되어 있는 지... 오픈하지 않은 날...
	        var tempAttr = colDate.getAttribute("class");
	
	        var status = confirmPossibleStatus(tempDate);	        
	        
	        if(status == 2){
	            tempAttr = tempAttr + " impossible-reg";
	            colDate.setAttribute("class" , tempAttr);
	        }else if(status == 3){
	            tempAttr = tempAttr + " reserved-reg";
	            colDate.setAttribute("class" , tempAttr);
	        }else{
	            //예약 가능한 경우...
	            //var funcArg = tempDate.getFullYear() + "-" + (tempDate.getMonth()+1) + "-" + tempDate.getDate();
	            var funcArg = tempDate.getFullYear();
	            funcArg += "/";
	            if(tempDate.getMonth()+1 < 10){
	                funcArg += "0";
	            }
	            funcArg += tempDate.getMonth()+1
	            funcArg += "/";
	            if(tempDate.getDate() < 10){
	                funcArg += "0";
	            }
	            funcArg += tempDate.getDate();
	
	            //히든에서 확인한다....
	            var value = document.getElementById("choose-date").value;
	            
	            if(value.indexOf(funcArg) > -1){
	                var attr = colDate.getAttribute("class");
	                attr += " choose-reg";
	                colDate.setAttribute("class",attr);
	                
	                colDate.setAttribute("onclick","cancelReservationDate(this,'"+funcArg+"'); removeTotalReservationDay();");
	            }else{
	                colDate.setAttribute("onclick","chooseReservationDate(this,'"+funcArg+"'); addTotalReservationDay();");
	            }
	
	
	            
	        }
	
	
	        weekRow.appendChild(colDate);
	
	
	        dateIndex++;
	    }
	    //후반... 빈칸 채우기...
	    if(tempDate.getDay() != 0){
	        for(i = tempDate.getDay() ; i < 7 ; i++){
	            var colDate = document.createElement("div");
	            colDate.setAttribute("class" , "col p-2 m-1 rounded-3");
	            weekRow.appendChild(colDate);
	        }
	    }
	
	
	}
	
	function confirmPossibleStatus(date){
		//백엔드 연동 실제 확인 후 아래와 같이 리턴...
	    //1 = 예약가능
	    //2 = 미운영일
	    //3 = 예약완료
	    
	    //today 보다 이전 날짜는 예약불가(2)
	    var today = new Date();
		today = new Date(today.getFullYear() , today.getMonth(), today.getDate());
		
		if(date <= today) {
			return 2;
		} 
		
		
		<%--
		//예약 완료된날짜 불러와서 배열에 값 넣기
		//var reservationCompleteDate = new Array();
		
		<c:forEach items="${officeRentalList}" var="rentalVo">
			reservationCompleteDate.push(new Date('<fmt:formatDate value="${rentalVo.rental_date}" pattern="yyyy-MM-dd"/>'));
		</c:forEach>
		--%>
		
		//예약완료된 날짜 체크
		for(var i=0; i<reservationCompleteDate.length; i++) {
			if(date.getFullYear() == reservationCompleteDate[i].getFullYear() && 
					date.getMonth() == reservationCompleteDate[i].getMonth() &&
					date.getDate() == reservationCompleteDate[i].getDate()) {
				return 3;
			}
		}
		
		
		//오피스 운영요일 불러와서 배열에 값 넣기
		<%--
		//var businessDay = new Array();
		
		<c:forEach items="${officeBusinessDayInfo}" var="list">
			businessDay.push("${list.businessDayVo.business_day}");
		</c:forEach>
		--%>
		
		//운영일 체크
		var day = date.getDay();
		
		switch(day){
			case 0:
			day = '일';
			if(businessDay.includes(day)){
				return 1;
				break;
			} else {
				return 2;
				break;
			}
			case 1:
			day = '월';
			if(businessDay.includes(day)){
				return 1;
				break;
			} else {
				return 2;
				break;
			}
			case 2:
			day = '화';
			if(businessDay.includes(day)){
				return 1;
				break;
			} else {
				return 2;
				break;
			}
			case 3:
			day = '수';
			if(businessDay.includes(day)){
				return 1;
				break;
			} else {
				return 2;
				break;
			}
			case 4:
			day = '목';
			if(businessDay.includes(day)){
				return 1;
				break;
			} else {
				return 2;
				break;
			}
			case 5:
			day = '금';
			if(businessDay.includes(day)){
				return 1;
				break;
			} else {
				return 2;
				break;
			}
			case 6:
			day = '토';
			if(businessDay.includes(day)){
				return 1;
				break;
			} else {
				return 2;
				break;
			}
			
		}
    
		
		
		//return parseInt(Math.random() * 3) + 1;
		
	}
	
	
	
	
	
	function chooseReservationDate(e,date){
	    //히든 값 세팅
	    var value = document.getElementById("choose-date").value;
	    value += "," + date;
	    document.getElementById("choose-date").value = value;
	
	    //UI...
	    var attr = e.getAttribute("class");
	    attr += " choose-reg";
	    e.setAttribute("class",attr);
	    e.setAttribute("onclick" , "cancelReservationDate(this,'"+date+"'); removeTotalReservationDay();");
	
	    var totalPrice = document.querySelector("#totalPrice");  	    	    	    
	    
	    var dayList = ['일', '월', '화', '수', '목', '금', '토'];	    
	    var day = dayList[new Date(date).getDay()];
	    
	    var total = (parseInt(totalPrice.innerText.split(",").join("")) + parseInt(businessDayMap[day]));
	    totalPrice.innerText = total.toLocaleString();
	    
	}
	
	function cancelReservationDate(e,date){
	    //히든 값... 빼기...
	    var value = document.getElementById("choose-date").value;
	    value = value.replaceAll("," + date , "");
	    document.getElementById("choose-date").value = value;
	
	    var attr = e.getAttribute("class");
	    attr = attr.replaceAll(" choose-reg","");
	    e.setAttribute("class",attr);
	    e.setAttribute("onclick" , "chooseReservationDate(this,'"+date+"'); addTotalReservationDay();");
	    
	    var totalPrice = document.querySelector("#totalPrice");
	    
	    var dayList = ['일', '월', '화', '수', '목', '금', '토'];	    
	    var day = dayList[new Date(date).getDay()];
	    
	    var total = (parseInt(totalPrice.innerText.split(",").join("")) - parseInt(businessDayMap[day]));
	    totalPrice.innerText = total.toLocaleString();
	}
	
	
	window.addEventListener("DOMContentLoaded" , function(){
	    getOfficeReservedDateAndBusinessDay();

	    
	});
	
	document.addEventListener('keydown', function(event) {
	  if (event.keyCode === 13) {
	    event.preventDefault();
	  };
	}, true);	
	
</script>

</head>
<body>
<div class="container-fluid px-0" style="overflow-x : hidden">
<jsp:include page="../commons/navbar.jsp"></jsp:include>

	<div class="row" style="padding-top: 2em;">
	
		<div class="col"></div> <!-- 왼쪽 여백 -->
		
		<div class="col-10">
		<form id="frm" action="paymentPage" method="post">
			<div class="row">
				<div class="col center text-fs-23 bold">
					<i class="bi bi-calendar-check" style="margin-right:0.08rem;"></i>
					<span>예약하기</span>
				</div>
			</div>					
			
			<div class="row mt-4">
				<div class="col">
					<div class="row">
						<div class="col text-fs-13">
							<i class="bi bi-square-fill impossible-reg-icon"></i>
							<span class="grayColor" style="margin-bottom : 0;">예약 불가능</span>
						</div>
					</div>
				</div>
			</div>
			
			<div class="row mt-2"><!-- 날짜체크 -->
			
			<div id="calendar-wrapper" class="col">
	            <div class="row">
	                <div id="month-prev" class="col text-center fw-bold fs-2" onclick="renderDate(2)"><i class="bi bi-chevron-left"></i></div>
	                <div id="month-current" class="col-6 text-center fw-bold fs-2"></div>
	                <div id="month-next" class="col text-center fw-bold fs-2" onclick="renderDate(4)"><i class="bi bi-chevron-right"></i></div>
	            </div>
	            <div class="row my-2">
	                <div class="col text-center p-2 m-1 text-danger rounded-3">일</div>
	                <div class="col text-center p-2 m-1 rounded-3">월</div>
	                <div class="col text-center p-2 m-1 rounded-3">화</div>
	                <div class="col text-center p-2 m-1 rounded-3">수</div>
	                <div class="col text-center p-2 m-1 rounded-3">목</div>
	                <div class="col text-center p-2 m-1 rounded-3">금</div>
	                <div class="col text-center p-2 m-1 text-primary rounded-3">토</div>
	            </div>
	            <div class="row">
	                <div id="date" class="col">
	                </div>
	            </div>
	            <input id="choose-date" type="hidden" name="rental_date">
            </div>
			
			</div>
			
			<div class="row mt-4 mb-2"> <!-- 인원체크 -->
				<div class="col text-fs-13 bold" style="padding-top:0.75rem;">예약 인원
				<span class="text-fs-11">(최대 ${officeInfo.officeInfoVo.office_personnel}명)</span>
				</div>
				<div class="col-4 right">
					<span class="text-fs-28" onclick="reducePersonnel();">-&nbsp;</span> 
					<span class="text-fs-19 bold" id="personnel">1</span> 
					<span class="text-fs-28" onclick="addPersonnel();">&nbsp;+</span>
					<input id="personnelInput" type="hidden" name="order_personnel"/>
				</div>
				<%--
				<div class="col-2">
					 <input id="personnelInput" type="number" name="order_personnel" class="form-control form-control-sm" onblur="preventMax(this, ${officeInfo.officeInfoVo.office_personnel })" min="1" max="${officeInfo.officeInfoVo.office_personnel }" value="1" />
				</div>
				 --%>
			</div>
			<hr>
			
			<div class="row mt-2 text-fs-17">
				<div class="col">
					<span class="float-right bold">일</span><span id="totalReservationDay" class="float-right bold">0</span><span class="float-right bold">총&nbsp;</span>
				</div>			
			</div>
			
			<div class="row mt-2 text-fs-17">
				<div class="col bold">Total<span class="text-fs-11">&nbsp;(최소 ${officeInfo.officeInfoVo.office_min_booking_day }일)</span></div>
				<div class="col">
					<span class="float-right bold">원</span><span id="totalPrice" class="float-right bold">0</span><span class="float-right bold">￦&nbsp;</span>
				</div>			
			</div>
			
						
			
			<div class="row" style="padding:0.7em;"></div>
			
			<div class="row leading-tight">
				<div class="col">
					<div class="d-grid">
						<button type="button" class="btn buttonColor" onclick="orderValidCheck(event)">선택 완료</button>
						<input type="hidden" name="officeNo" value="${officeInfo.officeInfoVo.office_no }">
						<input id="orderTid" type="hidden" name="order_tid">
					</div>
				</div>
			</div>
			
			</form>
			
			<div class="row" style="padding:1.5em;"></div>
		
		</div>
		
		<div class="col"></div> <!-- 왼쪽 여백 -->
			
	</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>