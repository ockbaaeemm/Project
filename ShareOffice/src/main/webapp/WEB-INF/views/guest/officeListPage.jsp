<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
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
<style>
 a {text-decoration:underline ; color:#A68A64;}
 a:link {
  color : #A68A64;
}
a:hover {
  color : #A68A64;
}
 a:active {
  color : #A68A64;
}
i {text-decoration: none; color:#A68A64;}
</style>
<script >
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

<div class="row" style="width: auto;padding-top:2rem;margin:0;background-image:url('../resources/img/back4.jpg'); background-repeat:no-repeat;background-size:cover;">
	<div class="col">
	  <%-- 내용작성 --%>
		<div class="row" style="" >		
		<!-- <i class="bi bi-building" style="color:#464444;"></i> -->
		  <p class=" text-fs-23 bold "style="text-align:center;"><i class="bi bi-card-text" style="color:#464444"></i> 오피스 목록</p>
		  <p class="text-fs-16" style="text-align:left;margin-bottom:0;">Share Office에서 
		  <br>최적의 업무 환경을 경험해보세요.</p>
		  <p class="text-fs-14" style="margin-bottom:0;"><a href="./officeMapPage" style="">위치 검색하러 가기<i class="bi bi-arrow-right"></i></a></p>
		</div>
			
		<div class="row" >
		   <div class="col" style="padding:0.5rem;">
			
			<c:forEach items="${officelist}" var="office">
				<div class="card mb-3" >
				<a href="./officeDetailPage?office_no=${office.officeVo.office_no }">
					<img src="/soUpload/officeImage/${office.officeVo.office_thumbnail}" width=100%, height=250em class="card-img-top" alt="..."> 
					
					</a>
				<div class="card-body shadow-sm p-3 bg-body rounded">
						<div class="row" style="height:2rem">
						  <div class="col card-title text-fs-23 font-medium2 ">	<p>${office.officeVo.office_name }</p></div>
						   <div class="col-3 text-fs-16 font-medium" style="margin:0.7rem ;text-align:right;">
						      <p style="margin-bottom:0.3rem"><i class="bi bi-star-fill" style="color:#EDB867;"></i> ${office.officeAvgRating}</p>
						   </div>
						</div>
						<div class="row text-fs-13">
						  <div class="col">
						    <p class="card-text">
									<small class="text-muted"> 
						                 #${office.officeVo.office_tags }
						            </small>
						    </p>  
						   </div>            
						 </div>	
						 <div class="row mt-2" style="padding:0;">
						 	<div class="col text-fs-13">
								<p style="margin:0"><i class="bi bi-geo-alt"></i>${office.officeVo.office_address}</p>
							</div>						 
						 </div>			
						<div class="row ms-1 " style="height:2rem;">					
						  <div class="col" style="padding:0rem;margin-top:0.3rem;">
                             <c:forEach items="${office.facilityCategoryList }" var="facilityVo" end="2">						   					        					          
							       <c:if test="${facilityVo.facility_no eq '1'  }">	
							         <span style="margin-top:0.7rem"><img src="../resources/img/wifi (1).png" width=22em, height=22em></span>			         			   	
							       </c:if>			     										             
							        <c:if test="${facilityVo.facility_no eq '2'  }">								      
							           <span style="margin-top:0.7rem"> <img src="../resources/img/desktop.png" width=22em, height=22em></span>  		   								   													   	       
							        </c:if>					     							     
							         <c:if test="${facilityVo.facility_no eq '3'  }">							         
							           <span> <img src="../resources/img/fax.png" width=22em, height=22em></span>	   								   	                                      				   	       
							        </c:if>		      
							         <c:if test="${facilityVo.facility_no eq '4'  }">								          								          
							          <span> <img src="../resources/img/printer.png" width=20em, height=20em></span>	   								   	                                 				   	       
							        </c:if> 
							         <c:if test="${facilityVo.facility_no eq '5'  }">							          								         
							           <span> <img src="../resources/img/whiteBoard.png" width=20em, height=20em></span>	   								   	                                   				   	       
							        </c:if>					      							     
							         <c:if test="${facilityVo.facility_no eq '6'  }">	
							           <span><img src="../resources/img/projector (1).png" width=20em, height=20em></span>		   								   	                                      				   	       
							        </c:if>							      						 
							         <c:if test="${facilityVo.facility_no eq '7'  }">	
							          <span><img src="../resources/img/air-purifier.png" width=20em, height=20em></span>		   								   	    				   	       
							        </c:if>		      
							         <c:if test="${facilityVo.facility_no eq '8'  }">	
							           <span><img src="../resources/img/lockers.png" width=20em, height=20em></span> 	   								   	                                   				   	       
							        </c:if>					       
							         <c:if test="${facilityVo.facility_no eq '9'  }">	
							          <span> <img src="../resources/img/kitchen.png" width=20em, height=20em></span>		   								   	                                 				   	       
							        </c:if>	     
							         <c:if test="${facilityVo.facility_no eq '10'  }">	
                                       <span><img src="../resources/img/parking.png" width=20em, height=20em></span> 			   	       
							        </c:if>				             
						    </c:forEach>	
                        </div>
						<div class="col-7 fs-3, fw-bold" style="text-align:right;">
								<p class="text-muted" style="margin-top:0.8rem;">
									<fmt:formatNumber value="${office.officeMinPrice}" pattern="#,###"/>~ <span class="font-light text-fs-13 ">원/일</span></p>
						</div>
						</div>

					</div>
				</div>

			</c:forEach>
			</div>
		</div>
		</div>
</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>