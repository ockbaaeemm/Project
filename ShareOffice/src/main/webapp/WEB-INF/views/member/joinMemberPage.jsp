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

<style>
.title {width:5rem;}
</style>

<script>

const member_email = '${member_email}';

function onlyNumber(obj) {

        obj.value = obj.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');            

}

function confirmEmail() {
	var emailRegExp = /^[A-Za-z0-9+]*$/;

	
	var inputEmail = document.getElementById("inputEmail");
	
	var emailConfirmPwAlertBox = document.getElementById("emailConfirmPwAlertBox");
	
	if(!emailRegExp.test(inputEmail.value)) {
		emailConfirmPwAlertBox.innerText = "이메일 주소를 형식에 맞게 입력해주세요";
		emailConfirmPwAlertBox.style.color = "red";
		confirm_email = false;
	} else {
		emailConfirmPwAlertBox.innerText = "";
		emailConfirmPwAlertBox.style.color = "green";
		confirm_email = true;
	}
	
}


function confirmEmailDomain() {
	var domainRegExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
	var inputEmailDomain = document.getElementById("inputEmailDomain");
	
	var emailConfirmPwAlertBox = document.getElementById("emailConfirmPwAlertBox");
	
	if(!domainRegExp.test(inputEmailDomain.value)) {
		emailConfirmPwAlertBox.innerText = "이메일 도메인을 형식에 맞게 입력해주세요";
		emailConfirmPwAlertBox.style.color = "red";
		confirm_emailDomain = false;
	} else {
		emailConfirmPwAlertBox.innerText = "";
		emailConfirmPwAlertBox.style.color = "green";
		confirm_emailDomain = true;
	}
}	

function setEmailDomain(domain){
    $("#inputEmailDomain").val(domain);
    $("#emailConfirmPwAlertBox").text("");
    confirm_emailDomain = true;        
}


  	var confirm_email = false;
  	var confirm_emailDomain = false;
	
	function joinMemberValidCheck(e){
		
		e.preventDefault();
		

		//입력 유무 체크

		if($("#inputNick").val() == ""){
			alert("닉네임을 입력해주세요.");
			$("#inputNick").focus();
			return;
		}
		
		if($("#inputPhone").val() == ""){
			alert("휴대폰번호를 입력해주세요.");
			$("#inputPhone").focus();
			return;
		}
		

		if(member_email == 'undefined') {
			
			if($("#inputEmail").val() == ""){
				alert("이메일을 입력해주세요.");
				$("#inputEmail").focus();
				return;
			}
			
			if($("#inputEmailDomain").val() == ""){
				alert("이메일 도메인을 입력해주세요.");
				$("#inputEmailDomain").focus();
				return;
			}
			
			if(!confirm_email) {
				alert("이메일을 확인해주세요.");
				$("#inputEmail").focus();
				return;			
			}
			
			if(!confirm_emailDomain) {
				alert("이메일 도메인을 확인해주세요.");
				$("#inputEmailDomain").focus();
				return;			
			}
			
			var inputEmail = document.getElementById("inputEmail");
			var inputEmailDomain = document.getElementById("inputEmailDomain");		
			document.getElementsByName("member_email")[0].value = inputEmail.value + "@" + inputEmailDomain.value;	
		} else {
			document.getElementsByName("member_email")[0].value = member_email;
		}
		// 생년월일 합치기
		var inputBirth_yy = document.getElementById("inputBirth_yy");
		var inputBirth_mm = document.getElementById("inputBirth_mm");
		var inputBirth_dd = document.getElementById("inputBirth_dd");

		var month = parseInt(inputBirth_mm.value);
		var day = parseInt(inputBirth_dd.value);
		
		
		if(month == 2 && day > 28) {

			inputBirth_dd.value = "28";
		}
		else if(month%2 == 0 && day > 30) {

			inputBirth_dd.value = "30";
		}
		
		var member_birth = document.getElementsByName("member_birth")[0];
		member_birth.value = inputBirth_yy.value + "-" + inputBirth_mm.value + "-" + inputBirth_dd.value; 					
		
		var frm = document.getElementById("frm");
		
		//submit 실행
		
		frm.submit();
		
	}	
	
	function inputPhoneNumber(obj) {

		obj.value = obj.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
		
		var number = obj.value.replace(/[^0-9]/g, "");
		var phone = "";
		
		
		
		if(number.length < 4) {
		    return number;
		} else if(number.length < 7) {
		    phone += number.substr(0, 3);
		    phone += "-";
		    phone += number.substr(3);
		} else if(number.length < 11) {
		    phone += number.substr(0, 3);
		    phone += "-";
		    phone += number.substr(3, 3);
		    phone += "-";
		    phone += number.substr(6);
		} else {
		    phone += number.substr(0, 3);
		    phone += "-";
		    phone += number.substr(3, 4);
		    phone += "-";
		    phone += number.substr(7);
		}
		obj.value = phone;
	}	
	
	function createBirthSelect() {
		var now = new Date();
		var year = now.getFullYear();
		var mon = (now.getMonth() + 1) > 9 ? ''+(now.getMonth() + 1) : '0'+(now.getMonth() + 1);
		var day = (now.getDate()) > 9 ? ''+(now.getDate()) : '0'+(now.getDate()); 
		
		//년도 selectbox만들기 
		for(var i = 1900 ; i <= year ; i++) { 
			$('#inputBirth_yy').append('<option value="' + i + '">' + i + '년</option>');
		} 
		
		// 월별 selectbox 만들기 
		for(var i=1; i <= 12; i++) {
			var mm = i > 9 ? i : "0"+i ;
			$('#inputBirth_mm').append('<option value="' + mm + '">' + mm + '월</option>');
		}
		
		// 일별 selectbox 만들기
		for(var i=1; i <= 31; i++) {
			var dd = i > 9 ? i : "0"+i ;
			$('#inputBirth_dd').append('<option value="' + dd + '">' + dd+ '일</option>');
		}
		
		// 기본 값 오늘 날짜로 세팅
		$("#inputBirth_yy > option[value="+year+"]").attr("selected", "true");
		$("#inputBirth_mm > option[value="+mon+"]").attr("selected", "true");
		$("#inputBirth_dd > option[value="+day+"]").attr("selected", "true"); 
		
	}
	
	
	window.addEventListener("DOMContentLoaded" , function(){
		createBirthSelect();				
	});		

</script>

</head>
<body>
<div class="container-fluid px-0" style="overflow-x : hidden">
<jsp:include page="../commons/navbar.jsp"></jsp:include>

<div class="row" style="padding-top: 2rem;">
	<div class="col">
			<div class="row">
				<div class="col text-center text-fs-23 bold"><i class="bi bi-pencil"></i> 회원가입</div>
			</div>
			<div class="row mt-1">
				<div class="col divider"></div>
			</div>
		 	<div class="row mt-3">		 		
		 		<div class="col">
		 			<form id="frm" action="joinMemberProcess" method="post">		 			
			 			<div class="row"><!-- 닉네임 입력란 -->
			 				<div class="col-3 ms-4 pr-0 title text-fs-13">
			 					<p class="center pt-1">닉네임</p>
			 				</div>
			 				<div class="col-7 pl-0">
			 					<input type="hidden" name="member_id" value="${member_id }">
			 					<input id="inputNick" name="member_nick" type="text" class="form-control form-control-sm text-fs-13" placeholder="닉네임을 입력해주세요" value="${member_nick }">
			 				</div>
			 				<div class="col"></div>
			 			</div>
						<div class="row"><!-- 이름 입력란 -->
			 				<div class="col-3 ms-4 pr-0 title text-fs-13">
			 					<p class="center pt-2">성별</p>
			 				</div>
			 				<div class="col-4 pt-2 pl-0">
			 					<input class="form-check-input" name="member_gender" type="radio" value="M" checked> 남&nbsp;
			 					<input class="form-check-input" name="member_gender" type="radio" value="F"> 여
			 				</div>
			 			</div>		 			
			 			<div class="row"><!-- 휴대폰 입력란 -->
			 				<div class="col-3 ms-4 pr-0 title text-fs-13">
			 					<p class="center pt-1">휴대폰</p>
			 				</div>
			 				<div class="col-7 pl-0">
			 					<input id="inputPhone" type="text" name="member_phone" class="form-control form-control-sm text-fs-13" id="my_pnumber" oninput="inputPhoneNumber(this);" maxlength="13">
			 				</div>
			 			</div>		 			
			 			<div class="row mt-3"><!-- email 입력란 -->
			 				<div class="col">
			 					<div class="row">
			 						<div class="col-3 ms-4 pr-0 title text-fs-13">
					 					<p class="center pt-2">이메일</p>
					 					<input type="hidden" name="member_email">
					 				</div>
					 				<c:choose>
					 					<c:when test="${member_email == 'undefined'}">
							 				<div class="col-3 pl-0 title text-fs-11" style="padding-right:0">
							 					<input id="inputEmail" type="text" onblur="confirmEmail()" 
							 					class="form-control form-control-sm">							 					
							 				</div>
							 				<div class="center" style="width:.5rem; padding-right:.25rem; padding-left:0;padding-top:.25rem;">@</div>
							 				<div class="col-3 text-fs-11" style="padding-left:.5rem; padding-right:.25rem; width:5.5rem">
							 					<input id="inputEmailDomain" type="text" class="form-control form-control-sm" onblur="confirmEmailDomain()">
							 				</div>
							 				<div class="col-3 text-fs-11" style="padding:0; width:6rem">
							 					<select class="form-select form-select-sm pl-1 pr-0" onchange="setEmailDomain(this.value);return false;">
												    <option value="">직접입력</option>
												    <option value="naver.com">naver.com</option>
												    <option value="gmail.com">gmail.com</option>
												    <option value="daum.net">hanmail.net</option>
												    <option value="hotmail.com">hotmail.com</option>
												    <option value="korea.com">korea.com</option>
												    <option value="nate.com">nate.com</option>
												    <option value="yahoo.com">yahoo.com</option>
												</select>
							 				</div>
					 					</c:when>
					 					<c:otherwise>
					 						<div class="col">
					 							${member_email }
					 						</div>
					 					</c:otherwise>					 				
					 				</c:choose>
			 					</div>			 					
			 					<div class="row">
			 						<div class="col-2">
					 				</div>
					 				<div class="col">
					 					<div id="emailConfirmPwAlertBox" style="font-size: small;"></div>
					 				</div>
			 					</div>
			 				</div>
			 			</div>			 			
			 			<div class="row mt-3"><!-- 생년월일 -->			 			
			 				<div class="col">
			 					<div class="row">
			 						<div class="col-3 ms-4 title">
					 					<p class="center pt-2 text-fs-13">생년월일</p>
					 				</div>
					 				<div class="col-3 pl-0" style="width:6rem">			 					
					 					<select class="form-control text-fs-13" id="inputBirth_yy"></select>
										<input type="hidden" name="member_birth">
					 				</div>
					 				<div class="col-3 pl-0" style="width:6rem">
		                                <select class="form-control text-fs-13" id="inputBirth_mm"></select>
					 				</div>
					 				<div class="col-3 pl-0" style="width:6rem">
					 					<select class="form-control text-fs-13" id="inputBirth_dd"></select>
					 				</div>
			 					</div>
			 				</div>
			 			</div>			 			
			 			<div class="row mt-2"><!-- 여백 -->
			 			</div>			 			
			 			<div class="row mt-5 mb-5"> <!-- 회원가입 버튼 -->
			 				<div class="col"></div>
							<div class="col-4">
								<div class="d-grid">
									<button class="btn btn-dark" type="button" onclick="joinMemberValidCheck(event)">회원가입</button>
								</div>
							</div>
							<div class="col"></div>
						</div>
					 </form>
		 		</div>		 		 		
		 	</div>	
		
	</div>
</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>