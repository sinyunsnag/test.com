﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<%--MasterPage_1 은 회원기본정보 1,2,3 관련페이지 --%>

<head>
<!-- Head_Import -->
<!-- /////////// -->
<jsp:include page="/PartsOfContent/Head_Import.jsp" flush="false" />
<!-- /////////// -->
</head>

<body>
	<!-- FrontHeader
	Company의 마스터 페이지 상에서 Header 
	1. 마스터 헤더 한번 변경해보기 ~!!! container 안으로
	 -->
	<!--  //////////////////////////////////// -->
	<div class="container">
		<!--  //////////////////////////////////// -->
		<jsp:include page="/PartsOfContent/SiteHeader/FrontHeader_Master.jsp"
			flush="false" />
		<!--  //////////////////////////////////// -->
		<!-- Image Container 
container 가 아닌 row로 하는 경우는 전체 영역 다 차지한다. 
-->
		<div class="row">
			<div class="col-lg-12">
				<img src="/Company/zImage/Company_IN(height_280).jpg"
					class="img-responsive res_width" alt="Responsive image">
			</div>
		</div>
	</div>
	<!--  //////////////////////////////////// 
	Header 끝
	-->


	<!-- Page Content -->
	<div class="container">

		<!-- Page Heading/Breadcrumbs -->
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">
					Company <small> ${breadcrumb}</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="/">Home</a></li>
					<li>Company</li>
					<li class="active">${breadcrumb}</li>
				</ol>
			</div>
		</div>
		<!-- /.row -->

		<!-- Content Row -->
		<div class="row">
			<!-- Sidebar Column left메뉴 추후 변경 예정<시작>-->
			<div class="col-md-3">
				<jsp:include page="/Company/CompanyLeftMenu.jsp" flush="false" />
			</div>
			<!-- 끝 -->

			<div class="col-md-9">
				<!-- 소제목 -->
			
			 <c:if
				test="${page_header ne null}">
				<div class="col-lg-12">
					<h2 class="page-header">${page_header}</h2>
				</div>
			</c:if>
				<!-- ----- -->

				<!-- Content Column -->
				<div class="col-lg-12">

					<c:if test="${mode == 'm_bnsForm'}">
						<jsp:include page="/CommonApps/BoardNews/bnsForm.jsp"
							flush="false" />
					</c:if>

					<c:if test="${mode == 'm_bnsList'}">
					<script></script>
						<jsp:include page="/CommonApps/BoardNews/bnsList.jsp"
							flush="false" />
					</c:if>

					<c:if test="${mode == 'm_bnsView'}">
						<jsp:include page="/CommonApps/BoardNews/bnsView.jsp"
							flush="false" />
					</c:if>

					<c:if test="${sessionScope.mode == 'SbnsUpdate'}">
						<jsp:include page="/CommonApps/BoardNews/bnsForm.jsp"
							flush="false" />
					</c:if>


				</div>


			</div>
		</div>
	</div>
	<!-- /.container -->

	<!-- Footer -->
	<footer>
		<!--/////////////////////////////////////////////////// -->
		<jsp:include page="/PartsOfContent/SiteFooter/FrontFooter.jsp"
			flush="false" />
		<!--/////////////////////////////////////////////////// -->
	</footer>


</body>

</html>