<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>호스트/공유오피스목록</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="../resources/css/commons.css" rel="stylesheet">
<link href="https://webfontworld.github.io/naver/NanumSquareRound.css" rel="stylesheet">
<style>
i {text-decoration: none; color:#A68A64;}
	
	#registerButton{
			border-radius: 0.3rem 0.3rem 0.3rem 0.3rem; 
			text-align: center; 
			padding-top: 0.3rem; 
			padding-bottom: 0.3rem;
	}

</style>
<script>
function getOfficeList(select) {
	
	var office_approve =  select.value;
	location.href="./officeListPage?office_approve=" + office_approve;
}

function goReview(event, office_no){
	
	event.stopPropagation();
	location.href="../guest/officeReviewPage?office_no=" + office_no;
}

function createOption() {
	var root = document.querySelector("#selectContainer");

 	var select = document.createElement("select");
 	select.setAttribute("name", "office_approve");
 	select.setAttribute("class", "form-select form-select-sm text-fs-12");
 	select.setAttribute("onchange", "getOfficeList(this)");
	var optionList = [];	
	var option1 = document.createElement("option");
	option1.value = "all";
	option1.innerText = "전체";
	optionList.push(option1);
	var option2 = document.createElement("option");
	option2.value = "Y";
	option2.innerText = "승인완료";
	optionList.push(option2);
	var option3 = document.createElement("option");
	option3.value = "P";
	option3.innerText = "승인대기";
	optionList.push(option3);
	var option4 = document.createElement("option");
	option4.value = "N";
	option4.innerText = "승인거절";
	optionList.push(option4);
	
	var office_approve = '${office_approve}';
	
	for(var option of optionList) {
		if(option.value == office_approve) {
			option.selected = true;
		}
		select.appendChild(option);
	}
	
	root.appendChild(select);
}

window.addEventListener("DOMContentLoaded", function() {
	createOption();
});

</script>

</head>
<body>
<div class="container-fluid px-0" style="overflow-x : hidden">
<jsp:include page="../commons/navbar.jsp"></jsp:include>

<div class="row ms-1" style="padding-top: 2rem; padding-bottom:2.75rem;">
	<div class="col">
		<%-- 내용작성 --%>
 	<div class="row">
		<div class="col text-center">
			<div class="text-fs-23 bold">공유오피스 리스트</div>
			<p class="text-fs-14 text-gray-c_25 mt-1">등록하신 공유오피스 목록입니다.</p>
		</div>
	</div>
					
		
 		<div class="row mt-4">
 			<div class="col"></div>
 			<div id="selectContainer" class="col-4 mr-5" >
 		
 			</div>
		</div>


			<div class="row mt-1 mb-5 ms-1 me-1">
				<div class="col">
					<c:forEach items="${officeList }" var="office">
						<div class="row cursor-pointer rounded-10 border py-3 mr-1 mt-2" onclick="location.href='./officeDetailPage?office_no=${office.office_no}'">
						<div class="col-4">
						 <img src="/soUpload/officeImage/${office.office_thumbnail }" style="width:100%; height:100%;">
						</div>
						
						<div class="col-8">
						
						<div class="row">
						<div class="col bold">
						${office.office_name}
						</div>
						<c:if test="${office.office_approve eq 'Y' }">
						<div class="col-4 text-right text-fs-13" onclick="goReview(event,${office.office_no})">
						<i class="bi bi-star-fill" style="color:#EDB867;"></i>리뷰
						</div>
						</c:if>
						</div>

						
						<div class="row mt-2"> 
						<div class="col text-fs-13 relative">
						<c:choose>
							<c:when test="${office.office_approve eq 'P' }">
								<i class="bi bi-hourglass-split text-gold text-fs-15 absolute" style="top:-5%; left:8%"></i> 
								<span class="ms-4">승인대기중</span>
							</c:when> 
							
							<c:when test="${office.office_approve eq 'Y' }">
								<i class="bi bi-check text-green-soft text-fs-19 absolute" style="top:-25%; left:8%"></i>
								<span class="ms-4">승인완료</span>
							</c:when>
							 
							<c:otherwise>
								<i class="bi bi-x-octagon text-red-soft text-fs-15 absolute" style="top:-3%; left:8%"></i> 
								<span class="ms-4 text-red-soft" >승인거절</span>
							 	<div class="text-fs-12 text-muted">${office.office_approve_comment }</div> 
							</c:otherwise>
						</c:choose>
						</div>
						</div>
						
						
						</div>
						
						</div>
					</c:forEach>
				</div>
			</div>
			
				<div class="gap-1 me-4" align="right">
					  <button type="button" id="registerButton" class="btn btn-outline-gold" onclick="location.href='../host/registerOfficePage'">오피스 등록</button>
				</div>
	</div>
</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>