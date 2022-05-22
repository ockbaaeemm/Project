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


	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>	
	<script>
	
	function kakaoLogin() {
 		var xhr = new XMLHttpRequest();
 		
 		xhr.onreadystatechange = function() {
 			if(xhr.readyState == 4 && xhr.status == 200) {
 				var data = JSON.parse(xhr.responseText);
 				
 				getCode(data.jsKey);
 			}
 		};
 		
 		xhr.open("get", "./getJSKey");
 		xhr.send();
 	}
	
	function getCode(jsKey) {
		Kakao.init(jsKey);
		
		Kakao.Auth.authorize({
			redirectUri: 'http://localhost:8181/member/loginGetCode'
			//redirectUri: 'http://15.164.100.116:8080/member/loginGetCode'
		});
	}
	
	window.addEventListener("DOMContentLoaded", function() {
		kakaoLogin();
	});
		
		
	</script>
</head>
<body>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>