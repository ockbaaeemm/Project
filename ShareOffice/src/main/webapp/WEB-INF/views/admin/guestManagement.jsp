<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<%
 String strReferer = request.getHeader("referer");
 
 if(strReferer == null){
%>
 <script language="javascript">
  alert("정상적인 경로를 통해 다시 접근해 주세요.");
  document.location.href="loginAdmin";
 </script>
<%
  return;
 }
%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>게스트 관리 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="../resources/css/commons.css" rel="stylesheet">

<style>
	th, td {
		table-layout:fixed;
		white-space: nowrap;
		text-overflow: ellipsis;
  		text-align : center;
  		overflow: hidden;
	}
	
</style>



</head>
<body>
<div class="container-fluid px-0" style="overflow-x : hidden">
<jsp:include page="../commons/admin.jsp"></jsp:include>
<div class="row" style="padding-top: 5em; padding-bottom: 5em; padding-left: 5em; padding-right: 5em;">
	<div class="col">
		<h1>게스트 회원 관리</h1>
		<table class="table">
			<form action="./guestManagement" method="get">
			<div class="row mb-3">
				<div class="col">
					<select name="searchOption" class="form-select">
						<option value="number">번호</option>
						<option value="nickname">닉네임</option>
						<option value="id">아이디</option>
					</select>
				</div>
				<div class="col-8">
					<input name="searchStr" type="text" class="form-control">
				</div>
				<div class="col d-grid">
					<input type="submit" value="검색" class="btn btn-dark">
				</div>
			</div>
			</form>

			<col width="50"><col width="200"><col width="100"><col width="50">
			<col width="150"><col width="200"><col width="200"><col width="200">
			<col width="150">
			<thead>
			    <tr>
			      <th scope="col">NO</th>
			      <th scope="col">ID</th>
			      <th scope="col">닉네임</th>
			      <th scope="col">성별</th>
			      <th scope="col">생년월일</th>
			      <th scope="col">연락처</th>
			      <th scope="col">이메일</th>
			      <th scope="col">가입일자</th>
			      <th scope="col">기능</th>
			    </tr>
			 </thead>
			 <tbody>
				<c:forEach items="${guestList }" var="list">
				<tr>
					<th scope="row">${list.memberVo.member_no }</th>
				    <td>${list.memberVo.member_id }</td>
				    <td>${list.memberVo.member_nick }</td>
				    <td>${list.memberVo.member_gender }</td>
					<td><fmt:formatDate pattern="yyyy-MM-dd" value="${list.memberVo.member_birth }"/></td>
					<td>${list.memberVo.member_phone }</td>
					<td>${list.memberVo.member_email }</td>
					<td><fmt:formatDate pattern="yyyy-MM-dd" value="${list.memberVo.member_joindate }"/></td>
					<td><button type="button" class="btn btn-secondary" onclick="if (confirm('회원탈퇴를 진행하시겠습니까?')) location.href='./deleteGuest?member_no=${list.memberVo.member_no }';">회원탈퇴</button></td>
				</tr>
				</c:forEach>
			  </tbody>
		</table>

		<div class="row mt-3" style="padding-bottom: 2em;">
			<div class="col"></div>
			<div class="col">
				
      <nav aria-label="..." >
        <ul class="pagination" style="justify-content: center;">
          <li class="page-item" ><a class="page-link" style="color: #000000;"> < </a></li>
          <li class="page-item"><a class="page-link"  style="color:white; background-color: #000000; border-color: #000000;" href="./guestManagement?pageNum=1">1</a></li>
          <li class="page-item"><a class="page-link" style="color: #000000;" href="./guestManagement?pageNum=2">2</a></li>
          <li class="page-item"><a class="page-link" style="color: #000000;" href="./guestManagement?pageNum=3">3</a></li>
          <li class="page-item"><a class="page-link" style="color: #000000;">></a></li>
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