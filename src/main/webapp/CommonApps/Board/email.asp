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

<script language=javascript>
<!--
function submit(){
    if(document.inno.email.value.length == 0){
        alert("�����»���� EMail�� �Է��� �ֽʽÿ�.");
        document.inno.email.focus();
        return;

    }

    if (document.inno.email.value.length > 1 )  {

	str = document.inno.email.value;
	if(	(str.indexOf("@")==-1) || (str.indexOf(".")==-1)){
		alert("���ڿ��� �ּ������� �����ʽ��ϴ�")
		document.inno.email.focus();
		return;
	}
	}

    if(document.inno.title.value.length == 0){
        alert("������ �Է��� �ֽʽÿ�.");
        document.inno.title.focus();
        return;
    }
    if(document.inno.content.value.length == 0){
        alert("������ �Է��� �ֽʽÿ�.");
        document.inno.content.focus();
        return;
    }

    document.inno.submit();
}

function reset()
{
	document.inno.reset();
}
//-->
</script>

</head>
<body bgcolor="<%=bgcolor%>"  onload="document.inno.email.focus();" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">

<form name="inno" method="post" action="email_ok.asp" onsubmit="submit()">
<input type="hidden" name="bID" value="<%=Request.QueryString("bID")%>">
<input type="hidden" name="page" value="<%=request.QueryString("page")%>">
<input type="hidden" name="homepage" value="<%=request.QueryString("homepage")%>">
<input type="hidden" name="num" value="<%=request.QueryString("num")%>">
<input type="hidden" name="sw" value="<%=request.QueryString("sw")%>">
<input type="hidden" name="st" value="<%=request.QueryString("st")%>">
<input type="hidden" name="sc" value="<%=request.QueryString("sc")%>">
<input type="hidden" name="sn" value="<%=request.QueryString("sn")%>">

<%=bTop%>
<% '��ü ���̺� ���� %>
<table width="570" border="0" cellpadding="0" cellspacing="0">

<tr>
	<td colspan="2">
<table width="570" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td height="1" bgcolor="#333333"></td>
</tr>
<tr>
	<td height="1" bgcolor="#ffffff"></td>
</tr>
<tr>
	<td height="4" bgcolor="#333333"></td>
</tr>
<tr>
	<td height="1" bgcolor="#ffffff"></td>
</tr>
<tr>
	<td height="1" bgcolor="#333333"></td>
</tr>
</table>
	</td>
</tr>
<tr>
	<td colspan="2" height="1"></td>
</tr>
<tr>
	<td colspan="2" height="1" bgcolor="#cccccc"></td>
</tr>
<tr bgcolor="F7F7F7" height="25">
	<td width="110" class="form_title" align="right"><b>�޴� ��� &nbsp;</b></td>
	<td width="460"><input type="text" name="toemail" size="30" class="form_input" maxlength="240" value="<%=Request.QueryString("email")%>"></td>
</tr>
<tr>
	<td colspan="2" height="1" bgcolor="#cccccc"></td>
</tr>
<tr bgcolor="F7F7F7" height="25">
	<td width="110" class="form_title" align="right"><b>������ ��� &nbsp;</b></td>
	<td width="460"><input type="text" name="email" size="30" class="form_input" maxlength="240"></td>
</tr>
<tr>
	<td colspan="2" height="1" bgcolor="#cccccc"></td>
</tr>
<tr bgcolor="F7F7F7" height="25">
	<td width="110" class="form_title" align="right"><b>�� �� &nbsp;</b></td>
	<td width="460"><input type="text" name="title" size="30" class="form_input" maxlength="240"></td>
</tr>
<tr>
	<td colspan="2" height="1" bgcolor="#cccccc"></td>
</tr>
<tr>
	<td colspan="4" align="center" bgcolor="F7F7F7"><br><textarea name="content" cols="105" rows="12" class="form_textarea"></textarea><br><br></td>
</tr>
<tr>
	<td colspan="4" height="1" bgcolor="#cccccc"></td>
</tr>
<tr>
	<td colspan="2">
<table width="570" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td height="1" bgcolor="#333333"></td>
</tr>
<tr>
	<td height="1" bgcolor="#ffffff"></td>
</tr>
<tr>
	<td height="4" bgcolor="#333333"></td>
</tr>
<tr>
	<td height="1" bgcolor="#ffffff"></td>
</tr>
<tr>
	<td height="1" bgcolor="#333333"></td>
</tr>
</table>
	</td>
</tr>
</table>

<table width="570" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td align="right" style="word-break:break-all;padding:5px;"><a href="javascript:submit();"><img src="../img/but_ok.gif" border="0"></a> <a href="javascript:reset();"><img src="../img/but_again.gif" border="0"></a> <a href="javascript:history.go(-<% if mode = "edit" then %>2<% else %>1<% end if %>);"><img src="../img/but_cancel.gif" border="0"></a><br><!-- #include file="../inc/copyleft.asp" --></td>
</tr>
</table>


</form>
<%= bBottom %>

</body>
</html>
