<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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


</head>
<body>
<div class="container-fluid px-0" style="overflow-x : hidden">
<jsp:include page="../commons/navbar.jsp"></jsp:include>

<div class="row" style="padding-top:2rem ;">
	<div class="col">
				<div class="card text-dark bg-light mb-3" style="margin: 1em;margin-top:2em">			  
					 <div class="card-body text-center " >	
					 
					      <div class="row mt-5"> 
						     <p class="text-fs-18 bold">호스트 신청이 완료되었습니다.</p> 	
						     <p class="text-muted fs-16">관리자 승인 완료 후에 <br>오피스를 등록할 수 있습니다.</p>
						   </div>  	
						   <div class="row mt-4 text-fs-16">
						      <div class="col d-grid" style="margin: 0"><a href="./applyCheckPage" class="btn btn-outline-secondary">호스트 신청 현황 보러가기</a></div>
				           </div>
				           <div class="row">
				              <div class="col d-grid" style="margin-top:0.3rem;"><a href="./mainPage" class="btn btn-outline-secondary">메인으로</a></div>
						   </div>	  
					</div>								
				</div>			
					

	</div>
</div>

<div class="row" style="padding:1.5em;"></div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>