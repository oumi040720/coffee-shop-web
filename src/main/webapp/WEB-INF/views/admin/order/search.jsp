<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Coffee Shop | Admin | Order</title>
		
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
        								<li class="breadcrumb-item"><a href="javascript: void(0);">Hóa Đơn</a></li>
        								<li class="breadcrumb-item active">Danh sách</li>
        							</ol>
        						</div>
        						<h4 class="page-title">Danh sách hóa đơn</h4>
        					</div>
        				</div>
        			</div>
        			<div class="row">
        				<div class="col-lg-12">
        					<div class="card-box">
        						<div>
        							<div class="row">
        								<div class="col-lg-8">
        									<a href="<c:url value='/admin/order/add' />" 
        									class="btn btn-outline-success btn-rounded waves-effect waves-light"><i class="ion ion-md-add-circle"></i> Thêm</a>
        								</div>
        								<div class="col-lg-4">
        									<div class="d-none d-sm-block">
        										<form action="<c:url value='/admin/order/search' />" class="app-search" method="post">
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
        						<c:if test="${not empty message}">
        							<div>
        								<div class="alert alert-${alert} alert-dismissible fade show mb-0" role="alert">
        									<button type="button" class="close" data-dismiss="alert" aria-label="Close">
        										<span aria-hidden="true">&times;</span>
        									</button>
        									${message}
	        							</div>
	        						</div>
	        						<br>
        						</c:if>
        						<form id="form-submit" action="<c:url value='/admin/order/search' />" method="get">
        							<table class="table table-bordered">
        								<thead>
        									<tr class="thead-dark">
        										<th>Ngày Đặt</th>
        										<th>Mã Hóa Đơn</th>
        										<th>Trạng Thái</th>
        										<th>Họ Và Tên</th>
        										<th>#</th>
        									</tr>
        								</thead>
        								<tbody>
        									<c:forEach var="order" items="${orders}">
        										<tr>
        											<td>${order.orderDate}</td>
        											<td>${order.orderCode}</td>
        											<td>
        											<c:if test="${order.status == 1}">Đã Giao</c:if>
        											<c:if test="${order.status == 0}">Chưa Giao</c:if>
        											</td>
        											<td>${order.fullname}</td>
        											<td>
        												<c:url var="editURL" value="/admin/order/edit">
        													<c:param name="id" value="${order.id}" />
        												</c:url>
        												<a href="${editURL}" class="btn btn-outline-info">
        													<i class=" typcn typcn-edit"></i>
        												</a>
        												<c:url var="editURL" value="/admin/order/edit">
        													<c:param name="id" value="${order.id}" />
        												</c:url>
        												<a href="${editURL}" class="btn btn-outline-info">
        													<i class="mdi mdi-pencil-outline"></i>
        												</a>
        												
        												<c:url var="deleteURL" value="/admin/order/delete">
        													<c:param name="id" value="${order.id}" />
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
			var totalPagess = ${totalPages};
			var currentPages = ${page};
			var limit = ${limit};
		
			$(function() {
				window.pagObj = $('#pagination').twbsPagination({
					totalPagess : totalPagess,
					visiblePages : 5,
					startPage : currentPages,
					onPageClick : function(event, page) {
						if (currentPages != page) {
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