<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<link href="../resources/css/commons.css" rel="stylesheet">

<style>
	table {
		border-collapse: collapse;
		border-spacing: 0;
		width: 100%;
		font-size: 1em;
	}
	th, td {
		table-layout:fixed;
		white-space: nowrap;
		text-overflow: ellipsis;
  		text-align: left;
  		
  		overflow: hidden;
  		
	}
	
	tr:nth-child(even) {
		background-color: #f8f9fa;
		overflow:hidden;
		text-overflow:ellipsis;
		white-space:nowrap;
	}


</style>
<title>Insert title here</title>
</head>
<body>
<div class="container-fluid px-0" style="overflow-x : hidden">
<jsp:include page="../commons/navbar.jsp"></jsp:include>

<div class="row" style="padding-top: 2em;">
		<%--
			<div style="overflow-x:auto;">
		 --%>
				<div class="col" style="margin:1rem">
				<%-- 내용작성 --%>
					<div class="row">
						<div class="col text-center">
							<div class="text-fs-23 bold"><i class="bi bi-file-text"></i> 자유게시판</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col text-center">
							<table class="table mt-4">
								<thead>
							    <tr>
							      <th class="text-center text-fs-16">No</th>
							      <th class="text-center text-fs-16">Title</th>
							      <th class="text-center text-fs-16">작성일</th>
							      <th class="text-center text-fs-16">조회</th>
							    </tr>
							    </thead>
							    <tbody>
								<c:forEach items="${freeBoardList }" var="freeBoardList">
								   <tr style="color: #868e96">
								      	<td class="text-center py-3">${freeBoardList.freeBoardVo.freeboard_no }</td>
							    		<td>
									    	<a href="./freeBoardReadPage?freeboard_no=${freeBoardList.freeBoardVo.freeboard_no }" style="color: #464444; font-weight: bold;">
									      	${freeBoardList.freeBoardVo.freeboard_title }
									      	</a>
									      	  <br>
									      	<span class="text-fs-13">${freeBoardList.memberVo.member_nick }</span>
									      	
								      	</td>
								      	<td style="text-align: center;">
								      		<span class="text-fs-13 py-4" ><fmt:formatDate value="${freeBoardList.freeBoardVo.freeboard_writeDate }" pattern="MM/dd" /></span>
								      	</td>
								      	<td style="text-align: center;">
									      	<span class="text-fs-13 py-4" >${freeBoardList.freeBoardVo.freeboard_readCount }</span>
								      	</td>
								    </tr>
								</c:forEach>
								</tbody>
							</table>
						</div>
					</div>	
						
				</div>
						
				
			</div>
		<!-- 	
		<div class="row">
			<div class="col" style="margin-right:0.5rem;margin-left:0.5rem;">
				<%-- 수정
				<c:if test="${!empty sessionUser }">
				</c:if>
				 --%>
					<a href="./freeBoardWritePage" style="background-color: #a68a64; color: white;" class="float-end btn btn-light">글쓰기</a>
				
			</div>
		</div>  -->
		<c:if test="${!empty sessionUser }">
			<div class="fixed " style="bottom: 4rem; right: 3rem; z-index: 99">
				<a href="freeBoardWritePage"><i class="bi bi-plus-circle-fill" style="font-size: 3.5rem; color: #A68A64;"></i></a>
			</div>
		</c:if>
			
		<div class="row" style="padding-bottom: 2em;">
			<div class="col"></div>
			<div class="col">
				
				<nav aria-label="...">
				  <ul class="pagination mb-0 my" style="justify-content: center;">
				  <c:choose>
				  	<c:when test="${startPage <= 1}">
					    <li class="page-item disabled">
					      <a class="page-link">&lt;</a>
					    </li>
				  	</c:when>
				  	<c:otherwise>
					    <li class="page-item">
					      <a class="page-link" href="./freeBoardPage?pageNum=${startPage-1 }">&lt;</a>
					    </li>
				  	</c:otherwise>
				  </c:choose>
				    <c:forEach begin="${startPage}" end="${endPage}" var="i">
				    	<c:choose>
				    		<c:when test="${currentPage == i}">
						    	<li class="page-item active ">
						    		<a class="page-link" href="./freeBoardPage?pageNum=${i}" style="background-color: #A68A64; border-color: #A68A64">${i}</a>
						    	</li>
				    		</c:when>
				    		<c:otherwise>
						    	<li class="page-item">
						    		<a class="page-link" href="./freeBoardPage?pageNum=${i}" style="color: #A68A64;">${i}</a>
						    	</li>
				    		</c:otherwise>
				    	</c:choose>
				    
				    </c:forEach>
				    <c:choose>
				    	<c:when test="${endPage >= totalPageCount}">
						    <li class="page-item disabled">
						      <a class="page-link">&gt;</a>
						    </li>
				    	</c:when>
				    	<c:otherwise>
						    <li class="page-item">
						      <a class="page-link" href="./freeBoardPage?pageNum=${endPage+1 }">&gt;</a>
						    </li>
				    	</c:otherwise>							    
				    </c:choose>
				  </ul>
				</nav>							
			
			
			</div>
			<div class="col"></div>
		</div>	

<%--
</div>
 --%>

<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>