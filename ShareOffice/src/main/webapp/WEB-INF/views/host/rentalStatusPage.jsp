<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
.menus {border: 0.2rem solid rgba(189, 189, 189, 0.781); border-radius: 624.938rem; text-align: center; color: rgba(189, 189, 189, 0.781);}
.menus.on {border: 0.2rem solid #22223bc9; color:#1a1a2ee5;}

.sec_cal {
    width: 90%;
    margin: 0 auto;
    font-family: "NotoSansR";
}

.sec_cal .cal_nav {
    display: flex;
    justify-content: center;
    align-items: center;
    font-weight: 700;
    font-size: 3rem;
    line-height: 4.875rem;
}

.sec_cal .cal_nav .year-month {
    width: 18.75rem;
    text-align: center;
    line-height: 1;
    overflow-y: hidden;
    color: rgba(37,37,37,1);
    padding-bottom:.25rem;
}

.sec_cal .cal_nav .nav {
    display: flex;
    border: 0.063rem solid #333333;
    border-radius: 0.313rem;
}

.sec_cal .cal_nav .go-prev,
.sec_cal .cal_nav .go-next {
    display: block;
    width: 3.125rem;
    height: 4.875rem;
    font-size: 0;
    display: flex;
    justify-content: center;
    align-items: center;
}

.sec_cal .cal_nav .go-prev::before,
.sec_cal .cal_nav .go-next::before {
    content: "";
    display: block;
    width: 1.25rem;
    height: 1.25rem;
    border: 0.188rem solid #000;
    border-width: 0.188rem 0.188rem 0 0;
    transition: border 0.1s;
    color: rgba(37,37,37,1);
}

.sec_cal .cal_nav .go-prev:hover::before,
.sec_cal .cal_nav .go-next:hover::before {
    border-color: #A68A64;
}

.sec_cal .cal_nav .go-prev::before {
    transform: rotate(-135deg);
}

.sec_cal .cal_nav .go-next::before {
    transform: rotate(45deg);
}

.sec_cal .cal_wrap {
    padding-top: 1.5rem;
    position: relative;
    margin: 0 auto;
}

.sec_cal .cal_wrap .days {
    display: flex;
    margin-bottom: 1.25rem;
    padding-bottom: 1.25rem;
    border-bottom: 0.063rem solid #ddd;
}

.sec_cal .cal_wrap::after {
    top: 23rem;
}

.sec_cal .cal_wrap .day {
    display:flex;
    align-items: center;
    justify-content: center;
    width: calc(100% / 7);
    text-align: left;
    color: rgb(75, 75, 75);
    font-size: 0.75rem;
    text-align: center;
    border-radius:0.313rem
}

.current.today {background: #c9ad5234;}

.sec_cal .cal_wrap .dates {
    display: flex;
    flex-flow: wrap;
    height: 18.125rem;
}

.sec_cal .cal_wrap .day:nth-child(7n) {
    color: #3c6ffa;
}

.sec_cal .cal_wrap .day:nth-child(7n+1) {
    color: #ed2a61;
}

.sec_cal .cal_wrap .day.disable {
    color: #ddd;
}

</style>

<script>
	var category = null;
	var searchKeyword = null;
	var onlyCancel = false;
	
	function selectMenu(obj) {
		for(var e of document.querySelectorAll(".menus.on")) {
			e.classList.remove("on");
		}
		
		obj.classList.add("on");
		document.querySelector("#rootContainer").innerHTML = "";
		
		if(obj.id == "calendarBtn") {
			createCalendarBox();
			calendarInit();
			
			getMonthRental();
			
			var rental_date = new Date();
			var year = rental_date.getFullYear();
			var month = rental_date.getMonth() + 1;
			var date = rental_date.getDate();
			
			rental_date = year + "-" + (month >= 10 ? month : '0' + month) + "-" + (date >= 10 ? date : '0' + date);
			loadCalendarRentalList(rental_date);
		} else if(obj.id == "listBtn") {						
			
			category = null;
			searchKeyword = null;
			onlyCancel = false;
			
			createSearchBox();
			loadOrderList();
			
		}
	}
	
	function loadCalendarRentalList(rental_date) {
		var xhr = new XMLHttpRequest();
		
		
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				var data = JSON.parse(xhr.responseText);
	
				if(data.result == 'success') {					

				   	document.querySelector("#rentalContainer").innerHTML = "";						
					
					if(data.dataList.length > 0) {
						for(var d of data.dataList) {
							createRentalBox(d, true);	
						}
												
					} else {
						createNoResultBox("rentalContainer", "날짜");
					}
				} else {
					alert(data.message);
				}								
			}
		};
		
		xhr.open("get", "./getCalendarRentalList?rental_date=" + rental_date, true);
		xhr.send();
	}
	
	function loadOrderList() {
		var xhr = new XMLHttpRequest();
				
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				var data = JSON.parse(xhr.responseText);					
				
				document.querySelector("#orderContainer").innerHTML = "";
				
				if(data.dataList.length == 0) {
					createNoResultBox("orderContainer", "조건");
				}
				
				for(var d of data.dataList) {
					createOrderBox(d);
				}								
			}
		};
		
		xhr.open("get", "./searchOrder?category=" + category + "&searchKeyword=" + searchKeyword +
				"&onlyCancel=" + onlyCancel, true);
		xhr.send();		
	}
	
	function createRentalBox(data) {
		var root = document.querySelector("#rentalContainer");
		
		var row = document.createElement("div");
		row.setAttribute("class", "row border rounded-10 px-2 ms-3 me-3 mt-2 mb-3");
		row.setAttribute("onclick", "location.href='../host/orderDetailPage?order_no=" + data.orderInfo.order_no + "'");
		
		var colorLine = document.createElement("div");
		colorLine.setAttribute("class", "px-0");
		if(data.orderInfo.rental_status == "U") {
			colorLine.setAttribute("style", "width:.5rem; background-color:rgba(21, 110, 36, 0.664)");	
		} else if(data.orderInfo.rental_status == "P") {
			colorLine.setAttribute("style", "width:.5rem; background-color:rgba(245, 231, 42, 0.664)");	
		} else if(data.orderInfo.rental_status == "C") {
			colorLine.setAttribute("style", "width:.5rem; background-color:rgba(133, 133, 133, 0.664)");	
		}					
		row.appendChild(colorLine);	
		
		var imgCol = document.createElement("div");
		imgCol.setAttribute("class", "col-2");
		var img = document.createElement("img");
		img.setAttribute("src", "/soUpload/officeImage/" + data.orderInfo.office_thumbnail);
		img.setAttribute("style", "width:100%; height:100%;");
		imgCol.appendChild(img);
		row.appendChild(imgCol);
		
		var infoCol = document.createElement("div");
		infoCol.setAttribute("class", "col-7 px-0");
		var nameRow = document.createElement("div");
		nameRow.setAttribute("class", "row mt-2");
		var nameCol = document.createElement("div");
		nameCol.setAttribute("class", "col text-fs-15");
		nameCol.innerText = data.orderInfo.office_name;
		nameRow.appendChild(nameCol);
		if(data.orderInfo.rental_status == "C") {
			var div = document.createElement("div");
			div.setAttribute("class", "col text-red-dsoft text-fs-10");
			div.setAttribute("style", "padding-top: 0.15rem");
			div.innerText = "(취소)";
			nameRow.appendChild(div);
		}
		var resvRow = document.createElement("div");
		resvRow.setAttribute("class", "row mt-1 text-fs-10");
		var resvCol1 = document.createElement("div");
		resvCol1.setAttribute("class", "col");
		resvCol1.innerText = "예약자 : " + data.guestVo.member_nick;
		
		
		var resvCol2 = document.createElement("div");
		resvCol2.setAttribute("class", "col");
		resvCol2.innerText = "금액 : " + data.orderInfo.rental_price;
		if(data.orderInfo.rental_status == "C") {
			resvCol2.setAttribute("style", "text-decoration:line-through; text-decoration-color: rgba(37,37,37,1);");
			resvCol2.classList.add("text-gray-c_25");								
		}
		
		resvRow.appendChild(resvCol1);
		resvRow.appendChild(resvCol2);
		infoCol.appendChild(nameRow);
		infoCol.appendChild(resvRow);
		row.appendChild(infoCol);
		
		var chevronCol = document.createElement("div");
		chevronCol.setAttribute("class", "col-2 pt-2 px-0 ms-3");
		var chevron = document.createElement("i");
		chevron.setAttribute("class", "bi bi-chevron-right text-fs-30 float-right text-gray-c_25");
		chevronCol.appendChild(chevron);
		row.appendChild(chevronCol);
		
		root.appendChild(row);
	}
	
	function createNoResultBox(rootId, message) {
		var root = document.querySelector("#" + rootId);
		
		var row = document.createElement("div");
		row.setAttribute("class", "row border rounded-10 px-2 ms-3 me-3 mt-2 mb-3");
		var col = document.createElement("div");
		col.setAttribute("class", "col text-center mt-3");
		var img = document.createElement("img")
		img.setAttribute("src", "../resources/img/noresult.png");
		img.setAttribute("style", "width:20%");
		col.appendChild(img);
		
		
		var row2 = document.createElement("div");
		row2.setAttribute("class", "row");
		var col2 = document.createElement("div");
		col2.setAttribute("class", "col text-center mt-3 mb-3 text-gray-c_25");
		col2.innerText = "해당 " + message + " 예약 내역이 없습니다";
		row2.appendChild(col2);
		col.appendChild(row2);
			
		row.appendChild(col);
		root.appendChild(row);
	}
	
	function selectDay(obj, year, month) {
		for(var e of document.querySelectorAll(".current.today")) {
			e.classList.remove("today");
		}
		
		obj.classList.add("today");
		
		loadCalendarRentalList(year + "-" + month + "-" + obj.innerText);
	}
	
	function createSearchBox() {
		var root = document.querySelector("#rootContainer");
		
		var searchRow = document.createElement("div");
		searchRow.setAttribute("class", "row mt-4 me-1 ms-1");
		var selectCol = document.createElement("div");
		selectCol.setAttribute("class", "col-4");
		var select = document.createElement("select");
		select.setAttribute("class", "form-select form-select-sm text-fs-13");
		select.setAttribute("id", "category");
		var option1 = document.createElement("option");
		option1.innerText = "전체";
		option1.value = "all";
		var option2 = document.createElement("option");
		option2.innerText = "예약번호";
		option2.value = "order_no";
		var option3 = document.createElement("option");
		option3.innerText = "예약자";
		option3.value = "nick";
		select.appendChild(option1);
		select.appendChild(option2);
		select.appendChild(option3);
		selectCol.appendChild(select);
		
		var searchCol = document.createElement("div");
		searchCol.setAttribute("class", "col");
		var searchInput = document.createElement("input");
		searchInput.setAttribute("class", "form-control form-control-sm text-fs-13");
		searchInput.setAttribute("type", "text");
		searchInput.setAttribute("onKeypress", "javascript:if(event.keyCode==13) {search(this)}");
		searchInput.setAttribute("id", "searchKeyword");
		searchCol.appendChild(searchInput);
				
		searchRow.appendChild(selectCol);
		searchRow.appendChild(searchCol);
		
		root.appendChild(searchRow);
		
		var toggleRow = document.createElement("div");
		toggleRow.setAttribute("class", "row mt-3");
		toggleRow.setAttribute("style", "height:1.25rem");
		var blankCol = document.createElement("div");
		blankCol.setAttribute("class", "col-7");
		var toggleCol = document.createElement("div");
		toggleCol.setAttribute("class", "col ms-3");
		var formSwitch = document.createElement("div");
		formSwitch.setAttribute("class", "form-check form-switch");
		var toggle = document.createElement("input");
		toggle.setAttribute("class", "form-check-input");
		toggle.setAttribute("type", "checkbox");
		toggle.setAttribute("role", "switch");
		toggle.setAttribute("id", "flexSwitchCheckChecked");
		toggle.setAttribute("onclick", "checkToggle(this)");
		var label = document.createElement("label");
		label.setAttribute("class", "form-check-label text-fs-11 pt-1");
		label.setAttribute("for", "flexSwitchCheckChecked");
		label.innerText = "취소건만 표시";
		formSwitch.appendChild(toggle);
		formSwitch.appendChild(label);
		toggleCol.appendChild(formSwitch);
		toggleRow.appendChild(blankCol);
		toggleRow.appendChild(toggleCol);
		
		root.appendChild(toggleRow);
		
		var orderRow = document.createElement("div");
		orderRow.setAttribute("class", "row");
		var orderCol = document.createElement("div");
		orderCol.setAttribute("class", "col");
		orderCol.setAttribute("id", "orderContainer");
		orderRow.appendChild(orderCol);
		
		root.appendChild(orderRow);
		
	}
	
	
	function search(obj) {	
		
		category = document.querySelector("#category").value;
		searchKeyword = document.querySelector("#searchKeyword").value;
	
		loadOrderList();
	}
	
	function checkToggle(toggle) {
		if(toggle.checked) {
			onlyCancel = true;
		} else {
			onlyCancel= false;
		}
		
		loadOrderList();
	}
	
	function createOrderBox(data) {
		var root = document.querySelector("#orderContainer");		
		
		var row = document.createElement("div");
		row.setAttribute("class", "row border rounded-10 px-2 ms-3 me-3 mt-2 mb-3");
		row.setAttribute("onclick", "location.href='../host/orderDetailPage?order_no=" + data.orderInfo.order_no + "'");
		
		var imgCol = document.createElement("div");
		imgCol.setAttribute("class", "col-2");
		var img = document.createElement("img");
		img.setAttribute("src", "/soUpload/officeImage/" + data.officeVo.office_thumbnail);
		img.setAttribute("style", "width:100%; height:100%;");
		imgCol.appendChild(img);
		row.appendChild(imgCol);
		
		var infoCol = document.createElement("div");
		infoCol.setAttribute("class", "col-7 px-0");
		var nameRow = document.createElement("div");
		nameRow.setAttribute("class", "row mt-2");
		var nameCol = document.createElement("div");
		nameCol.setAttribute("class", "col text-fs-15");
		nameCol.innerText = data.officeVo.office_name;
		nameRow.appendChild(nameCol);
		var resvRow = document.createElement("div");
		resvRow.setAttribute("class", "row mt-1 text-fs-10");
		var resvCol1 = document.createElement("div");
		resvCol1.setAttribute("class", "col");
		resvCol1.innerText = "예약자 : " + data.orderInfo.member_nick;
		var resvCol2 = document.createElement("div");
		resvCol2.setAttribute("class", "col");
		resvCol2.innerText = "총액 : " + data.totalPrice;
		resvRow.appendChild(resvCol1);
		resvRow.appendChild(resvCol2);
		infoCol.appendChild(nameRow);
		infoCol.appendChild(resvRow);
		row.appendChild(infoCol);
		
		var chevronCol = document.createElement("div");
		chevronCol.setAttribute("class", "col-2 pt-2 px-0 ms-3");
		var chevron = document.createElement("i");
		chevron.setAttribute("class", "bi bi-chevron-right text-fs-30 float-right text-gray-c_25");
		chevronCol.appendChild(chevron);
		row.appendChild(chevronCol);
		
		root.appendChild(row);
	}
	
	// calendar 

	function createCalendarBox() {
	  
	  var root = document.querySelector("#rootContainer");
	  
	  var sec_cal = document.createElement("div");
	  sec_cal.setAttribute("class", "sec_cal mt-2");
	  var cal_nav = document.createElement("div");
	  cal_nav.setAttribute("class", "cal_nav");
	  var prev = document.createElement("a");
	  prev.setAttribute("class", "nav-btn go-prev");
	  prev.setAttribute("href", "javascript:;");
	  prev.innerText = "prev";
	  var yearMonth = document.createElement("div");
	  yearMonth.setAttribute("class", "year-month");
	  var next = document.createElement("a");
	  next.setAttribute("class", "nav-btn go-next");
	  next.setAttribute("href", "javascript:;");
	  next.innerText = "next";
	  cal_nav.appendChild(prev);
	  cal_nav.appendChild(yearMonth);
	  cal_nav.appendChild(next);
	  
	  var cal_wrap = document.createElement("div");
	  cal_wrap.setAttribute("class", "cal_wrap");
	  var days = document.createElement("div");
	  days.setAttribute("class", "days");
	  var dayList = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
	  for(var d of dayList) {
		  var day = document.createElement("div");
		  day.setAttribute("class", "day");
		  day.innerText = d;
		  days.appendChild(day);
	  }
	  var dates = document.createElement("div");
	  dates.setAttribute("class", "dates");
	  cal_wrap.appendChild(days);
	  cal_wrap.appendChild(dates);
	  
	  sec_cal.appendChild(cal_nav);
	  sec_cal.appendChild(cal_wrap);
	  	  	  
	  root.appendChild(sec_cal);
	  
	    
      var row = document.createElement("div");
      row.setAttribute("class", "row mt-2 mb-4");
      var col = document.createElement("div");
      col.setAttribute("class", "col");
      col.setAttribute("id", "rentalContainer");
      row.appendChild(col);
      root.appendChild(row);	
	  
	}

	function getMonthRental() {
		var xhr = new XMLHttpRequest();

		var year_month = document.querySelector(".year-month").innerText;
		var year_month_split = year_month.split(".");
		
		var month = (year_month_split[1] < 10) ? "0" + year_month_split[1] : year_month_split[1];
		
		var rental_date = year_month_split[0] + "-" + year_month_split[1] + "-01";		
		
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				var data = JSON.parse(xhr.responseText);					
				
				for(var monthRental of data.monthRentalList) {
					drawCalendarDot(monthRental);
				}
			}
		};
		
		xhr.open("get", "./getMonthRental?rental_date=" + rental_date, true);
		xhr.send();	
	}
	
	function drawCalendarDot(rental) {
		var rental_date = new Date(rental.rental_date);
		
		/*var year = rental_date.getFullYear();
		var month = rental_date.getMonth()+1;
		month = (month < 10) ? "0" + month : month;*/
		var date = rental_date.getDate();
		//day = (day < 10) ? "0" + day : day;
		
		for(var day of document.querySelectorAll(".day.current")) {
			if (day.innerText == date) {
				day.classList.add("relative");
				var i = document.createElement("i");
				i.setAttribute("class", "bi bi-dot text-red-soft text-fs-25 bold absolute");
				i.setAttribute("style", "top:40%");
				day.appendChild(i);
			}
		} 
		
	}
	
	function calendarInit() {

	    // 날짜 정보 가져오기
	    var date = new Date(); // 현재 날짜(로컬 기준) 가져오기
	    var utc = date.getTime() + (date.getTimezoneOffset() * 60 * 1000); // uct 표준시 도출
	    var kstGap = 9 * 60 * 60 * 1000; // 한국 kst 기준시간 더하기
	    var today = new Date(utc + kstGap); // 한국 시간으로 date 객체 만들기(오늘)
	  
	    var thisMonth = new Date(today.getFullYear(), today.getMonth(), today.getDate());
	    // 달력에서 표기하는 날짜 객체
	  
	    
	    var currentYear = thisMonth.getFullYear(); // 달력에서 표기하는 연
	    var currentMonth = thisMonth.getMonth(); // 달력에서 표기하는 월
	    var currentDate = thisMonth.getDate(); // 달력에서 표기하는 일

	    // kst 기준 현재시간

	    // 캘린더 렌더링
	    renderCalender(thisMonth);

	    function renderCalender(thisMonth) {

	        // 렌더링을 위한 데이터 정리
	        currentYear = thisMonth.getFullYear();
	        currentMonth = thisMonth.getMonth();
	        currentDate = thisMonth.getDate();

	        // 이전 달의 마지막 날 날짜와 요일 구하기
	        var startDay = new Date(currentYear, currentMonth, 0);
	        var prevDate = startDay.getDate();
	        var prevDay = startDay.getDay();

	        // 이번 달의 마지막날 날짜와 요일 구하기
	        var endDay = new Date(currentYear, currentMonth + 1, 0);
	        var nextDate = endDay.getDate();
	        var nextDay = endDay.getDay();

	        // 현재 월 표기
	        $('.year-month').text(currentYear + '.' + (currentMonth + 1));

	        // 렌더링 html 요소 생성
	        calendar = document.querySelector('.dates')
	        calendar.innerHTML = '';
	        
	        // 지난달
			if(prevDate - (prevDate-prevDay) < 6) {
				for (var i = prevDate - prevDay; i <= prevDate; i++) {
	            calendar.innerHTML = calendar.innerHTML + '<div class="day prev disable cursor-pointer" onclick="selectDay(this,' + currentYear +', ' + (currentMonth + 1) +')">' + i + '</div>'
	        }

			}
	        // 이번달
	        for (var i = 1; i <= nextDate; i++) {
	            calendar.innerHTML = calendar.innerHTML + '<div class="day current cursor-pointer" onclick="selectDay(this,' + currentYear +', ' + (currentMonth + 1) +')">' + i + '</div>'
	        }
	        // 다음달
	        for (var i = 1; i <= (6 - nextDay == 7 ? 0 : 6 - nextDay); i++) {
	            calendar.innerHTML = calendar.innerHTML + '<div class="day next disable cursor-pointer" onclick="selectDay(this,' + currentYear +', ' + (currentMonth + 1) +')">' + i + '</div>'
	        }

	        // 오늘 날짜 표기
	        if (today.getMonth() == currentMonth) {
	            todayDate = today.getDate();
	            var currentMonthDate = document.querySelectorAll('.dates .current');
	            currentMonthDate[todayDate -1].classList.add('today');
	        }
	    }

	    // 이전달로 이동
	    $('.go-prev').on('click', function() {
	        thisMonth = new Date(currentYear, currentMonth - 1, 1);
	        renderCalender(thisMonth);
	        getMonthRental();
	    });

	    // 다음달로 이동
	    $('.go-next').on('click', function() {
	        thisMonth = new Date(currentYear, currentMonth + 1, 1);
	        renderCalender(thisMonth);
	        getMonthRental();
	    });
	}	
	
	
	window.addEventListener("DOMContentLoaded", function() {
		createCalendarBox();
		calendarInit();

		getMonthRental();
		
		var rental_date = new Date();
		var year = rental_date.getFullYear();
		var month = rental_date.getMonth() + 1;
		var date = rental_date.getDate();
		
		rental_date = year + "-" + (month >= 10 ? month : '0' + month) + "-" + (date >= 10 ? date : '0' + date);
		loadCalendarRentalList(rental_date);
		
	});
	
</script>


</head>
<body>
<div class="container-fluid px-0" style="overflow-x : hidden">
<jsp:include page="../commons/navbar.jsp"></jsp:include>

<div class="row" style="padding-top: 2rem;">
	<div class="col">
		<div class="row mt-1">
			<div class="col bold text-fs-23 text-gray-c_25 text-center"><i class="bi bi-calendar-week"></i> 예약 내역</div>
		</div>
		<div class="row mt-5">
			<div class="col"></div>
			<div id="calendarBtn" class="py-2 ms-3 col-4 cursor-pointer menus on bold" onclick="selectMenu(this)">달력으로 보기</div>
			<div id="listBtn" class="py-2 ms-3 col-4 cursor-pointer menus bold" onclick="selectMenu(this)">리스트로 보기</div>
			<div class="col"></div>
		</div>
		<div class="row">
			<div id="rootContainer" class="col mb-5">
			  
			</div>
		</div>					
	</div>
</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>