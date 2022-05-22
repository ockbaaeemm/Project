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

</head>
<body>
<div class="container-fluid px-0" style="overflow-x : hidden">
<jsp:include page="../commons/navbar.jsp"></jsp:include>

<div class="row mb-5" style="padding-top: 5rem;">
	<div class="col">		
			<div class="row">
				<div class="col"></div>
				<div class="col-7 text-center text-fs-23 fw-bold">
					<div>회원가입을</div>
					<div>축하드립니다</div>
				</div>
				<div class="col"></div>
			</div>
			<div class="row mt-5">
				<div class="col"></div>
				<div class="col-7 text-center text-fs-16">
					<div>로그인하여 서비스이용이</div>
					<div>가능합니다.</div>
				</div>
				<div class="col"></div>
			</div>		
			<div class="row mt-4 mb-5">
				<div class="col"></div>
				<div class="col-4 d-grid">
					<input type="submit" value="로그인하기" class="btn btn-light" onClick="window.location.href='./loginPage'">
				</div>
				<div class="col"></div>
			</div>			
	</div>
</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>