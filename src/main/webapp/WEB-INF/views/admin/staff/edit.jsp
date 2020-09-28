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
        							<form:form action="${action}" modelAttribute="staff" cssClass="col-lg-12" 
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
        										<form:select path="username" cssClass="form-control">
        											<form:option value="">-- Lựa chọn tài khoản --</form:option>
        											<<c:forEach items="${users}" var="user">
        												<form:option value="${user.username}">${user.username}</form:option>
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
        			var fullname = $('#fullname').val();
        			var birthday = $('#birthday').val();
        			var email = $('#email').val();
        			var phone = $('#phone').val();
        			var address = $('#address').val();
        			var photo = $('#photo').val();
        			var username = $('#username').val();
        			
        			var checkFullname = false;
        			var checkBirthday = false;
        			var checkEmail = false;
        			var checkPhone = false;
        			var checkAddress = false;
        			var checkPhoto = false;
        			var checkUsername = false;
        			
					if (fullname.trim().length > 0) {
						$('#warningFullname').text('');
						$('#fullname').removeClass('parsley-error');
						checkFullname = true;
					} else {
						$('#fullname').addClass('parsley-error');
						$('#warningFullname').text('Không được bỏ trống HỌ VÀ TÊN!');
						checkFullname = false;
					}
					
					if (birthday.trim().length > 0) {
						$('#warningBirthday').text('');
						$('#birthday').removeClass('parsley-error');
						checkBirthday = true;
					} else {
						$('#birthday').addClass('parsley-error');
						$('#warningBirthday').text('Không được bỏ trống NGÀY SINH!');
						checkBirthday = false;
					}
					
					if (email.trim().length > 0) {
						$('#warningEmail').text('');
						$('#email').removeClass('parsley-error');
						checkEmail = true;
					} else {
						$('#email').addClass('parsley-error');
						$('#warningEmail').text('Không được bỏ trống E-MAIL!');
						checkEmail = false;
					}
					
					if (phone.trim().length > 0) {
						$('#warningPhone').text('');
						$('#phone').removeClass('parsley-error');
						checkPhone = true;
					} else {
						$('#phone').addClass('parsley-error');
						$('#warningPhone').text('Không được bỏ trống SỐ ĐIỆN THOẠI!');
						checkPhone = false;
					}
					
					if (address.trim().length > 0) {
						$('#warningAddress').text('');
						$('#address').removeClass('parsley-error');
						checkAddress = true;
					} else {
						$('#address').addClass('parsley-error');
						$('#warningAddress').text('Không được bỏ trống ĐỊA CHỈ!');
						checkAddress = false;
					}
					
					if (photo.trim().length > 0) {
						$('#warningPhoto').text('');
						$('#photo').removeClass('parsley-error');
						checkPhoto = true;
					} else {
						$('#photo').addClass('parsley-error');
						$('#warningPhoto').text('Không được bỏ trống HÌNH ẢNH!');
						checkPhoto = false;
					}
					
					if (username.trim().length > 0) {
						$('#warningUsername').text('');
						$('#username').removeClass('parsley-error');
						checkUsername = true;
					} else {
						$('#username').addClass('parsley-error');
						$('#warningUsername').text('Không được bỏ trống TÊN TÀI KHOẢN!');
						checkUsername = false;
					}
					
					if (checkBirthday) {
						var pattern = new RegExp('[0-3][0-9]/(0|1)[0-9]/(19|20)[0-9]{2}'); 
						if(birthday.match(pattern)) {
							var array = birthday.split('//'); 
							
							var day = array[0]; 
							var month = array[1] - 1;
							var year = date_array[2]; 
							
							sourceDate = new Date(year,month,day); 
							
							if(year != sourceDate.getFullYear()) {
								$('#birthday').addClass('parsley-error');
								$('#warningBirthday').text('Năm của NGÀY SINH không hợp lệ!');
								checkBirthday = false;
							} else {
								$('#warningBirthday').text('');
								$('#birthday').removeClass('parsley-error');
								checkBirthday = true;
							}
							
							if(month != sourceDate.getMonth()) {
								$('#birthday').addClass('parsley-error');
								$('#warningBirthday').text('Tháng của NGÀY SINH không hợp lệ!');
								checkBirthday = false;
							} else {
								$('#warningBirthday').text('');
								$('#birthday').removeClass('parsley-error');
								checkBirthday = true;
							}
							
							if(day != sourceDate.getDate()) {
								$('#birthday').addClass('parsley-error');
								$('#warningBirthday').text('Ngày của NGÀY SINH không hợp lệ!');
								checkBirthday = false;
							} else {
								$('#warningBirthday').text('');
								$('#birthday').removeClass('parsley-error');
								checkBirthday = true;
							}
						} else {
							$('#birthday').addClass('parsley-error');
							$('#warningBirthday').text('Định dạng NGÀY SINH không hợp lệ!');
							checkBirthday = false;
						}
					}
					
					if (checkEmail) {
						var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
						if (filter.test(email)) {
							$('#warningEmail').text('');
							$('#email').removeClass('parsley-error');
							checkEmail = true;
						} else {
							$('#email').addClass('parsley-error');
							$('#warningEmail').text('E-MAIL không hợp lệ!');
							checkEmail = false;
						}
					}
					
					if (checkFullname && checkBirthday && checkEmail && checkPhone && checkAddress && checkPhoto && checkUsername) {
						return true;
					} else {
						return false;
					}
        		}
        	</script>
        </div>
	</body>
</html>