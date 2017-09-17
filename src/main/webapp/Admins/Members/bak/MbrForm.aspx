<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MbrForm.aspx.cs" Inherits="ADMIN.Admins_Members_MbrForm" %>
<%@ Register TagPrefix="uc1" TagName="DateSelector" Src="~/CommonApps/Calendar/DateSelector/DateSelector.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="robots" content="noindex,nofollow"/>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
    <link href="/App_Themes/Objects.css" rel="stylesheet" type="text/css"/>
    <link href="/App_Themes/OverallPage.css" rel="stylesheet" type="text/css"/>
    <script language="JavaScript" src="/CommonLibrary/CommonLibrary.js" type="text/javascript"></script> 

    <link href="/CommonApps/Calendar/DateSelector/popcalendar.css" type="text/css" rel="stylesheet" />
    <title>The Members Management</title>
</head>
<body>
    <form id="frmMbr" method="post" runat="server">
    <table cellspacing="0" cellpadding="0" width="815" border="0">
        <tr>
            <td bgcolor="#ffffff">
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td width="22"><img height="27" src="../zImages/admin_top009.gif" /></td>
                        <td bgcolor="#f4f4f4">������ġ : 
                      <asp:Literal ID="litPageTitle" runat="server" /></td>
                        <td width="10"><img height="27" src="../zImages/admin_top010.gif" width="10" /></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr valign="top" align="center" bgcolor="#ffffff">
            <td height="20">&nbsp;
                
            </td>
        </tr>
        <tr valign="top" align="center" bgcolor="#ffffff">
            <td height="150">
                <table cellspacing="0" cellpadding="0" width="800" border="0">
                    <tr>
                        <td width="176">
                            <img width="176" height="53" src="Images/member_006.gif" />                        </td>
                        <td background="Images/member_005.gif">&nbsp;
                            
                        </td>
                    </tr>
                </table>
                <table cellspacing="0" cellpadding="0" width="780" border="0">
                    <tr>
                        <td>&nbsp;
                            
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table cellspacing="1" cellpadding="2" width="100%" border="0">
                                <tr>
                                    <td class="Bwhite" align="center" bgcolor="#005983" colspan="4" height="30">
                                        �⺻����
                                    </td>
                                </tr>
                                <tr>
                                    <td class="Bwhite" bgcolor="#3a8bb1" height="22">
                                        &nbsp;ȸ����ȣ
                                    </td>
                                    <td>
                                        <asp:Literal ID="member_id" runat="server" Text="���Ҵ�"></asp:Literal>
                                    </td>
                                    <td class="Bwhite" bgcolor="#3a8bb1">
                                        &nbsp;�ֹε�Ϲ�ȣ
                                    </td>
                                    <td>
                                        <asp:TextBox ID="SSN1" runat="server" Columns="6" CssClass="box003" MaxLength="6"></asp:TextBox>
                                        -
                                        <asp:TextBox ID="SSN2" runat="server" Columns="7" CssClass="box003" MaxLength="7"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Display="None"
                                            ControlToValidate="SSN1" ErrorMessage="���ڸ� �ֹι�ȣ�� �Է��ϼ���.">*</asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" Display="Dynamic"
                                            ControlToValidate="SSN2" ErrorMessage="���ڸ� �ֹι�ȣ�� �Է��ϼ���.">*</asp:RequiredFieldValidator>
                                        &nbsp;<input class="box003" id="btnSSN" style="width: 86px; height: 17px" type="button"
                                            value="�ֹι�ȣȮ��" name="Button1" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="Bwhite" bgcolor="#3a8bb1" height="22">
                                        &nbsp;��������
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="cbProMbr" runat="server" Text="���θ���� ���� �����Դϴ�."></asp:CheckBox>
                                    </td>
                                    <td class="Bwhite" bgcolor="#3a8bb1">
                                        &nbsp;�ּ�
                                    </td>
                                    <td>
                                        <asp:TextBox ID="zipcode" runat="server" CssClass="box003" MaxLength="6" ReadOnly="True"
                                            Width="50px"></asp:TextBox>
                                        <asp:HyperLink ID="hlSeekAddr" runat="server">�ּ�ã��</asp:HyperLink>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="zipcode"
                                            ErrorMessage="�����ȣ�� ã������.">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="Bwhite" bgcolor="#3a8bb1" height="22">
                                        &nbsp;�α��ξ��̵�
                                    </td>
                                    <td>
                                        <asp:TextBox ID="loginID" runat="server" Columns="12" CssClass="box003" MaxLength="15"></asp:TextBox>
                                        <input class="box003" id="bnLoginID" type="button" value="�˻�" name="Button1" runat="server" />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" Display="Dynamic"
                                            ControlToValidate="loginID" ErrorMessage="���̵� ��������.">*</asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="revLoginID" runat="server" ControlToValidate="loginID"
                                            ErrorMessage="���̵�� �����ڷ� �����Ͽ� 3�� �̻� 15�� �����Դϴ�." ValidationExpression="[A-z]\w{2,15}">*</asp:RegularExpressionValidator>
                                        <marquee id="marqeeIdCheckWaitMag" style="border-top-width: 0px; display: none" scrollamount="5"
                                            behavior="alternate" width="50">
                    <font color="blue">������..</font>
                    </marquee>
                                    </td>
                                    <td class="Bwhite" bgcolor="#3a8bb1" rowspan="2">&nbsp;
                                        
                                    </td>
                                    <td>
                                        <asp:TextBox ID="mAddress1" runat="server" CssClass="box003" MaxLength="200" ReadOnly="True"
                                            Width="300px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="Bwhite" bgcolor="#3a8bb1" height="22">
                                        &nbsp;�α��ξ�ȣ
                                    </td>
                                    <td>
                                        <asp:TextBox ID="loginPW" runat="server" Columns="12" CssClass="box003" MaxLength="15"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="loginPW"
                                            ErrorMessage="�н����带 ��������.">*</asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="Regularexpressionvalidator4" runat="server" ControlToValidate="loginPW"
                                            ErrorMessage="��ȣ�� ������� 4�� �̻� �Է��ϼ���." ValidationExpression="\w{4,14}">*</asp:RegularExpressionValidator>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="mAddress2" runat="server" CssClass="box003" MaxLength="200" Width="300px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="mAddress2"
                                            ErrorMessage="�ּҸ� ��Ȯ�� �Է��ϼ���.">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="Bwhite" style="height: 22px" bgcolor="#3a8bb1" height="22">
                                        &nbsp;ȸ����
                                    </td>
                                    <td style="height: 22px">
                                        <asp:TextBox ID="MbrName" runat="server" Columns="12" CssClass="box003" MaxLength="20"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="MbrName"
                                            ErrorMessage="�̸��� �Է��ϼ���.">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td class="Bwhite" bgcolor="#3a8bb1">
                                        &nbsp;����������û
                                    </td>
                                    <td style="height: 22px">
                                        <asp:CheckBox ID="newsLetter" runat="server" Text="���������� ��û�մϴ�." Checked="True">
                                        </asp:CheckBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="Bwhite" bgcolor="#3a8bb1" height="22">
                                        &nbsp;������ȭ��ȣ
                                    </td>
                                    <td>
                                        <asp:TextBox ID="phone1" runat="server" CssClass="box003" MaxLength="4" Width="50px"></asp:TextBox>
                                        -
                                        <asp:TextBox ID="phone2" runat="server" CssClass="box003" MaxLength="4" Width="50px"></asp:TextBox>
                                        -
                                        <asp:TextBox ID="phone3" runat="server" CssClass="box003" MaxLength="12" Width="70px"></asp:TextBox>
                                    </td>
                                    <td class="Bwhite" bgcolor="#3a8bb1">
                                        &nbsp;PWã������
                                    </td>
                                    <td>
                                        <span>
                                            <asp:DropDownList ID="findingID" runat="server">
                                                <asp:ListItem Value="0" Selected="True">8~�����ϼ���~8</asp:ListItem>
                                            </asp:DropDownList>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="Bwhite" bgcolor="#3a8bb1" height="22">
                                        &nbsp;�ڵ�����ȣ
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="cellularP1" runat="server" CssClass="box003">
                                            <asp:ListItem Selected="True" Value="">����</asp:ListItem>
                                        </asp:DropDownList>
                                        -
                                        <asp:TextBox ID="cellularP2" runat="server" CssClass="box003" MaxLength="4" Width="50px"></asp:TextBox>
                                        -
                                        <asp:TextBox ID="cellularP3" runat="server" CssClass="box003" MaxLength="12" Width="70px"></asp:TextBox>
                                    </td>
                                    <td class="Bwhite" bgcolor="#3a8bb1">
                                        &nbsp;PWã���
                                    </td>
                                    <td>
                                        <asp:TextBox ID="findingA" runat="server" CssClass="box003" MaxLength="50" Width="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="Bwhite" bgcolor="#3a8bb1" height="22">
                                        &nbsp;�̸���
                                    </td>
                                    <td>
                                        <asp:TextBox ID="MbrEmail" runat="server" CssClass="box003" MaxLength="50" Width="200px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="Requiredfieldvalidator4" runat="server" ControlToValidate="MbrEmail"
                                            ErrorMessage="�̸����� �Է��ϼ���.">*</asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="MbrEmail"
                                            ErrorMessage="�̸����� ��Ȯ�� �Է��ϼ���." ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
                                    </td>
                                    <td class="Bwhite" bgcolor="#3a8bb1">
                                        &nbsp;��õ�ξ��̵�
                                    </td>
                                    <td>
                                        <asp:TextBox ID="rcmderID" runat="server" Columns="12" CssClass="box003" MaxLength="15"></asp:TextBox>
                                        <input class="box003" id="bnRcmderID" type="button" value="�˻�" runat="server" />
                                        <asp:RegularExpressionValidator ID="revRcmderID" runat="server" ControlToValidate="rcmderID"
                                            ErrorMessage="���̵�� �����ڷ� �����Ͽ� 3�� �̻� 15�� �����Դϴ�." ValidationExpression="[A-z]\w{2,15}">*</asp:RegularExpressionValidator>
                                        <marquee id="marqeeIdCheckWaitMag1" style="border-top-width: 0px; display: none"
                                            scrollamount="5" behavior="alternate" width="70">
                    <font color="blue">������..</font>
                    </marquee>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td height="2">
                        </td>
                    </tr>
                    <tr>
                        <td height="2" bgcolor="#aaaaaa">
                        </td>
                    </tr>
                    <tr>
                        <td height="5">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td class="Bwhite" align="center" bgcolor="#005983" height="30">&nbsp;
                                        
                                    </td>
                                    <td class="Bwhite" align="center" bgcolor="#005983">
                                        �ΰ�����
                                    </td>
                                    <td class="Bwhite" align="center" bgcolor="#005983">
                                        <asp:ImageButton ID="ibAdditionalInfo" runat="server" Width="73" Height="20" AlternateText="�ΰ�����"
                                            ImageUrl="../zImages/btn_add_info.gif" align="absmddle" 
                                            CausesValidation="False" onclick="ibAdditionalInfo_Click">
                                        </asp:ImageButton>
                                    </td>
                                </tr>
                                <asp:Panel ID="pnAdditionalInfo" runat="server" Visible="False">
                                    <tr>
                                        <td colspan="3">
                                            <table cellspacing="0" cellpadding="0" width="780" border="0">
                                                <tr>
                                                    <td valign="top">
                                                        <table cellspacing="1" cellpadding="2" width="100%" border="0">
                                                            <tr>
                                                                <td class="Bwhite" align="center" bgcolor="#3a8bb1" height="25">
                                                                    ȸ�����
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center" height="35">
                                                                    <asp:DropDownList ID="ddlMLevel" runat="server" Visible="False" AutoPostBack="True"
                                                                        Enabled="False">
                                                                        <asp:ListItem Value="101">����</asp:ListItem>
                                                                        <asp:ListItem Value="5">�ֿ��(�÷�Ƽ��)</asp:ListItem>
                                                                        <asp:ListItem Value="4">�ֿ��(���)</asp:ListItem>
                                                                        <asp:ListItem Value="3">�ֿ��(�ǹ�)</asp:ListItem>
                                                                        <asp:ListItem Value="2">���ȸ��</asp:ListItem>
                                                                        <asp:ListItem Value="1">��ȸ��</asp:ListItem>
                                                                        <asp:ListItem Value="0">�ҷ�ȸ��</asp:ListItem>
                                                                        <asp:ListItem Value="-1">Ż��ȸ��</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <table cellspacing="1" cellpadding="2" width="100%" border="0">
                                                            <tr>
                                                                <td class="Bwhite" align="center" bgcolor="#3a8bb1" height="25">
                                                                    �ƹ�Ÿ�̹���
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td valign="middle" align="center" height="300">
                                                                    <asp:Image ID="avataImage" runat="server" ImageUrl="../../xUpload/MbrData/Avata/AvaPic_default.gif">
                                                                    </asp:Image>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td valign="middle" align="left">
                                                                    <input language="C#" class="box003" id="bnAvataImage" type="file" size="22" name="file"
                                                                        runat="server" />
                                                                    <asp:CheckBox ID="cbDeleteAI" runat="server" Text="���ϻ���" Visible="False"></asp:CheckBox>
                                                                    &nbsp;(512K�̸�)
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td valign="top">
                                                        <table cellspacing="1" cellpadding="2" width="100%" border="0">
                                                            <tr>
                                                                <td width="120" height="22" align="center" bgcolor="#3a8bb1" class="Bwhite">Ȩ������</td>
                                                                <td colspan="3">
                                                                    &nbsp;http://
                                                                    <asp:TextBox ID="homepage" runat="server" MaxLength="50" CssClass="box003" Width="176px"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td height="22" align="center" bgcolor="#3a8bb1" class="Bwhite">
                                                                    ����ռҵ�</td>
                                                                <td>
                                                                    &nbsp;<span style="height: 19px">
                                                                        <asp:DropDownList ID="monthlyPay" runat="server">
                                                                            <asp:ListItem Selected="True" Value="">8~�����ϼ���~8</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </span>
                                                                </td>
                                                                <td class="Bwhite" bgcolor="#3a8bb1" height="22">
                                                                    &nbsp;��������
                                                                </td>
                                                                <td>
                                                                    <span style="height: 19px">&nbsp;
                                                                        <asp:DropDownList ID="carInfo" runat="server">
                                                                            <asp:ListItem Selected="True" Value="">8~�����ϼ���~8</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </span>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td height="22" align="center" bgcolor="#3a8bb1" class="Bwhite">����</td>
                                                                <td colspan="3">
                                                                    <asp:RadioButtonList ID="rblSLBirth" runat="server" RepeatDirection="Horizontal"
                                                                        RepeatLayout="Flow">
                                                                        <asp:ListItem Value="��">���</asp:ListItem>
                                                                        <asp:ListItem Value="��">����</asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                    <asp:TextBox ID="tbBirthDay" runat="server" MaxLength="10" CssClass="box003" Columns="9"
                                                                        ReadOnly="True"></asp:TextBox>
                                                                    <uc1:DateSelector ID="dSelectorBirth" runat="server"></uc1:DateSelector>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td height="22" align="center" bgcolor="#3a8bb1" class="Bwhite">��ȥ�����</td>
                                                                <td>
                                                                    <asp:RadioButtonList ID="rblMarried" runat="server" RepeatDirection="Horizontal"
                                                                        RepeatLayout="Flow">
                                                                        <asp:ListItem Value="��">��ȥ</asp:ListItem>
                                                                        <asp:ListItem Value="��">��ȥ</asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                </td>
                                                                <td colspan="2">
                                                                    <asp:Panel ID="pnWA" runat="server">
                                                                        <asp:TextBox ID="tbWeddingDay" runat="server" MaxLength="10" CssClass="box003" Columns="9"
                                                                            ReadOnly="True"></asp:TextBox>
                                                                        <uc1:DateSelector ID="dSelectorWedding" runat="server"></uc1:DateSelector>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td height="22" align="center" bgcolor="#3a8bb1" class="Bwhite">�ڳ��                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="children" runat="server" MaxLength="3" CssClass="box003" Columns="3"></asp:TextBox>
                                                                    <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="0~99 ���� �ȿ��� �Է��ϼ���."
                                                                        ControlToValidate="children" MinimumValue="0" MaximumValue="99" Type="Integer">*</asp:RangeValidator>
                                                                </td>
                                                                <td class="Bwhite" height="22">&nbsp;
                                                                    
                                                                </td>
                                                                <td>&nbsp;
                                                                    
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td height="22" align="center" bgcolor="#3a8bb1" class="Bwhite">�޽�����</td>
                                                                <td>
                                                                    <asp:TextBox ID="MsgName" runat="server" MaxLength="50" CssClass="box003" Columns="20"></asp:TextBox>
                                                                </td>
                                                                <td class="Bwhite" bgcolor="#3a8bb1" height="22">
                                                                    &nbsp;�޽������̵�
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="MsgID" runat="server" MaxLength="50" CssClass="box003" Columns="20"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td height="22" align="center" bgcolor="#3a8bb1" class="Bwhite">��� ��<br />
                                                              &nbsp;���ɺо�</td>
                                                                <td colspan="3">
                                                                    <span class="Bwhite">
                                                                        <asp:CheckBoxList ID="hobbies" runat="server" Width="400" RepeatColumns="4">
                                                                        </asp:CheckBoxList>
                                                                    </span>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="Bwhite" bgcolor="#3a8bb1" height="22">&nbsp;</td>
                                                                <td bgcolor="#3a8bb1" colspan="3">
                                                                    &nbsp;<span class="Bwhite">����� ���� �� </span>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center" colspan="4" height="22">
                                                                    <asp:TextBox ID="mark" runat="server" MaxLength="2000" CssClass="box004" Width="500px"
                                                                        TextMode="MultiLine" Rows="3"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="Bwhite" bgcolor="#3a8bb1" height="22">&nbsp;
                                                                    
                                                                </td>
                                                                <td bgcolor="#3a8bb1" colspan="3">
                                                                    &nbsp;<span class="Bwhite">ȸ������</span>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td height="22" align="center" bgcolor="#3a8bb1" class="Bwhite">
                                                                    &nbsp;ȸ���                                                                </td>
                                                                <td colspan="3">
                                                                    &nbsp;
                                                                    <asp:TextBox ID="company" runat="server" MaxLength="80" CssClass="box003" Columns="30"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td height="20" align="center" bgcolor="#3a8bb1" class="Bwhite" style="height: 20px">
                                                                    &nbsp;�� ��                                                                </td>
                                                                <td colspan="3">
                                                                    &nbsp;
                                                                    <asp:DropDownList ID="jobType" runat="server">
                                                                        <asp:ListItem Selected="True" Value="">8~�����ϼ���~8</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td height="22" align="center" bgcolor="#3a8bb1" class="Bwhite">
                                                                    &nbsp;������ȣ                                                                </td>
                                                                <td colspan="3">
                                                                    &nbsp;
                                                                    <asp:TextBox ID="officeP1" runat="server" MaxLength="4" CssClass="box003" Width="50px"></asp:TextBox>
                                                                    -
                                                                    <asp:TextBox ID="officeP2" runat="server" MaxLength="4" CssClass="box003" Width="50px"></asp:TextBox>
                                                                    -
                                                                    <asp:TextBox ID="officeP3" runat="server" MaxLength="8" CssClass="box003" Width="70px"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td height="22" align="center" bgcolor="#3a8bb1" class="Bwhite">
                                                                    &nbsp;ȸ���ּ�                                                                </td>
                                                                <td colspan="3">
                                                                    &nbsp;
                                                                    <asp:TextBox ID="oZipcode" runat="server" MaxLength="6" CssClass="box003" Width="50px"
                                                                        ReadOnly="True"></asp:TextBox>
                                                                    &nbsp;
                                                                    <asp:HyperLink ID="hlSeekOAddr" runat="server">�ּ�ã��</asp:HyperLink>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="Bwhite" bgcolor="#3a8bb1" rowspan="2">&nbsp;
                                                                    
                                                                </td>
                                                                <td colspan="3" height="22">
                                                                    &nbsp;
                                                                    <asp:TextBox ID="oAddress1" runat="server" MaxLength="200" CssClass="box003" Width="300px"
                                                                        ReadOnly="True"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="3" height="22">
                                                                    &nbsp;
                                                                    <asp:TextBox ID="oAddress2" runat="server" MaxLength="200" CssClass="box003" Width="300px"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                      </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#005983" colspan="3" height="2">
                                        </td>
                                    </tr>
                                </asp:Panel>
                                <tr>
                                    <td colspan="3" height="30">&nbsp;
                                        
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" DESIGNTIMEDRAGDROP="2564"
                    ShowSummary="False" ShowMessageBox="True"></asp:ValidationSummary>
            </td>
        </tr>
        <tr>
            <td align="center" bgcolor="#ffffff" height="30">
                <asp:HyperLink ID="hlList" runat="server" ImageUrl="../zImages/btn_view_list.gif" NavigateUrl="MbrList.aspx" />
                <asp:HyperLink ID="hlBack" runat="server" ImageUrl="../zImages/btn_admin_back.gif" />
                <asp:ImageButton ID="ibInsert" runat="server" ImageUrl="../zImages/admin_btn_enter.gif" />
                <asp:ImageButton ID="ibUpdate" runat="server" ImageUrl="../zImages/btn_admin_modify.gif" />
            </td>
        </tr>
    </table>
    </form>
<div id="joiningWebService" style="BEHAVIOR: url(http://<%= HttpContext.Current.Request.ServerVariables["HTTP_HOST"] %>/CommonLibrary/WebServices/webservice.htc)" />
</body>
</html>
