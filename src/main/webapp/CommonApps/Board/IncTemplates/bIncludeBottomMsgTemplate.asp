<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<%
	' �Խ��ǿ� �ٷ� �ϴܿ� ���Ե� ���ø�
	bID = Request("bID")
	if bID = "" then '������ ǥ���ؾ� ��
		Call ShowAlertMsg("�Խ���ID�� �������� �ʽ��ϴ�.")
	end if 
%>
<base href="<%= Application("SiteURLDir") & "CommonAccessories/Board/IncTemplates/" %>" target="_self">
<%
	Select Case bID
		Case "GeneralMbr"
%>

<table width="100%" border="0" cellpadding="3" cellspacing="3">
  <tr>
    <td><% if bBottomMsg <> "" then %><img src="../../../Images/member_icon.gif"> <%= bBottomMsg %><% end if %></td>
  </tr>
</table>

<%
		Case "free"
%>

<table width="100%" border="0" cellpadding="3" cellspacing="3">
  <tr>
    <td><% if bBottomMsg <> "" then %><img src="../../../Images/member_icon.gif"> <%= bBottomMsg %><% end if %></td>
  </tr>
</table>

<%
		Case "OpenBiz"
%>

<table width="100%" border="0" cellpadding="3" cellspacing="3">
  <tr>
    <td><% if bBottomMsg <> "" then %><img src="../../../Images/member_icon.gif"> <%= bBottomMsg %><% end if %></td>
  </tr>
</table>

<%
		Case "AnYang"
%>

<table width="100%" border="0" cellpadding="3" cellspacing="3">
  <tr>
    <td><% if bBottomMsg <> "" then %><img src="../../../Images/member_icon.gif"> <%= bBottomMsg %><% end if %></td>
  </tr>
</table>

<%
		Case "AnSan"
%>

<table width="100%" border="0" cellpadding="3" cellspacing="3">
  <tr>
    <td><% if bBottomMsg <> "" then %><img src="../../../Images/member_icon.gif"> <%= bBottomMsg %><% end if %></td>
  </tr>
</table>

<%
		Case Else
			'Call ShowAlertMsg("�Խ���ID�� �߸��ƽ��ϴ�.")
	End Select
%>
<base href="<%= Application("SiteURLDir") & "CommonAccessories/Board/" %>" target="_self">