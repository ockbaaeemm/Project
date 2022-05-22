<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>        

	Kakao.init('${jsKey}');
	Kakao.Auth.setAccessToken('${access_token}');		
	Kakao.API.request({
	    url: '/v2/user/me',

	    success: function(response) {
	    	createForm(response);
	    },
	    fail: function(error) {
	    	alert("카카오 로그인 실패 :" + token + ", " + jsKey);
	    	location.href='./loginPage';
	    }
	});
	
	function createForm(response) {
		var form = document.createElement("form");
		form.setAttribute("action", "./checkJoin");
		form.setAttribute("method", "post");
		form.setAttribute("style", "display:none;");
		
		var id = document.createElement("input");
		id.setAttribute("name", "member_id");
		id.setAttribute("value", response.id);
		
		// 선택
		var email = document.createElement("input");
		email.setAttribute("name", "member_email");
		email.setAttribute("value", response.kakao_account.email);
		
		var nickname = document.createElement("input");
		nickname.setAttribute("name", "member_nick");
		nickname.setAttribute("value", response.kakao_account.profile.nickname);
						
		form.appendChild(id);
		form.appendChild(email);
		form.appendChild(nickname);
		
		document.body.appendChild(form);
		
		form.submit();
	}
	
</script>
</head>
<body>

</body>
</html>