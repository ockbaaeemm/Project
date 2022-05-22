<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<link href="../resources/css/commons.css" rel="stylesheet">

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
	#bgColor {
		background-color: #3ad0ab;
	}
</style>


<title>Insert title here</title>
</head>
<body>
<div class="container-fluid px-0" style="overflow-x : hidden">
<jsp:include page="../commons/navbar.jsp"></jsp:include>

<div class="row" style="padding-top: 2em; padding-bottom: 2em;">
	<div class="col" style="margin-left: 1rem; margin-right: 1rem;">
	<%-- 내용작성 --%>
		<div class="row">
			<form action="./freeBoardWriteProcess" method="get">
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
					<input type="text" class="form-control" name="freeboard_title" placeholder="제목을 입력해 주세요.">
				</div>
			</div>
				
				<hr>
			
			<div class="row">
					<div class="col" style="margin-bottom: 1rem;">
						<textarea class="form-control" rows="5" name="freeboard_content" placeholder="내용을 입력해 주세요."></textarea>
					</div>
			</div>

				<%--
				<div class="row">
					<div class="col">
						<input type="file" accept="image/*" class="form-control" multiple name="" aria-describedby="inputGroupFileAddon03" aria-label="Upload">
					</div>
				</div>
				 --%> 
				<div class="row">
					<div class="col" style="margin-bottom: 1rem;">
						<button type="submit" style="background-color: #A68A64; color: white; width: 100%;" class="btn btn-light btn-block text-fs-16"><i class="bi bi-pencil-square"></i> 글 작성</button>					
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

	
