<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>관리자 Q&A 관리 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="../resources/css/commons.css" rel="stylesheet">

	<style>
	.ellipsis{
		overflow:hidden;
		text-overflow:ellipsis;
		white-space:nowrap;
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
	
	</style>

</head>
<body>
<div class="container-fluid px-0" style="overflow-x : hidden">
	<jsp:include page="../commons/admin.jsp"></jsp:include>

	<div class="row" style="padding-top: 5em; padding-bottom: 5em; padding-left: 5em; padding-right: 5em;">
		
		<div class="col">						
			<h1>Q&A 관리</h1>
	
			<div class="row mt-5">
				<div class="col-1 pr-0">
					<div class="pb-1 text-center text-fs-16 bold" style="border-bottom:0.125em solid;">No.</div>	
				</div>			
				<div class="col pl-0 pr-0">
					<div class="pb-1 text-center text-fs-16 bold" style="border-bottom:0.125em solid;">제목</div>	
				</div>
				<div class="col-2 px-0">
					<div class="pb-1 text-center text-fs-16 bold" style="border-bottom:0.125em solid;">답변 여부</div>	
				</div>
				<div class="col-2 pl-0">
					<div class="pb-1 text-center text-fs-16 bold" style="border-bottom:0.125em solid;">등록일</div>			
				</div>
				
			</div>		
			
			<c:forEach items="${QnABoardList }" var="List">
			
			
			
			<div class="row pt-1 pattern">
				<div class="col-1 pr-0 text-fs-16 bold" >
					<div class="text-center py-2">${List.QnABoardVo.qna_no }</div>
				</div>
			
				<div class="col pr-0">
				<%-- 비밀글 관련 --%>
					<c:choose>
						<c:when test="${List.QnABoardVo.qna_screct eq 'N' }">
							<c:choose>
								<c:when test="${!empty adminUser }">
									<div class="text-center ellipsis pr-0 py-2 text-fs-16 ">
											<a class="main_color" href="QnAReadPage?qna_no=${List.QnABoardVo.qna_no }">${List.QnABoardVo.qna_title }</a></div>	
								</c:when>
								<c:otherwise>
									<div class="basic_color text-center ellipsis pr-0 py-2 text-fs-16"><i class="py-3 text-fs-20 bi bi-file-lock-fill"></i> 비공개 글입니다.</div>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<div class="text-center text-fs-16 ellipsis pr-0 py-2 ">
							<a class="main_color" href="QnAReadPage?qna_no=${List.QnABoardVo.qna_no }">${List.QnABoardVo.qna_title }</a></div>
						</c:otherwise>
					</c:choose>
				</div>
				
					<c:choose>
						<c:when test="${List.CheckedQnAComment >= 1}">
				<div class="col-2 px-0 py-2 text-center text-fs-20"><i class="complete_color bi bi-patch-check"></i></div>
						</c:when>	
						<c:otherwise>
				<div class="col-2 px-0 py-2 text-center text-fs-20"><i class="bi bi-patch-question"></i></div>
						</c:otherwise>				
					</c:choose>
				
				<div class="col-2 pl-0">
					<div class="text-center py-2"><fmt:formatDate value="${List.QnABoardVo.qna_writeDate }" pattern="M.dd"/> </div>
				</div>
			</div>
			<hr class="my-1">
			</c:forEach>
		
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
						    		<a class="page-link" href="./QnAPage?pageNum=${i}" style="background-color: #000000; border-color: #000000">${i}</a>
						    	</li>
				    		</c:when>
				    		<c:otherwise>
						    	<li class="page-item">
						    		<a class="page-link" href="./QnAPage?pageNum=${i}" style="color: #000000;">${i}</a>
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