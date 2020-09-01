<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Coffee Shop | Admin | Order</title>

<%@ include file="/WEB-INF/views/admin/common/css.jsp"%>
</head>

<body>
	<div id="wrapper">

		<%@ include file="/WEB-INF/views/admin/common/header.jsp"%>

		<%@ include file="/WEB-INF/views/admin/common/menu.jsp"%>

		<div class="content-page">
			<div class="container-fluid">
				<div class="row">
					<div class="col-12">
						<div class="page-title-box">
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">Uplon</a></li>
									<li class="breadcrumb-item"><a href="javascript: void(0);">Hóa
											Đơn</a></li>
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
									<div class="col-sm-8">
										<a href="<c:url value='/admin/order/add' />"
											class="btn btn-success">Thêm</a>
									</div>
									<div class="col-sm-4">
										<div class="d-none d-sm-block">
											<form action="<c:url value='/admin/order/search' />"
												class="app-search" method="post">
												<div class="app-search-box">
													<div class="input-group">
														<input type="text" name="key" class="form-control"
															placeholder="Search..."> <input type="hidden"
															name="page" value="1">
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
									<div
										class="alert alert-${alert} alert-dismissible fade show mb-0"
										role="alert">
										<button type="button" class="close" data-dismiss="alert"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										${message}
									</div>
								</div>
								<br>
							</c:if>
							<form id="form-submit"
								action="<c:url value='/admin/order/list' />" method="get">
								<table class="table table-bordered" id="my-table">
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
												<td id="length" hidden>${length}</td>
												<td id="orderID[]" hidden>${order.id}</td>
												<td id="orderDate${order.id}">${order.orderDate}</td>
												<td>${order.orderCode}</td>
												<td><c:if test="${order.status == 1}">Đã Giao</c:if> <c:if
														test="${order.status == 0}">Chưa Giao</c:if></td>
												<td>${order.fullname}</td>
												<td><a href="#"
													class="btn btn-outline-info btn-order-detail" data-id="${order.orderCode}"> <i
														class=" typcn typcn-edit"></i>
												</a>
												 <c:url var="editURL" value="/admin/orderdetail/edit">
														<c:param name="orderCode" value="${order.orderCode}" />
													</c:url> <a href="${editURL}" class="btn btn-outline-info"> <i
														class="typcn typcn-edit"></i>
												</a> 
												 <c:url var="editURL" value="/admin/order/edit">
														<c:param name="id" value="${order.id}" />
													</c:url> <a href="${editURL}" class="btn btn-outline-info"> <i
														class="mdi mdi-pencil-outline"></i>
												</a> <c:url var="deleteURL" value="/admin/order/delete">
														<c:param name="id" value="${order.id}" />
													</c:url> <a href="${deleteURL}" class="btn btn-outline-danger">
														<i class=" mdi mdi-window-close"></i>
												</a></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<br>
								<nav aria-label="Page navigation">
									<ul class="pagination" id="pagination"></ul>
									<input type="hidden" id="page" name="page" value=""> <br>
									<br>
								</nav>
							</form>
						</div>
						<div class="row">
							<div class="col-12">
								<!--  Modal content for the above example -->
								<div class="modal fade modal-order-code" tabindex="-1"
									role="dialog" aria-labelledby="myLargeModalLabel"
									aria-hidden="true" style="display: none;">
									<div class="modal-dialog modal-lg">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="myLargeModalLabel">Hóa Đơn
													Chi Tiết</h5>
												<button type="button" class="close" data-dismiss="modal"
													aria-hidden="true">×</button>
											</div>
											<div class="modal-body">
												<div class="row">													
													<form action="${action}"  class="col-lg-12">
														<div class="form-group row">
															<label class="col-lg-2 col-form-label"> Số Lượng
																 <span class="text-danger"> (*) </span>
															</label>
															<div class="col-lg-10">
																<input type="number" id="quantity" Class="form-control" />
															</div>
														</div>
														<div class="form-group row">
															<label class="col-lg-2 col-form-label"> Mã Hóa Đơn
																 <span class="text-danger"> (*) </span>
															</label>
															<div class="col-lg-10">
																<input type="text" Class="form-control" id="order" readonly="readonly"/>
															</div>
														</div>	
														<div class="form-group row">
															<label class="col-lg-2 col-form-label">  Sản Phẩm
																 <span class="text-danger"> (*) </span>
															</label>
															<div class="col-lg-10">
																<input type="text" id="product" Class="form-control" />
																<!-- <select  Class="form-control">
																<option id="product"></option>
																</select> -->
															</div>
														</div>														
														<div class="form-group row">
															<label class="col-lg-2 col-form-label"></label>
															<div class="col-lg-10">
																<button id="submit" type="submit"
																	class="btn btn-success">
																		Cập nhật
																</button>
																<button type="submit" class="btn btn-outline-warning">
																	Xóa</button>
															</div>
														</div>
													</form>
												</div>
											</div>
										</div>
										<!-- /.modal-content -->
									</div>
									<!-- /.modal-dialog -->
								</div>
								<!-- /.modal -->
							</div>
						</div> 
					</div>
				</div>
			</div>
		</div>

		<%@ include file="/WEB-INF/views/admin/common/js.jsp"%>
		<script
			src='<c:url value="/template/paging/jquery.twbsPagination.js" />'></script>
		 <script type="text/javascript">
			var totalPagesss = ${totalPages};
			var currentPagess = ${page};
			var limit = ${limit};
		
			$(function() {
				window.pagObj = $('#pagination').twbsPagination({
					totalPagess : totalPagesss,
					visiblePages : 5,
					startPage : currentPagess,
					onPageClick : function(event, page) {
						if (currentPagess != page) {
							$('#page').val(page);
							$('#form-submit').submit();
						}
					}
				});
			});
		</script>
		<script>
			var a = document.getElementById("length").innerHTML
			 for (var i = 1; i <= a; i++) {
 			
		 		var d = document.getElementById("orderDate"+i).innerHTML
				console.log(d) 
				var today = new Date(d);
				var dd = String(today.getDate()).padStart(2, '0');
				var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
				var yyyy = today.getFullYear();

				today = dd + '-' + mm + '-' + yyyy;
				document.getElementById("orderDate" + i).innerHTML = today;
			}    
		</script>	
		<script type="text/javascript">
		$('.btn-order-detail').on('click', function(){
			$.ajax({
				method: 'GET',
				url: 'http://localhost:9999/coffee-shop/admin/order/orderDetail?orderCode=' + $(this).data('id'),
				success: function(res){
					$('#quantity').val(res[0].quantity);
					$('#order').val(res[0].order);
					$('#product').val(res[0].product);
					$('.modal-order-code').modal('show');
				}
			})
		})
		</script>
	</div>
</body>
</html>