<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<jsp:include page="/PartsOfContent/Head_Import.jsp" flush="false" />
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
					Company <small> History</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="index.html">Home</a></li>
					<li>Company</li>
					<li class="active">History</li>
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

			<!-- Content Column -->
			<div class="col-md-9">

				<div class="row">
					<div class="col-lg-12">
						<h2 class="page-header">History</h2>
					</div>
					<div class="col-lg-10">

						<div id="timeline">
							<div class="row timeline-movement timeline-movement-top">
								<div class="timeline-badge timeline-future-movement">
									<a href="#"> <span class="glyphicon glyphicon-plus"></span>
									</a>
								</div>
								<div class="timeline-badge timeline-filter-movement">
									<a href="#"> <span class="glyphicon glyphicon-time"></span>
									</a>
								</div>

							</div>
							<div class="row timeline-movement">

								<div class="timeline-badge">
									<span class="timeline-balloon-date-day">18</span> <span
										class="timeline-balloon-date-month">APR</span>
								</div>


								<div class="col-sm-6  timeline-item">
									<div class="row">
										<div class="col-sm-11">
											<div class="timeline-panel credits">
												<ul class="timeline-panel-ul">
													<li><span class="importo">Mussum ipsum cacilds</span></li>
													<li><span class="causale">Lorem ipsum dolor sit
															amet, consectetur adipiscing elit. </span></li>
													<li><p>
															<small class="text-muted"><i
																class="glyphicon glyphicon-time"></i> 11/09/2014</small>
														</p></li>
												</ul>
											</div>

										</div>
									</div>
								</div>

								<div class="col-sm-6  timeline-item">
									<div class="row">
										<div class="col-sm-offset-1 col-sm-11">
											<div class="timeline-panel debits">
												<ul class="timeline-panel-ul">
													<li><span class="importo">Mussum ipsum cacilds</span></li>
													<li><span class="causale">Lorem ipsum dolor sit
															amet, consectetur adipiscing elit. </span></li>
													<li><p>
															<small class="text-muted"><i
																class="glyphicon glyphicon-time"></i> 11/09/2014</small>
														</p></li>
												</ul>
											</div>

										</div>
									</div>
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /.row -->
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