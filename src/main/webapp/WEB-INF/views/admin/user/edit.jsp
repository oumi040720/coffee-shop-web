<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Coffee Shop | Admin | User</title>
		
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
        										<form:input path="username" cssClass="form-control" onfocusout="getUser()"/>
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
        
        	<input id='flag' type="hidden" value='' >
        
        	<%@ include file="/WEB-INF/views/admin/common/js.jsp" %>
        	<c:if test="${!check}">
        		<script type="text/javascript">
	        		var getUser =  function() {
	            		var url = '${domain}' + '/user/username/' + $('#username').val();
	
	            		$.ajax({
	    					 url: url,
	    					 type : "get",
	    					 success: function(result) {
	    						 console.log(result);
	    						 if (!result) {
	    							 $('#flag').val('true');
	    							 $('#warningUsername').text('');
	    							 $('#username').removeClass('parsley-error');
	    						 } else {
	    							 $('#flag').val('false');
	    							 $('#username').addClass('parsley-error');
	    							 $('#warningUsername').text('TÊN TÀI KHOẢN đã tồn tại!');
	    						 }
	    					 }
	    				});
	            	}
        		</script>
        	</c:if>
        	<script type="text/javascript">
        		var checkValidated =  function() {
        			try {
        				var username = $('#username').val();
            			var password = $('#password').val();
            			var confirm = $('#confirm').val();
            			var role = $('#roleCode').val();
            			
            			var checkUsername = false;
            			var checkPassword = false;
            			var checkConfirm = false;
            			var checkRole = false;
            			
            			var flag = $('#flag').val();
            			
            			if (username.trim().length > 0) {
    						$('#warningUsername').text('');
    						$('#username').removeClass('parsley-error');
    						checkUsername = true;
    						
    					} else {
    						$('#username').addClass('parsley-error');
    						$('#warningUsername').text('Không được bỏ trống TÊN TÀI KHOẢN!');
    						checkUsername = false;
    					}
            			
    					if (password.trim().length > 0) {
    						$('#warningPassword').text('');
    						$('#password').removeClass('parsley-error');
    						checkPassword = true;
    					} else {
    						$('#password').addClass('parsley-error');
    						$('#warningPassword').text('Không được bỏ trống MẬT KHẨU!');
    						checkPassword = false;
    					}
    					
    					if (confirm.trim().length > 0) {
    						$('#warningConfirm').text('');
    						$('#confirm').removeClass('parsley-error');
    						checkConfirm = true;
    					} else {
    						$('#confirm').addClass('parsley-error');
    						$('#warningConfirm').text('Không được bỏ trống XÁC NHẬN MẬT KHẨU!');
    						checkConfirm = false;
    					}
    					
    					if (role.trim().length > 0) {
    						$('#warningRole').text('');
    						$('#roleCode').removeClass('parsley-error');
    						checkRole = true;
    					} else {
    						$('#roleCode').addClass('parsley-error');
    						$('#warningRole').text('Không được bỏ trống VAI TRÒ!');
    						checkRole = false;
    					}
    					
    					if (checkUsername) {
    						if (flag === 'true') {
    							$('#warningUsername').text('');
							 	$('#username').removeClass('parsley-error');
    							checkUsername = true;
    						} else if (flag === 'false') {
    							$('#username').addClass('parsley-error');
								$('#warningUsername').text('TÊN TÀI KHOẢN đã tồn tại!');
    							checkUsername = false;
    						}
    					} 
    					
    					if (checkPassword && checkConfirm) {
    						if (password === confirm) {
    							$('#warningConfirm').text('');
    							$('#confirm').removeClass('parsley-error');
    							checkPassword = true;
    							checkConfirm = true;
    						} else {
    							checkPassword = false;
    							checkConfirm = false;
    		        			$('#confirm').addClass('parsley-error');
    							$('#warningConfirm').text('XÁC NHẬN MẬT KHẨU không chính xác!');
    						}
    					} 
    					
    					if (checkUsername && checkPassword && checkConfirm && checkRole) {
    						return true;
    					} else {
    						return false;
    					}
        			} catch(err) {
        				return false;
        			}
        		}
        	</script>
        </div>
	</body>
</html>