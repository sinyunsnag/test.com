<%@EnableSessionState=False%>
<html>
<head>
<title>�� ���ε����Դϴ�. ��</title>
<meta http-equiv="expires" content="Tue, 01 Jan 1981 01:00:00 GMT">
<meta http-equiv=refresh content="1,progressbar.asp?ID=<%=Request.QueryString("ID")%>">
<style type="text/css">
td {  font-family: "verdana","����", "Arial"; color: #333333; font-size: 9pt}
</style>

<%
On Error Resume Next 
Set theProgress = Server.CreateObject("ABCUpload4.XProgress")
theProgress.ID = Request.QueryString("ID")
%> 

<script language="javascript">
<!--
if (<% =theProgress.PercentDone %> == 100) top.close();
//-->
</script> 

</head>
<body bgcolor="#CCCCCC"> 

<table border="0" width="100%">
<tr>
<td><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>�� ���ε����Դϴ�. ��</b></font></td>
</tr>
<tr bgcolor="#999999">
<td>
<table border="0" width="<%=theProgress.PercentDone%>%" cellspacing="1" bgcolor="#0033FF">
<tr>
<td><font size="1">&nbsp;</font></td>
</tr>
</table>
</td>
</tr>
<tr>
<td>
<table border="0" width="100%">
<tr>
<td>���� �ð� : </td>
<td>
<%=Int(theProgress.SecondsLeft / 60)%> �� 
<%=theProgress.SecondsLeft Mod 60%> �� 
(<%=Round(theProgress.BytesDone / 1024, 1)%> KB of 
<%=Round(theProgress.BytesTotal / 1024, 1)%> KB uploaded)</td>
</tr>
<tr>
<td>���ۼӵ� : </td>
<td><%=Round(theProgress.BytesPerSecond/1024, 1)%> KB/sec</td>
</tr>
<tr>
<td>���� ���� : </td>
<td><%=theProgress.Note%></td>
</tr>
</table>
</td>
</tr>
<tr></tr>
</table> 

</body>
</html> 

