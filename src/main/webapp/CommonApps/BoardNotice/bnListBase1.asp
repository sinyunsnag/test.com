<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<% ' �� ��Ŭ��带 ���ø� ��ܵ� ���Խ�Ų��. %>
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
	page = Request("page")'�̰� �����̴ϱ�..
	if page <> "" And IsNumeric(page) then
		page = CInt(page)
	else
		page = 1
	end if


	bnMode = Request("bnMode")
	if  bnMode <> "v" then
		pgScope = 2	'���������� ǥ�õǴ� ����������  ����(�ٲ� �ʿ����)
		pgStartNbr = Int(page / pgScope) + 1	'���������� /  ������������  + 1	 >>	�������������� ���۹�ȣ
		If page MOD pgScope = 0 Then
			pgStartNbr = pgStartNbr - 1	'������������ �������������� ���� ���� 0 �̸�, ������������ 1�� ����.
		else
			pgStartNbr = (pgStartNbr - 1) * pgScope + 1	'���� �������������� ���۹�ȣ
		end if
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''
		if pgSize = "" then pgSize = 12	' ���������� ǥ�õǴ� ���
		topCnt = page * pgSize	' "100 Percent" '��µǴ� ����Ʈ �� (���ڵ忡�� �������� ����Ʈ ������ �̱� ���ؼ�...) 'Top topCnt
		selectedFields = "bnIdx,bnGroup,bnService,bnTitle,noticeDT"
		if SelBnGrp <> "" then
			whereClause = "bnGroup='��ü' Or bnGroup = '" & SelBnGrp & "'"
		else
			whereClause = ""
		end if

		orderBy = "bnOrder DESC, bnIdx DESC"
		RSresult = SelectRecord(bnRS, pgSize, topCnt, selectedFields, "vBoardNotice", whereClause, orderBy)
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	else  	'�Ʒ��� view����� ���
		bnIdx = CInt(Request("bnIdx"))
		if bnIdx = "" then Call ShowAlertMsg("�Խ��� ��ȿ���� �ƴմϴ�.")

		virNbr = Request("virNbr")
		'Page = Request("Page")


		'''''''''''''''''''''''''''''''''''''''''''''''''''''''
		pgSize = 1	' ���������� ǥ�õǴ� ���
		topCnt = "100 Percent" '��µǴ� ����Ʈ �� (���ڵ忡�� �������� ����Ʈ ������ �̱� ���ؼ�...) 'Top topCnt
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

		'�ش���ȸ������.
		Call ChangeFvalue("vBoardNotice","viewCount=viewCount+1","bnIdx=" & bnIdx)

		'����, ���� �Խù� �̸�����
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
	'�⺻ ����Ʈ�� bnMode�� ���̸� ������ ����Ʈ�� ���

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
		totRC = GetRecordCount("vBoardNotice", whereClause)		'�۹�ȣ
		virNbr = totRC - ((page - 1) * pgSize)	' �Խù� ��ȣ�� ���ϴ� ���̶��~

		'Do Until bnRS.EOF  Or i > bnRS.PageSize = pgSize			'������ �����̸� �����ϰ�, ���̸� �����. Do While�� �ݴ�.
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
    <TD Colspan="4" Align="center" Height="25">��ϵ� ������ �����ϴ�.</TD>
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
	else  		'view ���
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





