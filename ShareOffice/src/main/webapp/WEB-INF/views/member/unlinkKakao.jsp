<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>        

	const jsKey = '${jsKey }';

	Kakao.init(jsKey);

	Kakao.API.request({
		  url: '/v1/user/unlink',
		  success: function(response) {
		    console.log(response);
		    location.href="../member/loginPage";
		  },
		  fail: function(error) {
		    console.log(error);
		  },
		});	
	
</script>
</head>
<body>

</body>
</html>