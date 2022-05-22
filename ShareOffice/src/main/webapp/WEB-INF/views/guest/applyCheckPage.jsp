<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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


<script>
	function licenseImg(img_url) {
		window.open("/soUpload/licenseImg/" + img_url, "_blank", "width=250, height=353");
	}

</script>


</head>
<body>
<div class="container-fluid px-0" style="overflow-x : hidden">
<jsp:include page="../commons/navbar.jsp"></jsp:include>

<div class="row" style="padding-top: 2em;">
	<div class="col">
			<div class="row" style="">
			   <div class="col"></div>
			   <div class="col-8" style="text-align: center"><p class="text-fs-23 bold"><i class="bi bi-person-lines-fill"></i> 호스트 신청 현황</p></div>
			   <div class="col"></div>
			</div>	    
	    <div class="row mt-1">
	       <div class="col ">

	       <c:forEach items="${applyList }" var="apply">
				<div class="card text-fs-16" style="margin: 1em;">
				  
					<div class="card-body text-left" style="padding-bottom:0;">						
						<p class="card-text">대표자명:${apply.hostVo.host_owner}</p>
						<p class="card-text">상호명:${apply.hostVo.host_name}</p>
						<p class="card-text">사업자 번호:${apply.hostVo.host_license_number }
						<i class="bi bi-file-earmark" onclick="licenseImg('${apply.hostVo.host_license_img}')"></i><!-- 사업자등록증 팝업띄우기 --></p>
						<p class="card=text">신청일:<fmt:formatDate value="${apply.hostVo.host_apply_date }" pattern="yy-MM-dd"/></p>
					 </div>
					 <div class="card-body text-center" style="padding-top:0">	 
					    <!-- approve =="P"이면 진행중 어쩌구 -->										
						<c:if test="${apply.hostVo.host_approve eq 'P' }">
						   <p class="card-text ">호스트 승인 대기 중입니다.</p> 
						</c:if>
						<c:if test="${apply.hostVo.host_approve eq 'Y' }">  
						   <p class="card-text" style="color:blue">호스트 승인이 완료되었습니다.</p>
						  <div class="col d-grid"> <a href="../host/mainPage" class="btn btn-outline-secondary">호스트 페이지로 가기</a></div>	
					    </c:if>
					    <c:if test="${apply.hostVo.host_approve eq 'N'|| apply.hostVo.member_no == null }">  
						   <p class="card-text"  style="color:red;margin:0.2rem;" >호스트 승인이 거절되었습니다.</p>
						   <p class=" text-fs-13" style="color:red;margin:0.5rem;">거절 사유:${apply.hostVo.host_approve_comment }</p>
						   	
					    </c:if>
					  
					</div>
								
				</div>
			</c:forEach>	
				
				<c:choose>
				   <c:when test="${!empty sessionUser && sessionUser.member_type eq 'G'}">
				         <div class="col d-grid" style="margin: 1em"> <a href="../guest/applyHostPage" class="btn" style="background-color: #A68A64; color: #ffffff;">호스트 재신청 하기</a></div>				  
				         <div class="col d-grid" style="margin: 1em"><a href="./mainPage" class="btn" style="background-color: #A68A64; color: #ffffff;">메인으로</a></div>
				   </c:when>
				   <c:when test="${!empty sessionUser && sessionUser.member_type eq 'H' }">
				         <div class="col d-grid" style="margin: 1em"><a href="./mainPage" class="btn" style="background-color: #A68A64; color: #ffffff;">메인으로</a></div>
 				   </c:when>			
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