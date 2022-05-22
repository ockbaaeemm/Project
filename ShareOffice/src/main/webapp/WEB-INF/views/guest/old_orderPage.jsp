<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
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
	
	function getOfficeReservedDateAndBusinessDay(){
		var xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200) {
				var data = JSON.parse(xhr.responseText);
				
				//오피스 운영일 및 예약완료된 날짜 배열에 넣기
				for(e of data.officeBusinessDayInfo){
					businessDay.push(e.businessDayVo.business_day);
				}
				
				for(e of data.officeRentalList){
					reservationCompleteDate.push(new Date(e.rental_date));
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
		chooseDate.value = chooseDate.value.substring(1, chooseDate.length);
		
		//submit 실행
		var frm = document.getElementById("frm");
		frm.submit();
		
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
	                
	                colDate.setAttribute("onclick","cancelReservationDate(this,'"+funcArg+"')");
	            }else{
	                colDate.setAttribute("onclick","chooseReservationDate(this,'"+funcArg+"')");
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
		
		if(date < today) {
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
	    e.setAttribute("onclick" , "cancelReservationDate(this,'"+date+"')");
	
	}
	
	function cancelReservationDate(e,date){
	    //히든 값... 빼기...
	    var value = document.getElementById("choose-date").value;
	    value = value.replaceAll("," + date , "");
	    document.getElementById("choose-date").value = value;
	
	    var attr = e.getAttribute("class");
	    attr = attr.replaceAll(" choose-reg","");
	    e.setAttribute("class",attr);
	    e.setAttribute("onclick" , "chooseReservationDate(this,'"+date+"')");
	}
	
	
	window.addEventListener("DOMContentLoaded" , function(){
	    getOfficeReservedDateAndBusinessDay();

	    
	});
	
</script>

</head>
<body>
<jsp:include page="../commons/navbar.jsp"></jsp:include>

	<div class="row" style="padding-top: 70px;">
	
		<div class="col"></div> <!-- 왼쪽 여백 -->
		
		<div class="col-10">
		<form id="frm" action="./paymentPage" method="post">
			<div class="row mt-5">
				<div class="col fs-2 center">예약하기</div>
			</div>
			
			<div class="row mt-5">
				<div class="col fs-5">예약 공간</div>
			</div>
			
			<div class="row"><div class="col"><hr></div></div> <!-- 구분선 -->
		
			<div class="row"> <!-- 예약오피스 썸네일 -->
			
				<div class="col"> 
					<%-- <img src="../resources/img/testImage.jpg" width="100%" height="170em"> --%>
			   		<img src="/soUpload/officeImage/${officeInfo.officeInfoVo.office_thumbnail }" width="100%" height="100%">
				</div>
			
			</div>
			
			<div class="row mt-4"> <!-- 예약 오피스 정보 -->
				<div class="col">
				
					<div class="row">
						<div class="col fs-5">
							<p>${officeInfo.officeInfoVo.office_name }</p>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<p class="grayColor">${officeInfo.officeInfoVo.office_simpleContent }</p>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<p class="grayColor">${officeInfo.officeInfoVo.office_detailContent }</p>
						</div>
					</div>
					
				</div>
			</div>
			
			<div class="row mt-5">
				<div class="col">
				
					<div class="row mt-5">
						<div class="col">오피스 운영 요일, 시간 및 가격</div>
					</div>
					
					<c:forEach items="${officeBusinessDayInfo }" var="obdi">
					<div class="row">
						<div class="col fw-light">
							<span>${obdi.businessDayVo.business_day }
							&#40;${obdi.businessDayVo.business_time_start}:00 ~ ${obdi.businessDayVo.business_time_finish}:00&#41; / 
							<fmt:formatNumber value="${obdi.businessDayVo.business_day_price }"/>원</span>
						</div>
					</div>
					</c:forEach>
					
				</div>
			</div>
			
			<div class="row mt-2">
				<div class="col">
					최소 예약일수 : <span class="fw-light">${officeInfo.officeInfoVo.office_min_booking_day }일</span>
				</div>
			</div>
			
			<div class="row mt-2">
				<div class="col">
					최대 예약가능 인원 : <span class="fw-light">${officeInfo.officeInfoVo.office_personnel }명</span>
				</div>
			</div>
			
			
			<div class="row mt-5">
				<div class="col fs-5">예약 날짜 및 인원</div>
			</div>
			
			<div class="row"><div class="col"><hr></div></div> <!-- 구분선 -->
			
			<div class="row mt-4">
				<div class="col">인원 선택</div>
			</div>
			
			<div class="row mt-2"> <!-- 인원체크 -->
			
				<div class="col">
					 <input id="personnelInput" type="number" name="order_personnel" class="form-control" min="1" max="30" value="1"/>
				</div>
				<div class="col-9"></div>
			</div>
			
			<div class="row mt-3">
				<div class="col">
					<div class="row">
						<div class="col">
							<p style="margin-bottom : 10px;">날짜 선택</p>
						</div>
					</div>
					<div class="row">
						<div class="col">
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
	                <div id="month-current" class="col-6 text-center fw-bold fs-2">3월</div>
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
			
			<div class="row" style="padding:1em;"></div>
			
			
			<div class="row mt-3">
				<div class="col">
					<div class="d-grid">
						<button class="btn buttonColor" onclick="orderValidCheck(event)">결제하기</button>
						<input type="hidden" name="office_no" value="${officeInfo.officeInfoVo.office_no }">
					</div>
				</div>
			</div>
			
			</form>
			
			<div class="row" style="padding:1em;"></div>
		
		</div>
		
		<div class="col"></div> <!-- 왼쪽 여백 -->
			
	</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>