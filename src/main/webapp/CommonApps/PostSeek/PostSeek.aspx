<%@ Page language="c#" Codebehind="PostSeek.aspx.cs" AutoEventWireup="false" Inherits="KistelSite.CommonApps.PostSeek.PostSeek" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>PostSeek</title>
		<META http-equiv="Content-Type" content="text/html; charset=ks_c_5601-1987">
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../../../StyleSheets/Objects.css" type="text/css" rel="stylesheet">
		<LINK href="../../../StyleSheets/OverallPage.css" type="text/css" rel="stylesheet">
		<script language="JavaScript" src="../../../CommonLibrary/CommonLibrary.js"></script>
		<script language="JavaScript">
		<!--
			function pBkCr(irow,Cr) {
			ilen=document.all.stb.rows(0).cells.length;
			if (Cr=="IN") for(i=0;i<ilen;i++) document.all.stb.rows(irow).cells(i).style.backgroundColor="#70B9CB";//powderpink
			else for (j=0;j<ilen;j++) document.all.stb.rows(irow).cells(j).style.backgroundColor="#9ACDDA";//#cedee7
			}
			
			function ReturnValues(ZIPCODE, totAddrValue) {
				if(window.name == "cardZip") {
					window.opener.document.frmCard.zipcode.value = ZIPCODE;
					window.opener.document.frmCard.address1.value= totAddrValue;
					window.opener.document.frmCard.address2.focus();
				}else if(window.name == "memberZip") {
					window.opener.document.frmMbr.zipcode.value = ZIPCODE;
					window.opener.document.frmMbr.mAddress1.value= totAddrValue;
					window.opener.document.frmMbr.mAddress2.focus();
				}else if(window.name == "staffZip") {
					window.opener.document.frmStf.zipcode.value = ZIPCODE;
					window.opener.document.frmStf.address1.value= totAddrValue;
					window.opener.document.frmStf.address2.focus();
				}else if(window.name == "officeZip") {
					window.opener.document.frmMbr.oZipcode.value = ZIPCODE;
					window.opener.document.frmMbr.oAddress1.value= totAddrValue;
					window.opener.document.frmMbr.oAddress2.focus();
				}else if(window.name == "usMemberZip") {
					window.opener.document.frmMbr.MSF_mZipcode.value = ZIPCODE;
					window.opener.document.frmMbr.MSF_mAddress1.value= totAddrValue;
					window.opener.document.frmMbr.MSF_mAddress2.focus();													
				}else if(window.name == "usOfficeZip") {
					window.opener.document.frmMbr.MSF_oZipcode.value = ZIPCODE;
					window.opener.document.frmMbr.MSF_oAddress1.value= totAddrValue;
					window.opener.document.frmMbr.MSF_oAddress2.focus();		
				}else {
					alert("ERROR");
				}
				window.close();
			}			
		-->
		</script>
	</HEAD>
	<body>
		<form id="frmAddr" method="post" runat="server">
			<table cellSpacing="0" cellPadding="0" width="98%" background="Images/post_002.gif" border="0">
				<tr>
					<td width="125" rowSpan="2"><IMG height="138" src="Images/post_001.gif" width="125"></td>
					<td vAlign="top" height="64"><IMG height="64" src="Images/post_004.gif" width="133"></td>
					<td width="24" rowSpan="2"><IMG height="137" src="Images/post_003.gif" width="24"></td>
				</tr>
				<tr>
					<td>
						<table cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td>&nbsp;
									<asp:label id="postDisplay" runat="server">ã���� �Ͻô� �ּ��� ��(��/��/��)�� �Է��Ͻʽÿ�.</asp:label><br>
									&nbsp;&nbsp;��) û�㵿, �Ÿ���</td>
							</tr>
							<tr>
								<td>&nbsp;
									<asp:textbox id="addrSeek" runat="server" Width="110px"></asp:textbox><asp:requiredfieldvalidator id="RequiredFieldValidator1" runat="server" ControlToValidate="addrSeek" ErrorMessage="�ּҸ� �Է��ϼ���!!">*</asp:requiredfieldvalidator><asp:imagebutton id="btnSearch" runat="server" align="absmiddle" ImageUrl="images/post_006.gif"></asp:imagebutton><A href="javascript:PostSubmit();"></A></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<br>
			<asp:panel id="pnAddrList" runat="server" DESIGNTIMEDRAGDROP="1860" Visible="False">
				<TABLE height="20" cellSpacing="0" cellPadding="0" width="470" align="center" bgColor="#eeeeee"
					border="0">
					<TR>
						<TD>&nbsp;<IMG height="12" src="Images/post_005.gif" width="28">�ش��ϴ� �ּҸ� Ŭ���ϼ���.</TD>
					</TR>
				</TABLE>
				<CENTER>
			</asp:panel><asp:panel id="pnNone" runat="server" Visible="False"><BR>&nbsp;&nbsp;&nbsp;�ش��ϴ� �ּҵ����Ͱ� �����ϴ�.</asp:panel>
			<asp:datalist id="dlPost" runat="server">
				<HeaderTemplate>
					<br>
					<TABLE id="stb" style="WIDTH: 400px" cellSpacing="1" cellPadding="0" width="400" bgColor="#ffffff"
						border="0" align="center">
						<TR class="white12b" bgColor="#eeeeee"> <!--#ff4d90 #ffd6dd-->
							<TH width="80" height="23">
								�����ȣ</TH>
							<TH>
								�� ��</TH></TR>
					</TABLE>
					<table style="WIDTH: 400px" cellspacing="1" bgcolor="#ffffff">
				</HeaderTemplate>
				<ItemTemplate>
					<TR style="CURSOR: hand" bgColor="#e6f8ff" id="trReturnValues" runat="server">
						<TD width="80" align="center" height="23">
							<%# ZipcodeFormat(DataBinder.Eval(Container.DataItem, "ZIPCODE")) %>
						</TD>
						<TD align="center" height="23">
							<%#	DataBinder.Eval(Container.DataItem, "totAddrValue") %>
						</TD>
					</TR>
				</ItemTemplate>
				<FooterTemplate>
					<TR bgColor="#4097ac">
						<TD colSpan="2"><IMG height="10" src="images/gif.gif" width="10"></TD>
					</TR>
					</table>
				</FooterTemplate>
			</asp:datalist></TD></TR></TBODY></TABLE>
			<asp:validationsummary id="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False"
				DisplayMode="List"></asp:validationsummary></form>
		</CENTER>
	</body>
</HTML>
