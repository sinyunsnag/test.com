<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- jQuery Version 1.11.0 -->
<script src="/CommonLibrary/Javascript/Common.js"></script>
<!-- 소제목 -->

<!-- ----- -->

<!-- Content Column 
container 안에 포함시키면된다.

-->
<!-- imsi -->
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css"
	rel="stylesheet">

<input type="hidden" name="pageNum" />
<%-- <div id="table_reset" class="table-responsive">
	<table class="table table-striped">
		<thead>
			<tr>
				<th>NO.</th>
				<th class="hidden-xs">Group</th>
				<th class="hidden-xs">Title</th>
				<th class="hidden-xs">WriteDate</th>
				<th>관리메뉴</th> 삭제예정

			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${fn:length(selectListBnsList) > 0}">
					<c:forEach var="VselectListBnsList" items="${selectListBnsList}">
					
						<tr>
							<input type="hidden" id="bNews_id" name="bNews_id"
								value="${VselectListBnsList.bNews_id }">
							<td class="hidden-xs">${VselectListBnsList.bNews_id}</td>
							<td class="hidden-xs">${VselectListBnsList.bnGroup}</td>
							<td><a
								href="javascript:window.location.href='/board/bnsView.mwav?bNews_id=${VselectListBnsList.bNews_id}'">${VselectListBnsList.bnTitle}</a></td>
							<td class="hidden-xs">${VselectListBnsList.fmbnInsertDt}</td>
							<td> <button type="button" class="btn btn-info" onclick="javascript:window.location.href='/board/bnsView.mwav?bNews_id=${FrontboardList.bNews_id}'">보기</button>&nbsp;
<button type="button" class="btn btn-warning" onclick="javascript:window.location.href='/board/bnsModify.mwav?bNews_id=${FrontboardList.bNews_id}'">수정</button>
</td>
						</tr>
					
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
					HTML 요소로 강제 텍스트 입력시 
						<td colspan="4">조회된 결과가 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</div> --%>

<c:choose>
	<c:when test="${fn:length(selectListBnsList) > 0}">
		<c:forEach var="VselectListBnsList" items="${selectListBnsList}">
			<input type="hidden" id="bNews_id" name="bNews_id"
				value="${VselectListBnsList.bNews_id }">
			<div class="row">
				<div class="col-md-12">
					
					<h4 style="color: #23527c !important;">
						<strong><a
							href="javascript:window.location.href='/board/bnsView.mwav?bNews_id=${VselectListBnsList.bNews_id}'">${VselectListBnsList.bnTitle}</a></strong>
					</h4>

					<p style="color: #78828D;">${VselectListBnsList.bnSubTitle}</p>
					<h6 class="pull-right">
						<span class="glyphicon glyphicon-calendar" aria-hidden="true"> ${VselectListBnsList.fmbnInsertDt}</span>
					</h6>
				</div>
			</div>
			<div class="enter"></div>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<div class="col-md-12">
			<h4>조회된 결과가 없습니다.</h4>
		</div>
	</c:otherwise>
</c:choose>
<!-- Pagination -->
<c:if test="${totalRow > 0}">
	<div class="row text-center">
		<div class="col-lg-12">
			<ul class="pagination">

				<c:if test="${pagingVO.startPage > pagingVO.pageBlock}">
					<li><a
						href="/board/bnsList.mwav?pageNum=${pagingVO.startPage - pagingVO.pageBlock}"><span
							class="glyphicon glyphicon-chevron-left"></span></a></li>
				</c:if>
				<c:forEach var="i" begin="${pagingVO.startPage}"
					end="${pagingVO.endPage}">
					<li><a href="/board/bnsList.mwav?pageNum=${i}">${i}</a></li>
				</c:forEach>
				<c:if test="${pagingVO.endPage < pagingVO.pageCount}">
					<li><a
						href="/board/bnsList.mwav?pageNum=${pagingVO.startPage + pagingVO.pageBlock}"><span
							class="glyphicon glyphicon-chevron-right"></span></a></li>
				</c:if>
				<!-- <li><a href="">&laquo;</a></li>
			<li class="active"><a href="#">1</a></li>
			<li><a href="#">2</a></li>
			<li><a href="#">3</a></li>
			<li><a href="#">4</a></li>
			<li><a href="#">5</a></li>
			<li><a href="#">&raquo;</a></li> -->
			</ul>
		</div>
	</div>
</c:if>

<script type="text/javascript">
	$(document).ready(function() {
		$("#bnsForm").on("click", function(e) { //목록으로 버튼
			e.preventDefault();
			fn_insertbnsForm();
		});

		$("#bnsView").on("click", function(e) { //저장하기 버튼
			e.preventDefault();
			fn_selectbnsView();
		});

		$("#bnsDelete").on("click", function(e) { //삭제하기 버튼
			e.preventDefault();
			fn_deleteBoard();
		});
	});

	function fn_insertbnsForm() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/board/bnsForm.mwav' />");
		comSubmit.submit();
	}

	function fn_selectbnsView() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/board/bnsView.mwav'/>");
		alert('sdf');
		comSubmit.addParam("bNews_id", $("#bNews_id").val());
		comSubmit.submit();
	}

	function fn_deleteBoard() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/board/bnsDelete.mwav' />");
		comSubmit.addParam("bNews_id", $("#bNews_id").val());
		comSubmit.submit();

	}
</script>