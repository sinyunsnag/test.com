<!-- ShopSetting Start -->
<!--#include File = "../../SiteSetting.asp" -->
<!-- ShopSetting End -->
<%
	'��������������
	NMmyPg = Trim(Request("NMmyPg"))

	orderNbr = Trim(Request("orderNbr"))
	clientName = Trim(Request("clientName"))	
	if Session("MbrID") = "" And (orderNbr = "" Or clientName = "") then 
		if NMmyPg = "Y" then 
			Response.Redirect("../../CommonAccessories/MbrUsers/muLoginDisplay.asp?NMmyPg=Y&gtu=" & Server.URLEncode(Application("SiteRoot") & "ShopBody/MyPage/MyPage.asp"))
		else
			Response.Redirect("../../CommonAccessories/MbrUsers/muLoginDisplay.asp?NMmyPg=N&gtu=" & Server.URLEncode(Application("SiteRoot") & "ShopBody/MyPage/MyPage.asp"))
		end if
	end if
	session("PageTitleName") = "����������"
	fristLevel =" > ����������"
%>

<html>
<head>
<title>[<%= Request.Cookies("siteTitle") %>]</title>
<meta name="keywords" content="ķ�ڴ� ī�޶� �޸�">
<meta name="description" content="�ְ��� ķ�ڴ� ��������Ʈ">
<meta name="GENERATOR" Content="Microsoft Visual Studio.NET 7.0">
<meta http-equiv="refresh" content="<%= refl %>">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../Include_css/Style.css" rel="stylesheet" type="text/css">
<link href="../../Include_css/Object.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="../../Include_js/CommonFunctions.js"></script>
<script language="JavaScript" src="../../Include_js/Function.js"></script>
</head>
<body> 
<table width="800" border="0" cellspacing="0" cellpadding="0"> 
  <tr> 
    <td> <!-- FrontHeader Start --> 
      <!--#include File = "../../SiteHeader/FrontHeader.asp" --> 
      <!-- FrontHeader End --> </td> 
  </tr> 
  <tr> 
    <td><table width="800" border="0" cellspacing="0" cellpadding="0"> 
        <tr> 
          <td colspan="2"> <!-- MainMenuBar Start --> 
            <!--#include File = "../../ShopComponents/MainMenu/MainMenuBar.asp" --> 
            <!-- MainMenuBar End --> </td> 
        </tr> 
        <tr> 
		 <base href="<%= Application("SiteURLDir") %>ShopBody/MyPage/" target="_self"> 
          <td colspan="2"><img src="Images/MyPageDisplay.gif" width="800" height="125"></td> 
        </tr> 
        <tr bgcolor="#E9FEFE"> 		
          <td width="170" bgcolor="#333399"><img src="Images/MyPageNametag.gif" width="171" height="31"></td> 
          <td width="640">
<%
	secondLevel =" > �������"
%>		  		  
		   
		  	<!-- LocationBar Start --> 
            <!--#include File = "../../ShopComponents/LocationBar/LocationBar.asp" --> 
            <!-- LocationBar End --> </td> 
        </tr> 
<base href="<%= Application("SiteURLDir") %>ShopBody/MyPage/" target="_self"> 
        <tr> 
          <td height="500" valign="top"> <!-- My Page left include start --> 
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0"> 
              <tr> 
                <td><img src="https://image.interpark.com/ssl/template/blank.gif" width="10" height="3"></td> 
              </tr> 
              <tr> 
                <td bgcolor="#DFDFDF"> <table width="100%" border="0" cellpadding="0" cellspacing="1"> 
<% if Session("MbrID") <> "" then %>
                    <tr> 
                      <td height="25" bgcolor="#FFFFFF"> * ȸ������ </td> 
                    </tr> 
                    <tr> 
                      <td bgcolor="#FFFFFF"> <table width="100%" border="0" cellspacing="0" cellpadding="5"> 
                          <tr> 
                            <td>- <a href="../../CommonAccessories/MbrUsers/muInput.asp?sMode=u">ȸ���⺻���� ����</a><br> 
                              <!-- <a href="#">ȸ���߰����� ����</a><br-->                              
							  
					          - Wish List<br> 
                              <!-- <a href="#">���� ������ ��</a> <br> 
                              - <a href="#">������ ����</a><br--> 
                              - <a href="#">ȸ��Ż��</a></td> 
                          </tr> 
                        </table></td> 
                    </tr> 
<% end if %>
                    <tr> 
                      <td height="25" bgcolor="#FFFFFF"> * �ֹ��������� </td> 
                    </tr> 
                    <tr> 
                      <td bgcolor="#FFFFFF"> <table width="100%" border="0" cellspacing="0" cellpadding="5"> 
                          <tr> 
                            <td bgcolor="#FFFFFF"> -
                                ���ֹ�/��� ��ȸ                              <!---<br> 
                              - <a href="#">���ű��� ����</a--></td> 
                          </tr> 
                        </table></td> 
                    </tr> 
                    <tr> 
                      <!--td height="25" bgcolor="#FFFFFF"> * �ŷ��������� </td> 
                    </tr> 
                    <tr> 
                      <td bgcolor="#FFFFFF"> <table width="100%" border="0" cellspacing="0" cellpadding="5"> 
                          <tr> 
                            <td><a href="#">- �Ա���</a><br> 
                              <a href="#">- �ſ�ī�� ������ǥ</a><br> 
                              <a href="#">- ���ڼ��ݰ�꼭</a></td> 
                          </tr> 
                        </table></td--> 
                    </tr> 
                    <tr> 
                      <!--td height="25" bgcolor="#FFFFFF">* �����</td> 
                    </tr> 
                    <tr> 
                      <td bgcolor="#FFFFFF"> <table width="100%" border="0" cellspacing="0" cellpadding="5"> 
                          <tr> 
                            <td><a href="#">- ����� Ư��</a><br> 
                              <a href="#">- ����� ����Ʈ</a></td> 
                          </tr> 
                        </table></td--> 
                    </tr> 
                  </table></td> 
              </tr> 
            </table> 
          <!-- My Page left include end --> </td> 
          <td valign="top">*�ֹ�������ȸ 
<%
	'�뷫����
	SQL = "SELECT orderNbr,howToPay,deliCharge,orderStatus,SvcStaff,comment,lCompany,lTraceNbr,MbrId,cName,rName,rPhone From vMyPage_order "
	if Session("MbrID") <> "" then
		SQL = SQL & " Where MbrId = '" & Session("MbrID") & "'"
	else
		SQL = SQL & " Where orderNbr = '" & orderNbr & "'"
		SQL = SQL & " And cName = '" & clientName & "'"
	end if
'Call ShowMeTheValues("sql:" & sql)
	RSresult = OpenSimpleRS(ordRS, SQL)
	if RSresult <> "Empty" then
		i = 0
		Do until ordRS.EOF
			orderNbr = ordRS("orderNbr")
			howToPay = ordRS("howToPay")
			deliCharge = ordRS("deliCharge")
			orderStatus = ordRS("orderStatus")
			SvcStaff = ordRS("SvcStaff")
			comment = ordRS("comment")
			lCompany = ordRS("lCompany")
			lTraceNbr = ordRS("lTraceNbr")
			cName = ordRS("cName")
			rName = ordRS("rName")
			rPhone = ordRS("rPhone")		
			'����
			SubSumPrice = 0
			TotSumPrice = 0
			if Len(i) < 2 then 	i = "0" & i			
			if SvcStaff = "" then SvcStaff = "�Ҵ� ��" 
%> 
<table width="100%" border="0" cellpadding="1" cellspacing="2">
  <tr bgcolor="#D1D1EF">
    <td>�ֹ���ȣ</td>
    <td>���ҹ��</td>
    <td>��۷�</td>
    <td>�ֹ���</td>
    <td>�����ڸ�</td>
    <td>�������ȭ��ȣ</td>
    <td>�ù�ȸ��</td>
    <td>�����ȣ</td>
  </tr>
  <tr>
    <td><%= orderNbr %></td>
    <td><%= howToPay %></td>
    <td><%= FormatNumber(deliCharge, 0) %>��</td>
    <td><%= cName %></td>
    <td><%= rName %></td>
    <td><%= rPhone %></td>
    <td><%= lCompany %></td>
    <td><%= lTraceNbr %></td>
  </tr>
</table>
         
<table width="98%" border="0" align="center" cellpadding="1" cellspacing="2">
  <tr bgcolor="#D1D1EF">
    <td>�󼼹�ȣ</td>
    <td>�𵨹�ȣ</td>
    <td>��ǰ��</td>
    <td>���Է�</td>
    <td>���԰�</td>
    <td>�Ұ谡</td>
    <td>������</td>
    <td>��������</td>
  </tr>
<%
	'���γ���
	SQL = "SELECT subNbr,gCode,gMnum,gName,amount,gPrice,gClass,cbNbr,reserveFund From vCurrentOrder "
	SQL = SQL & " Where orderNbr = '" & orderNbr & "'"
	RSresult = OpenSimpleRS(coRS, SQL)

	if RSresult <> "Empty" then
		Do until coRS.EOF
			subNbr = coRS("subNbr")
			gCode = coRS("gCode")
			gMnum = coRS("gMnum")
			gName = coRS("gName")
			amount = coRS("amount")
			gPrice = coRS("gPrice")
			gClass = coRS("gClass")
			cbNbr = coRS("cbNbr")
			reserveFund = coRS("reserveFund")
			'����
			SubSumPrice = gPrice * amount
			TotSumPrice = TotSumPrice + SubSumPrice
			if Len(subNbr) < 2 then subNbr = "0" & subNbr

%>
  <tr>
    <td><%= subNbr %></td>
    <td><%= gMnum %></td>
    <td><%= gName %></td>
    <td><%= FormatNumber(amount,0) %>EA</td>
    <td><%= FormatNumber(gPrice,0) %>��</td>
	<td><%= FormatNumber(SubSumPrice,0) %>��</td>
    <td><%= FormatNumber((reserveFund*amount),0) %>��</td>
    <td>����ȵ�</td>
  </tr>
<%
			coRS.MoveNext
		Loop
		Call CloseRS(coRS)
	end if  'if RSresult <> "Empty" then
	
%>
  <tr bgcolor="#FFE9DF">
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>�Ѱ�</td>
    <td colspan="2"><%= FormatNumber(TotSumPrice,0) %>��
+ ��۷�(<%= FormatNumber(deliCharge,0) %>��) </td>
    <td>= <%= FormatNumber(TotSumPrice + deliCharge ,0) %>��</td>
  </tr>
</table>

<table width="100%" border="0" cellpadding="1" cellspacing="2">
  <tr bgcolor="#D1D1EF">
    <td>�ֹ������</td>
    <td>�ֹ�����</td>
    <td>�ֹ��󼼾ȳ�</td>
    </tr>
  <tr>
    <td><%= SvcStaff %></td>
    <td><%= orderStatus %></td>
    <td><%= comment %></td>
    </tr>
</table>
<br>
<br>
<%
			i = i + 1
			ordRS.MoveNext
		Loop
		Call CloseRS(ordRS)
	else
		if Session("MbrID") <> "" then
			Response.Write("* " & Session("MbrID") & "���� �ֹ��Ͻ� ��ǰ�� �����ϴ�.")
		else
			Call ShowAlertMsg(cName & "���� �ֹ��Ͻ� ��ǰ�� �����ϴ�.")
		end if			
	end if  'if RSresult <> "Empty" then
	
%> 
<%
	'ȸ�������������ϱ�
	if Session("MbrID") <> "" then 
		SQL = "SELECT MbrName,phone,cellularP,MbrEmail,AddrZip,AddrCity,AddrStt From vMember "
		SQL = SQL & " Where MbrID = '" &  Session("MbrID") & "'"
		RSresult = OpenSimpleRS(mRS, SQL)
	
		MbrName = mRS("MbrName")
		phone = mRS("phone")
		cellularP = mRS("cellularP")
		MbrEmail = mRS("MbrEmail")
		AddrZip = mRS("AddrZip")
		AddrCity = mRS("AddrCity")
		AddrStt = mRS("AddrStt")
		'����
		MbrAddress =  "[" & AddrZip & "] " & AddrCity & " " & AddrStt
		Call CloseRS(mRS)
%>
<img src="Images/mbrTitlebar.gif" width="114" height="18" border="0">
<TABLE cellSpacing=0 cellPadding=1 width=98% align="center" bgColor=#dfdfdf border="0"> 
    <TR> 
      <TD> 
	  <TABLE cellSpacing=0 cellPadding=0 width="100%" align="center" border="0"> 
         <TR> 
              <TD width=50 height="30" align=middle bgColor=#f2f2f2>�̸�</TD> 
              <TD bgColor=#ffffff height="30"><IMG height=10 src="../../Images/TransparentImage.gif" width="10"><%= MbrName %></TD> 
              <TD class=text bgColor=#f2f2f2 height="30"> <IMG height=10 src="../../Images/TransparentImage.gif" width="10">�̸���</TD> 
              <TD class=text bgColor=#ffffff height="30"><IMG height=10 src="../../Images/TransparentImage.gif" width="10"><%= MbrEmail %></TD> 
              <TD class=text bgColor=#f2f2f2 height="30"> <IMG height=10 src="../../Images/TransparentImage.gif" width="10">��ȭ��ȣ</TD> 
              <TD class=text bgColor=#ffffff height="30"><IMG height=10 src="../../Images/TransparentImage.gif" width="10">
			    <%= phone %></TD> 
              <TD class=text bgColor=#f2f2f2>�ڵ�����ȣ</TD>
              <TD class=text bgColor=#ffffff><IMG height=10 src="../../Images/TransparentImage.gif" width="10"><%= cellularP %></TD>
         </TR> 
            <TR> 
              <TD bgColor=#dfdfdf colSpan=8 height=1><IMG height=1 src="������ũ  My Page.files/blank.gif" width=10></TD> 
            </TR> 
            <TR> 
              <TD align="middle" bgColor=#f2f2f2 height="30">�ּ�</TD> 
              <TD class=text bgColor=#ffffff colSpan=7 height="30">
			  <IMG height=10 src="../../Images/TransparentImage.gif" width="10"><%= MbrAddress %></TD> 
            </TR> 
            <TR> 
              <TD bgColor=#dfdfdf colSpan=8 height=1><IMG height=1 src="../../Images/TransparentImage.gif"  width=10></TD> 
            </TR> 
            <TR> 
              <TD bgColor=#dfdfdf colSpan=8 height=1><IMG height=1 src="../../Images/TransparentImage.gif"  width=10></TD> 
            </TR> 
            <TR align="left" bgColor=#ffffff> 
              <TD colSpan=8 height="30">
			  <A href="#"><!--img src="Images/icoMbrModify.gif" width="65" height="20" hspace="10" border="0"--></A>
</TD> 
            </TR> 
        </TABLE></TD> 
    </TR> 
</TABLE>
<br>
<br>	
<%
	end if 		'if Session("MbrID") <> "" then 
%>	
<%
	'���ǰ Ȯ��
	if Session("MbrID") <> "" then 
		SQL = "SELECT MbrID,cCode,gCode,chosenDT,gMnum,gName,gGname,SMprice,Sprice,buyable,reserveFund From vPickedupGoods "
		SQL = SQL & " Where MbrID = '" &  Session("MbrID") & "'"
		RSresult = OpenSimpleRS(pkRS, SQL)
		if RSresult <> "Empty" then
%>
<img src="Images/pkTitlebar.gif" width="100" height="18" border="0">
<table width="98%" border="0" align="center" cellpadding="1" cellspacing="2">
  <tr bgcolor="#D1D1EF">
    <td>�𵨹�ȣ</td>
    <td>��ǰ��(�Ϲݸ�)</td>
    <td>ȸ����</td>
    <td>�Ϲݰ�</td>
    <td>������</td>
    <td>��������</td>
    <td>����</td>
  </tr>
<%
		Do until pkRS.EOF
			MbrID = pkRS("MbrID")
			cCode = pkRS("cCode")
			gCode = pkRS("gCode")
			'chosenDT = pkRS("chosenDT")
			gMnum = pkRS("gMnum")
			gName = pkRS("gName")
			gGname = pkRS("gGname")
			SMprice = pkRS("SMprice")
			Sprice = pkRS("Sprice")
			reserveFund	= pkRS("reserveFund")
			'����
			if gGname <> "" then gGname = "(" & gGname & ")"
			 
%>
  <tr>
    <td><%= gMnum %></td>
    <td><%= gName %><%= gName %></td>
    <td><%= FormatNumber(SMprice,0) %></td>
    <td><%= FormatNumber(Sprice,0) %></td>
    <td><%= FormatNumber(reserveFund,0) %></td>
    <td>����ȵ�</td>
    <td><a href="DeleteChosenGoods_ok.asp?MbrID=<%= Session("MbrID") %>&g=<%= gCode %>"><img src="Images/icoDelete.gif" width="65" height="20" border="0"></a>
	&nbsp;<a href="../GoodsDetailBody.asp?c=<%= cCode %>&g=<%= gCode %>">����</a></td>
  </tr>
  <%
				pkRS.MoveNext
			Loop
	%>		
</table>		
<%		
			Call CloseRS(pkRS)
		end if  'if RSresult <> "Empty" then
	end if 	'if Session("MbrID") <> "" then 	
%>		  </td> 
        </tr> 
        <tr> 
          <td colspan="2"> 
		    <!-- FrontFooter Start --> 
            <!--#include File = "../../SiteFooter/FrontFooter.asp" --> 
            <!-- FrontFooter End --> </td> 
        </tr> 
      </table></td> 
  </tr> 
</table> 
</body>
</html>
