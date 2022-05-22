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

<div class="row" style="padding-top: 2em;">
	<div class="col" style="margin:2rem">
		<%-- 내용작성 --%>
		<div class="row">
			<form action="./fixQnAProcess" method="get">
			<div class="col">
				<h4 class="text-center">글수정페이지</h4>
			</div>
				<div class="row">
					<div class="col">
						제목  <input type="text" class="form-control" name="qna_title" value="${data.QnAVo.qna_title }">
					</div>	
				</div>	
				 
				<div class="row">
					<div class="col">
						작성자 <div>${sessionUser.member_nick }</div>
					</div>
				</div>
				 
				<hr>			
				<div class="row">
					<div class="col">
						내용  <textarea class="form-control" rows="5" name="qna_content">${data.QnAVo.qna_content }</textarea>
					</div>
				</div>
				
				<div class="row">
					<div class="col">
						<input type="hidden" name="qna_no" value="${data.QnAVo.qna_no }">
						<input type="submit" style="background-color: rgb(58,208,171);" class="float-end btn btn-light" value="글수정" onclick="test1()">
						<a style="background-color: rgb(58,208,171);" class="float-end btn btn-light" href="./QnAPage">목록</a>							
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