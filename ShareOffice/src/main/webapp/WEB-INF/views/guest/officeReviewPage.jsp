<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<style type="text/css">
 a {text-decoration: none; color:#A68A64;}
 i {text-decoration: none; color:#A68A64;}

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
			<div class="row" style="">
			   <div class="col"><a href="javascript:history.back();"class="btn" style="color: #A68A64"><i class="bi bi-arrow-left"></i></a></div>
			   <div class="col-7" style="text-align: center"><p class="text-fs-23 bold"><i class="bi bi-pencil" style="color:#464444"></i> 이용후기</p></div>
			   <div class="col"></div>
			</div>
			<div class="row" style="text-align: center;padding:0;"><p class="text-fs-16">후기:${reviewCount }개 <i class="bi bi-dot"></i>평균 평점: ${officeAvgRating }</p></div>
			<div class="row mt-2" style="padding-bottom:1.5rem">
				<div class="col">
				    <c:choose>
				        <c:when test="${reviewList.size() <= 0 }">
                              <div class="row mt-4">
							        <div class="col text-center"><p class="text-fs-16">등록된 이용 후기가 없습니다.</p></div>
							  </div>
							  <div class="row mt-1 mb-3 text-fs-16">
						             			     				  
						      </div>
							
				        </c:when>
				        <c:otherwise>
				              <c:forEach  items="${reviewList}" var="review">
					      <div class="card shadow-sm bg-body rounded" style="margin:0.5em;">
						     <div class="row">
							    <div class="col">
							 
							        
							    <div class="card-body">
									<div class="row">
										<div class="col-6">
									      	<!-- 별점 출력 수정 -->
							                   <select class="reviewRating">
                                                   <c:forEach begin="1" end="${review.reviewVo.review_rating }">
                                                      <option value="5">5</option>
                                                   </c:forEach>
                                                </select>
										</div>
										<div class="col">
											<p class="card-text" style="text-align: right;">
												<small class="text-muted"><fmt:formatDate value="${review.reviewVo.review_date}" pattern="yyyy-MM-dd"/></small>
											</p>
										</div>

									</div>
									<div class="row">
										<div class="col">
											<img src="/soUpload/reviewImage/${review.reviewVo.review_image }"
												class="img-fluid rounded-start" width=40rem, height=40em>
										</div>
										<div class="col-8 text-left">
											 <c:choose>
                                                <c:when test="${fn:length(review.reviewVo.review_title)> 15}">
                                                   <c:out value="${fn:substring(review.reviewVo.review_title,0,14)}"/>....
                                                </c:when>
                                                <c:otherwise>
                                                    <c:out value="${review.reviewVo.review_title}"/>
                                                </c:otherwise> 
                                             </c:choose><br>
											 <c:choose>
                                                <c:when test="${fn:length(review.reviewVo.review_content) > 15}">
                                                   <c:out value="${fn:substring(review.reviewVo.review_content,0,14)}"/>....
                                                </c:when>
                                                <c:otherwise>
                                                    <c:out value="${review.reviewVo.review_content}"/>
                                                </c:otherwise> 
                                              </c:choose>
										</div>
										<div class="col">
											<a href="./officeReviewDetailPage?review_no=${review.reviewVo.review_no }"><i class="bi bi-chevron-right"></i></a>
										</div>
									</div>
								</div>
								
								
							</div>

						</div>
					</div>				              
				              </c:forEach>
				        </c:otherwise>
				    </c:choose>

					 
				</div>
			</div>


		</div>
</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>