<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <div class="row" style="margin: auto;">
   <div class="col pt-2" style="background-image: url('../resources/img/RRealLogo.jpg'); background-position: center; height: 31.25rem; background-size: cover;">
   		<i data-bs-toggle="offcanvas" href="#offcanvasExample" role="button" aria-controls="offcanvasExample" class="bi bi-list cursor-pointer text-fs-40 menu" style="color:white;"></i>
   </div>
</div> --%>

<div class="row">
   <div class="col relative">
   		<img src="../resources/img/RRealLogo.jpg" class="img-fluid">
   		<i data-bs-toggle="offcanvas" href="#offcanvasExample" role="button" aria-controls="offcanvasExample" class="bi bi-list cursor-pointer text-fs-40 menu absolute" style="color:white; top:.75rem; left:1.5rem;"></i>
   </div>
</div>


<div class="offcanvas offcanvas-start w-75" tabindex="-1" id="offcanvasExample" aria-labelledby="offcanvasExampleLabel" style="background-color: #e0e0e0">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title bold ms-1 text-gray-c_25 text-fs-23" id="offcanvasExampleLabel">Menu
    	<a href="../member/messageListPage">
    		<i class="bi bi-bell-fill menu" style="font-size: 1.25rem; color: #d49d4c;"></i>
    	</a>
    </h5>
    
    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body">
	<div class="row">
		<c:choose>
			<c:when test="${empty sessionUser }">
				<div class="col cursor-pointer rounded-10 ms-2 me-3 px-8" style="background-color:#aa834d; padding-top:.7rem; padding-bottom:.7rem" onclick="location.href='../member/loginPage'"><i class="bi bi-chat-fill" style="color:#3A1D1D"></i><span class="ms-5 ps-1 text-gray-c_ff text-fs-13">카카오 로그인</span></div>
			</c:when>
			<c:otherwise>
				<div class="col text-gray-c_25 text-fs-16" style="font-weight: bold; margin-left: .5rem;"><span class="text-fs-23" style="color: #333"> ${sessionUser.member_nick }</span> 님</div>
				<div class="col cursor-pointer text-fs-16" style="text-align: right; padding-top:.4rem" onclick="location.href='../member/logoutProcess'"><i class="bi bi-lock text-gold"></i> logout</div>
			</c:otherwise>
		</c:choose>
	</div>

	<c:if test="${!empty sessionUser }">
	    <div class="row mt-3">
	    	<div class="col pr-1">
	    		<button type="button" class="btn text-white btn-block text-fs-15" style="background-color: #A68A64; width: 100%; padding-right: 0.25rem; padding-left: 0.25rem;"
				onclick="location.href='../guest/officeRentalListPage'"><i class="bi bi-card-list text-white"></i><br>예약목록</button>
	    	</div>
	    	<div class="col pl-1 pr-1">
	    		<button type="button" class="btn text-white btn-block text-fs-15" style="background-color: #A68A64; width: 100%;"
				onclick="location.href='../board/myCouponPage'"><i class="bi bi-ticket-perforated text-white"></i><br>쿠폰함</button>
	    	</div>
	    	<div class="col pl-1">
	    		<button type="button" class="btn text-white btn-block text-fs-15" style="background-color: #A68A64; width: 100%;"
				onclick="location.href='../member/messageListPage'"><i class="bi bi-envelope text-white"></i><br>쪽지함</button>
	    	</div>
	    </div>
    </c:if>
    
    <div class="row mt-4 mb-3">
    	<div class="col cursor-pointer text-fs-16" style="font-weight: bold; color: #333"><i class="bi bi-building"></i> 오피스</div>
    </div>
    <div class="row mt-1 ms-1">
    	<div class="col cursor-pointer text-fs-16" onclick="location.href='../guest/officeListPage'">오피스 목록</div>
    </div>
	<div class="row mt-1 ms-1">
		<div class="col cursor-pointer text-fs-16" onclick="location.href='../guest/officeMapPage'">오피스 검색</div>
	</div>
	<c:if test="${!empty sessionUser }">
		<div class="row mt-1 ms-1">
			<div class="col cursor-pointer text-fs-16" onclick="location.href='../board/couponListPage'">오피스 쿠폰</div>
		</div>			
	</c:if>
	
	<c:if test="${!empty sessionUser }">
		<div class="row mt-4 mb-3">
	    	<div class="col cursor-pointer text-fs-16" style="font-weight: bold; color: #333"><i class="bi bi-person"></i> 호스트</div>
	    </div>
		<c:choose>
			<c:when test="${!empty sessionUser && sessionUser.member_type == 'G' }">
				<div class="row mt-1 ms-1">
					<div class="col cursor-pointer text-fs-16" onclick="location.href='../guest/applyHostPage'">호스트 신청하기</div>
				</div>		
			</c:when>
			<c:when test="${!empty sessionUser && sessionUser.member_type == 'H' }">
				<div class="row mt-1 ms-1">
					<div class="col cursor-pointer text-fs-16" onclick="location.href='../host/mainPage'">호스트 페이지</div>
				</div>
				<div class="row mt-1 ms-1">
					<div class="col cursor-pointer text-fs-16" onclick="location.href='../host/registerOfficePage'">오피스 등록하기</div>
				</div>
				<div class="row mt-1 ms-1">
					<div class="col cursor-pointer text-fs-16" onclick="location.href='../host/officeListPage'">오피스 등록 현황</div>
				</div>
				<div class="row mt-1 ms-1">
					<div class="col cursor-pointer text-fs-16" onclick="location.href='../host/rentalStatusPage'">오피스 예약 관리</div>
				</div>
			</c:when>
		</c:choose>
		
	</c:if>
	
	<div class="row mt-4 mb-3">
    	<div class="col cursor-pointer text-fs-16" style="font-weight: bold; color: #333"><i class="bi bi-telephone"></i> 고객센터</div>
    </div>
	<div class="row mt-1 ms-1">
		<div class="col cursor-pointer text-fs-16" onclick="location.href='../board/freeBoardPage'">자유게시판</div>
	</div> 
   	<div class="row mt-1 ms-1">
		<div class="col cursor-pointer text-fs-16" onclick="location.href='../board/QnAPage'">Q&A</div>
	</div> 
  
  </div>
</div>

<!-- 하단 알림박스 -->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 999999;">
	<div id="liveToast" class="toast" style="background: #adb5bd" role="alert" aria-live="assertive" aria-atomic="true" onclick="location.href='../member/messageListPage'">
		<div id="notification" class="toast-body" style="color: white;"></div>
	</div>
</div>

<script>
	
	
var newMessageCount = 0;
var firstCheckMessage = true;

var toastLiveExample = document.getElementById('liveToast');

function newMessage(){

	var xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			var data = JSON.parse(xhr.responseText);
			var toast = new bootstrap.Toast(toastLiveExample);
			var notification = document.getElementById('notification');
			
			var menus = document.getElementsByClassName("menu");
			
			
			if(data.result == 'newMessage') {


				if(newMessageCount < data.count){

					for(var menu of menus) {
						menu.innerHTML = "";
					}
					
    				newMessageCount = data.count;

					for(var menu of menus) {
					var signal = document.createElement("span");
					signal.setAttribute("class","translate-middle badge rounded-pill bg-danger");
					signal.setAttribute("style","position:absolute; font-size: 0.75rem; top: 1.5rem;");
					signal.textContent = data.count;
					
					if(!menu.classList.contains("bi-bell-fill")) {
						signal.style.top = "1.1rem";
					}
					
					menu.appendChild(signal);
					}
					notification.textContent = "새로운 알림이 " + data.count + "개 있습니다";
					
					if(!firstCheckMessage){
						toast.show();	
					}

				}
				
			}
			
			firstCheckMessage = false;

		} 
		
	};
	
	xhr.open("GET" , "../member/newMessage", true);
	xhr.send();
}
 
window.addEventListener("DOMContentLoaded" , function(){
	newMessage();
	setInterval(newMessage , 3000);
});

</script>