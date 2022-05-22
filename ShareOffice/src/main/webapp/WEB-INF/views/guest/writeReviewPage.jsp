<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1, shrink-to-fit=no">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="../resources/css/commons.css">
<link rel="stylesheet" href="../resources/css/style.css">

<!-- star-rating -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
<link rel="stylesheet" href="../resources/css/fontawesome-stars.css">
<script type="text/javascript" src="../resources/js/jquery.barrating.min.js"></script>
<script>
	
	function writeReviewValidCheck(e) {
		
		e.preventDefault();
		
		//입력 유무 체크
		if($("#inputTitle").val() == ""){
			alert("이용후기 제목을 입력해주세요.");
			$("#inputTitle").focus();
			return;
		}
		
		if($("#inputContent").val() == ""){
			alert("이용후기를 입력해주세요.");
			$("#inputContent").focus();
			return;
		}		
		
		//submit 실행
		var frm = document.getElementById("frm");
		frm.submit();
	}
	
	
	$(function() {
	      $('.reviewRating').barrating({
	        theme: 'fontawesome-stars',
	        initialRating: 5,
	        onSelect: function(value, text, event){
	    		// 별점 클릭 후 처리는 여기서 코드
	    		// 선택한 별점 값을 value로 받음
	    	}
	        
	      });
	      $('.reviewRating').barrating('set', 5);
	   });	
	
	
</script>

</head>
<body>
<jsp:include page="../commons/navbar.jsp"></jsp:include>

	<div class="row" style="padding-top: 2rem;">
	
		<div class="col"></div> <!-- 왼쪽 여백 -->
		
		<div class="col-10">
			
			<div class="row">
				<div class="col center text-fs-23">이용 후기 작성</div>
			</div>
			
			<div class="row mt-5">
				<div class="col"> <!-- 오피스 정보 -->
					
					<div class="row"> <!-- 이용 오피스 이름 -->
						<div class="col">
							<p class="grayColor text-fs-16">${officeInfo.officeInfoVo.office_name }</p>
						</div>
					</div>
					
				</div>		
			</div>		
			
			<form id="frm" action="./writeReviewProcess" enctype="multipart/form-data" method="post">
			
			<div class="row"> <!-- 별점 -->
				<div class="col">
					<select class="reviewRating" name="review_rating">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</select>
				</div>
			</div>
			
			<div class="row mt-2"> <!-- 리뷰제목 -->
				<div class="col text-fs-16">
					<input id="inputTitle" class="form-control" type="text" name="review_title" placeholder="후기 제목">
				</div>
			</div>
			
			<div class="row mt-2"> <!-- 리뷰 내용 -->
				<div class="col text-fs-16">
					<textarea id="inputContent" class="form-control" rows="5" name="review_content" placeholder="후기 내용"></textarea>
				</div>
			</div>
			
			<div class="row"> <!-- 리뷰 사진 -->
				<div class="col-4 d-grid">
				  <label class="file-label text-fs-16" for="inputImage">사진 선택</label>
				  <input class="file" id="inputImage" type="file" name="uploadReviewImage" accept="image/*">
				</div>
				<div class="col"></div>
			</div>
			
			<div class="row" style="padding:1em;"></div>
			
			<div class="row mt-4"> <!-- 리뷰 작성 버튼 -->
		  		<div class="col">
					<div class="d-grid">
						<button class="btn buttonColor" onclick="writeReviewValidCheck(event)">후기 작성</button>
					</div>
				</div>
			</div>
			
			<input type="hidden" name="order_no" value="${order_no }">
			
			</form>
			
			<div class="row" style="padding:1em;"></div>
			
		
		</div>
		
		<div class="col"></div> <!-- 오른쪽 여백 -->
			
	</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>