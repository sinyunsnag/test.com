<% ' �� ��Ŭ��带 ���� ��ܵ� ���Խ�Ų��. %>
<!-- caSetting Start -->
	<!--#include File = "../caSetting.asp" -->
<!-- caSetting  End -->
<%

	
	'Response.write Request.ServerVariables("HTTP_REFERER") & "<br>" '������
	'Response.write Request.ServerVariables("PATH_INFO") & "<br>"
	'Response.end

	bnIdx = CInt(Request("bnIdx"))
	bnMode = Request("bnMode")
	bnGroup = Request.QueryString("bnGroup")					
	gotoURL = Server.URLEncode(Application("SiteRoot") & "CommonAccessories/BoardNotice/bnForm.asp")
	gotoURL = gotoURL &  Server.URLEncode("?bnMode=" & bnMode & "&bnIdx=" & bnIdx & "&bnGroup=" & bnGroup)
	if Session("sLevel4") = "" then Response.Redirect("../../Admin/Staffs/LoginBoxForStaff/LoginBoxForStaff.asp?gotoURL=" & gotoURL)
	if CInt(Session("sLevel4")) < 3 then  
		Call GotoThePage("������ �۽��ϴ�. �ٽ� �α����ϼ���.", "../../Admin/Staffs/LoginBoxForStaff/LoginBoxForStaff.asp?gotoURL=" & gotoURL)
	end if


	if bnIdx <> "" then 
		if bnMode = "u"	then 
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			selectedFields = "bnIdx,bnGroup,bnService,bnTitle,bnSubTitle,bnContent,bnOrder"
			whereClause = "bnIdx = " & bnIdx
			'orderBy = "bnOrder DESC, bnIdx DESC"
			RSresult = SelectSimpleRecord(bnRS, " Top 1 " & selectedFields, "vBoardNotice", whereClause, orderBy)
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			If RSresult = "NotEmpty" Then
				'bnIdx = bnRS("bnIdx")
				bnGroup = bnRS("bnGroup")
				'bnService = bnRS("bnService")
				bnTitle = bnRS("bnTitle")
				bnSubTitle = bnRS("bnSubTitle")
				bnContent = bnRS("bnContent")
				bnOrder = bnRS("bnOrder")
				CloseRS(bnRS)
			end if		'If RSresult = "NotEmpty" Then
		end if		'if bnMode = "u"	then 
	end if	'if bnIdx <> "" then 
%>


<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<html>
<head>
<title>���������Ӹ��</title>
</head>
	<link href="../../Include_css/Style.css" rel="stylesheet" type="text/css">
	<link href="../../Include_css/Object.css" rel="stylesheet" type="text/css">
	<script language="JavaScript" src="../../Include_js/CommonFunctions.js"></script>
	<script language="JavaScript" src="../../Include_js/Function.js"></script>

<style>
	.iptBorder{
		font-family : ����;
		color : #333333;
		font-size : 9pt;
		font-weight : normal;
		border : 1px solid;
		border-color : #CCCCCC;
		background-color : #FFFFFF;
	}

	.CsmScroll{
		font-family : ����;
		color : #333333;
		font-size : 9pt;
		font-weight : normal;
		border : 1px solid;
		border-color : #CCCCCC;
		background-color : #FFFFFF;
		scrollbar-face-color : #FFFFFF;
		scrollbar-shadow-color : #CCCCCC;
		scrollbar-gighlight-color : #777777;
		scrollbar-3dlight-color : #777777;
		scrollbar-darkshadow-color : #777777;
		scrollbar-track-color : #FFFFFF;
		scrollbar-arrow-color : #777777;
	}
</style>

<SCRIPT LANGUAGE="JavaScript">
<!--
	function fnNextValidate(){
		var frmName = document.frmBN;
		if(frmName.bnTitle.value == ""){
			alert("������ �Է��Ͽ� �ּ���.");
			frmName.bnTitle.focus();
			return;
		}else{
			var strTitle = frmName.bnTitle.value;
			var chTitle = strTitle.split(" ");

			if(strTitle.length+1 == chTitle.length){
				alert("������ �Է��Ͽ� �ּ���.");
				frmName.bnTitle,value = "";
				frmName.bnTitle.focus();
				return;
			}
		}
		if(frmName.bnSubTitle.value == ""){
			alert("�������� �Է��Ͽ� �ּ���.");
			frmName.bnSubTitle.focus();
			return;
		}

		if(frmName.bnContent.value == ""){
			alert("������ �Է��Ͽ� �ּ���.");
			frmName.bnContent.focus();
			return;
		}
		if(isNaN(frmName.bnOrder.value) || frmName.bnOrder.value == ""){
			alert("���ڸ� �Է��Ͽ� �ּ���.");
			frmName.bnOrder.focus();
			return;
		}
		frmName.submit();
	}
//-->
</SCRIPT>

<body onLoad="javascript:ToFocus(frmBN.bnTitle);">
<TABLE Border="0" Cellpadding="0" Cellspacing="0" Align="center" Width="500">
<TR Height="25">
  <TD height="30" colspan="2" Align="center" bgcolor="F4F4F2"> <Font size="2"><b>* �������� ���� * </b></Font></TD>
  </TR>
<FORM NAME="frmBN" METHOD="post" ACTION="bnForm_ok.asp">
<INPUT TYPE="hidden" NAME="bnMode" VALUE="<%=bnMode%>">
<INPUT TYPE="hidden" NAME="bnIdx" VALUE="<%=bnIdx%>">
<INPUT TYPE="hidden" NAME="bnService" VALUE="<%=Request("bnService")%>">

<TR Height="25">
	<TD Width="100" height="30" Align="center" bgcolor="F4F4F2">�� ��</TD>
	<TD>
		&nbsp;
		<INPUT NAME="bnTitle" TYPE="text" Class="iptBorder" id="bnTitle" Value="<%= bnTitle %>" Size="60" Maxlength="200">
&nbsp;		</TD>
</TR>
<TR Height="25">
	<TD height="30" Align="center" bgcolor="F4F4F2">������</TD>
	<TD>
		&nbsp;
		<INPUT NAME="bnSubTitle" TYPE="text" Class="iptBorder" id="bnSubTitle" Value="<%= bnSubTitle %>" Size="60" Maxlength="200">
&nbsp;			  </TD>
</TR>
<TR Height="25">
	<TD height="30" Align="center" bgcolor="F4F4F2">�з�/����</TD>
	<TD>
		&nbsp;
		<select name="bnGroup" size="1" >
          <option value="��ü" <%= writeSelected(bnGroup, "��ü") %>>��ü</option>
		  <!-- option value="Ŀ�´�Ƽ" <%= writeSelected(bnGroup, "Ŀ�´�Ƽ") %>>Ŀ�´�Ƽ</option-->
      </select>
		/	<INPUT NAME="bnOrder" TYPE="text" Class="iptBorder" id="bnOrder" Value="<%= bnOrder %>" Size="3" Maxlength="3"></TD>
</TR>
<TR>
	<TD height="300" Align="center" bgcolor="F4F4F2">����</TD>
	<TD>
		&nbsp;
		<TEXTAREA NAME="bnContent" COLS="60" ROWS="20" Class="CsmScroll" id="bnContent"><%= bnContent %></TEXTAREA>
&nbsp;		</TD>
</TR>
<TR>
	<TD height="40" bgcolor="F4F4F2"></TD>
	<TD Align="right" valign="middle" bgcolor="F4F4F2">
	<a href="javascript:fnNextValidate();"><img src="Images/bnConfirm.gif" width="58" height="22" border="0"></a>&nbsp;
	<a href="javascript:window.close();"><img src="Images/bnCancle.gif" width="55" height="22" border="0"></a> &nbsp; </TD>
</TR>
</FORM>
</TABLE>
</body>
</html>