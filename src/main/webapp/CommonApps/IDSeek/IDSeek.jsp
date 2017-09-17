<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- imsi -->
<link
	href="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.min.js"
	rel="stylesheet">
<!-- jQuery Version 1.11.0 -->
<%--아래 jquery가 들어가있으면 tooltip등 안먹힌다.  --%>
<!-- <script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
 -->
<!-- function idFindercheck() {
alert('sdfsdf');

$.ajax({
	  type : 'POST', // Http Request Method로 POST로 지정
	  url : '/member/IdFinder.mwav', // 서버 요청 주소
	  contentType : 'application/json;charset=UTF-8', // 서버 요청시 전송할 데이터가 UTF-8 형식의 JSON 객체임을 명시
	  data : JSON.stringify(request), // JavaScript 객체를 JSON 객체로 변환하여 서버 요청시 전송
	  dataType : 'json', // 서버로부터 응답받을 데이터가 JSON 객체임을 명시하여 수작업 없이 응답 데이터를 JavaScript 객체로 획득
	  success : function(response) { alert(response); }, // 서버로부터 응답 데이터 도착시 로직 처리, 응답 데이터는 JavaScript 객체로 바로 사용 가능
	    error : function() { ... } // 서버로부터 응답 데이터 실패시 로직 처리
	});
} 
 -->
<script>
	var xhr;
	function createXhr() {
		if (window.ActiveXObject) { // IE 이전버전
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else {
			xhr = new XMLHttpRequest();
		}
	}

	function selectOneMbrLoginIdSeek() { //idFindercheck()
		var phone = document.getElementById("mbrCellPhone");
		var email = document.getElementById("mbrEmail");

		//html element에 대하여 null 또는 비어있는지 체크 및 alert 문구 노출
		var flag; // return false 여부 체크 이함수도 false 시켜야하므로 
		flag = emptyCheck(phone, "휴대폰번호를 입력해주세요.");
		//alert(flag);
		flag = emptyCheck(email, "이메일을 입력해주세요.");
		//alert(flag);

		if (flag == false || flag == undefined) {
			//alert('11');
			return false;
		} else {
			//alert('22');

			var queryString = "mbrCellPhone=" + phone + "&mbrEmail=" + email;
			if (name == null || email == null) {
				document.getElementById("idcheckLayer").innerHTML = "<font color=red>이름 또는 이메일을 입력하세요.</font>";
			} else {
				// 1. XMLHttpReqeust 객체 생성
				createXhr();
				// 2. 이벤트 핸들러 등록
				xhr.onreadystatechange = callback; // callback 함수를 등록
				// 3. open()를 통해 요청관련 설정을 설정
				xhr.open("POST", "/member/mbrLoginIdSeek.mwav", true);
				// 4. Header에 contentType 지정 - post
				xhr.setRequestHeader("Content-Type",
						"application/x-www-form-urlencoded");
				// 5. send()를 통해 요청
				xhr.send(queryString); // 요청 쿼리를 보내준다.
			}
		}
	}
	function callback() {
		if (xhr.readyState == 4) { // 응답을 다 받은 경우
			if (xhr.status == 200) { // 응답코드가 200인 경우 - 정상인 경우
				var resTxt = xhr.responseText; // 서버가 보낸 응답 text

				document.getElementById("idcheckLayer").innerHTML = resTxt;
			} else {
				alert("요청처리가 정상적으로 되지 않았습니다.\n" + xhr.status);
			}
		}
	}
</script>
<script>
	function mbrTempLoginPwUpdate() { //PWFinder()
		var aa = document.getElementById("pwid");
	//$('#pwid'); undefined 출력
		//document.getElementById("mbrCellPhone");
		var bb = document.getElementById("pwemail");
		//document.getElementById("mbrCellPhone");

		//html element에 대하여 null 또는 비어있는지 체크 및 alert 문구 노출
		var flag; // return false 여부 체크 이함수도 false 시켜야하므로 
		flag = emptyCheck(aa, "회원아이디를 입력해주세요.");
		//alert(flag);
		flag = emptyCheck(bb, "이메일을 입력해주세요.");
		//alert(flag);
		if (flag == false || flag == undefined) {
			//alert('11');
			return false;
		} else {

			var URL = "mbrLoginId=" + aa + "&mbrEmail=" + bb;

			$.ajax({
				type : 'POST', // Http Request Method로 POST로 지정
				url : '/member/mbrTempLoginPwUpdate.mwav', // 서버 요청 주소
				data : URL, // JavaScript 객체를 JSON 객체로 변환하여 서버 요청시 전송
				success : function(data) {
					//alert(data);
					if (data == 'false') {
						alert('해당 회원정보는 존재하지 않습니다.');
						return false;
					} else {

						alert('입력해주신 ' + data
								+ '이메일로 임시PW를 발급완료했습니다. (5분안에 입력해주세요.)');
						document.getElementById("pwid").readOnly = true;
						document.getElementById("pwemail").readOnly = true;
						document.getElementById("pwok").disabled = true;
						$('#imsipwdisplay').css('display', 'block') //to show
						start_timer();
					}

				}, // 서버로부터 응답 데이터 도착시 로직 처리, 응답 데이터는 JavaScript 객체로 바로 사용 가능

				beforeSend : function() {
					//(이미지 보여주기 처리)
					//alert('1');
					$('.wrap-loading').removeClass('display-none');
				},
				complete : function() {
					//(이미지 감추기 처리)
					//alert('2');
					$('.wrap-loading').addClass('display-none');

				},
				error : function(status, error) {
					//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					if (status == 0) {
						alert('You are offline!!n Please Check Your Network.');
					} else if (status == 404) {
						alert('Requested URL not found.');
					} else if (status == 500) {
						alert('Internel Server Error.');
					} else if (error == 'parsererror') {
						alert('Error.nParsing JSON Request failed.');
					} else if (error == 'timeout') {
						alert('Request Time out.');
					} else {
						alert('Unknow Error.n' + request.responseText);
					}
				} // 서버로부터 응답 데이터 실패시 로직 처리
			});
		}
	}
</script>

<script>
	function mbrTempLoginPwSeek() { //imsiPWFinder()
		var before_value = $('#mbrTempLoginPw').val();
		var after_value;
		//공백값 제거
		after_value = trim(before_value);
		var URL = "mbrTempLoginPw=" + after_value;

		$.ajax({
			type : 'POST', // Http Request Method로 POST로 지정
			url : '/member/mbrTempLoginPwSeek.mwav', // 서버 요청 주소
			data : URL, // JavaScript 객체를 JSON 객체로 변환하여 서버 요청시 전송
			success : function(data) {

				if (data == true) {

					$('#PwFinder').css('display', 'none') //to show
					$('#pwfinder_1').css('display', 'block') //to show
					$('#pwfinder_1').addClass('active in') //to show
					alert('비밀번호를 변경합니다.');
					$("#imsi_mbrLoginPw").val(after_value);
					/* alert('aa'+aa);
					lol = $("#imsi_mbrLoginPw").val();
					alert('lol'+lol); */

				} else if (data == false) {
					alert('임시pw가 맞지 않습니다. 메일은 확인하고, 다시 입력해주세요.')
					document.pwform_1.imsipw_.focus();
				}

			}, // 서버로부터 응답 데이터 도착시 로직 처리, 응답 데이터는 JavaScript 객체로 바로 사용 가능

			beforeSend : function() {
				//(이미지 보여주기 처리)
				//alert('1');
				$('.wrap-loading').removeClass('display-none');
			},
			complete : function() {
				//(이미지 감추기 처리)
				//alert('2');
				$('.wrap-loading').addClass('display-none');

			},
			error : function() {
				alert('임시pw가 맞지 않습니다. 메일은 확인하고, 다시 입력해주세요.');

			} // 서버로부터 응답 데이터 실패시 로직 처리
		});
	}
</script>


<script>
	function updateMbrLoginPw(form) { //imsiPWFinder()
		
		// 로그인 및 기타 form 체크
		
			// 참고 a태그에서는 this 인지 못함
			// 원래는 로그인이 최상단 이나, 패스워드 찾기에서 패스워드 변경 부분에서 로그인이 위에있으면 그냥 통과라 변경
			// 추후 필히 변경 필요.
			if (form.mbrLoginPw.value.length == 0) {
				alert("패스워드를 입력해주세요");
				form.mbrLoginPw.focus();
				return false;
			}
			if (form.mbrLoginPw.value != form.mbrLoginPw_check.value) {
				alert("패스워드를 다시확인해주세요.");
				form.mbrLoginPw_check.focus();
				return false;
			}
		
		
		
		
		var imsi_mbrLoginPw = $('#imsi_mbrLoginPw').val();
		var mbrLoginPw = $('#mbrLoginPw_chk').val();
		var after_value;
		var after_value_;
		
		//공백값 제거
		after_value = trim(imsi_mbrLoginPw);
		after_value_ = trim(mbrLoginPw);
		var URL = "imsi_mbrLoginPw=" + after_value +"&mbrLoginPw="+after_value_;

		$.ajax({
			type : 'POST', // Http Request Method로 POST로 지정
			url : '/member/mbrLoginPwUpdate.mwav', // 서버 요청 주소
			data : URL, // JavaScript 객체를 JSON 객체로 변환하여 서버 요청시 전송
			success : function(data) {

				if (data == true) {
					alert('비밀번호를 변경합니다.');
					document.location="/MasterPage.jsp?mode=SMbrLogin";
					return true;
					
				} else if (data == false) {
					alert('이전에 사용한 비밀번호로 변경이 불가능합니다.');
					return false;
				}

			}, // 서버로부터 응답 데이터 도착시 로직 처리, 응답 데이터는 JavaScript 객체로 바로 사용 가능

			beforeSend : function() {
				//(이미지 보여주기 처리)
				//alert('1');
				$('.wrap-loading').removeClass('display-none');
			},
			complete : function() {
				//(이미지 감추기 처리)
				//alert('2');
				$('.wrap-loading').addClass('display-none');

			},
			error : function() {
				alert('pw가 맞지 않습니다.다시 입력해주세요.');
				

			} // 서버로부터 응답 데이터 실패시 로직 처리
		});
	}
</script>

<style>
.wrap-loading_images { /*로딩 이미지*/
	position: fixed;
	top: 50%;
	left: 50%;
	margin-left: -21px;
	margin-top: -21px;
}

.display-none { /*감추기*/
	display: none;
}

.wrap-loading { /*화면 전체를 어둡게 합니다.*/
	position: fixed;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	z-index: 10000;
	background: rgba(0, 0, 0, 0.2); /*not in ie */
	filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000',
		endColorstr='#20000000'; /* ie */
}
</style>
<div class="container">
	<!-- Modal -->
	<div class="modal fade IDPWSeek" id="IDPWSeek" tabindex="-1"
		role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="wrap-loading display-none">
				<img class="wrap-loading_images "
					src="/CommonApps/PostSeek/Images/ajax-loader.gif">
			</div>
			<div class="modal-content">
				<br>
				<div class="bs-example bs-example-tabs">
					<ul id="myTab" class="nav nav-tabs">
						<li class="active"><a href="#IdFinder" data-toggle="tab">IDSeek</a></li>
						<li class=""><a href="#PwFinder" data-toggle="tab">PWSeek</a></li>
						<li class="pull-right" style="right:15px;"><button type="button" class="close" data-dismiss="modal" aria-label="Close"><i class="fa fa-times" aria-hidden="true"></i></button></li>
					</ul>

				</div>
				<div class="modal-body">
					<div class="container-fluid">
						<div id="myTabContent" class="tab-content">
							<div class="tab-pane active fade in" id="IdFinder">
								<h2>아이디 찾기</h2>
								<p>아이디를 잊어버리셨나요? 아래 입력사항에 가입하실때 작성하신 정보를 입력해주세요! 가입시 이메일로
									전송됩니다.</p>
								
								<div class="col-xs-12 col-sm-12 col-md-12 enter">
									<div class="col-md-4 mgt4">휴대폰</div>
									<div class="col-md-8 mgt4">
										<input type="text" id="mbrCellPhone" class="form-control caps_lockchk"
											placeholder="휴대폰 번호" required>
									</div>
									
									<div class="col-md-4 mgt4">이메일</div>
									<div class="col-md-8 mgt4">
										<input type="text" id="mbrEmail" class="form-control caps_lockchk"
											placeholder="이메일" onchange="chkEmailPolicy(this.value, this)" required>
									</div>
								</div>


								<!-- 								<div id="idcheckLayer" class="col-md-offset-4 col-md-8"></div>
 -->
								<%--아이디찾기 표기부분 col-xs-12 col-sm-12 표기안하면 전체를 덮는다. --%>
								<div id="idcheckLayer" class="col-xs-12 col-sm-12 col-md-12"></div>
								<div class="col-xs-12 col-sm-12 col-md-12 enter">
									<button type="button" class="btn btn-block btn-sm btn-info"
										onclick="selectOneMbrLoginIdSeek()">확인</button>
								</div>

							</div>
							<div class="tab-pane fade" id="PwFinder">
								<form class="form-horizontal">
										<h2>비밀번호 찾기</h2>
										<p>비밀번호를 잊어버리셨나요? 아래 입력사항에 가입하실때 작성하신 정보를 입력해주세요! 가입시 이메일로
											전송됩니다.</p>
										<br />


										<div class="col-xs-12 col-sm-12 col-md-12">
											<div class="col-md-4 mgt4">아이디</div>
											<div class="col-md-8 mgt4">
												<input type="text" id="pwid" class="form-control caps_lockchk"
													placeholder="회원아이디" required>
											</div>

											<div class="col-md-4 mgt4">이메일</div>
											<div class="col-md-8 mgt4">
												<input type="text" id="pwemail" class="form-control caps_lockchk"
													placeholder="이메일" onchange="chkEmailPolicy(this.value, this)" required>
											</div>
											<div class="enter"></div>

										</div>
										
										

										<div class="col-md-12 enter">
											<button type="button" id="pwok"
												class="btn btn-block btn-sm btn-info"
												onclick="mbrTempLoginPwUpdate()">찾기</button>
										</div>
									
								</form>
								<form class="form-horizontal" name="pwform_1">
									<div class="row">
										<div class="col-md-12 mgt5" id="imsipwdisplay"
											style="display: none;">
											<div class="col-md-12">
												<%-- <div class="col-sm-4 col-sm-4 col-md-4">남은시간</div>
												타이머
												<div class="col-sm-8 col-sm-8 mgb3">
													<strong id="time1" class="text-danger"></strong>
												</div> --%>

												<div class='alert alert-danger text-center'>
													<strong class="text-danger">남은 시간은 </strong><strong
														id="time1" class="text-danger"></strong>
												</div>

												<div class="col-md-4 mgt4">임시비밀번호</div>
												<div class="col-md-8 ">
													<input type="text" name="imsipw_" id="mbrTempLoginPw"
														class="form-control caps_lockchk" placeholder="임시비밀번호.." >
												</div>
											</div>

											<div class="col-md-12 enter">
												<button type="button"
													class="btn btn-block btn-sm btn-danger"
													onclick="mbrTempLoginPwSeek()">찾기</button>
											</div>
										</div>
										<p></p>
									</div>
								</form>
								<!-- 리로드 -> imsipw 확인시 ajax 후 변경처리 reload -->
							</div>

							<div class="tab-pane fade" id="pwfinder_1" style="display: none;">
								<form name="pwform" class="form-horizontal" >
									<h2>비밀번호 변경</h2>
									<!-- <p>비밀번호를 변경합니다.</p> -->
									<br />

									<div class="col-md-8">
										<div class="col-md-4 mgt4">변경 할 PW</div>
										<div class="col-md-8 mgt4">
											<input type="password" name="mbrLoginPw" id="mbrLoginPw_chk" class="form-control caps_lockchk"
												onchange="chkPWPolicy(this.value, this)" placeholder="Password">
										</div>
										<input type="hidden" name="imsi_mbrLoginPw"
											id="imsi_mbrLoginPw" value="">
										<div class="col-md-4 mgt4">PW 재확인</div>
										<div class="col-md-8 mgt4">
											<input type="password" class="form-control caps_lockchk"
												onchange="chkPWPolicy(this.value, this)" placeholder="Confirm Password" name="mbrLoginPw_check">
										</div>
									</div>

									<div class="col-md-12 enter">
										<button type="button" id="pwok"
											class="btn btn-block btn-sm btn-primary" onclick="updateMbrLoginPw(document.pwform)">변경</button>
									</div>
								</form>
								<form class="form-horizontal">
									<div class="col-md-12 mgt5" id="imsipwdisplay"
										style="display: none;">
										<div class="col-md-8">
											<div class="col-md-4">남은시간</div>
											<div class="col-md-8" id="time1" style="color: red"></div>
											<div class="col-md-8 col-md-offset-4">
												<input type="text" id="imsipw" class="form-control caps_lockchk"
													placeholder="ImsiPw...">
											</div>
										</div>
										<div>
											<button type="button" class="btn btn-sm btn-info" onclick="">확인</button>
										</div>
									</div>
									<p></p>
								</form>
								<!-- 리로드 -> imsipw 확인시 ajax 후 변경처리 reload -->
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</div>