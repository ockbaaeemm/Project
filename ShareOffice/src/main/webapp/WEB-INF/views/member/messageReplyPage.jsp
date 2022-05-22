<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>답장 하기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="../resources/css/commons.css" rel="stylesheet">

<script>

 function goData() {
	 var form = document.userInput
	 form.submit()
}

 function goList() {
     if (!confirm("목록으로 돌아가시겠습니까?")) {
         return;
     } else {
    	 location.href='../member/messageListPage';
     }
 }
</script>
	
	<style>
	
		#sendMessage{
			border-radius: 0.3rem 0.3rem 0.3rem 0.3rem; 
			background-color:#A68A64; 
			color: white; 
			text-align: center; 
			padding-top: 0.3rem; 
			padding-bottom: 0.3rem;
		}
	</style>
</head>
<body>
<div class="container-fluid px-0" style="overflow-x : hidden">
<jsp:include page="../commons/navbar.jsp"></jsp:include>

<div class="row" style="padding-top: 2em; padding-bottom: 2em;">
	<div class="col">
		<div class="row">
			<div class="col text-fs-23 mb-4 bold" style="text-align: center;"><i class="bi bi-reply"></i> 답장하기</div>
		</div>
		
		<form action="./replyMessageProcess" class="form text-fs-16" role="form" name="userInput">
			<div class="row">
				<div class="col" style="margin-left: 1rem; margin-bottom: 0.5rem;">
					<div class="inline-block">작성자</div>
					<div class="inline-block pl-3 bold">${sessionUser.member_nick }</div>
				</div>
				<div class="col" style="text-align: right; margin-right: 1rem; font-size: 1.4rem;">
					<i class="bi bi-x-lg" onclick="goList();"></i>
				</div>
			</div>
			<div class="row">
				<div class="col" style="margin-left: 1rem;">
					<div class="inline-block">받는 사람</div>
					<div class="inline-block pl-3 bold">${data.memberVo.member_nick }</div>
					<input type="hidden" value="${data.messageVo.sender_no }" name="receive_no">
				</div>
    		</div>
    		<hr style="margin-left: 1rem; margin-right: 1rem;">
    		<div class="mb-3" style="margin: 1rem;">
			   <textarea class="form-control" id="exampleFormControlTextarea1" rows="5" name="txt" placeholder="내용을 입력해 주세요."></textarea>
			</div>
			<div class="row" style="margin-left: 1rem; margin-right: 1rem; margin-bottom: 1rem;">
				<div class="col text-fs-16" id="sendMessage" onclick="goData()"><i class="bi bi-send"></i> 답장하기</div>
			</div>
		</form>
	</div>
</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>