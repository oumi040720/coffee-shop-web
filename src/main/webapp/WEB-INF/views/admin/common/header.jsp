<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<div class="navbar-custom">
	<ul class="list-unstyled topnav-menu float-right mb-0">
		<li class="dropdown notification-list">
			<a class="nav-link dropdown-toggle nav-user mr-0 waves-effect waves-light" data-toggle="dropdown" href="#" role="button" aria-haspopup="false" aria-expanded="false">
				<img src="<c:url value='/template/admin/images/users/avatar-1.jpg' />" alt="user-image" class="rounded-circle">
				<span class="d-none d-sm-inline-block ml-1 font-weight-medium">Alex M.</span>
				<i class="mdi mdi-chevron-down d-none d-sm-inline-block"></i>
			</a>
			<div class="dropdown-menu dropdown-menu-right profile-dropdown ">
				<div class="dropdown-header noti-title">
					<h6 class="text-overflow text-white m-0">Welcome !</h6>
				</div>
				
				<a href="javascript:void(0);" class="dropdown-item notify-item">
					<i class="mdi mdi-account-outline"></i>
					<span>Profile</span>
				</a>
				
				<a href="javascript:void(0);" class="dropdown-item notify-item">
					<i class="mdi mdi-settings-outline"></i>
					<span>Settings</span>
				</a>
				
				<a href="javascript:void(0);" class="dropdown-item notify-item">
					<i class="mdi mdi-lock-outline"></i>
					<span>Lock Screen</span>
				</a>
				
				<div class="dropdown-divider"></div>
				
				<a href="javascript:void(0);" class="dropdown-item notify-item">
					<i class="mdi mdi-logout-variant"></i>
					<span>Logout</span>
				</a>
			</div>
		</li>
		
		<li class="dropdown notification-list">
			<a href="javascript:void(0);" class="nav-link right-bar-toggle waves-effect waves-light">
				<i class="mdi mdi-settings-outline noti-icon"></i>
			</a>
		</li>
	</ul>
	
	<div class="logo-box">
		<a href="index.html" class="logo text-center logo-dark">
			<span class="logo-lg">
				<img src="<c:url value='/template/admin/images/logo.png' />" alt="" height="22">
			</span>
			<span class="logo-sm">
				<img src="<c:url value='/template/admin/images/logo-sm.png' />" alt="" height="22">
			</span>
		</a>
		
		<a href="index.html" class="logo text-center logo-light">
			<span class="logo-lg">
				<img src="<c:url value='/template/admin/images/logo-light.png' />" alt="" height="22">
			</span>
			<span class="logo-sm">
				<img src="<c:url value='/template/admin/images/logo-sm-light.png' />" alt="" height="22">
			</span>
		</a>
	</div>
	
	<ul class="list-unstyled topnav-menu topnav-menu-left m-0">
		<li>
       		<button class="button-menu-mobile waves-effect waves-light">
            	<i class="mdi mdi-menu"></i>
          	</button>
     	 </li>
	</ul>
</div>
