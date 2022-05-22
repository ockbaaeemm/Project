<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>받은 쪽지함</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="../resources/css/commons.css" rel="stylesheet">
	
	<style>
	
		#message{
			border-radius: 0.3rem 0rem 0rem 0.3rem; 
			background-color:#BBA586; 
			color: white; 
			text-align: center; 
			padding-top: 0.75rem; 
			padding-bottom: 0.75rem;
		}
		
		#sendMessage{
			border-radius: 0rem 0.3rem 0.3rem 0rem; 
			background-color:#A68A64; 
			color: white; text-align: center; 
			padding-top: 0.75rem; 
			padding-bottom: 0.75rem;
		}
		
	</style>
	
</head>
<body>
<div class="container-fluid px-0" style="overflow-x : hidden">
<jsp:include page="../commons/navbar.jsp"></jsp:include>

<div class="row" style="padding-top: 2em; padding-bottom: 2em;">
	<div class="col">
		<div class="row text-fs-16" style="margin-left: 1rem; margin-right: 1rem; margin-bottom: 1rem;">
			<div class="col bold" id="message" onclick="location.href='../member/messageListPage'">
				<i class="bi bi-mailbox"></i> 쪽지보관함
			</div>
			<div class="col bold" id="sendMessage" onclick="location.href='../member/sendMessageListPage'">
				<i class="bi bi-mailbox2"></i> 보낸쪽지함
			</div>
		</div>
			<c:forEach items="${datalist }" var="data">
					<div class="card shadow-sm bg-body rounded" style="width: auto; margin: 1rem;">
					  <div class="card-body" style="background-color: #f8f9fa;">
					    <p class="card-title text-fs-16" style="font-weight: bold;">
					    	${sessionUser.member_nick} <i class="bi bi-caret-right"></i> ${data.memberVo.member_nick }
					    	<a href="./deleteSendMessage?message_no=${data.messageVo.message_no }" style="color: black;">
								<i class="bi bi-trash3 float-right" style="font-size: 1.1rem;"></i>
							</a>
					    </p>
					    <p class="card-text text-fs-16">${data.messageVo.txt }</p>
					  </div>
					</div>
			</c:forEach>
			<c:if test="${empty datalist}">
				<div class="row">
					<div class="col text-fs-23"style="text-align: center; padding-top: 8rem; padding-bottom: 13rem;">
					<i class="bi bi-envelope-slash"></i><br>
					보낸 쪽지가 없습니다.</div>
				</div>
			</c:if>
			<div class="fixed " style="bottom: 4rem; right: 3rem; z-index: 99">
				<a href="./writeMessagePage"><i class="bi bi-plus-circle-fill" style="font-size: 3.5rem; color: #A68A64"></i></a>
			</div>
	</div>
</div>
<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>