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

<style>
	table {
		border-collapse: collapse;
		border-spacing: 0;
		width: 100%;
		border: 0.021em solid #ddd;
		font-size: 1em;
	}
	th, td {
  		text-align: left;
	}

	tr:nth-child(even) {
		background-color: #f2f2f2;
	}
</style>
</head>
<body>
<div class="container-fluid px-0" style="overflow-x : hidden">	
<jsp:include page="../commons/admin.jsp"></jsp:include>

<div class="row" style="padding-top: 1em; padding-bottom: 2em;">
	<div class="col"></div>
	
	<div class="col-8" style="margin-left: 1rem; margin-right:1rem;">
		<%-- 내용작성 --%>
		<div class="row">
			<div class="col">
				
				<div class="row">
					<div class="col text-fs-16" style="padding-bottom: 2em;">
						<a href="../admin/QnAPage" style="color: #602b23;">
							<i class="bi bi-file-text"></i> QnA >
						</a>
					</div>
				</div>
			
				<div class="row">
					<div class="col">
						<div class="text-fs-24 bold">${readQnABoardRow.QnAVo.qna_title }</div>
					</div>	
				</div>	
				
					<div class="row mt-2">
						<div class="col text-fs-16" style="background-color:#f5f5f5;">
							<span>${readQnABoardRow.MemberVo.member_nick } &nbsp;&nbsp;</span>
							<span><i class="bi bi-hand-thumbs-up"> ${totalLikeCount }</i></span> 
							<span></span> 
							<span class="float-end"><fmt:formatDate value="${readQnABoardRow.QnAVo.qna_writeDate }" pattern="yyyy.MM.dd"></fmt:formatDate></span> 
						</div>
					</div>
		
				<div class="row mt-3">
					<div class="col text-fs-16">
						${readQnABoardRow.QnAVo.qna_content }
					</div>
					
				</div>
				
				<div class="row">
					<div class="col mt-2">
						<c:if test="${!empty adminUser}">
							<a class="float-end btn btn-dark" 
							href="./deleteQnAContentProcess?qna_no=${readQnABoardRow.QnAVo.qna_no }">삭제</a>	 
						</c:if>
					</div>
				</div>
				<hr class="mt-3">
				
	
				<table class="table mt-2">
				  <c:forEach items="${answerList }" var="answer">
				    <tr class="text-fs-16">
				      	<td class="col-2 bold">
							<span>${answer.author }</span>
				      	</td>
				      	<td class="col">
				      		<span>${answer.QnAAnswerVo.answer_content }</span>
				      	</td>
				      	<td class="col-2 text-right">
				      		<span><fmt:formatDate value="${answer.QnAAnswerVo.answer_writeDate }" pattern="yyyy.MM.dd" /></span>
				      	</td>
				    	</tr>
					</c:forEach>
				</table>	
				
				
				<c:if test="${!empty adminUser }">
				<div class="row">
					<div class="col mt-2">
						<form action="./QnAAnswerWriteProcess" method="get">
							<p>
								<input type="hidden" name="qna_no" value="${readQnABoardRow.QnAVo.qna_no }">
							</p>
							<p>
								<textarea rows="1" class="form-control" name="answer_content"></textarea>
							</p>
							<p>
								<input type="submit" class="float-end btn btn-dark" value="댓글작성">
							</p>
							
						</form>
					</div>
				</div>
				</c:if>
			
			</div>	
			
		</div>
	</div>
	
	<div class="col"></div>
</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>