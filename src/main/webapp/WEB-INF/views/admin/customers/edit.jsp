<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Coffee Shop | Admin | Customers</title>
		
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
        								<li class="breadcrumb-item"><a href="javascript: void(0);">Nhân Viên</a></li>
        								<c:if test="${check}">
        									<li class="breadcrumb-item active">Cập nhật</li>
        								</c:if>
        								<c:if test="${!check}">
        									<li class="breadcrumb-item active">Thêm mới</li>
        								</c:if>
        							</ol>
        						</div>
        						<c:if test="${check}">
        							<h4 class="page-title">Cập nhật nhân viên</h4>
        						</c:if>
        						<c:if test="${!check}">
        							<h4 class="page-title">Thêm mới nhân viên</h4>
        						</c:if>
        					</div>
        				</div>
        			</div>
        			<div class="row">
        				<div class="col-lg-12">
        					<div class="card-box">
        						<div class="row">
        							<c:url var="action" value="/admin/customers/save" />
        							<form:form action="${action}" modelAttribute="customers" cssClass="col-lg-12" 
        									onsubmit="return checkValidated()" data-parsley-validate="" novalidate="">
        								<div class="form-group row">
        									<label class="col-lg-2 col-form-label">
        										Họ Và Tên <span class="text-danger"> (*) </span>
        									</label>
        									<div class="col-lg-10">
        										<form:input path="fullname" cssClass="form-control"/>
        										<ul class="parsley-errors-list filled">
        											<li id="warningFullname" class="parsley-required"></li>
        										</ul>
        									</div>
        								</div>
        								<div class="form-group row">
        									<label class="col-lg-2 col-form-label">
        										Email <span class="text-danger"> (*) </span>
        									</label>
        									<div class="col-lg-10">
        										<form:input path="email" cssClass="form-control"/>
        										<ul class="parsley-errors-list filled">
        											<li id="warningEmail" class="parsley-required"></li>
        										</ul>
        									</div>
        								</div>
        								<div class="form-group row">
        									<label class="col-lg-2 col-form-label">
        										Địa Chỉ <span class="text-danger"> (*) </span>
        									</label>
        									<div class="col-lg-10">
        										<form:input path="address" cssClass="form-control"/>
        										<ul class="parsley-errors-list filled">
        											<li id="warningAddress" class="parsley-required"></li>
        										</ul>
        									</div>
        								</div>
        								<div class="form-group row">
        									<label class="col-lg-2 col-form-label">
        										Số Điện Thoại <span class="text-danger"> (*) </span>
        									</label>
        									<div class="col-lg-10">
        										<form:input path="phone" cssClass="form-control" type="number"/>
        										<ul class="parsley-errors-list filled">
        											<li id="warningPhone" class="parsley-required"></li>
        										</ul>
        									</div>
        								</div>
        								<div class="form-group row">
        									<label class="col-lg-2 col-form-label">
        										Tên Tài Khoản <span class="text-danger"> (*) </span>
        									</label>
        									<div class="col-lg-10">
        										<form:select path="username" cssClass="form-control">
        											<form:option value="">-- Lựa chọn tài khoản --</form:option>
        											<<c:forEach items="${users}" var="user">
        												<form:option value="${user.username}">${role.username}</form:option>
        											</c:forEach>
        										</form:select>
        										<ul class="parsley-errors-list filled">
        											<li id="warningUsername" class="parsley-required"></li>
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
        			var fullname = $('#fullname').val();
        			var email = $('#email').val();
        			var phone = $('#phone').val();
        			var address = $('#address').val();
        			var username = $('#username').val();
        			
        			var checkFullname = false;
        			var checkEmail = false;
        			var checkPhone = false;
        			var checkAddress = false;
        			var checkUsername = false;
        			
        			var pattten = /^[^ ]+@[^ ]+\.[a-z]{2,3}$/;
        			
					if (fullname.trim().length > 0) {
						$('#warningFullname').text('');
						$('#fullname').removeClass('parsley-error');
						checkFullname = true;
					} else {
						$('#fullname').addClass('parsley-error');
						$('#warningFullname').text('Không được bỏ trống HỌ VÀ TÊN!');
					}
					
					if (email.trim().length > 0) {							
						$('#warningEmail').text('');
						$('#email').removeClass('parsley-error');
						checkEmail = true;
						if(email.match(pattten)){
						
					}
					else {	
						$('#email').addClass('parsley-error');
						$('#warningEmail').text('Không nhập đúng định dạng EMAIL!');
					}}
					else {
						$('#email').addClass('parsley-error');
						$('#warningEmail').text('Không được bỏ trống EMAIL!');
						
					}
					
					if (address.trim().length > 0) {
						$('#warningAddress').text('');
						$('#address').removeClass('parsley-error');
						checkAddress = true;
					} else {
						$('#address').addClass('parsley-error');
						$('#warningAddress').text('Không được bỏ trống ĐỊA CHỈ');
					}
					
					if (phone.trim().length > 0) {
						$('#warningPhone').text('');
						$('#phone').removeClass('parsley-error');
						checkPhone = true;
					} else {
						$('#phone').addClass('parsley-error');
						$('#warningPhone').text('Không được bỏ trống SỐ ĐIỆN THOẠI!');
					}
					
					if (username.trim().length > 0) {
						$('#warningUsername').text('');
						$('#username').removeClass('parsley-error');
						checkUsername = true;
					} else {
						$('#username').addClass('parsley-error');
						$('#warningUsername').text('Không được bỏ trống TÊN TÀI KHOẢN!');
					}
					
					
					if (checkFullname && checkEmail && checkPhone && checkAddress && checkUsername) {
						return true;
					} else {
						return false;
					}
        		}
        	</script> 
        		
        </div>
	</body>
</html>