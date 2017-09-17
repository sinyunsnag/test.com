<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MbrOptList.aspx.cs" Inherits="ADMIN.Admins_Members_MbrOptList" %>
<%@ Import Namespace="JinsLibrary" %>
<%@ Register TagPrefix="uc1" TagName="AdminMessage" Src="~/MessageView/AdminMessage.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="robots" content="noindex,nofollow" />
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
    <link href="/App_Themes/Objects.css" rel="stylesheet" type="text/css" />
    <link href="/App_Themes/OverallPage.css" rel="stylesheet" type="text/css" />
    <script language="JavaScript" src="/CommonLibrary/CommonLibrary.js" type="text/javascript"></script>
    <title>The Members Management</title>
</head>
<body>
    <form id="frmMbr" method="post" runat="server">
    <table cellspacing="0" cellpadding="0" width="815" border="0">
        <tr>
            <td colspan="2">
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td width="22">
                            <img width="22" height="27" src="../zImages/admin_top009.gif" />
                        </td>
                        <td bgcolor="#dfdfdf">
                            ������ġ : <asp:Literal ID="litPageTitle" runat="server" />
                        </td>
                        <td>
                            <img height="27" src="../zImages/admin_top010.gif" width="10" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2" height="20">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <table id="Table5" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff"
                    border="0">
                    <tr>
                        <td valign="top" align="center" height="300">
                            <table height="49" cellspacing="0" cellpadding="0" width="800" border="0">
                                <tr>
                                    <td width="208">
                                        <img width="208" height="72" src="Images/member_008.gif" />
                                    </td>
                                    <td background="Images/member_002.gif">
                                        <table id="Table1" cellspacing="0" cellpadding="0" width="98%" border="0">
                                            <tr>
                                                <td valign="bottom" align="left" colspan="3" height="25">
                                                    <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                                        <tr>
                                                            <td height="20">
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:DropDownList ID="ddlSearch" runat="server">
                                                                    <asp:ListItem Value="MbrName" Selected="True">ȸ����</asp:ListItem>
                                                                    <asp:ListItem Value="loginID">���̵�</asp:ListItem>
                                                                    <asp:ListItem Value="company">ȸ���</asp:ListItem>
                                                                    <asp:ListItem Value="jobType">������</asp:ListItem>
                                                                    <asp:ListItem Value="hobbies">��̸�</asp:ListItem>
                                                                    <asp:ListItem Value="member_id">member_id</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <asp:TextBox ID="tbSearchString" runat="server" Height="20px" ToolTip="�˻� Ű���带 ��������."
                                                                    MaxLength="8" Width="100px" OnTextChanged="tbSearchString_TextChanged"></asp:TextBox>
                                                                <asp:Button ID="btnSearch" runat="server" Height="23px" Text="�˻�" EnableViewState="False"
                                                                    OnClick="btnSearch_Click"></asp:Button>
                                                            </td>
                                                            <td align="right">
                                                                <asp:DropDownList ID="ddlSelMenu" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSelMenu_SelectedIndexChanged">
                                                                    <asp:ListItem Value="255" Selected="True">��ȸ��</asp:ListItem>
                                                                    <asp:ListItem Value="101">����</asp:ListItem>
                                                                    <asp:ListItem Value="5">�ֿ��(�÷�Ƽ��)</asp:ListItem>
                                                                    <asp:ListItem Value="4">�ֿ��(���)</asp:ListItem>
                                                                    <asp:ListItem Value="3">�ֿ��(�ǹ�)</asp:ListItem>
                                                                    <asp:ListItem Value="2">���ȸ��</asp:ListItem>
                                                                    <asp:ListItem Value="1">��ȸ��</asp:ListItem>
                                                                    <asp:ListItem Value="0">�ҷ�ȸ��</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" EnableViewState="False"
                                                        ControlToValidate="tbSearchString" ErrorMessage="*" ValidationExpression="[0-9A-Za-z\uac00-\ud7a3]{2,10}"
                                                        Display="Dynamic">*����,Ư�����ڸ� ������ �α��� �̻��� �Է��ϼ���.</asp:RegularExpressionValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                        <img height="72" src="Images/member_003.gif" width="10" />
                                    </td>
                                </tr>
                            </table>
                            <asp:DataList ID="dataList" runat="server" onitemcommand="dataList_ItemCommand" 
                                onitemdatabound="dataList_ItemDataBound">
                                <HeaderTemplate>
                                    <table cellspacing="0" cellpadding="0" width="800" height="30" border="0">
                                        <tr>
                                            <td height="20">
                                            </td>
                                            <td valign="bottom" align="left">
                                                <asp:Literal ID="litSearchResult" runat="server"></asp:Literal>
                                                &nbsp;
                                            </td>
                                            <td valign="bottom" align="right">
                                                <asp:Literal ID="litListBrief" runat="server"></asp:Literal>
                                            </td>
                                        </tr>
                                    </table>
                                    <table cellspacing="1" cellpadding="2" width="800" border="0" bgcolor="#eeeeee">
                                        <tr align="center" bgcolor="#707070">
                                            <td width="55" height="25" bgcolor="#707070" class="Bwhite">
                                                ȸ����ȣ
                                            </td>
                                            <td width="30" class="Bwhite">
                                                ���
                                            </td>
                                            <td class="Bwhite">
                                                ȸ����(���̵�)
                                            </td>
                                            <td width="120" class="Bwhite">
                                                ȸ���(����)
                                            </td>
                                            <td width="70" class="Bwhite">
                                                ����
                                            </td>
                                            <td width="130" class="Bwhite">
                                                ��̻�Ȱ
                                            </td>
                                            <td width="95" class="Bwhite">
                                                ��������
                                            </td>
                                            <td width="40" class="Bwhite">
                                                �ڳ��
                                            </td>
                                            <td width="100" class="Bwhite">
                                                �����޴�
                                            </td>
                                        </tr>
                                    </table>
                                    <!-- ȸ���⺻����, ȸ���ΰ�����, ȸ����ġ, ȸ�������ۼ� -->
                                </HeaderTemplate>
                                <AlternatingItemStyle BackColor="#e9e9e9"></AlternatingItemStyle>
                                <ItemTemplate>
                                    <table width="800" cellpadding="2" cellspacing="1">
                                        <tr align="center">
                                            <td width="55" height="20" align="center">
                                                <%# DataBinder.Eval(Container.DataItem, "member_id")%>
                                            </td>
                                            <td width="30" align="center">                                            
                                                <asp:Label ID="mLevel" runat="server" Font-Underline="true"><%# DataBinder.Eval(Container.DataItem, "mLevel")%></asp:Label>
                                            </td>
                                            <td align="center">
                                                <asp:HyperLink ID="hlEmail" runat="server" />
                                            </td>
                                            <td width="120" align="center">
                                                <asp:Label ID="lbJobInfo" runat="server" />                                                
                                            </td>
                                            <td width="70" align="center">
                                                <asp:Literal ID="litMonthlyPayText" runat="server" />
                                            </td>
                                            <td width="130" align="center">
                                                <asp:Label ID="hobbies" runat="server"></asp:Label>
                                            </td>
                                            <td width="95" align="center">
                                                <asp:Literal ID="litCarInfoText" runat="server" />
                                            </td>
                                            <td width="40" align="center">
                                                <%# DataBinder.Eval(Container.DataItem, "children", "{0:n0}")%>
                                            </td>
                                            <td width="100" align="center">
                                                <asp:HyperLink ID="hlView" ImageUrl="../zImages/btn_admin_view.gif" Visible="False"
                                                    runat="server"></asp:HyperLink>
                                                <asp:ImageButton ID="ibModfy" runat="server" CommandName="select" ImageUrl="../zImages/btn_admin_modify.gif"
                                                    CommandArgument='<%# DataBinder.Eval(Container.DataItem, "member_id") %>' CausesValidation="False"
                                                    Visible="False"></asp:ImageButton>
                                                <asp:Literal ID="displayNone" Text="����" Visible="False" runat="server"></asp:Literal>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                                <SeparatorTemplate>
                                    <table width="800" cellpadding="0" cellspacing="0" height="1" bgcolor="#cccccc">
                                        <tr>
                                            <td height="1">
                                            </td>
                                        </tr>
                                    </table>
                                </SeparatorTemplate>
                            </asp:DataList>
                            <uc1:AdminMessage ID="ucMessage" runat="server"></uc1:AdminMessage>
                            <br />
                            <table cellspacing="0" cellpadding="0" width="800" border="0">
                                <tr>
                                    <td align="center">
                                        &nbsp;
                                    </td>
                                    <td align="center">
                                        <asp:Literal ID="litPaging" runat="server"></asp:Literal>
                                    </td>
                                    <td align="center">
                                        <asp:HyperLink ID="hlAllList" runat="server" NavigateUrl="MbrOptList.aspx" ImageUrl="../zImages/btn_view_list.gif"></asp:HyperLink>
                                        <asp:HyperLink ID="hlInsert" runat="server" NavigateUrl="MbrForm.aspx" ImageUrl="../zImages/btn_member_write.gif"></asp:HyperLink>
                                        <asp:ImageButton ID="ibSendMail" runat="server" ImageUrl="../zImages/btn_send_mail.gif"
                                            AlternateText="���Ϲ߼�"></asp:ImageButton>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
