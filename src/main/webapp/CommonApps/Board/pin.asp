<!-- ShopSetting Start -->
	<!--#include File = "../../SiteSetting.asp" -->
<!-- ShopSetting End -->
<%
	'���⿡ ���
%>

<!-- #include File="BoardInfo_inc.asp" -->
<!-- #include File="../../Include_asp/fsBoard_inc.asp" -->

<html>
<head>
<title><%=bTitleName%></title>

<LINK rel="stylesheet" type="text/css" href="IncTemplates/style.css">
<script language="javascript">
<!--//
function submit()
{

	if (document.frm.form_pin.value =="") {
		alert("��й�ȣ�� �Է��� �ּ���.");
		document.frm.form_pin.focus();
		return;
	}
	//�н����� ��ȣȭ����
	/*
	var letters = 'ghijklabvwxyzABCDEFef)_+|<>?:mnQRSTU~!@#$%^VWXYZ`1234567opGHIJKLu./;'+"'"+'[]MNOP890-='+'\\'+'&*("{},cdqrst '+"\n";
	var split = letters.split("");var bNbr = '';var c = '';
	var encrypted = '';
	var it = document.frm.form_pin.value;
	var b = '0';var chars = it.split("");while(b<it.length){c = '0';while(c<letters.length){if(split[c] == chars[b]){if(c == "0") { c = ""; }if(eval(c+10) >= letters.length){bNbr = eval(10-(letters.length-c));encrypted += split[bNbr];}else{bNbr = eval(c+10);encrypted += split[bNbr];}}c++;}b++;}document.frm.form_pin.value = encrypted;encrypted = '';
	*/
	document.frm.submit();

}
//-->
</script>
</head>
<body bgcolor="<%=bgcolor%>" marginwidth="0" marginheight="0" leftmargin="0" topmargin="0" onload="document.frm.form_pin.focus();">

<%
	'�ֻ��
	if bTopFilePath <> "" then Server.Execute(Application("SiteRoot") & bTopFilePath)
%>

<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%= Application("SiteRoot") & bigTB_img %>">
  <tr>
    <td>

<table width="<%=bWidth%>" border="0" cellpadding="0" cellspacing="0" align="<%= bAlign %>" bgcolor="<%= tb_bgcolor %>">
  <tr>
    <td align="left" colspan="3">
<%
	'��°���
	if bTop1FilePath <> "" then Server.Execute(Application("SiteRoot") & bTop1FilePath)
%>
</td>
  </tr>
  <tr>
    <td align="left" valign="top">
<%
	'�����޴�
	if bLeftFilePath <> "" then Server.Execute(Application("SiteRoot") & bLeftFilePath)
%>
</td>
    <td valign="top">

    	<table border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td align="left">
<%
	'�Խ��� �ٷ� �� ���
	if bTop2FilePath <> "" then Server.Execute(Application("SiteRoot") & bTop2FilePath)
%>        </td>
        </tr>
      <tr>
        <td width="<%=bWidth+12%>" align="center">

<!-------------------- ������Ͱ� �Խ��� ���� ----------------->

<%
	bNbr = Request.QueryString("bNbr")
	mode = Request.QueryString("mode")
	sw = Request.QueryString("sw")

	Select Case mode
		Case "edit"
			url = "bForm.asp?"
			msg = "���� ���� <font color=red><b>����</b></font>�մϴ�."
		Case "del"
			url = "del_ok.asp?"
			msg = "���� ���� <font color=red><b>����</b></font>�մϴ�."
		Case "com_del"
			url = "bComment_ok.asp?cmtOrder="&Request.QueryString("cmtOrder")&"&"
			msg = "���� �޸��� <font color=red><b>����</b></font>�մϴ�."
		Case "secret"
			url = "bView.asp?"
			msg = "�� ���� <font color=red><b>��б�</b></font> �Դϴ�."
		Case Else
			Response.Redirect("bList.asp?bID=" & Request("bID"))
		End Select

%>
<base href="<%= Application("SiteURLDir") & "CommonAccessories/Board/" %>" target="_self">
<table width="300" border="0" cellpadding="0" cellspacing="0">
<form name="frm" method="POST" action="<%=url%>bID=<%=Request.QueryString("bID")%>&bNbr=<%=bNbr%>&page=<%=Request.QueryString("page")%>&mode=<%=mode%><% if sw<>"" then %>&st=<%=Request.QueryString("st")%>&sc=<%=Request.QueryString("sc")%>&sn=<%=Request.QueryString("sn")%>&sw=<%=Request.QueryString("sw")%><% end if %>">
<tr>
	<td>
	<table width="300" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td height="1" bgcolor="#cccccc"></td>
	</tr>
	<tr>
		<td height="1" bgcolor="#ffffff"></td>
	</tr>
	<tr>
		<td height="4" bgcolor="#999999"></td>
	</tr>
	<tr>
		<td height="1" bgcolor="#ffffff"></td>
	</tr>
	<tr>
		<td height="1" bgcolor="#cccccc"></td>
	</tr>
	</table>
	</td>
</tr>
<tr>
	<td style="word-break:break-all;padding:10px;" align="center" bgcolor="#eeeeee"><%=msg%><br>��й�ȣ�� �Է����ּ���.<br><br>
	<input type="password" name="form_pin" size="15" class="form_input">
	<a href="javascript:submit();"><img src="Images/but_ok.gif" border="0"></a>
	<a href="javascript:history.back();"><img src="Images/but_cancel.gif" border="0"></a>
	</td>
</tr>
<tr>
	<td>
	<table width="300" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td height="1" bgcolor="#cccccc"></td>
	</tr>
	<tr>
		<td height="1" bgcolor="#ffffff"></td>
	</tr>
	<tr>
		<td height="4" bgcolor="#999999"></td>
	</tr>
	<tr>
		<td height="1" bgcolor="#ffffff"></td>
	</tr>
	<tr>
		<td height="1" bgcolor="#cccccc"></td>
	</tr>
	</table>
	</td>
</tr>
</form>
</table>
<p><br>

<!-------------------- ������Ͱ� �Խ��� ���� ��----------------->
	</td>
        </tr>
      <tr>
        <td align="left"><!-- #include File="IncTemplates/bIncludeBottomMsgTemplate.asp" --></td>
        </tr>
    </table>

    </td>
    <td align="left" valign="top">
<%
	'�����޴�
	if bRightFilePath <> "" then Server.Execute(Application("SiteRoot") & bRightFilePath)
%>
</td>
  </tr>
</table>
    	</td>
  </tr>
</table>

<%
	'���ϴ�
	if bBottomFilePath <> "" then Server.Execute(Application("SiteRoot") & bBottomFilePath)
%>


</body>
</html>