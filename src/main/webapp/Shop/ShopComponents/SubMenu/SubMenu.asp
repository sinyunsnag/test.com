<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<%

'��ǰ�ڵ�
g = Request.QueryString("g")

'����ī�װ��� �������� ������
c = Request.QueryString("c")
if c = "" then
	'g ���� �ȳѾ� ����
	if g <> "" then
		tempC = PickUpValue("vGoodsList_c", "cCode", "gCode = '" & g & "'")
		if tempC = "NoPickUp" then
			Call GotoThePage("�ش� ����ī�װ��� �������� �ʽ��ϴ�!!", Application("SiteRoot"))
		else
			c = tempC
		end if
	end if		'if g = "" then
end if


if c <> "" then 
	SQL = "SELECT c2Code, c2Name From vSubMenu "
	SQL = SQL & " Where cCode = " & c
	SQL = SQL & " Order By c2Order DESC"
	RSresult = OpenSimpleRS(SCRrs, SQL)

	if RSresult <> "Empty" then
%>
<base href="<%= Application("SiteURLDir") %>ShopComponents/SubMenu/" target="_self">
<table width="150" border="0" cellspacing="0" cellpadding="0">
<%
		Do until SCRrs.EOF
			c2Code = trim(SCRrs("c2Code"))
			c2Name = trim(SCRrs("c2Name"))
			'SMname = "SM" & c2Code & ".gif"
			'gInputDT = trim(SCRrs("gInputDT"))
			'���� �̹��� ���ϱ�
			'smallImage = PickUpValue("vMasterImages", "pName", "gCode = '" & gCode & "' And imgSize = 'S'")
			'if smallImage = "NoPickUp" then smallImage ="iSdefault.gif"
%>

  <tr>
    <td width="10" height="25">&nbsp;</td>
    <td>
	<!-- a href="../../ShopBody/GoodsListBody.asp?c=<%= c %>&cc=<%= c2Code %>"><img src="Images/<%= SMname %>" alt="<%= c2Name %>" border="0"></a-->
	
	<a href="../../ShopBody/GoodsListBody.asp?c=<%= c %>&cc=<%= c2Code %>"><%= c2Name %></a></td>
  </tr>
<%
			SCRrs.MoveNext
		Loop
%>
</table>
<%
		Call CloseRS(SCRrs)

	end if  'if RSresult <> "Empty" then
end if	'if c <> "" then 
%>	