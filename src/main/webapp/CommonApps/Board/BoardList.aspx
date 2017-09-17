<%@ Page language="c#" Codebehind="BoardList.aspx.cs" AutoEventWireup="false" Inherits="KistelSite.CommonApps.Board.bList" %>
<%@ Import namespace="KistelSite.Admins.CompanyMgr.Staffs" %>
<%@ Import namespace="KistelSite.Admins.CompanyMgr.Docs" %>
<%@ Import namespace="JinsLibrary" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
    <title>bList</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
	<LINK href="/StyleSheets/Objects.css" type="text/css" rel="stylesheet">
	<LINK href="/StyleSheets/OverallPage.css" type="text/css" rel="stylesheet">
	<script language="JavaScript" src="/CommonLibrary/CommonLibrary.js"></script>
</HEAD>
  <body MS_POSITIONING="FlowLayout">

<FORM id="frmNotice" method="post" runat="server">
<TABLE id="Table2" cellSpacing="0" cellPadding="0" width="810" border="0">
  <TR>
    <TD colSpan="2">
      <TABLE id="Table3" cellSpacing="0" cellPadding="0" width="100%" border="0">
        <TR>
          <TD width="22"><IMG height="27" src="../../zImages/admin_top009.gif" 
            width="22"></TD>
          <TD bgColor="#dfdfdf">������ġ :
									<%= KistelSite.Admins.WebPageParts.MakeLocationBar(Request.QueryString["sm"]) %>
								</TD>
          <TD width="10"><IMG height="27" src="../../zImages/admin_top010.gif" 
            width="10"></TD></TR></TABLE></TD></TR>
  <TR>
    <TD colSpan="2" height="20">&nbsp;</TD></TR>
  <TR align=center>
    <TD colSpan="2">
      <TABLE id="Table4" cellSpacing="0" cellPadding="0" width="800" border="0">
        <TR>
          <TD width="176"><IMG height="72" src="Images/Document_001.gif" 
          width="179"></TD>
          <TD background="Images/Document_002.gif">
            <TABLE id="Table6" cellSpacing="0" cellPadding="0" width="100%" 
              border="0">
              <TR>
                <TD height="20">&nbsp;</TD>
                <TD align=right height=20>&nbsp;</TD></TR>
              <TR>
                <TD><asp:dropdownlist id="ddlSearch" runat="server">
						<asp:ListItem Value="daCategory">��з�</asp:ListItem>
						<asp:ListItem Value="daType">Ÿ��</asp:ListItem>
						<asp:ListItem Value="daName" Selected="True">������</asp:ListItem>
						<asp:ListItem Value="daDescription">���μ���</asp:ListItem>
						<asp:ListItem Value="da_id">������ȣ</asp:ListItem>
						<asp:ListItem Value="staff_id">���̵�</asp:ListItem>
					</asp:dropdownlist><asp:textbox id="tbSearchString" runat="server" Height="20px" Width="100px" MaxLength="8" ToolTip="�˻� Ű���带 ��������."></asp:textbox><asp:button id="btnSearch" runat="server" Height="23px" EnableViewState="False" Text="�˻�"></asp:button></TD>
                <TD align=right><asp:dropdownlist id="ddlSelMenu" runat="server" AutoPostBack="True">
													<asp:ListItem Value="5">��ܺ�</asp:ListItem>
													<asp:ListItem Value="34" Selected="True">���Թ���</asp:ListItem>
													<asp:ListItem Value="2">���ο�û</asp:ListItem>
													<asp:ListItem Value="1">�ӽù���</asp:ListItem>
													<asp:ListItem Value="255">��������</asp:ListItem>
												</asp:dropdownlist></TD></TR></TABLE></TD>
          <TD width="9"><IMG height="72" src="Images/Document_003.gif" 
        width="8"></TD></TR></TABLE></TD></TR>
  <TR>
    <TD colSpan="2" height="20">&nbsp;</TD></TR>
  <TR>
    <TD colSpan="2">
      <TABLE id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0">
        <TR>
          <TD height="20">&nbsp;</TD>
          <TD vAlign="bottom" align=left><asp:label id="lbSearchResult" runat="server" Visible="False"></asp:label>&nbsp;</TD>
          <TD vAlign="bottom" align=right><asp:label id="lbListBrief" runat="server"></asp:label></TD></TR></TABLE></TD></TR>
  <TR>
    <TD width="10">&nbsp;</TD>
    <TD>
      <TABLE id="Table5" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" 
      border="0">
        <TR>
          <TD vAlign="top" align=center><asp:datagrid id="dataGrid" runat="server" Width="800px" AutoGenerateColumns="False" CellSpacing="1" PageSize="6" GridLines="None" CellPadding="1" BorderWidth="0px">
										<AlternatingItemStyle BackColor="#EEEEEE"></AlternatingItemStyle>
										<ItemStyle HorizontalAlign="Center"></ItemStyle>
										<HeaderStyle Wrap="False" HorizontalAlign="Center" Height="30px" VerticalAlign="Middle" BackColor="#707070"></HeaderStyle>
										<Columns>
											<asp:BoundColumn DataField="da_id" ReadOnly="True" HeaderText="������ȣ">
												<HeaderStyle Width="60px" CssClass="Bwhite"></HeaderStyle>
											</asp:BoundColumn>
											<asp:BoundColumn DataField="daCategory" HeaderText="��з�">
												<HeaderStyle Width="120px" CssClass="Bwhite"></HeaderStyle>
												<ItemStyle Height="25px"></ItemStyle>
											</asp:BoundColumn>
											<asp:BoundColumn DataField="daType" HeaderText="Ÿ��">
												<HeaderStyle Width="120px" CssClass="Bwhite"></HeaderStyle>
											</asp:BoundColumn>
											<asp:BoundColumn DataField="daName" HeaderText="������">
												<HeaderStyle CssClass="Bwhite"></HeaderStyle>
											</asp:BoundColumn>
											<asp:TemplateColumn HeaderText="��޻���">
												<HeaderStyle Width="60px" CssClass="Bwhite"></HeaderStyle>
												<ItemTemplate>
													<%# DocBaseLib.GetStatus(DataBinder.Eval(Container.DataItem, "daStatus")) %>
												</ItemTemplate>
											</asp:TemplateColumn>
											<asp:TemplateColumn HeaderText="������">
												<HeaderStyle CssClass="Bwhite"></HeaderStyle>
												<ItemTemplate>
													<%# StfBaseLib.GetLoginID( DataBinder.Eval(Container.DataItem, "staff_id") ) %>
												</ItemTemplate>
											</asp:TemplateColumn>
											<asp:BoundColumn DataField="docDay" HeaderText="��¥" DataFormatString="{0:d}">
												<HeaderStyle Width="70px" CssClass="Bwhite"></HeaderStyle>
											</asp:BoundColumn>
											<asp:TemplateColumn HeaderText="�����޴�">
												<HeaderStyle Width="60px" CssClass="Bwhite"></HeaderStyle>
												<ItemTemplate>
													<%# DocBaseLib.ViewButton(DataBinder.Eval(Container.DataItem, "da_id"), DataBinder.Eval(Container.DataItem, "DNSecurity"), DataBinder.Eval(Container.DataItem, "SLSecurity")) %>
													<%# DocBaseLib.DisplayNone() %>
												</ItemTemplate>
											</asp:TemplateColumn>
										</Columns>
										<PagerStyle HorizontalAlign="Right" ForeColor="#000066" BackColor="White" Mode="NumericPages"></PagerStyle>
									</asp:datagrid><asp:label id="lbInfoList" runat="server" Height="50px" Visible="False">��ϵ� ������ �����ϴ�.</asp:label><BR>
            <TABLE id="Table7" cellSpacing="0" cellPadding="0" width="800" border="0">
              <TR>
                <TD align=center width=100>&nbsp;</TD>
                <TD align=center><asp:label id="lbPaging" runat="server"></asp:label></TD>
                <TD align=center width=200><asp:hyperlink id="hlAllList" runat="server" NavigateUrl="DocList.aspx" ImageUrl="../../zImages/btn_view_list.gif"></asp:hyperlink><asp:hyperlink id="hlInsert" runat="server" NavigateUrl="DocForm.aspx" ImageUrl="Images/btn_Document_write.gif"></asp:hyperlink></TD></TR></TABLE></TD></TR></TABLE></TD></TR>
  <TR>
    <TD>&nbsp;</TD>
    <TD>&nbsp;</TD></TR></TABLE></FORM>
	
  </body>
</HTML>
