<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<% ' �� ��Ŭ��带 ���ø� ��ܵ� ���Խ�Ų��. %>
<!-- caSetting Start -->
	<!--# include File = "../caSetting.asp" -->
<!-- caSetting  End -->
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
		pgScope = 10	'���������� ǥ�õǴ� ����������  ����(�ٲ� �ʿ����)
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


<base href="<%= Application("SiteURLDir") %>CommonAccessories/BoardNotice/" target="_self">
<%
	'�⺻ ����Ʈ�� bnMode�� ���̸� ������ ����Ʈ�� ���

	if  bnMode <> "v" then
%>

<TABLE width="100%" Border="0" Cellpadding="0" Cellspacing="1" bgColor="#FFFFFF" class="body18">
  <TR Align="center"  bgColor="#F4F4F2">
    <TD width="30" Height="30 ">��ȣ</TD>
    <TD>��������</TD>
    <TD>����</TD>
    <TD>������</TD>
  </TR>
<%

	If RSresult = "NotEmpty" Then

		'cursor,lockType
		'Response.Write(bnRS.cursorType)
		'Response.Write(bnRS.lockType)

		bnRS.AbsolutePage = page


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
  <TR Height="25">
    <TD Align="center"><%= bnIdx %>.</TD>
    <TD>&nbsp;<A HREF="<%=pageName%>?bnMode=v&bnIdx=<%=CInt(bnIdx)%>&virNbr=<%=virNbr%>&page=<%=page%>">
	<%= ReplaceTo(ShortenString(bnTitle, 60), "toHTML") %></A></TD>
    <TD Align="center"><nobr><%= bnGroup %></nobr></TD>
    <TD Align="center"><%= DateValue(noticeDT) %></TD>
  </TR>
  <TR>
    <TD Colspan="4" background="Images/dotline.gif" height="3"></TD>
  </TR>
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
  <TR>
    <TD colspan="4">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#F4F4F2" class="body18">
        <tr>
          <td><%Call MakePageScope(pgStartNbr, pageName & "?bnMode=li&iBranch=" & iBranch, pgScope, pgSize, page, totRC)%></td>
          <td align="right">
      <A HREF="javascript:OpenWindow('<%= Application("SiteURLDir") %>CommonAccessories/BoardNotice/bnForm.asp?bnMode=i&bnGroup=<%=SelBnGrp%>','bnPopup','scrollbars=yes,resizable=no,width=600,height=470')">
	  <img src="Images/bnWrite.gif" width="47" height="22" border="0" ></A>
	  <% If Session("sLevel4") <> "" Then %>
	  <a href="../../Admin/Staffs/StfExit.asp?bnMode=logout"><img src="Images/bnLogout.gif" width="22" height="22" border="0"></a> </td>
	  <% end if %>
        </tr>
      </table></TD>
  </TR>
</TABLE>

<%
	else  		'view ���
%>

<TABLE Width="98%" Height="240" Border="0" Cellpadding="0" Cellspacing="1" class="body18">
<TR bgColor="#F4F4F2">
	<TD colspan="2">
	<TABLE Width="100%" height="60" Border="0" Cellpadding="2" Cellspacing="1" bgcolor="#FFFFFF" class="body18">
      <TR bgColor="#F4F4F2">
        <TD Height="45" Style="padding-left:5px;"><B>[<%=bnIdx%>]&nbsp;<%= bnTitle %> -<%= bnGroup %></B></TD>
        <TD Align="center"><nobr><%= noticeDT %></nobr></TD>
      </TR>
    </TABLE></TD>
  </TR>
<TR valign="top">
	<TD Colspan="2" Height="244" Style="padding:14px;"><div id="boxScroll">
		<p alin=justify><font color="8A4F41"><b><%= bnSubTitle %></b></font><br><br>
		<%= bnContent %>
	</div>	</TD>
</TR>
<TR Height="25" bgColor="#F4F4F2">
	<TD width="360" align="center"><table width="100%"  border="0" cellpadding="4" cellspacing="1" bgcolor="#FFFFFF">
	  <tr bgcolor="#F4F4F2">
        <td width="30" align="center">����</td>
        <td>
		<A HREF="<%= pageName %>?bnMode=v&bnIdx=<%=bnIdxNext%>&virNbr=<%=virNbr + 1%>&page=<%=page%>">
		<%=ReplaceTo(ShortenString(IdxNextString, 26),  "toHTML")%></A>
</td>
	    </tr>
          <tr bgcolor="#F4F4F2">
            <td width="30" align="center">����</td>
            <td><A HREF="<%= pageName %>?bnMode=v&bnIdx=<%=bnIdxBefore%>&virNbr=<%=virNbr - 1%>&page=<%=page%>">
			<%=ReplaceTo(ShortenString(IdxBeforeString, 26),  "toHTML")%></A>
</td>
          </tr>
        </table>	</TD>
	<TD Align="center" bgcolor="#F4F4F2"><nobr>
	<A HREF="<%= pageName %>?Page=<%=Page%>"><IMG SRC="Images/bnList.gif" WIDTH="39" HEIGHT="22" BORDER="0"></A>
	<% If Session("sLevel4") <> "" Then %>
	<A HREF="javascript:OpenWindow('<%= Application("SiteURLDir") %>CommonAccessories/BoardNotice/bnForm.asp?bnMode=u&bnIdx=<%=bnIdx%>','bnPopup','scrollbars=yes,resizable=no,width=600,height=470')"><img src="Images/bnModify.gif" width="54" height="22" border="0"></A>
	<A HREF="javascript:OpenWindow('<%= Application("SiteURLDir") %>Admins/Staffs/LoginBoxForStaff/LoginBoxForStaff.asp?bnMode=d&bnIdx=<%=bnIdx%>','bnPopup','scrollbars=yes,resizable=no,width=600,height=470')"><img src="Images/bnDelete.gif" width="55" height="22" border="0"></A>
	<a href="../../Admin/Staffs/StfExit.asp?bnMode=logout"><img src="Images/bnLogout.gif" width="22" height="22" border="0"></a>
	<% else %>
	<A HREF="javascript:OpenWindow('<%= Application("SiteURLDir") %>Admins/Staffs/LoginBoxForStaff/LoginBoxForStaff.asp?bnMode=login','bnPopup','scrollbars=yes,resizable=no,width=600,height=470')"><img src="Images/bnLogin.gif" width="22" height="22" border="0"></A>
	<% End If %>&nbsp;
	</nobr>	</TD>
</TR>
</TABLE>
<%
end if		'if  bnMode <> "v" then
%>





