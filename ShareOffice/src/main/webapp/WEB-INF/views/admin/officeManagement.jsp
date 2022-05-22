<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<%
	String strReferer = request.getHeader("referer");

if (strReferer == null) {
%>
<script language="javascript">
	alert("정상적인 경로를 통해 다시 접근해 주세요.");
	document.location.href = "loginAdmin";
</script>
<%
	return;
}
%>

<script>
	function refuseEvent(office_no, member_no)
	{		
		var refuseReason = prompt("거절 사유를 입력해주세요.");
		
		if(refuseReason != null)
		{
			location.href="./officeRefuse?refuseReason=" + refuseReason + "&office_no=" + office_no + "&member_no=" + member_no;
		}
	}

</script>


<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>오피스 관리 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="../resources/css/commons.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid px-0" style="overflow-x : hidden">
	<jsp:include page="../commons/admin.jsp"></jsp:include>
	<div class="row" style="padding-top: 5em; padding-bottom: 5em; padding-left: 5em; padding-right: 5em;">
	<div class="col">
		<h1>오피스관리</h1>
		<form action="./officeManagement" method="get">
		<div class="row mb-3">
			<div class="col">
				<select name="searchOption" class="form-select">
					<option value="number">번호</option>
					<option value="officename">오피스 이름</option>
					<option value="approve">승인 여부</option>
				</select>
			</div>
			<div class="col-8">
				<input name="searchStr" type="text" class="form-control">
			</div>
			<div class="col d-grid">
				<input type="submit" value="검색" class="btn btn-dark">
			</div>
		</div>
		</form>
		
		<!--  <c:forEach items="${officeList }" var="list">
			<div class="card">
		    	<div class="card-body text-left">
		    		<img src="/soUpload/officeImage/${list.getOffice.office_thumbnail }" width=100%, height=300em alt="">
		    		
		    		
		    		
		    		
		    		
		    		<div id="carouselExampleDark" class="carousel carousel-dark slide" data-bs-ride="carousel">
  						<div class="carousel-inner">
  							<c:set var="count" value="0"/>
		    				<c:forEach items="${list.imageDetailList }" var="imgList" varStatus="imgStatus">
									 	<div class="carousel-item">
									 		<img src="/soUpload/officeImage/${imgList.image_url }" width=100%, height=300em alt="">
									 	</div>
							</c:forEach>
						</div>	
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
					<p class="card-text">오피스 번호 :${list.getOffice.office_no}</p> 
					<p class="card-text">오피스 이름 :${list.getOffice.office_name}</p>
					<p class="card-text">간략 설명 :${list.getOffice.office_simpleContent}</p>
					<p class="card-text">상세 설명 :${list.getOffice.office_detailContent}</p>
					<p class="card-text">사용 인원 :${list.getOffice.office_personnel}</p>
					<p class="card-text">태그 :${list.getOffice.office_tags}</p>
					<p class="card-text">주소 :${list.getOffice.office_address} ${list.getOffice.office_address_detail}</p>
					<p class="card-text">담당자 전화번호 (가상번호) :${list.getOffice.office_managerPhone} ( ${list.getOffice.office_changedPhone} )</p>
					<p class="card-text">최소 예약일 :${list.getOfficeVo.office_min_booking_day}</p>
					<p class="card-text">승인 여부 :${list.getOffice.office_approve}</p>
					<c:if test = "${list.getOffice.office_approve == 'N'}">  
						<p class="card-text">거절 사유 :${list.getOffice.office_approve_comment}</p>
					</c:if>
					<c:if test = "${list.getOffice.office_approve != 'P'}">
						<p class="card=text">승인 / 거절 날짜 :<fmt:formatDate value="${list.getOffice.office_approve_date}" pattern="yy-MM-dd"/></p>
					</c:if>
					<c:choose>
						<c:when test = "${list.getOffice.office_approve == 'P'}">
							<button type="button" class="btn btn-secondary" onclick="if (confirm('승인하시겠습니까?')) location.href='./officeApply?office_no=${list.getOffice.office_no }&member_no=${list.getOffice.member_no }';">승인</button>
							<button type="button" class="btn btn-secondary" onclick="refuseEvent(${list.getOffice.office_no }, ${list.getOffice.member_no })">거절</button>
						</c:when>
					</c:choose>
				</div>
			</div>
		</c:forEach> -->
		
		<c:forEach items="${officeList }" var="list">
			<div class="row shadow-sm bg-body rounded" style="border: solid 0.1rem; border-radius: 0.4rem; border-color: #dee2e6; margin-bottom: 1rem;">
				<div class="col-4 m-3">
					<div class="row">
						<div class="col text-center" style="border: solid 0.1rem; border-color: #dee2e6; height: 25em;">
							<img style="width:100%; height:100%" src="/soUpload/officeImage/${list.getOffice.office_thumbnail }"><br>
						</div>
					</div>
					<div class="row text-center">
						<c:forEach items="${list.imageDetailList }" var="imgList">
							<div class="col pt-3" style="text-align: center;">
								<%-- <div style=" border: solid 0.1rem; border-color: #dee2e6; margin: auto;  padding: 0; text-align: center;"><img src="/soUpload/officeImage/${imgList.image_url }" class="img-fluid">--%>
								<div style="width: 7.5em; height:5em; border: solid 0.1rem; border-color: #dee2e6; margin: auto;  padding: 0; text-align: center;"><img src="/soUpload/officeImage/${imgList.image_url }" style="width: 100%; height:100%;">
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="col m-3">
					<div>No. ${list.getOffice.office_no}</div> 
					<div class="text-fs-40 mb-4">${list.getOffice.office_name}</div>
					<div class="text-fs-30">${list.getOffice.office_simpleContent}</div>
					<div class="text-fs-20 mb-4">상세 설명 :${list.getOffice.office_detailContent}</div>
					<div class="text-fs-16 mb-2">사용 인원 :${list.getOffice.office_personnel}</div>
					<div class="text-fs-16 mb-2">#${list.getOffice.office_tags}</div>
					<div class="text-fs-16 mb-2">주소 :${list.getOffice.office_address} ${list.getOffice.office_address_detail}</div>
					<div class="text-fs-16 mb-2">담당자 전화번호 (가상번호) :${list.getOffice.office_managerPhone} ( ${list.getOffice.office_changedPhone} )</div>
					<div class="text-fs-16 mb-2">최소 예약일 :${list.getOffice.office_min_booking_day}</div>
					<div class="text-fs-16 mb-2">승인 여부 :${list.getOffice.office_approve}</div>
					<c:if test = "${list.getOffice.office_approve == 'N'}">  
						<div class="text-fs-16 mb-2">거절 사유 :${list.getOffice.office_approve_comment}</div>
					</c:if>
					<c:if test = "${list.getOffice.office_approve != 'P'}">
						<div class="text-fs-16 mb-2">승인 / 거절 날짜 :<fmt:formatDate value="${list.getOffice.office_approve_date}" pattern="yy-MM-dd"/></div>
					</c:if>
					<c:choose>
						<c:when test = "${list.getOffice.office_approve == 'P'}">
							<button type="button" class="btn btn-secondary" onclick="if (confirm('승인하시겠습니까?')) location.href='./officeApply?office_no=${list.getOffice.office_no }&member_no=${list.getOffice.member_no }';">승인</button>
							<button type="button" class="btn btn-secondary" onclick="refuseEvent(${list.getOffice.office_no }, ${list.getOffice.member_no })">거절</button>
						</c:when>
					</c:choose>
				</div>
			</div>
		</c:forEach>
		
	</div>
	</div>

	<jsp:include page="../commons/footer.jsp"></jsp:include>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
</body>
</html>
			    