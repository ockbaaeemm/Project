<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	function refuseEvent(office_no)
	{		
		var refuseReason = prompt("거절 사유를 입력해주세요.");
		
		if(refuseReason != null)
		{
			location.href="./officeRefuse?refuseReason=" + refuseReason + "&office_no=" + office_no;
		}
	}

</script>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>오피스 상세</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="../resources/css/commons.css" rel="stylesheet">

</head>
<body>
	<jsp:include page="../commons/navbar.jsp"></jsp:include>
	<div class="row" style="padding-top: 5em;">
		<div class="col">
			<div class="card" style="margin: 1em">
				<button type="button" class="btn btn-secondary"
					onclick="location.href='adminPage'">메인 페이지</button>
					<button type="button" class="btn btn-secondary"
					onclick="location.href='officeManagement'">오피스 현황 페이지</button>
				</td>
				<h5 class="card-title text-center mt-4">오피스 현황</h5>
				<c:forEach items="${officeDetailList }" var="list">
					<div class="card-body text-left">
						<p class="card-text">오피스 번호 :${list.getOfficeVo.office_no}</p>
						<p class="card-text">오피스 이름 :${list.getOfficeVo.office_name}</p>
						<p class="card-text">간략 설명 :${list.getOfficeVo.office_simpleContent}</p>
						<p class="card-text">상세 설명 :${list.getOfficeVo.office_detailContent}</p>
						<p class="card-text">사용 인원 :${list.getOfficeVo.office_personnel}</p>
						<p class="card-text">태그 :${list.getOfficeVo.office_tags}</p>
						<p class="card-text">주소 :${list.getOfficeVo.office_address} ${list.getOffice.office_address_detail}</p>
						<p class="card-text">담당자 전화번호 (가상번호) :${list.getOfficeVo.office_managerPhone} ( ${list.getOfficeVo.office_changedPhone} )</p>
						<p class="card-text">최소 예약일 :${list.getOfficeVo.office_min_booking_day}</p>
						<button type="button" class="btn btn-secondary"
							onclick="if (confirm('승인하시겠습니까?')) location.href='./officeApply?office_no=${list.getOfficeVo.office_no }';">승인</button>
						<button type="button" class="btn btn-secondary"
							onclick="refuseEvent(${list.getOfficeVo.office_no })">거절</button>
					</div>
				</c:forEach>
			
			</div>
		</div>
	</div>	

	<jsp:include page="../commons/footer.jsp"></jsp:include>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
</body>
</html>