<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
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



	<style>
	.ellipsis{
		overflow:hidden;
		text-overflow:ellipsis;
		white-space:nowrap;
		width: 3em;
	}
	.border_bottom{
		border-bottom:0.063em solid #d1d1d1;
	}
	.bold{
		font-weigth:bold;
	}
	.main_color{
		color:#464444;
	}
	
	.basic_color{
		color: #868e96
	}
	.complete_color{
		color:#38dd2b;
	}
	
	.pattern:nth-child(even) {
		background-color: #f8f9fa;
		overflow:hidden;
		text-overflow:ellipsis;
	}
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

</head>
<body>
<div class="container-fluid px-0" style="overflow-x : hidden">

	<jsp:include page="../commons/navbar.jsp"></jsp:include>

	
	
	<div class="row" style="padding-top: 2em ">
		
			
		<div class="col" style="margin-bottom: 1rem; margin-left: 1rem; margin-right: 1rem;">
			<div class="row">
				<div class="col text-center text-fs-23 bold"><i class="bi bi-question-circle"></i> QnA</div>
			</div>
			<div class="row mt-4">
				<div class="col text-fs-18 bold">자주 묻는 질문 Best3</div>
			</div>
			
			
				<div class="row">
					<div class="col text-center">
						<table class="table">
							<thead>
							    <tr>
							      <th class="text-center text-fs-16">No</th>
							      <th class="text-center text-fs-16">Title</th>
							      <th class="text-center text-fs-16">작성일</th>
							      <th class="text-center text-fs-16">답변여부</th>
							    </tr>
							    </thead>
							    <tbody>
								<c:forEach items="${hotQnAVoList }" var="hotList">
								   	<tr style="color: #868e96">
								      	<td class="text-center">${hotList.QnAVo.qna_no }</td>
							    		<td class="text-fs-14 pt-2 ellipsis">
									    	<a href="./QnAReadPage?qna_no=${hotList.QnAVo.qna_no }" style="color: #464444;">
									      		${hotList.QnAVo.qna_title }
									      	</a>									      	
								      	</td>
								      	<td style="text-align: center;">
								      		<span class="text-fs-13" ><fmt:formatDate value="${hotList.QnAVo.qna_writeDate }" pattern="MM/dd" /></span>
								      	</td>
								      	<c:choose>
								      	<c:when test="${hotList.getCheckedQnAComment >= 1}">
									      	<td style="text-align: center;">
										      	<i class="complete_color bi bi-patch-check"></i>
									      	</td>
								      	</c:when>
								      	<c:otherwise>
								      		<td style="text-align: center;">
										      	<i class="bi bi-patch-question"></i>
									      	</td>
								      	</c:otherwise>
								      	</c:choose>
								    </tr>
								</c:forEach>
								</tbody>
							</table>
						</div>
					</div>

	
			<div class="row mt-3">
				<%-- <div class="col text-center"><img src="../resources/img/iu-상큼.webp" style="width:20.438em;"></div> --%>
				<div class="col text-center"><img src="../resources/img/qnabanner.jpg" style="width:20.438em;"></div>		
			</div>
			
	
			<div class="row">
					<div class="col text-center text-truncate">
						<table class="table mt-4">
							<thead>
							    <tr>
							      <th class="text-center text-fs-16">No</th>
							      <th class="text-center text-fs-16">Title</th>
							      <th class="text-center text-fs-16">작성일</th>
							      <th class="text-center text-fs-16">답변여부</th>
							    </tr>
							    </thead>
							    <tbody>
								<c:forEach items="${QnABoardList }" var="List">
								   	<tr style="color: #868e96" class="text-truncate">
								      	<td class="text-center">${List.QnABoardVo.qna_no }</td>
								      	<c:choose>
									      	<c:when test="${List.QnABoardVo.qna_screct eq 'N' }">
									      		<c:choose>
									      		<c:when test="${(!empty sessionUser && sessionUser.member_no eq List.QnABoardVo.member_no) || !empty adminUser }">
										    		<c:choose>
									      			<c:when test="${fn:length(List.QnABoardVo.qna_title) >= 10}">
											      		<td class="text-fs-14 pt-2 text-truncate">
											      			<a class="text-truncate ellipsis" style="color: black;" href="QnAReadPage?qna_no=${List.QnABoardVo.qna_no }">${List.QnABoardVo.qna_title.substring(0,10) }...</a>
											      		</td>
									      			</c:when>
									      			<c:otherwise>
									      				<td class="text-fs-14 pt-2 ellipsis">
												    		<a style="color: #464444;" href="QnAReadPage?qna_no=${List.QnABoardVo.qna_no }">${List.QnABoardVo.qna_title }</a>								      	
											      		</td>
									      			</c:otherwise>
									      		</c:choose>
									      		</c:when>
									      		<c:otherwise>
									      			<td class="text-fs-14">
									      				<i class="text-fs-15 bi bi-file-lock2"></i> 비공개 글입니다.
									      			</td>
									      		</c:otherwise>
									      		</c:choose>
									      	</c:when>
									      	<c:otherwise>
									      		<c:choose>
									      			<c:when test="${fn:length(List.QnABoardVo.qna_title) >= 10}">
											      		<td class="text-fs-14 pt-2 text-truncate">
											      			<a class="text-truncate ellipsis" style="color: black;" href="QnAReadPage?qna_no=${List.QnABoardVo.qna_no }">${List.QnABoardVo.qna_title.substring(0,10) }...</a>
											      		</td>
									      			</c:when>
									      			<c:otherwise>
									      				<td class="text-fs-14 pt-2 ellipsis">
												    		<a style="color: #464444;" href="QnAReadPage?qna_no=${List.QnABoardVo.qna_no }">${List.QnABoardVo.qna_title }</a>								      	
											      		</td>
									      			</c:otherwise>
									      		</c:choose>
									      	</c:otherwise>
								      	</c:choose>
								      	<td>
								      		<span class="text-fs-13" ><fmt:formatDate value="${List.QnABoardVo.qna_writeDate }" pattern="MM/dd"/></span>
								      	</td>
								      	<c:choose>
								      	<c:when test="${List.CheckedQnAComment >= 1}">
									      	<td style="text-align: center;">
										      	<i class="complete_color bi bi-patch-check"></i>
									      	</td>
								      	</c:when>
								      	<c:otherwise>
								      		<td style="text-align: center;">
										      	<i class="bi bi-patch-question"></i>
									      	</td>
								      	</c:otherwise>
								      	</c:choose>
								    </tr>
								</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				<%--
			<div class="row">
				<div class="col">
					<a href="./QnAWritePage" style="background-color: #adb5bd; color: white;" class="float-end btn btn-light pt-2 px-0">글쓰기</a>
				</div>
			</div>
				 --%>
				<c:if test="${!empty sessionUser }">
					<div class="fixed " style="bottom: 4rem; right: 3rem; z-index: 99">
						<a href="QnAWritePage"><i class="bi bi-plus-circle-fill" style="font-size: 3.5rem; color: #A68A64;"></i></a>
					</div>
				</c:if>
					
		
		
		<div class="row mt-3" style="padding-bottom: 2em;">
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
					      <a class="page-link" href="./QnAPage?pageNum=${startPage-1 }">&lt;</a>
					    </li>
				  	</c:otherwise>
				  </c:choose>
				    <c:forEach begin="${startPage}" end="${endPage}" var="i">
				    	<c:choose>
				    		<c:when test="${currentPage == i}">
						    	<li class="page-item active ">
						    		<a class="page-link" href="./QnAPage?pageNum=${i}" style="background-color: #A68A64; border-color: #A68A64">${i}</a>
						    	</li>
				    		</c:when>
				    		<c:otherwise>
						    	<li class="page-item">
						    		<a class="page-link" href="./QnAPage?pageNum=${i}" style="color: #A68A64;">${i}</a>
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
						      <a class="page-link" href="./QnAPage?pageNum=${endPage+1 }">&gt;</a>
						    </li>
				    	</c:otherwise>							    
				    </c:choose>
				  </ul>
				</nav>							
			
			
			</div>
			<div class="col"></div>
		</div>	
		</div>
	</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>