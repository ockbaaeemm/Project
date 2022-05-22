<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1, shrink-to-fit=no">
<title>쪽지 보내기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="../resources/css/commons.css" rel="stylesheet">

<script>

 var isConfirmed = false;
 
 function goData() {
	 
	 if(isConfirmed == false){
			alert("존재하지 않는 닉네임 입니다.");
			$("inputNick").val("");
			return;
		}
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
 

 function confirmId(){

 	var idBox = document.getElementById("inputNick");
 	var idValue = idBox.value;
 	
 	var xhr = new XMLHttpRequest();
 	
 	xhr.onreadystatechange = function(){
 		if(xhr.readyState == 4 && xhr.status == 200){
 			var data = JSON.parse(xhr.responseText);
 			
 			var confirmAlertBox = document.getElementById("confirmAlertBox");
 			if(data.result == 'notNick'){
 				isConfirmed = false;
 				confirmAlertBox.innerText = "존재하지 않는 닉네임 입니다.";
 				confirmAlertBox.setAttribute("style","margin-left: 1rem; font-size: 0.813rem; color: red; padding-top: 0.5rem;");
 			}else{
 				isConfirmed = true;
 				confirmAlertBox.innerHTML = "";
 				confirmAlertBox.setAttribute("style","padding-top: 0rem;");
 			}
 			
 		}
 		
 	};
 	
 	
 	xhr.open("GET" , "./checkNick?nick=" + idValue , true);
 	xhr.send();
 	
 }
</script>

	<style>
	
		#writeMessage{
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
			<div class="col text-fs-23 mb-4 bold" style="text-align: center;"><i class="bi bi-envelope-paper"></i> 쪽지보내기</div>
		</div>
		
		<form action="./writeMessageProcess" class="form text-fs-16" role="form" name="userInput">
			<div class="row">
				<div class="col" style="margin-left: 1rem; margin-bottom: 0.5rem;">
					<div class="inline-block">작성자</div>
					<div class="inline-block pl-3 bold">${sessionUser.member_nick }</div>
				</div>
				<div class="col" style="text-align: right; margin-right: 1rem; font-size: 1.4rem;">
					<i class="bi bi-x-lg" onclick="goList();"></i>
				</div>  
			</div>
			<div style="margin-left: 1rem; margin-right: 1rem;">
			  <input type="text" id="inputNick" onblur="confirmId()" class="form-control" placeholder="받는 사람 닉네임을 입력해 주세요." name="nick">
			</div>
			<div id="confirmAlertBox"></div>
    		<hr style="margin-left: 1rem; margin-right: 1rem;">
			<div class="mb-3" style="margin: 1rem;">
			   <textarea class="form-control" id="exampleFormControlTextarea1" rows="5" name="txt" placeholder="내용을 입력해 주세요."></textarea>
			</div>
			<div class="row" style="margin-left: 1rem; margin-right: 1rem; margin-bottom: 1rem;">
				<div class="col text-fs-16" id="writeMessage" onclick="goData();"><i class="bi bi-send"></i> 쪽지보내기</div>
			</div>
		</form>
	</div>
</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>