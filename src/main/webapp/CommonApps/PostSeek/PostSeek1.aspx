<%@ Page language="c#" Codebehind="PostSeek1.aspx.cs" AutoEventWireup="false" Inherits="SkyShop.INC.UTIL.PopZipSearch" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<TITLE>PopZipSearch</TITLE>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=euc-kr">
		<META CONTENT="Microsoft Visual Studio .NET 7.1" NAME="GENERATOR">
		<META CONTENT="C#" NAME="CODE_LANGUAGE">
		<META CONTENT="JavaScript" NAME="vs_defaultClientScript">
		<META CONTENT="http://schemas.microsoft.com/intellisense/ie5" NAME="vs_targetSchema">
		<LINK HREF="/INC/CSS/sky_shop.css" REL="stylesheet" TYPE="text/css">
		<SCRIPT LANGUAGE="javascript">
		<!--
			function SetAddress(zip, addr, selectBox)
			{
				var strValue = document.all(selectBox).value.split('@');
				
				opener.document.all(zip).value = strValue[0];
				opener.document.all(addr).focus();
				opener.document.all(addr).value = strValue[1];
				self.close();
			}
		//-->
		</SCRIPT>
	</HEAD>
	<BODY TOPMARGIN="0" LEFTMARGIN="0" MARGINHEIGHT="0" MARGINWIDTH="0">
		<FORM ID="Form1" METHOD="post" RUNAT="server">
			<TABLE WIDTH="650" HEIGHT="250" BORDER="0" CELLPADDING="0" CELLSPACING="0">
				<!--  Ÿ��Ʋ �̹��� ����-->
				<TR>
					<TD WIDTH="650" HEIGHT="48" VALIGN="top"><IMG SRC="/MEMBERSHIP/IMG/pw_find_tit_04.gif" WIDTH="650" HEIGHT="48"></TD>
				</TR>
				<!--  Ÿ��Ʋ �̹��� ��-->
				<TR>
					<TD BACKGROUND="/MEMBERSHIP/IMG/pw_bg.gif" HEIGHT="4"></TD>
				</TR>
				<TR>
					<TD HEIGHT="15"></TD>
				</TR>
				<TR>
					<TD ALIGN="center" VALIGN="top">
						<!------  ���� ū ���̺� ����------>
						<TABLE WIDTH="600" BORDER="0" CELLSPACING="0" CELLPADDING="0">
							<TR>
								<TD WIDTH="9" HEIGHT="10"><IMG SRC="/MEMBERSHIP/IMG/td_bg_01.gif" WIDTH="9" HEIGHT="10"></TD>
								<TD WIDTH="280" HEIGHT="10" BACKGROUND="/MEMBERSHIP/IMG/td_bg_02.gif"></TD>
								<TD WIDTH="10" HEIGHT="10"><IMG SRC="/MEMBERSHIP/IMG/td_bg_03.gif" WIDTH="10" HEIGHT="10"></TD>
							</TR>
							<TR>
								<TD BACKGROUND="/MEMBERSHIP/IMG/td_bg_04.gif">&nbsp;</TD>
								<TD>
									<!------ �� �Է� ����------>
									<ASP:PANEL ID="St_Panel" RUNAT="server" WIDTH="580">
										<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="580" BORDER="0">
											<TR>
												<TD ALIGN="center" COLSPAN="2">
													<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="311" BORDER="0">
														<TR>
															<TD WIDTH="15" HEIGHT="23"><IMG HEIGHT="23" SRC="/MEMBERSHIP/IMG/txt_bg_01.gif" WIDTH="15"></TD>
															<TD BGCOLOR="#ebebeb"><IMG HEIGHT="5" SRC="/MEMBERSHIP/IMG/bullet_arrow_b.gif" WIDTH="11">
																<ASP:LABEL ID="lblResult" RUNAT="server">ã���� �ϴ� ��/��/���� �Է��ϼ���.</ASP:LABEL>
															</TD>
															<TD WIDTH="12" HEIGHT="23"><IMG HEIGHT="23" SRC="/MEMBERSHIP/IMG/txt_bg_02.gif" WIDTH="12"></TD>
														</TR>
													</TABLE>
												</TD>
											</TR>
											<TR>
												<TD COLSPAN="2" HEIGHT="10"></TD>
											</TR>
											<TR>
												<TD BGCOLOR="#e7e7e7" COLSPAN="2" HEIGHT="1"></TD>
											</TR>
											<TR>
												<TD COLSPAN="2" HEIGHT="10"></TD>
											</TR>
											<TR>
												<TD ALIGN="right" WIDTH="367" HEIGHT="25">
													<ASP:TEXTBOX ID="tb_Dong" RUNAT="server" MAXLENGTH="20" CSSCLASS="input_box"></ASP:TEXTBOX>
													<ASP:REQUIREDFIELDVALIDATOR ID="RequiredFieldValidator1" RUNAT="server" CONTROLTOVALIDATE="tb_Dong" DISPLAY="None"
														ERRORMESSAGE="�������� �Է� �ϼ���.">*</ASP:REQUIREDFIELDVALIDATOR>
													<ASP:VALIDATIONSUMMARY ID="ValidationSummary1" RUNAT="server" SHOWMESSAGEBOX="True" SHOWSUMMARY="False"
														DISPLAYMODE="SingleParagraph"></ASP:VALIDATIONSUMMARY></TD>
												<TD WIDTH="213" HEIGHT="29">&nbsp;
													<ASP:IMAGEBUTTON ID="imgBtn_Search" RUNAT="server" WIDTH="57" BORDERWIDTH="0px" HEIGHT="24" IMAGEALIGN="absmiddle"
														IMAGEURL="/MEMBERSHIP/IMG/bt_confirm.gif"></ASP:IMAGEBUTTON></TD>
											</TR>
											<TR>
												<TD COLSPAN="2" HEIGHT="10"></TD>
											</TR>
										</TABLE>
									</ASP:PANEL>
									<!------ �� �Է� ��------>
									<!------ �� ��� ����------>
									<ASP:PANEL ID="Ed_Panel" RUNAT="server" WIDTH="580" VISIBLE="False">
										<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="580" BORDER="0">
											<TR>
												<TD ALIGN="center">
													<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="311" BORDER="0">
														<TR>
															<TD WIDTH="15" HEIGHT="23"><IMG HEIGHT="23" SRC="/MEMBERSHIP/IMG/txt_bg_01.gif" WIDTH="15"></TD>
															<TD BGCOLOR="#ebebeb"><IMG HEIGHT="5" SRC="/MEMBERSHIP/IMG/bullet_arrow_b.gif" WIDTH="11">
																�Ʒ� �˻��� �ּ� �� �ش�Ǵ� �ּҸ� �����ϼ���.
															</TD>
															<TD WIDTH="12" HEIGHT="23"><IMG HEIGHT="23" SRC="/MEMBERSHIP/IMG/txt_bg_02.gif" WIDTH="12"></TD>
														</TR>
													</TABLE>
												</TD>
											</TR>
											<TR>
												<TD HEIGHT="10"></TD>
											</TR>
											<TR>
												<TD BGCOLOR="#e7e7e7" HEIGHT="1"></TD>
											</TR>
											<TR>
												<TD HEIGHT="10"></TD>
											</TR>
											<TR>
												<TD WIDTH="448" HEIGHT="25" ALIGN="right" STYLE="padding-left:50px">
													<ASP:DROPDOWNLIST ID="selAddr" RUNAT="server" WIDTH="440"></ASP:DROPDOWNLIST>
												</TD>
											</TR>
											<TR>
												<TD ALIGN="center" VALIGN="bottom">
													<BR>
													<A HREF="javascript:SetAddress(<%=GetParams()%>);"><IMG HEIGHT="24" SRC="/MEMBERSHIP/IMG/bt_confirm.gif" WIDTH="57" BORDER="0" VALIGN="middle">
													</A>
												</TD>
											</TR>
										</TABLE>
									</ASP:PANEL>
									<!------ �� ��� ��------>
								</TD>
								<TD BACKGROUND="/MEMBERSHIP/IMG/td_bg_05.gif"><IMG SRC="/MEMBERSHIP/IMG/td_bg_05.gif" WIDTH="10" HEIGHT="7"></TD>
							</TR>
							<TR>
								<TD WIDTH="9" HEIGHT="15"><IMG SRC="/MEMBERSHIP/IMG/td_bg_06.gif" WIDTH="9" HEIGHT="15"></TD>
								<TD WIDTH="280" BACKGROUND="/MEMBERSHIP/IMG/td_bg_07.gif">&nbsp;</TD>
								<TD><IMG SRC="/MEMBERSHIP/IMG/td_bg_08.gif" WIDTH="10" HEIGHT="15"></TD>
							</TR>
						</TABLE>
						<!------  ���� ū ���̺� ��------>
					</TD>
				</TR>
				<TR>
					<TD HEIGHT="10">&nbsp;</TD>
				</TR>
				<!-------  â�ݱ� ���� ----------->
				<TR>
					<TD HEIGHT="40" BGCOLOR="#e4e4e4" ALIGN="right" STYLE="PADDING-RIGHT:15px">
						<A HREF="javascript:self.close();">
							<IMG SRC="/MEMBERSHIP/IMG/bt_winclose.gif" WIDTH="69" HEIGHT="26" BORDER="0"></A></TD>
				</TR>
				<!-------  â�ݱ� �� ----------->
			</TABLE>
		</FORM>
	</BODY>
</HTML>
