<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<!-- star-rating -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
<link rel="stylesheet" href="../resources/css/fontawesome-stars.css">
<script type="text/javascript" src="../resources/js/jquery.barrating.min.js"></script>
<style>



</style>

<script>
$(function() {
    $('.reviewRating').barrating({
      theme: 'fontawesome-stars',
      readonly: true,
    });
    $('.reviewRating').barrating('set', 5);
 });

</script>
</head>
<body>
<div class="container-fluid px-0" style="overflow-x : hidden">
<jsp:include page="../commons/navbar.jsp"></jsp:include>

<div class="row" style="padding-top: 2em;">
	<div class="col">
	
		<div class="row">	
			 <div class="col"><a href="javascript:history.back();"class="btn" style="color: #A68A64"><i class="bi bi-arrow-left"></i></a></div>
		     <div class="col-7" style="text-align: center"><p class="text-fs-23 bold"><i class="bi bi-menu-up" style="color:#464444"></i> 이용후기</p></div>
		     <div class="col"></div>
		</div>

		<div class="row mt-2 mb-4 text-fs-16">
		   <div class="col-md-12">	
		      <div class="card " style="margin: 0.5em;">
			
		  		<div class="card-body">	
		  		
		  			 <div class="row mt-2 text-fs-19 bold">
						   <div class="col"><p class="card-title">${review.reviewVo.review_title }</p></div>					   
					 </div>
		  	
				     <div class="row mt-2">
				          <div class="col"><span>  ${review.memberVo.member_nick }</span></div>
				          <div class="col" style="margin-top: 0.15rem;">
				          		<!-- 별점 출력 -->	
				     	  		<div class="col text-right">
								    <select class="reviewRating">
				                      <c:forEach begin="1" end="${review.reviewVo.review_rating }">
				                        <option value="5">5</option>
				                      </c:forEach>  
				                    </select>
			                  	</div>
				     	  </div>  	     
				     </div>	
				     
				     <div class="row">
					   <div class="col" style="text-align:left; color:#868e96;"> 
					   		<p class="card-text muted text-fs-13"> <fmt:formatDate value="${review.reviewVo.review_date}" pattern="yyyy/MM/dd"/></p>
					   </div>
					 </div>	
					 
					 <hr style="margin-top: 0.5rem;">
					 
					 <div class="row mt-2">	
					      <img src="/soUpload/reviewImage/${review.reviewVo.review_image }" class="card-img-top" alt="..." width=100%, height=250em>
					 </div>	
					 
					 <div class="row mt-3">
						   <p class="card-text">${review.reviewVo.review_content }</p>
					 </div>	
					 
		    	</div>
				
			</div>
		 </div>
		</div>	



		
	</div>
</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>


