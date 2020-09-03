<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
        							<c:url var="action" value="/admin/staff/save" />
        							<form:form action="${action}" modelAttribute="user" cssClass="col-lg-12" 
        									onsubmit="return checkValidated()" data-parsley-validate="" novalidate="">
        								<div class="form-group row">
        									<label class="col-lg-2 col-form-label">
        										Tên nhân viên <span class="text-danger"> (*) </span>
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
        										Ngày Sinh <span class="text-danger"> (*) </span>
        									</label>
        									<div class="col-lg-10">
        										<form:input path="birthday" cssClass="form-control"/>
        										<ul class="parsley-errors-list filled">
        											<li id="warningBirthday" class="parsley-required"></li>
        										</ul>
        									</div>
        								</div>
        								<div class="form-group row">
        									<label class="col-lg-2 col-form-label">
        										E-mail <span class="text-danger"> (*) </span>
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
        										Số điện thoại <span class="text-danger"> (*) </span>
        									</label>
        									<div class="col-lg-10">
        										<form:input path="phone" cssClass="form-control"/>
        										<ul class="parsley-errors-list filled">
        											<li id="warningPhone" class="parsley-required"></li>
        										</ul>
        									</div>
        								</div>
        								<div class="form-group row">
        									<label class="col-lg-2 col-form-label">
        										Địa chỉ <span class="text-danger"> (*) </span>
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
        										Hình ảnh <span class="text-danger"> (*) </span>
        									</label>
        									<div class="col-lg-10">
        										<form:input path="photo" cssClass="form-control"/>
        										<ul class="parsley-errors-list filled">
        											<li id="warningPhoto" class="parsley-required"></li>
        										</ul>
        									</div>
        								</div>
        								<div class="form-group row">
        									<label class="col-lg-2 col-form-label">
        										Tên tài khoản <span class="text-danger"> (*) </span>
        									</label>
        									<div class="col-lg-10">
        										<form:select path="roleCode" cssClass="form-control">
        											<form:option value="">-- Lựa chọn tài khoản --</form:option>
        											<<c:forEach items="${users}" var="user">
        												<form:option value="${user.username}">${user.username}</form:option>
        											</c:forEach>
        										</form:select>
        										<ul class="parsley-errors-list filled">
        											<li id="warningUser" class="parsley-required"></li>
        										</ul>
        									</div>
        								</div>
        								<div class="form-group row">
        									<label class="col-lg-2 col-form-label"></label>
        									<div class="col-lg-10">
        										<button id="submit" type="submit" class="btn btn-success">
        											<c:if test="${check}"> Cập nhật </c:if>
        											<c:if test="${!check}"> Thêm </c:if>
        										</button>
        										<c:if test="${check}"> 
        											<form:hidden path="id"/>
        										</c:if>
        										<form:hidden path="flagDelete"/>
        										<button type="reset" class="btn btn-outline-warning">
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
        	<!-- 
        	<script type="text/javascript">
        		var checkValidated = function() {
        			var username = $('#username').val();
        			var password = $('#password').val();
        			var confirm = $('#confirm').val();
        			var role = $('#roleCode').val();
        			
        			var checkUsername = false;
        			var checkPassword = false;
        			var checkConfirm = false;
        			var checkRole = false;
        			
					if (username.trim().length > 0) {
						$('#warningUsername').text('');
						$('#username').removeClass('parsley-error');
						checkUsername = true;
					} else {
						$('#username').addClass('parsley-error');
						$('#warningUsername').text('Không được bỏ trống TÊN TÀI KHOẢN!');
					}
					
					if (password.trim().length > 0) {
						$('#warningPassword').text('');
						$('#password').removeClass('parsley-error');
						checkPassword = true;
					} else {
						$('#password').addClass('parsley-error');
						$('#warningPassword').text('Không được bỏ trống MẬT KHẨU!');
					}
					
					if (confirm.trim().length > 0) {
						$('#warningConfirm').text('');
						$('#confirm').removeClass('parsley-error');
						checkConfirm = true;
					} else {
						$('#confirm').addClass('parsley-error');
						$('#warningConfirm').text('Không được bỏ trống XÁC NHẬN MẬT KHẨU!');
					}
					
					if (role.trim().length > 0) {
						$('#warningRole').text('');
						$('#roleCode').removeClass('parsley-error');
						checkRole = true;
					} else {
						$('#roleCode').addClass('parsley-error');
						$('#warningRole').text('Không được bỏ trống VAI TRÒ!');
					}
					
					if (checkPassword && checkConfirm) {
						if (password === confirm) {
							$('#warningConfirm').text('');
							$('#confirm').removeClass('parsley-error');
							checkRole = true;
						} else {
							var checkConfirm = false;
		        			$('#confirm').addClass('parsley-error');
							$('#warningConfirm').text('XÁC NHẬN MẬT KHẨU không chính xác!');
						}
					} 
					
					if (checkUsername && checkPassword && checkConfirm && checkRole) {
						return true;
					} else {
						return false;
					}
        		}
        	</script>
        	-->
        </div>
	</body>
</html>