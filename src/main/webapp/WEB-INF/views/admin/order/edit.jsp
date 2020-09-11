<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
        								<c:if test="${check}">
        									<li class="breadcrumb-item active">Cập nhật</li>
        								</c:if>
        								<c:if test="${!check}">
        									<li class="breadcrumb-item active">Thêm mới</li>
        								</c:if>
        							</ol>
        						</div>
        						<c:if test="${check}">
        							<h4 class="page-title">Cập nhật hóa đơn</h4>
        						</c:if>
        						<c:if test="${!check}">
        							<h4 class="page-title">Thêm mới hóa đơn</h4>
        						</c:if>
        					</div>
        				</div>
        			</div>
        			<div class="row">
        				<div class="col-lg-12">
        					<div class="card-box">
        						<div class="row">
        							<c:url var="action" value="/admin/order/save" />
        							<form:form action="${action}" modelAttribute="orders" cssClass="col-lg-12" 
        									onsubmit="return checkValidated()" data-parsley-validate="" novalidate="">
        								<div class="form-group row">
        									<label class="col-lg-2 col-form-label">
        										Ngày Đặt <span class="text-danger"> (*) </span>
        									</label>
        									<div class="col-lg-10">
        										<form:input path="orderDate" cssClass="form-control" type="date" id="orderDate" value="${orders.orderDate}"/>
        										<ul class="parsley-errors-list filled">
        											<li id="warningOrderDate" class="parsley-required"></li>
        										</ul>
        									</div>
        								</div>
        								<div class="form-group row">
        									<label class="col-lg-2 col-form-label">
        										Mã Hóa Đơn <span class="text-danger"> (*) </span>
        									</label>
        									<div class="col-lg-10">
        										<form:input path="orderCode" cssClass="form-control"/>
        										<ul class="parsley-errors-list filled">
        											<li id="warningOrderCode" class="parsley-required"></li>
        										</ul>
        									</div>
        								</div>
        								<div class="form-group row">
        									<label class="col-lg-2 col-form-label">
        										Trạng Thái <span class="text-danger"> (*) </span>
        									</label>
        									<div class="col-lg-10">
        										<form:select path="status" cssClass="form-control">
        											<form:option value="">-- Lựa chọn trạng thái --</form:option>
        												<form:option value="1">Đã Giao</form:option>
        												<form:option value="0">Chưa Giao</form:option>
        										</form:select>
        										<ul class="parsley-errors-list filled">
        											<li id="warningStatus" class="parsley-required"></li>
        										</ul>
        									</div>
        								</div>  								
        								<div class="form-group row">
        									<label class="col-lg-2 col-form-label">
        										Họ Và Tên <span class="text-danger"> (*) </span>
        									</label>
        									<div class="col-lg-10">
        										<form:select path="fullname" cssClass="form-control">
        											<form:option value="">-- Lựa chọn họ tên --</form:option>
        											<<c:forEach items="${customers}" var="customer">
        												<form:option value="${customer.fullname}">${customer.fullname}</form:option>
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
        										<button id="submit" type="submit" class="btn btn-outline-success btn-rounded waves-effect waves-light"><i class="ion ion-ios-save"></i>
        											<c:if test="${check}"> Cập nhật </c:if>
        											<c:if test="${!check}"> Thêm </c:if>
        										</button>
        										<c:if test="${check}"> 
        											<form:hidden path="id"/>
        										</c:if>
        										<form:hidden path="flagDelete"/>
        										<button type="reset" class="btn btn-outline-warning btn-rounded waves-effect waves-light"><i class="ion ion-md-refresh"></i>
        											Nhập lại
        										</button>
        									</div>
        								</div>
        							</form:form>
        						</div>
        					</div>
        				</div>
        			</div>
        		</div>
        	</div>
        
        	<%@ include file="/WEB-INF/views/admin/common/js.jsp" %>
        	<script type="text/javascript">
        		var checkValidated = function() {
        			var orderDate = $('#orderDate').val();
        			var orderCode = $('#orderCode').val();
        			var status = $('#status').val();
        			var fullname = $('#fullname').val();
        			
        			var checkOrderDate = false;
        			var checkOrderCode = false;
        			var checkStatus = false;
        			var checkFullname = false;
        			
        			console.log(orderDate)
					 if (orderDate != "") {						 
						$('#warningOrderDate').text('');
						console.log("hello")
						$('#orderDate').removeClass('parsley-error');		
						checkOrderDate= true;
					} else {
						$('#orderDate').addClass('parsley-error');
						$('#warningOrderDate').text('Không được bỏ trống Ngày Đặt!');
						
					} 
					
					if (orderCode.trim().length > 0) {							
						$('#warningOrderCode').text('');
						$('#orderCode').removeClass('parsley-error');
						checkOrderCode = true;						
					}
					else {
						$('#orderCode').addClass('parsley-error');
						$('#warningOrderCode').text('Không được bỏ trống MÃ ĐẶT HÀNG!');
						
					}
					
					if (status.trim().length > 0) {
						$('#warningStatus').text('');
						$('#status').removeClass('parsley-error');
						checkStatus = true;
					} else {
						$('#status').addClass('parsley-error');
						$('#warningStatus').text('Không được bỏ trống TRẠNG  THÁI!');
					} 
					
					if (fullname.trim().length > 0) {
						$('#warningFullname').text('');
						$('#fullname').removeClass('parsley-error');
						checkFullname = true;
					} else {
						$('#fullname').addClass('parsley-error');
						$('#warningFullname').text('Không được bỏ trống HỌ VÀ TÊN!');
					}
					
					
					if ( orderDate && checkOrderCode && checkStatus && checkFullname) {
						return true;
					} else {
						return false;
					}
        		}
        	</script> 
        		
        </div>
	</body>
</html>