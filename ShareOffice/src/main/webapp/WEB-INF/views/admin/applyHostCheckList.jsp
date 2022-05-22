<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!DOCTYPE html>
<%
	String strReferer = request.getHeader("referer");

if (strReferer == null) {
%>
<script language="javascript">
  alert("정상적인 경로를 통해 다시 접근해 주세요.");
  document.location.href="loginAdmin";
 </script>
<%
	return;
}
%>

<script>
	function refuseEvent(host_no)
	{		
		var refuseReason = prompt("거절 사유를 입력해주세요.");
		
		if(refuseReason != null)
		{
			location.href="./hostRefuseGuest?refuseReason=" + refuseReason + "&host_no=" + host_no;
		}
	}

</script>

<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>호스트 신청 목록</title>
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
				</td>
				<button type="button" class="btn btn-secondary"
					onclick="location.href='hostManagement'">호스트 회원 목록</button>
				</td>
				<h5 class="card-title text-center mt-4">호스트 신청 현황</h5>
				<c:forEach items="${hostCheckList }" var="list">
					<div class="card-body text-left">
						<p class="card-text">대표자명 :${list.checkHost.host_owner}</p>
						<p class="card-text">상호명 :${list.checkHost.host_name}</p>
						<p class="card-text">사업자 번호
							:${list.checkHost.host_license_number}</p>
						<!-- <i class="bi bi-file-earmark" onclick="licenseImg()"></i>-->
						<p class="card-text">호스트 신청일
							:${list.checykHost.host_apply_date}</p>
						<button type="button" class="btn btn-secondary"
							onclick="if (confirm('승인하시겠습니까?')) location.href='./hostApplyGuest?member_no=${list.checkHost.member_no }&host_no=${list.checkHost.host_no }';">승인</button>
						<button type="button" class="btn btn-secondary"
							onclick="refuseEvent(${list.checkHost.host_no })">거절</button>
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