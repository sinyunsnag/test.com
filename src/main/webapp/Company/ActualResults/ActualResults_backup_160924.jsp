<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<!-- Head_Import -->
<!-- /////////// -->
<!-- /PartsOfContent/Head_Import.jsp -->
<jsp:include page="/PartsOfContent/Head_Import.jsp" flush="false" />
<!-- /////////// -->
</head>

<body>
	<%--참조사이트
1. http://bootsnipp.com/snippets/featured/easy-image-gallery-in-a-modal 이미지 모달
 --%>

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

		<!-- Page Heading/Breadcrumbs  SPA방식으로 추후변경 -->
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">
					Company<small> ActualResults</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="/">Home</a></li>
					<li>Company</li>
					<li class="active">ActualResults</li>
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
				<!-- Content Column -->

				<!-- Gallery - START -->

				<div class="row">
					<div class="text-center">
						<h1>Sample Image Gallery</h1>
					</div>
					<div class="row">
						<div class="col-md-4">
							<div class="well">
								<img class="thumbnail img-responsive" alt="Bootstrap template"
									src="http://www.prepbootstrap.com/Content/images/shared/houses/h9.jpg" />
							</div>
						</div>
						<div class="col-md-4">
							<div class="well">
								<img class="thumbnail img-responsive" alt="Bootstrap template"
									src="http://www.prepbootstrap.com/Content/images/shared/houses/h8.jpg" />
							</div>
						</div>
						<div class="col-md-4">
							<div class="well">
								<img class="thumbnail img-responsive" alt="Bootstrap template"
									src="http://www.prepbootstrap.com/Content/images/shared/houses/h4.jpg" />
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-4">
							<div class="well">
								<img class="thumbnail img-responsive" alt="Bootstrap template"
									src="http://www.prepbootstrap.com/Content/images/shared/houses/h7.jpg" />
							</div>
						</div>
						<div class="col-md-4">
							<div class="well">
								<img class="thumbnail img-responsive" alt="Bootstrap template"
									src="http://www.prepbootstrap.com/Content/images/shared/houses/h3.jpg" />
							</div>
						</div>
						<div class="col-md-4">
							<div class="well">
								<img class="thumbnail img-responsive" alt="Bootstrap template"
									src="http://www.prepbootstrap.com/Content/images/shared/houses/h6.jpg" />
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-4">
							<div class="well">
								<img class="thumbnail img-responsive" alt="Bootstrap template"
									src="http://www.prepbootstrap.com/Content/images/shared/houses/h1.jpg" />
							</div>
						</div>
						<div class="col-md-4">
							<div class="well">
								<img class="thumbnail img-responsive" alt="Bootstrap template"
									src="http://www.prepbootstrap.com/Content/images/shared/houses/h2.jpg" />
							</div>
						</div>
						<div class="col-md-4">
							<div class="well">
								<img class="thumbnail img-responsive" alt="Bootstrap template"
									src="http://www.prepbootstrap.com/Content/images/shared/houses/h5.jpg" />
							</div>
						</div>
					</div>
				</div>
				<!-- Gallery - END -->

			</div>
		</div>
	</div>
	<!-- /.container -->

	<!-- Footer -->
	<footer>
		<!--/////////////////////////////////////////////////// 
			/PartsOfContent/SiteFooter/FrontFooter.jsp
			-->
		<jsp:include page="/PartsOfContent/SiteFooter/FrontFooter.jsp"
			flush="false" />
		<!--/////////////////////////////////////////////////// -->
	</footer>



</body>

</html>