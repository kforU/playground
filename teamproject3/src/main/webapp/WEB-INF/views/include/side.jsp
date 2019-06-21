<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<div id="MainSidenav" class="sidenav">
	<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
	<div class="sidebar">
		<!-- User Widget -->
		<div class="widget user-dashboard-profile">
			<!-- User Image -->
			<div class="profile-thumb">
				<img src="${ path }/resources/images/user/user-thumb.jpg" alt="" class="rounded-circle">
			</div>
			<!-- User Name -->
			<h5 class="text-center">Samanta Doe</h5>
			<p>Joined February 06, 2017</p>
			<a href="user-profile.html" class="btn btn-main-sm">Edit Profile</a>
		</div>
		<!-- Dashboard Links -->

			<ul>
				<li><a href="dashboard-my-ads.html"><i class="fa fa-user"></i> My Ads</a></li>
				<li class="active"  >
					<a href="dashboard-favourite-ads.html"><i class="fa fa-bookmark-o"></i> Favourite Ads <span>5</span></a>
				</li>
				<li>
					<a href="dashboard-archived-ads.html"><i class="fa fa-file-archive-o"></i>Archeved Ads <span>12</span></a>
				</li>
				<li>
					<a href="dashboard-pending-ads.html"><i class="fa fa-bolt"></i> Pending Approval<span>23</span></a>
				</li>
				<li>
					<a href="logout.html"><i class="fa fa-cog"></i> Logout</a>
				</li>
				<li>
					<a href="delete-account.html"><i class="fa fa-power-off"></i>Delete Account</a>
				</li>
			</ul>
		
	</div>
			


</div>