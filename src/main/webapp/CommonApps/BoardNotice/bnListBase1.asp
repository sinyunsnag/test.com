<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<% ' 이 인클루드를 템플릿 상단데 포함시킨다. %>
<!-- caSetting Start -->
	<!--# include File = "../caSetting.asp" -->
<!-- caSetting  End -->
<base href="<%= Application("SiteURLDir") %>CommonAccessories/BoardNotice/" target="_self">
<script language="javascript">
<!--
	self.name="BoardNotice";
-->
</script>
	<link href="../../Include_css/Style.css" rel="stylesheet" type="text/css">
	<link href="../../Include_css/Object.css" rel="stylesheet" type="text/css">
	<script language="JavaScript" src="../../Include_js/CommonFunctions.js"></script>
	<script language="JavaScript" src="../../Include_js/Function.js"></script>

<%
	Dim pageName,page,bnMode
	Dim bnRS,topCnt,selectedFields,whereClause,orderBy,RSresult
	Dim pgScope,pgStartNbr,pgSize

	pageName = Request.ServerVariables("PATH_INFO")
	'Response.Write(pageName)
	'''''''''''''''''''''''''''''''''''''''''''''
	page = Request("page")'이거 계산식이니깐..
	if page <> "" And IsNumeric(page) then
		page = CInt(page)
	else
		page = 1
	end if


	bnMode = Request("bnMode")
	if  bnMode <> "v" then
		pgScope = 2	'한페이지에 표시되는 페이지범위  갯수(바꿀 필요없음)
		pgStartNbr = Int(page / pgScope) + 1	'현재페이지 /  페이지스코프  + 1	 >>	페이지스코프의 시작번호
		If page MOD pgScope = 0 Then
			pgStartNbr = pgStartNbr - 1	'현재페이지와 페이지스코프을 나눈 몫이 0 이면, 시작페이지의 1을 뺀다.
		else
			pgStartNbr = (pgStartNbr - 1) * pgScope + 1	'다음 페이지스코프의 시작번호
		end if
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''
		if pgSize = "" then pgSize = 12	' 한페이지에 표시되는 행수
		topCnt = page * pgSize	' "100 Percent" '출력되는 리스트 수 (레코드에서 보여지는 리스트 수만을 뽑기 위해서...) 'Top topCnt
		selectedFields = "bnIdx,bnGroup,bnService,bnTitle,noticeDT"
		if SelBnGrp <> "" then
			whereClause = "bnGroup='전체' Or bnGroup = '" & SelBnGrp & "'"
		else
			whereClause = ""
		end if

		orderBy = "bnOrder DESC, bnIdx DESC"
		RSresult = SelectRecord(bnRS, pgSize, topCnt, selectedFields, "vBoardNotice", whereClause, orderBy)
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	else  	'아래는 view모드일 경우
		bnIdx = CInt(Request("bnIdx"))
		if bnIdx = "" then Call ShowAlertMsg("게시판 유효값이 아닙니다.")

		virNbr = Request("virNbr")
		'Page = Request("Page")


		'''''''''''''''''''''''''''''''''''''''''''''''''''''''
		pgSize = 1	' 한페이지에 표시되는 행수
		topCnt = "100 Percent" '출력되는 리스트 수 (레코드에서 보여지는 리스트 수만을 뽑기 위해서...) 'Top topCnt
		selectedFields = "bnIdx,bnGroup,bnService,bnTitle,bnSubTitle,bnContent,noticeDT,bnGroup"
		whereClause = "bnIdx = " & bnIdx
		orderBy = "" '"bnOrder DESC, bnIdx DESC"
		RSresult = SelectRecord(bnRS, pgSize, topCnt, selectedFields, "vBoardNotice", whereClause, orderBy)
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		If RSresult = "NotEmpty" Then
			'bnIdx = bnRS("bnIdx")
			bnGroup = bnRS("bnGroup")
			bnService = bnRS("bnService")
			bnTitle = ReplaceTo(bnRS("bnTitle"), "toHTML")
			bnSubTitle = ReplaceTo(bnRS("bnSubTitle"), "toHTML")
			bnContent = ReplaceTo(bnRS("bnContent"), "toHTML")
			noticeDT = DateValue(bnRS("noticeDT"))
			bnGroup = bnRS("bnGroup")
			CloseRS(bnRS)
		else
			Response.Redirect(pageName & "?page=" & page)
		end if			'If RSresult = "NotEmpty" Then

		'해당조회수증가.
		Call ChangeFvalue("vBoardNotice","viewCount=viewCount+1","bnIdx=" & bnIdx)

		'다음, 이전 게시물 미리보기
		PLN  = PreLoadBeforeNext("plNext", "vBoardNotice", "bnIdx", "bnIdx, bnTitle")
		bnIdxNext = PLN(0)
		bnTitleNext = PLN(1)
		if bnIdxNext <> "" then IdxNextString =  "[ " & bnIdxNext  &  " ] " & bnTitleNext
		PLB  = PreLoadBeforeNext("plBefore", "vBoardNotice", "bnIdx", "bnIdx, bnTitle")
		bnIdxBefore = PLB(0)
		bnTitleBefore= PLB(1)
		if bnIdxBefore <> "" then IdxBeforeString =  "[ " & bnIdxBefore  &  " ] "  & bnTitleBefore
	end if

%>

<%
	'기본 디폴트로 bnMode가 널이면 무조건 리스트가 출력

	if  bnMode <> "v" then
%>
<table width="477" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td background="Images/notice_bg1.gif" width="55"><img src="Images/notice_1.gif" width="55" height="15"></td>
                      <td background="Images/notice_bg1.gif" width="257"><img src="Images/notice_2.gif" width="16" height="15"></td>
                      <td background="Images/notice_bg1.gif" width="65"><img src="Images/notice_2.gif" width="16" height="15"></td>
                      <td background="Images/notice_bg1.gif" width="100" align="right"><img src="Images/notice_3.gif" width="16" height="15"></td>
                    </tr>
                    <tr>
                      <td><img src="Images/notice_tit1.gif" width="31" height="20"></td>
                      <td><img src="Images/notice_tit2.gif" width="35" height="20"></td>
                      <td><img src="Images/notice_tit3.gif" width="44" height="20"></td>
                      <td><img src="Images/notice_tit4.gif" width="37" height="20"></td>
                    </tr>
                    <tr>
                      <td height="5" colspan="4" background="Images/notice_line1.gif"></td>
                    </tr>
<%

	If RSresult = "NotEmpty" Then

		bnRS.AbsolutePage = page
		'Response.Write(bnRS.PageSize)

		Dim totRC, virNbr
		totRC = GetRecordCount("vBoardNotice", whereClause)		'글번호
		virNbr = totRC - ((page - 1) * pgSize)	' 게시물 번호를 구하는 것이라오~

		'Do Until bnRS.EOF  Or i > bnRS.PageSize = pgSize			'조건이 거짓이면 수행하고, 참이면 벗어난다. Do While과 반대.
		for i = 1 to bnRS.PageSize
			if (bnRS.EOF) then Exit for
			bnIdx = bnRS("bnIdx")
			bnGroup = bnRS("bnGroup")
			bnService = bnRS("bnService")
			bnTitle = bnRS("bnTitle")
			noticeDT = bnRS("noticeDT")
%>

                    <tr class="body16" onmouseover="this.style.background='#FAFAFA'"
              onmouseout="this.style.background='#ffffff'">
                      <td height="18"><div align="center"><%= bnIdx %>.</div></td>
                      <td><A HREF="<%=pageName%>?bnMode=v&bnIdx=<%=CInt(bnIdx)%>&virNbr=<%=virNbr%>&page=<%=page%>"><%= ReplaceTo(ShortenString(bnTitle, 23), "toHTML") %></A></td>
                      <td><div align="center"><%= bnGroup %></div></td>
                      <td><div align="center"><%= DateValue(noticeDT) %></div></td>
                    </tr>
                    <tr>
                      <td height="5" colspan="4" background="Images/notice_dot1.gif"></td>
                    </tr>
<%
			virNbr = virNbr - 1
			bnRS.MoveNext
		Next
		'Loop
		CloseRS(bnRS)

	Else			'''''''''''''''''''''''''''''''''''''''''''''''''
%>
  <TR>
    <TD Colspan="4" Align="center" Height="25">등록된 내용이 없습니다.</TD>
  </TR>
  <TR>
    <TD Colspan="4" background="Images/dotline.gif"></TD>
  </TR>
<% End If %>
                    <tr class="body16" onmouseover="this.style.background='#FAFAFA'"
              onmouseout="this.style.background='#ffffff'">
                      <td height="18"><div align="center">
                      </div></td>
                      <td><%Call MakePageScope(pgStartNbr, pageName & "?bnMode=li&iBranch=" & iBranch, pgScope, pgSize, page, totRC)%></td>
                      <td><div align="center"></div></td>
                      <td><div align="center">
		<A HREF="javascript:OpenWindow('<%= Application("SiteURLDir") %>CommonAccessories/BoardNotice/bnForm.asp?bnMode=i&bnGroup=<%=SelBnGrp%>','bnPopup','scrollbars=yes,resizable=no,width=600,height=470')">
	  <img src="Images/bnWrite.gif" width="47" height="22" border="0" ></A>
	  <% If Session("sLevel4") <> "" Then %>
	  <a href="../../Admin/Staffs/StfExit.asp?bnMode=logout"><img src="Images/bnLogout.gif" width="22" height="22" border="0"></a>
	  <% end if %>
	  	</div></td>
                    </tr>
                    <tr>
                      <td height="5" colspan="4" background="Images/notice_line2.gif"></td>
                    </tr>
</table>
<%
	else  		'view 모드
%>

<table width="490" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td background="Images/notice_bg1.gif" width="25"><img src="Images/notice_2.gif" width="16" height="15"></td>
    <td width="320" background="Images/notice_bg1.gif"><img src="Images/notice_2.gif"></td>
    <td background="Images/notice_bg1.gif" width="60"><img src="Images/notice_2.gif"></td>
    <td  width="70" background="Images/notice_bg1.gif"><img src="Images/notice_2.gif"></td>
    <td  width="16" background="Images/notice_bg1.gif"><img src="Images/notice_3.gif" ></td>
  </tr>
  <tr class="body16">
    <td height="18">
      <div align="center"><font color="#40808A"> <%=bnIdx%></font></div></td>
    <td> <font color="#40808A">&nbsp; <%= bnTitle %></font></td>
    <td>
      <div align="center"><font color="#40808A"><%= bnGroup %></font></div></td>
    <td colspan="2">
      <div align="center"><font color="#40808A"><%= noticeDT %></font></div></td>
  </tr>
  <tr>
    <td height="5" colspan="5" background="Images/notice_line1.gif"></td>
  </tr>
  <tr valign="top" class="body16" >
    <td  Height="244" colspan="5" style="padding-top:15;padding-left:15;padding-right:15;padding-bottom:15"><div id="boxScroll">
      <p alin=justify><font color="8A4F41"><b><%= bnSubTitle %></b></font><br>
          <br>
          <%= bnContent %>
    </div></td>
  </tr>
  <tr>
    <td height="5" colspan="5" background="Images/notice_line2.gif"></td>
  </tr>
  <tr align="center">
    <td colspan="5"><table width="98%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="50" height="25"><div align="center" class="body16">
      <div align="left"><font color="#40808A">[next]<br>
    </font></div>
    </div></td>
    <td><A HREF="<%= pageName %>?bnMode=v&bnIdx=<%=bnIdxNext%>&virNbr=<%=virNbr + 1%>&page=<%=page%>"><%=ReplaceTo(ShortenString(IdxNextString, 30),  "toHTML")%></A></td>
  </tr>
  <tr>
    <td height="25"><div align="center" class="body16">
      <div align="left"><font color="#40808A">[preview] </font></div>
    </div></td>
    <td><A HREF="<%= pageName %>?bnMode=v&bnIdx=<%=bnIdxBefore%>&virNbr=<%=virNbr - 1%>&page=<%=page%>"><%=ReplaceTo(ShortenString(IdxBeforeString, 30),  "toHTML")%></A></td>
  </tr>
</table>      </td>
  </tr>
  <tr>
    <td height="5" colspan="5" background="Images/notice_line3.gif"></td>
  </tr>
  <tr>
    <td height="30" colspan="5" style="padding-top:10;padding-left:15;padding-right:15;padding-bottom:10""><div align="right"><nobr><a href="<%= pageName %>?Page=<%=Page%>"><img src="Images/bnList.gif" width="39" height="22" border="0"></a>
          <% If Session("sLevel4") <> "" Then %>
          <a href="javascript:OpenWindow('<%= Application("SiteURLDir") %>CommonAccessories/BoardNotice/bnForm.asp?bnMode=u&bnIdx=<%=bnIdx%>','bnPopup','scrollbars=yes,resizable=no,width=600,height=470')"><img src="Images/bnModify.gif" width="54" height="22" border="0"></a> <a href="javascript:OpenWindow('<%= Application("SiteURLDir") %>Admins/Staffs/LoginBoxForStaff/LoginBoxForStaff.asp?bnMode=d&bnIdx=<%=bnIdx%>','bnPopup','scrollbars=yes,resizable=no,width=600,height=470')"><img src="Images/bnDelete.gif" width="55" height="22" border="0"></a> <a href="../../Admin/Staffs/StfExit.asp?bnMode=logout"><img src="Images/bnLogout.gif" width="22" height="22" border="0"></a>
          <% else %>
          <a href="javascript:OpenWindow('<%= Application("SiteURLDir") %>Admins/Staffs/LoginBoxForStaff/LoginBoxForStaff.asp?bnMode=login','bnPopup','scrollbars=yes,resizable=no,width=600,height=470')"><img src="Images/bnLogin.gif" width="22" height="22" border="0"></a>
          <% End If %>
    </nobr> </div></td>
  </tr>
</table>
<%
end if		'if  bnMode <> "v" then
%>





