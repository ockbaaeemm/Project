<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>관리자 로그인</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="../resources/css/commons.css" rel="stylesheet">

<head>
<meta charset="UTF-8">
<title>관리자 로그인</title>
</head>
<body>
<div style="width:1925px; margin:0 auto">
<jsp:include page="../commons/admin.jsp"></jsp:include>

<div class="row" style="padding-top: 7em; margin-bottom: 7rem">
	<div class="col-4"></div>
	<div class="col bg-gray-c_e1 rounded-10 py-11 px-30 ms-3 me-3" style="padding-bottom:5rem">
		<h1 class="text-center mb-5">관리자 로그인</h1>
		<form action="./adminLoginProcess" method="post">
			<div class="row">
				<div class="col input-group">
					<div class="input-group-text bg-gray-c_ff bold text-gray-c_3c"><i class="bi bi-unlock"></i></div>
					<input class="form-control" type="password" name="admin_pw" placeholder="관리자 비밀번호를 입력해주세요"><br>	
				</div>
			</div>
			<div class="row mt-4">
				<div class="col d-grid"><input class="btn btn-dark" type="submit" value="로그인"></div>
			</div>			
		</form>		
	</div>
	<div class="col-4"></div>
</div>
</div>
<jsp:include page="../commons/footer.jsp"></jsp:include>
</body>
</html>