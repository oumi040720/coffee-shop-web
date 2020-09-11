<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Coffee Shop | Admin | OrderDetail</title>

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
									<li class="breadcrumb-item"><a href="javascript: void(0);">Hóa
											Đơn Chi Tiết</a></li>
									<li class="breadcrumb-item active">Danh sách</li>
								</ol>
							</div>
							<h4 class="page-title">Danh sách hóa đơn chi tiết</h4>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="card-box">
							<div>
								<div class="row">
									<div class="col-sm-8">

										<button onclick="myFunction()"
											class="btn btn-outline-success btn-rounded waves-effect waves-light">
											<i class="ion ion-md-add-circle"></i> Thêm
										</button>
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
							<form id="form-submit">
								<table class="table table-bordered" id="my-table">
									<thead>
										<tr class="thead-dark">
											<th>Sản Phẩm</th>
											<th>Mã Hóa Đơn</th>
											<th>Số Lượng</th>
											<th>#</th>
										</tr>
									</thead>
									<tbody id="dataList">

										<c:forEach var="orderDetail" items="${orderDetails}">
											<tr>
												<td>${orderDetail.product}</td>
												<td id="nameCode" accesskey="${orderDetail.order}">${orderDetail.order}</td>
												<td>${orderDetail.quantity}</td>
												<td>
												<button onclick= 'edit("+(dataList.length -1)+")' class='btn btn-outline-info'><i class='mdi mdi-pencil-outline'></i></button>
												<button onclick= 'delete("+(dataList.length -1)+")' class='btn btn-outline-danger'><i class=' mdi mdi-window-close'></i></button>

												</td>
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
					</div>
				</div>
			</div>
			<div class="container-fluid" id="myDIV" style="display: none;">

				<div class="row">
					<div class="col-12">
						<div class="page-title-box">
							<h4 class="page-title" id="myDIV1" style="display: none;">Thêm
								Hóa Đơn Chi Tiết</h4>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="card-box">
							<div class="row">
								<form:form action="" modelAttribute="orderDetails"
									cssClass="col-lg-12" onsubmit="return checkValidated()"
									data-parsley-validate="" novalidate="" method="get">
									<div class="form-group row">
										<label class="col-lg-2 col-form-label"> Số Lượng <span
											class="text-danger"> (*) </span>
										</label>
										<div class="col-lg-2">
											<div class="input-group">
												<span class="input-group-btn">
													<button type="button" onclick="minus()"
														class="quantity-left-minus btn btn-danger btn-number"
														 data-field="">
														<span class="mdi mdi-minus-circle"></span>
													</button>
												</span> <input type="number" id="quantity" name="quantity" style="border:inset;text-align: center;"
													class="form-control mb-3" min="1"
													max="100"> <span class="input-group-btn">
													<button type="button" onclick="plus()"
														class="quantity-right-plus btn btn-success btn-number"
														data-type="plus" data-field="">
														<span class="mdi mdi-plus-circle"></span>
													</button>
												</span>
											</div>
										</div>
									</div>
									<div class="form-group row">
        									<label class="col-lg-2 col-form-label">
        										Mã Hóa Đơn <span class="text-danger"> (*) </span>
        									</label>
        									<div class="col-lg-10">
        										<input id="orderCode" Class="form-control" readonly="readonly"/>
        										<ul class="parsley-errors-list filled">
        											<li id="warningOrderCode" class="parsley-required"></li>
        										</ul>
        									</div>
        								</div> 
									<div class="form-group row">
        									<label class="col-lg-2 col-form-label">
        										Sản Phẩm <span class="text-danger"> (*) </span>
        									</label>
        									<div class="col-lg-10">
        										<form:select path="" cssClass="form-control"  onchange="selected(this)">
        											<form:option value="" id="product">-- Lựa chọn sản phẩm --</form:option>
        											<c:forEach items="${menus}" var="menu">
        												<form:option value="${menu.productName}">${menu.productName}</form:option>
        											</c:forEach>
        										</form:select>
        										<ul class="parsley-errors-list filled">
        											<li id="warningFullname" class="parsley-required"></li>
        										</ul>
        									</div>
        								</div>
									<div class="form-group row">
										<label class="col-lg-2 col-form-label"></label>
										<div class="col-lg-10">
												<button id="btn_click" type="button" onclick="add()"  class="btn btn-success"  > 
												Thêm
												</button>
											<button type="reset" class="btn btn-outline-warning">
												Nhập lại</button>
										</div>
									</div>
								</form:form>
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
			 var dem = 0;		
			function plus() {
				dem ++;
				
				document.getElementById("quantity").value = dem;
			}
			function minus() {
				if(dem > 0){
				--dem;
				console.log(dem)
				}else{
					dem = 0
				}
				document.getElementById("quantity").value = dem;
			}
		</script>
		<script>
			function myFunction() {
				var x = document.getElementById("myDIV");
				var y = document.getElementById("myDIV1");
				var z = document.getElementById("nameCode").getAttribute("accesskey");
				document.getElementById("orderCode").setAttribute("value",z);;
				var m = document.getElementById("orderCode").getAttribute("value");
				if (x.style.display === "none") {
					x.style.display = "block";
				}
				if (y.style.display === "none") {
					y.style.display = "block";
				}
			}
		</script>
		<script type="text/javascript">
		var dataList = [];
		var products = '';		
		function selected(obj) {
			var options = obj.children;			
			var product = document.getElementById('product').innerHTML;
			for(var i = 0 ; i < options.length; i++){
				if(options[i].selected){
					products += options[i].value
				}
			}
			product = products;
		}
			function add() {
				var quantity = document.getElementById("quantity").value;
				var orderCode = document.getElementById("orderCode").value;
				var product = document.getElementById("product").value;
				console.log(products)
				var orderDetail = {
						'quantity' : quantity,
						'orderCode' : orderCode,
						'product' : products,
				};
				if(currenIndex == -1){
					addTag(orderDetail);
				}else{
					dataList[currenIndex] = orderDetail;
					currenIndex = 0
					document.getElementById("btn_click").innnerHTML = "Thêm";
				}
				
			}
			
			function addTag(orderDetail){
				dataList.push(orderDetail);
				console.log(dataList)
				 var table = document.getElementById("dataList");
				table.innerHTML += 
					"<tr>"+
					"<td>" + products + "</td>"+
					"<td>" + orderDetail.orderCode + "</td>"+
					"<td>" + orderDetail.quantity + "</td>"+
					"<td><button onclick= 'edit("+(dataList.length -1)+")' class='btn btn-outline-info'><i class='mdi mdi-pencil-outline'></i></button> <button onclick= 'delete("+(dataList.length -1)+")' class='btn btn-outline-danger'><i class=' mdi mdi-window-close'></i></button></td>"+
					"</tr>"; 
			}
			
			var currenIndex = -1;
			function edit(index){
				var orderDetail = dataList[index];
				document.getElementById("quantity").value = orderDetail.quantity;
				document.getElementById("orderCode").value = orderDetail.orderCode;
				document.getElementById("product").value = orderDetail.products;
				document.getElementById("btn_click").innnerHTML = "Cập Nhật";
			}
			
		</script>
	</div>
</body>
</html>