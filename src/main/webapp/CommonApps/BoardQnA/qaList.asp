<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<%
	'����
	if  CInt(Session("sLevel4")) < 2  And Session("MbrID") = ""  And  Session("userEmail") = "" then
		Response.Redirect(pageName & "?qaMode=vali")
	end if

	'''''''''''''''''''''''''''''''''''''''''''''
	page = Request("page")
	if page <> "" And IsNumeric(page) then
		page = CInt(page)
	else
		page = 1
	end if
	'''''''''''''''''''''''''''''''''''''''''''''''
		pgScope = 10 	'���������� ǥ�õǴ� ����������  ����
		pgStartNbr = Int(page / pgScope) + 1	'���������� /  ������������  + 1	 >>	�������������� ���۹�ȣ
		If (page MOD pgScope = 0) Then pgStartNbr = pgStartNbr - 1	'������������ �������������� ���� ���� 0 �̸�, ������������ 1�� ����.
		pgStartNbr = (pgStartNbr - 1) * pgScope + 1	'���� �������������� ���۹�ȣ

		'''''''''''''''''''''''''''''''''''''''''''''''''''''''
		if pgSize = "" then pgSize = 12	' ���������� ǥ�õǴ� ���
		topCnt = page * pgSize	' "100 Percent" '��µǴ� ����Ʈ �� (���ڵ忡�� �������� ����Ʈ ������ �̱� ���ؼ�...) 'Top topCnt
		selectedFields = "QAidx,MbrID,userName,qGroup,qTitle,writeOutDT"

		if Session("sID") = "" then
			if Session("MbrID") <>  "" then
				whereClause = "MbrID='" & Session("MbrID") & "'"
			elseif Session("userEmail") <> "" then
				whereClause = "userEmail='" & Session("userEmail") & "' And userPW='" & Session("userPW") & "'"
			else
				whereClause = ""
			end if
		else
			whereClause = ""
		end if			'if Session("sID") = "" then

		orderBy = "QAidx DESC, writeOutDT DESC"


		RSresult = SelectRecord(qaRS, pgSize, topCnt, selectedFields, "vQuestion", whereClause, orderBy)
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''
%>

<style type="text/css">
<!--
.style1 {color: #006600}
-->
</style>
<br>
<table width="500" border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                      <td width="70" height="25"><span class="style1">�׷�</span></td>
                      <td><span class="style1">����</span></td>
                      <td><span class="style1">������</span></td>
                      <td><span class="style1">�ۼ���</span></td>
                      <td><span class="style1">����</span></td>
                    </tr>
                    <tr>
                      <td height="5" colspan="5" background="Images/notice_line1.gif"></td>
                    </tr>
<%

	If RSresult = "NotEmpty" Then
		qaRS.AbsolutePage = page
		'Response.Write(qaRS.PageSize)
		'Response.write qaRS.RecordCount & "  " & totRC

		Dim totRC, virNbr
		totRC = GetRecordCount("vQuestion", whereClause)		'�۹�ȣ
		virNbr = totRC - ((page - 1) * pgSize)	' �Խù� ��ȣ�� ���ϴ� ���̶��~

		'������ �������� �����ؼ� ������ ���
		if CInt(page) > CInt(totRC/pgSize+1) then  Call ShowAlertMsg("�߸��� ��η� �����Ͽ����ϴ�.")




		'Do Until qaRS.EOF  Or i > qaRS.PageSize = pgSize			'������ �����̸� �����ϰ�, ���̸� �����. Do While�� �ݴ�.
		for i = 1 to qaRS.PageSize
			if (qaRS.EOF) then Exit for
			QAidx = qaRS("QAidx")
			MbrID = qaRS("MbrID")
			userName = qaRS("userName")
			qGroup = qaRS("qGroup")
			qTitle = qaRS("qTitle")
			writeOutDT = qaRS("writeOutDT")
			'����
			if MbrID <> "" then
				inquirer = userName & "(" & MbrID & ")"
			else
				inquirer = userName
			end if

			if PickUpValue("vAnswer", "QAidx", "QAidx = " & QAidx)  <> "NoPickUp"  then
				qaStatus =  "�亯�Ϸ�" : qaStatusBit = 1
			else
				qaStatus =  "��������" : qaStatusBit = 0
			end if

%>
		<tr class="body16" onmouseover="this.style.background='#FAFAFA'"  onmouseout="this.style.background='#ffffff'">
		  <td height="18"><div align="center"><%= qGroup %></div></td>
		  <td><A HREF="<%=pageName%>?qaMode=qav&QAidx=<%=QAidx%>&virNbr=<%=virNbr%>&page=<%=page%>&qaStatusBit=<%=qaStatusBit %>">
		  <%= ReplaceTo(ShortenString(qTitle, 23), "toHTML") %></A>
		  </td>
		  <td><div align="center"><%= inquirer %></div></td>
		  <td><div align="center"><%= DateValue(writeOutDT) %></div></td>
		  <td align="center"><%= qaStatus %></td>
		</tr>
		<tr>
		  <td height="5" colspan="5" background="Images/notice_dot1.gif"></td>
		</tr>
<%
			virNbr = virNbr - 1
			qaRS.MoveNext
		Next
		'Loop
		CloseRS(qaRS)
%>

  <tr align="center">
    <td height="50" colspan="5">
	<%  Call MakePageScope(pgStartNbr, pageName & "?qaMode=li", pgScope, pgSize, page, totRC) %>	</td>
  </tr>

<%
	Else			'''''''''''''''''''''''''''''''''''''''''''''''''
%>
  <TR>
    <TD Colspan="5" Align="center" Height="100">��ϵ� ���ǳ����� �����ϴ�.</TD>
  </TR>
  <TR>
    <TD Colspan="5" background="Images/dotline.gif"></TD>
  </TR>
<% End If %>
                    <tr bgcolor="#FAFAFA" class="body16">
                      <td height="18" align="center">
					  <% If Session("userEmail") <> "" Then %>
					  <a href="javascript:ConfirmJ('��ȸ�� �α׾ƿ��Ͻðڽ��ϱ�?', '<%= Application("SiteURLDir") %>CommonAccessories/BoardQnA/qaLogin_ok.asp?gotoURL=<%= pageName %>')">��ȸ��<br>
                      �α׾ƿ�</a>
					   <% end if %></td>
                      <td><A HREF="javascript:OpenWindow('<%= Application("SiteURLDir") %>CommonAccessories/BoardNotice/bnForm.asp?qaMode=i&bnGroup=<%=SelBnGrp%>','bnPopup','scrollbars=yes,resizable=no,width=600,height=470')">
					  </A><a href="<%= pageName %>?qaMode=qi"><img src="Images/qaCancle.gif" width="55" height="22" border="0"></a></td>
                      <td><div align="center"></div></td>
                      <td><div align="center">
		<A HREF="javascript:OpenWindow('<%= Application("SiteURLDir") %>CommonAccessories/BoardNotice/bnForm.asp?qaMode=i&bnGroup=<%=SelBnGrp%>','bnPopup','scrollbars=yes,resizable=no,width=600,height=470')">	  </A>
	  <% If Session("sLevel4") <> "" Then %>
	  <a href="../../Admin/Staffs/StfExit.asp?qaMode=logout"><img src="Images/qaLogout.gif" width="22" height="22" border="0"></a>
	  <% end if %>
	  	</div></td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td height="5" colspan="5" background="Images/notice_line2.gif"></td>
                    </tr>
</table>
