<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dcba11bad3364b22a9a962b80ee0acfb&libraries=services"></script>

<script>
	function drawMap(){
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };

		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption); 
	}

	
	window.addEventListener("DOMContentLoaded" , drawMap);

</script>


</head>
<body>
<div style="margin: 0 auto">
	<div class="container-fluid">
		<div class="row">
			<div class="col" id="map" style="width:500px;height:500px"></div>
		</div>
	
	
		<div class="row">
			<div class="col">
				<jsp:include page="../commons/navbar.jsp"></jsp:include>
			</div>
		</div>
		
		<div class="row" style="padding-top: 70px;"> <%--style="top:90%;"> --%>
			<div class="col">
				<%-- 내용작성 --%>
				<%-- 선생님들께서 구현하실 jsp파일에 이 파일(basic_frame) 코드 전체 복붙하시면 됩니다!
				 다만!! --%> <%--    ../commons/footer.jsp 로 변경바랍니다    --%> <%--변경해주셔야지 에러 안뜰거에요 --%>
				<%-- 여기에 내용작성 하시면 됩니다 화이팅!!<br>--%>
				1. 가나다라마바사자차카타파하가나다라마바사자차카타파하가나다라마바사자차카타파하
				2. 가나다라마바사자차카타파하가나다라마바사자차카타파하가나다라마바사자차카타파하
				3. 가나다라마바사자차카타파하가나다라마바사자차카타파하가나다라마바사자차카타파하
				4. 가나다라마바사자차카타파하가나다라마바사자차카타파하가나다라마바사자차카타파하
				5. 가나다라마바사자차카타파하가나다라마바사자차카타파하가나다라마바사자차카타파하
				6. 가나다라마바사자차카타파하가나다라마바사자차카타파하가나다라마바사자차카타파하
				7. 가나다라마바사자차카타파하가나다라마바사자차카타파하가나다라마바사자차카타파하
				8. 가나다라마바사자차카타파하가나다라마바사자차카타파하가나다라마바사자차카타파하
				

			</div>
		</div>
		<jsp:include page="../commons/footer.jsp"></jsp:include>	
	</div>
</div>
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>