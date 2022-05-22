<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>호스트 메인페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commons.css">
<link rel="stylesheet" href="../resources/css/style.css">

<style>

</style>

</head>
<body>

<div class="container-fluid px-0" style="overflow-x : hidden">


<jsp:include page="../commons/main.jsp"></jsp:include>

<%-- <div class="row" style="padding-top: 3rem;">
	<div class="col" style="background-image: url('../resources/img/office.jpg'); background-position: center; height: 14rem; background-size: cover; margin: auto;">
		<button type="button" class="btn text-white" style="background-color: #A68A64; float: right; margin-top: 11rem; margin-right: 1rem; font-size: 0.8rem;" onclick="location.href='../guest/officeListPage'">오피스 구경하러 가기</button>
	</div>
</div> --%>

<div class="row" style="padding-top: 3rem;">
	<div class="col relative" onclick="location.href='../guest/officeListPage'">
		<img src="../resources/img/office.jpg" class="img-fluid"> 
		<button type="button" class="btn text-white absolute" style="background-color: #A68A64; font-size: 0.8rem; bottom:0.75rem; right:1.5rem" >오피스 구경하러 가기</button>
	</div>
</div>


<c:choose>
	<c:when test="${empty sessionUser}">
		<div class="row" style="padding-top: 3rem; padding-bottom: 3rem;">
			<div class="col relative" onclick="location.href='../member/loginPage'">
				<img class="img-fluid" src="../resources/img/host.jpg">
					<button type="button" class="btn text-white absolute" style="background-color: #A68A64; font-size: 0.8rem; bottom:0.75rem; left:1.5rem;">
						호스트 신청하기
					</button>
			</div>
		</div>
	</c:when>

	<c:when test="${!empty sessionUser && sessionUser.member_type == 'G' }">
		<div class="row" style="padding-top: 3rem; padding-bottom: 3rem;">
			<div class="col relative" onclick="location.href='../guest/applyHostPage'">
				<img class="img-fluid" src="../resources/img/host.jpg">
					<button type="button" class="btn text-white absolute" style="background-color: #A68A64; font-size: 0.8rem; bottom:0.75rem; left:1.5rem;">
						호스트 신청하기
					</button>
			</div>
		</div>
	</c:when>

	<c:when test="${!empty sessionUser && sessionUser.member_type == 'H' }">
		<div class="row" style="padding-top: 3rem; padding-bottom: 3rem;">
			<div class="col relative" onclick="location.href='../host/mainPage'">
				<img class="img-fluid" src="../resources/img/host.jpg">
					<button type="button" class="btn text-white absolute" style="background-color: #A68A64; font-size: 0.8rem; bottom:0.75rem; left:1.5rem;">
						호스트 센터
					</button>
			</div>
		</div>
	</c:when>
</c:choose>


<jsp:include page="../commons/footer.jsp"></jsp:include>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>