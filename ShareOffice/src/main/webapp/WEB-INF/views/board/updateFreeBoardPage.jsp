<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1, shrink-to-fit=no">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="../resources/css/commons.css" rel="stylesheet">

<script>
	function test1(){
		alert("글수정이 완료 되었습니다");
	}
</script>

</head>
<body>
<div class="container-fluid px-0" style="overflow-x : hidden">
<jsp:include page="../commons/navbar.jsp"></jsp:include>

<div class="row" style="padding-top: 2em; padding-bottom: 2em;">
	<div class="col" style="margin-left: 1rem; margin-right: 1rem;">
		<%-- 내용작성 --%>
		<div class="row">
			<form action="./updateFreeBoardProcess" method="get">
			<div class="row">
					<div class="col text-fs-23 text-center mb-4 bold"><i class="bi bi-pencil-square"></i> 글 수정</div>
			</div>
			<div class="col text-fs-13" style="text-align: right; margin-bottom: 0.3rem;">
				No. ${data.freeBoardVo.freeboard_no}
			</div>
				<div class="row">
					<div class="col">
						<input type="text" class="form-control text-fs-20" name="freeboard_title" value="${data.freeBoardVo.freeboard_title }">
					</div>	
				</div>	
				 
				<div class="row" style="margin-top: 1rem;">
					<div class="col text-fs-16">
						<span>작성자</span>
						<span class="inline-block pl-3 bold">${data.memberVo.member_nick }</span> 
					</div>
				</div>
				 
				<hr style="margin-top: 0.5rem;">			
				<div class="row">
					<div class="col">
						<textarea class="form-control text-fs-16" rows="5" name="freeboard_content">${data.freeBoardVo.freeboard_content }</textarea>
					</div>
				</div>
				
				<div class="row" style="margin-top: 1em;">
					<div class="col" style="margin-bottom: 1rem;">
						<input type="hidden" name="freeboard_no" value="${data.freeBoardVo.freeboard_no }">
						<%-- 수정 (세션정보랑 작성자 닉이랑 같은지 비교 해야함)
						<c:if test="${!empty sessionUser && sessionUser.member_nick == data.memberVo.member_nick}">
						</c:if>
						 --%> 
						<button onclick="test1()" type="submit" style="background-color: #A68A64; color: white; width: 100%;" class="btn btn-light btn-block text-fs-16"><i class="bi bi-pencil-square"></i> 글 수정</button>						
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