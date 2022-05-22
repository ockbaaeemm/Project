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

<div class="row" style="padding-top: 2em; padding-bottom: 2em;">
	<div class="col" style="margin-left:1rem; margin-right:1rem;">
		<%-- 내용작성 --%>
			<div class="row">
				<form action="./QnAWriteProcess" method="get">
				<div class="col mb-4">
						<div class="text-center text-fs-23 bold"><i class="bi bi-pencil-square"></i> 글 작성</div>
				</div>
				
				<div class="row">
					<div class="col">
						<div class="inline-block">작성자</div>
						<div class="inline-block pl-3 bold">${sessionUser.member_nick }</div>
					</div>
				</div>
			
				<div class="row mt-2">
					<div class="col">
						<!-- 
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="qna_screct" value="Y" checked>
							<label class="form-check-label">공개</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="qna_screct" value="N">
							<label class="form-check-label">비공개</label>
						</div>
	
						 -->
						<!-- 
						<input type="radio" class="btn-check" name="options-outlined" id="success-outlined" autocomplete="off" checked>
						<label class="btn btn-outline-success" for="success-outlined">공개</label>
						
						<input type="radio" class="btn-check" name="options-outlined" id="danger-outlined" autocomplete="off">
						<label class="btn btn-outline-secondary" for="danger-outlined">비공개</label>
						 --> 
						<input type="radio" name="qna_screct" value="Y" class="form-check-input" checked /><span>공개</span>&nbsp;&nbsp;&nbsp;&nbsp;
   						<input type="radio" name="qna_screct" value="N" class="form-check-input" /><span>비공개</span>&nbsp;
					</div>
				</div>
				
			
				  
				<div class="row mt-2">
					<div class="col mt-1">
						<input type="text" class="form-control" name="qna_title" placeholder="제목을 입력해 주세요.">
					</div>	
				</div>	
				 
				<hr>			
				<div class="row">
					<div class="col">
						 <textarea class="form-control" rows="5" name="qna_content" placeholder="내용을 작성해 주세요."></textarea>
					</div>
				</div>
				
				<div class="row">
					<div class="col d-grid mt-2">
					<button type="submit" style="background-color: #A68A64; color: white;" class="btn btn-light btn-block text-fs-16">
					<i class="bi bi-pencil-square"></i> 글 작성</button>
						</div>
					</div>
				</form>
			</div>
		</div>
</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>