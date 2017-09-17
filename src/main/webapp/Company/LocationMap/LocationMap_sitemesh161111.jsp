<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

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
					Company <small> LocationMap</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="index.html">Home</a></li>
					<li>Company</li>
					<li class="active">LocationMap</li>
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

				<div class="enter"></div>
				<!-- Content Column -->
				<div class="col-md-8">
					<!-- Embedded Google Map 
					http://www.thewordcracker.com/scribblings/how-to-embed-googlemap-to-blogs/
					-->
					<iframe width="100%" height="400px" frameborder="0" scrolling="no"
						marginheight="0" marginwidth="0"
						src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3163.9550746795585!2d127.07577181478221!3d37.532556284051026!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca4e4811fdfcd%3A0xdd8daef36b445a0a!2z7ISc7Jq47Yq567OE7IucIOq0keynhOq1rCDsnpDslpEy64-ZIDYwNy0yMA!5e0!3m2!1sko!2skr!4v1448867907317"></iframe>
				</div>
				<div class="col-md-4">
					<h3>Contact Details</h3>
					<p>
						607-20, Jayang-dong, <br>Gwangjin-gu, Seoul, <br> Korea
						GV4F
					</p>
					<p>
						<i class="fa fa-phone"></i> <abbr title="Phone">P</abbr>:
						+82-2-6214-7039
					</p>
					<p>
						<i class="fa fa-envelope-o"></i> <abbr title="Email">E</abbr>: <a
							href="mailto:ebizpromwav@gmail.com">ebizpromwav@gmail.com</a>
					</p>
					<p>
						<i class="fa fa-clock-o"></i> <abbr title="Hours">H</abbr>: Monday
						- Friday: <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						9:00 AM to 6:00 PM
					</p>
					<ul class="list-unstyled list-inline list-social-icons">
						<li><a class="btn btn-social-icon btn-twitter"> <span
								class="fa fa-twitter"></span>
						</a></li>
						<li><a class="btn btn-social-icon btn-facebook"> <span
								class="fa fa-facebook"></span>
						</a></li>
						<li><a class="btn btn-social-icon btn-google"> <span
								class="fa fa-google"></span>
						</a></li>
						<li><a class="btn btn-social-icon btn-linkedin"> <span
								class="fa fa-linkedin"></span>
						</a></li>
					</ul>
				</div>

				<!-- /.row -->

			</div>
		</div>
	</div>
	<!-- /.container -->

	<!-- Footer -->
	<footer>
		<!--/////////////////////////////////////////////////// -->
		<jsp:include page="../../PartsOfContent/SiteFooter/FrontFooter.jsp"
			flush="false" />
		<!--/////////////////////////////////////////////////// -->
	</footer>


</body>

</html>

