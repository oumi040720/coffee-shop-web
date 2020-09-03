<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Coffee Shop | Admin | Staff</title>
		
		<%@ include file="/WEB-INF/views/admin/common/css.jsp" %>
	</head>
	
	<body>
        <div id="wrapper">
        
        	<%@ include file="/WEB-INF/views/admin/common/header.jsp" %>
        
        	<%@ include file="/WEB-INF/views/admin/common/menu.jsp" %>
        
        	<div class="content-page">
        		<div class="container-fluid">
        			<div class="row">
        				<div class="col-12">
        					<div class="page-title-box">
        						<div class="page-title-right">
        							<ol class="breadcrumb m-0">
        								<li class="breadcrumb-item"><a href="javascript: void(0);">Uplon</a></li>
        								<li class="breadcrumb-item"><a href="javascript: void(0);">Nhân viên</a></li>
        								<li class="breadcrumb-item active">Danh sách</li>
        							</ol>
        						</div>
        						<h4 class="page-title">Danh sách nhân viên</h4>
        					</div>
        				</div>
        			</div>
        			<div class="row">
        				<div class="col-lg-12">
        					<div class="card-box">
        						<div>
        							<div class="row">
        								<div class="col-lg-8">
        									<a href="<c:url value='/admin/staff/add' />" class="btn btn-success">Thêm</a>
        								</div>
        								<div class="col-lg-4">
        									<div class="d-none d-sm-block">
        										<form action="<c:url value='/admin/staff/search' />" class="app-search" method="post">
        											<div class="app-search-box">
        												<div class="input-group">
        													<input type="text" class="form-control" placeholder="Search...">
        													<div class="input-group-append">
        														<button class="btn btn-dark" type="submit">
        															<i class="fas fa-search"></i>
        														</button>
        													</div>
        												</div>
        											</div>
        										</form>
        									</div>
        								</div>
        							</div>
        						</div>
        						<br>
        						<form id="form-submit" action="<c:url value='/admin/staff/search' />" method="get">
        							<table class="table table-bordered">
        								<thead>
        									<tr class="thead-dark">
        										<th>Hình</th>
        										<th>Họ và tên</th>
        										<th>E-mail</th>
        										<th>Điện thoại</th>
        										<th>Tài khoản</th>
        										<th>#</th>
        									</tr>
        								</thead>
        								<tbody>
        									<c:forEach var="staff" items="${staffs}">
        										<tr>
        											<td style="width: 5%;">
        												<img src="<c:url value='${staff.photo}' />">
        											</td>
        											<td>${staff.fullname}</td>
        											<td>${staff.email}</td>
        											<td>${staff.phone}</td>
        											<td>${staff.username}</td>
        											<td>
        												<c:url var="editURL" value="/admin/staff/edit">
        													<c:param name="id" value="${staff.id}" />
        												</c:url>
        												<a href="${editURL}" class="btn btn-outline-info">
        													<i class="mdi mdi-pencil-outline"></i>
        												</a>
        												
        												<c:url var="deleteURL" value="/admin/staff/delete">
        													<c:param name="id" value="${staff.id}" />
        												</c:url>
        												<a href="${deleteURL}" class="btn btn-outline-danger">
        													<i class=" mdi mdi-window-close"></i>
        												</a>
        											</td>
        										</tr>
        									</c:forEach>
        								</tbody>
        							</table>
        							<br>
        							<nav aria-label="Page navigation">
										<ul class="pagination" id="pagination"></ul>
										<input type="hidden" id="key" name="key" value=""> 
										<input type="hidden" id="page" name="page" value="">
										<br><br>
									</nav>
        						</form>
        					</div>
        				</div>
        			</div>
        		</div>
        	</div>
        
        	<%@ include file="/WEB-INF/views/admin/common/js.jsp" %>
        	<script src='<c:url value="/template/paging/jquery.twbsPagination.js" />'></script>
        	<script type="text/javascript">
			var totalPages = ${totalPages};
			var currentPage = ${page};
			var limit = ${limit};
			var key = '${key}';
		
			$(function() {
				window.pagObj = $('#pagination').twbsPagination({
					totalPages : totalPages,
					visiblePages : 5,
					startPage : currentPage,
					onPageClick : function(event, page) {
						if (currentPage != page) {
							$('#key').val(key);
							$('#page').val(page);
							$('#form-submit').submit();
						}
					}
				});
			});
		</script>
        </div>
	</body>
</html>