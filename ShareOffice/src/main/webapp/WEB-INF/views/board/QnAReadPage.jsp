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
<jsp:include page="../commons/navbar.jsp"></jsp:include>


<div class="row" style="padding-top: 1em; padding-bottom: 2em;">
	<div class="col" style="margin-left: 1rem; margin-right:1rem;">
	<%-- 내용작성 --%>
		<div class="row">
			<div class="col">
				
				<div class="row">
					<div class="col text-fs-13" style="padding-bottom: 2em;">
						<a href="../board/QnAPage" style="color: #602b23;">
							<i class="bi bi-question-circle"></i> QnA >
						</a>
					</div>
				</div>
			
				<div class="row">
					<div class="col-9 text-fs-23 bold" style="margin-bottom: 1rem;">
						<span>
							${readQnABoardRow.QnAVo.qna_title }
						</span>
					</div>
					<div class="py-2 col-3 text-fs-13" style="text-align: right;">No. ${readQnABoardRow.QnAVo.qna_no }</div>
				</div>
				<!-- 
				<hr class="mt-3 mb-0 ">
					<div class="row">
						<div class="col text-fs-12" style="background-color:#f5f5f5;">
							<span>${readQnABoardRow.MemberVo.member_nick } &nbsp&nbsp</span>
							<span><i class="bi bi-hand-thumbs-up"> ${totalLikeCount }</i></span> 
							<span></span> 
							<span class="float-end"><fmt:formatDate value="${readQnABoardRow.QnAVo.qna_writeDate }" pattern="yyyy.MM.dd"></fmt:formatDate></span> 
						</div>
					</div> --> 
				
				<div class="row">
					<div class="col text-fs-16" style="margin-bottom: 0.3rem;">
						<span>작성자</span>
						<span class="inline-block pl-3 bold">${readQnABoardRow.MemberVo.member_nick }</span> 
					</div>
				</div>
				
				<div class="row">
					<div class="col text-fs-12" style="color: #868e96">
						<fmt:formatDate value="${readQnABoardRow.QnAVo.qna_writeDate }" pattern="yyyy/MM/dd" />
					</div>
				</div>
				
				<hr class="mb-1 mt-0">
		
				<div class="row">
					<div class="col">
						${readQnABoardRow.QnAVo.qna_content }
					</div>
					<br>
					<c:if test="${!empty sessionUser }">
					<div class="row">
						<div class="col text-center pt-2">
							<c:if test="${!empty sessionUser }">
								<c:choose>
									<c:when test="${myLikeCount > 0}">
										<a href="./likeProcess?qna_no=${readQnABoardRow.QnAVo.qna_no }" style="color: #bba586">
											<i class="bi bi-hand-thumbs-up-fill text-fs-20"></i> ${totalLikeCount }
										</a>
									</c:when>
									<c:otherwise>
										<a href="./likeProcess?qna_no=${readQnABoardRow.QnAVo.qna_no }" style="color: #bba586">
											<i class="bi bi-hand-thumbs-up text-fs-20"></i> ${totalLikeCount }
										</a>
									</c:otherwise>
								</c:choose>
							</c:if>	
						</div>
					</div>
					</c:if>
					
				</div>
				<c:if test="${!empty sessionUser && sessionUser.member_no == readQnABoardRow.QnAVo.member_no || !empty adminUser}">
					<div class="row">
						<div class="col mt-2">
							<a style="background-color: #bba586; color: white;" class="float-end btn btn-light" href="./deleteQnAContentProcess?qna_no=${readQnABoardRow.QnAVo.qna_no }">삭제</a>	
							<a style="background-color: #bba586; color: white;" class="float-end btn btn-light" href="./updateQnAPage?qna_no=${readQnABoardRow.QnAVo.qna_no }">수정</a> 
						</div>
					</div>
				</c:if>
				
				<hr>

				<div class="row mt-3">
					<div class="col text-fs-16">
						<c:forEach items="${answerList }" var="answer">
							<div class="row">
								<div class="col bold">${answer.author }</div>
								<div class="col text-fs-13" style="text-align: right; color: #868e96">
									<fmt:formatDate value="${answer.QnAAnswerVo.answer_writeDate }" pattern="MM월dd일" />
								</div>
							</div>
							<div class="row mt-2">
								<div class="col">${answer.QnAAnswerVo.answer_content }</div>
							</div>
							<hr style="margin-top: 0.7em; margin-bottom: 0.7em;">
						</c:forEach>
					</div>
				</div>
				
				
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
								<input type="submit" style="background-color: #bba586;" class="float-end btn btn-light" value="댓글작성">
							</p>
							
						</form>
					</div>
				</div>
				</c:if>
			
			</div>	
			
		</div>
	</div>
</div>

<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>