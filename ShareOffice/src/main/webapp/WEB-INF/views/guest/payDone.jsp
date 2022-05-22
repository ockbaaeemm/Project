<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 완료</title>
<script>

	var response_code = '${response_code}';

	window.close();
	
	window.addEventListener('unload', function() {
		window.opener.sendMeData(response_code);
	});
</script>
</head>
<body>

</body>
</html>