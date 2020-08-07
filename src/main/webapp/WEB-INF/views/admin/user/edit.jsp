<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Coffee Shop | Admin | User</title>
		
		<%@ include file="/WEB-INF/views/admin/common/css.jsp" %>
		<style type="text/css">
		
		</style>
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
        								<li class="breadcrumb-item"><a href="javascript: void(0);">Tài khoản</a></li>
        								<c:if test="${check}">
        									<li class="breadcrumb-item active">Cập nhật</li>
        								</c:if>
        								<c:if test="${!check}">
        									<li class="breadcrumb-item active">Thêm mới</li>
        								</c:if>
        							</ol>
        						</div>
        						<c:if test="${check}">
        							<h4 class="page-title">Cập nhật tài khoản</h4>
        						</c:if>
        						<c:if test="${!check}">
        							<h4 class="page-title">Thêm mới tài khoản</h4>
        						</c:if>
        					</div>
        				</div>
        			</div>
        			<div class="row">
        				<div class="col-lg-12">
        					<div class="card-box">
        						<div class="row">
        							<c:url var="action" value="/admin/user/save" />
        							<form:form action="${action}" modelAttribute="user" cssClass="col-lg-12" 
        									onsubmit="return checkValidated()" data-parsley-validate="" novalidate="">
        								<div class="form-group row">
        									<label class="col-lg-2 col-form-label">
        										Tên tài khoản <span class="text-danger"> (*) </span>
        									</label>
        									<div class="col-lg-10">
        										<form:input path="username" cssClass="form-control"/>
        										<ul class="parsley-errors-list filled">
        											<li id="warningUsername" class="parsley-required"></li>
        										</ul>
        									</div>
        								</div>
        								<div class="form-group row">
        									<label class="col-lg-2 col-form-label">
        										Mật khẩu <span class="text-danger"> (*) </span>
        									</label>
        									<div class="col-lg-10">
        										<form:password path="password" cssClass="form-control"/>
        										<ul class="parsley-errors-list filled">
        											<li id="warningPassword" class="parsley-required"></li>
        										</ul>
        									</div>
        								</div>
        								<div class="form-group row">
        									<label class="col-lg-2 col-form-label">
        										Xác nhận mật khẩu <span class="text-danger"> (*) </span>
        									</label>
        									<div class="col-lg-10">
        										<input type="password" id="confirm" class="form-control">
        										<ul class="parsley-errors-list filled">
        											<li id="warningConfirm" class="parsley-required"></li>
        										</ul>
        									</div>
        								</div>
        								<div class="form-group row">
        									<label class="col-lg-2 col-form-label">
        										Vai trò <span class="text-danger"> (*) </span>
        									</label>
        									<div class="col-lg-10">
        										<form:select path="roleCode" cssClass="form-control">
        											<form:option value="">-- Lựa chọn vai trò --</form:option>
        											<<c:forEach items="${roles}" var="role">
        												<form:option value="${role.roleCode}">${role.roleName}</form:option>
        											</c:forEach>
        										</form:select>
        										<ul class="parsley-errors-list filled">
        											<li id="warningRole" class="parsley-required"></li>
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
        		
        </div>
	</body>
</html>