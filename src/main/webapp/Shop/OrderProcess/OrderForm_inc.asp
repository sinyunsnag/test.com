<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<% if opMode = "f" then %>
<script language="JavaScript" src="of_inc.js"></script>
<%
	'ȸ��, ��ȸ�� ��Ȯ��.
	NMLoggedin = trim(request("NMLoggedin"))
	if (session("MbrID") = "" and NMLoggedin <> "Y") Or (session("MbrID") <> "" and NMLoggedin = "Y") then
		Call GotoThePage("��ð� �ֹ����·� �����ϸ� �����ճ���. ������ ���� �α׾ƿ��մϴ�.\n���ֹ��ϼ���. ", Application("SiteURLDir") & "CommonAccessories/MbrUsers/muExit.asp")
	end if

	cCode = Request("cCode")
	gCode = Request("gCode")
	gSize = Request("gSize")
	gColor = Request("gColor")
	amount = Trim(Request("amount"))
	if cCode <> "" And gCode <> "" And amount <> "" Then directBuy = "Y"	'�������ż��ý�
%>
<form name="frmOrderForm" action="OrderForm_ok.asp" method="post" onSubmit="return SubmitOrderForm(this)">
<!-- �������Ž� �Ѿ���� ���� -->
<input name="cCode" type="hidden" id="cCode" value="<%= cCode %>">
<input name="gCode" type="hidden" id="gCode" value="<%= gCode %>">
<input name="gSize" type="hidden" id="gSize" value="<%= gSize %>">
<input name="gColor" type="hidden" id="gColor" value="<%= gColor %>">
<input name="amount" type="hidden" id="amount" value="<%= amount %>">
<input name="NMLoggedin" type="hidden" id="NMLoggedin" value="<%= NMLoggedin %>">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><TABLE width=750 border=0 cellPadding=0 cellSpacing=0>
          <TR>
          <TD><IMG height=28 src="Images/icoOrderForm_item.gif" width=121></TD>
        </TR>
      </TABLE></td>
  </tr>
  <tr>
    <td>
<%
	if cCode <> "" And gCode <> "" And amount <> "" Then  	'�������ż��ý�
		SQL = "SELECT cCode,gCode,gMnum,gName,gGname,"
		if session("MbrID") <> "" then
			SQL = SQL & "SMprice as gPrice"
		else
			SQL = SQL & "Sprice as gPrice"
		end if
		SQL = SQL & ",reserveFund," & amount & " as amount FROM vGoodsList_c "
		SQL = SQL & " WHERE cCode = " & cCode
		SQL = SQL & " And gCode = '" & gCode & "'"
	else 	'����īƮ�� ���ؼ� ���Խ�
		SQL = "SELECT cCode,gCode,gMnum,gName,gGname,"
		if session("MbrID") <> "" then
			SQL = SQL & "SMprice as gPrice"
		else
			SQL = SQL & "Sprice as gPrice"
		end if
		SQL = SQL & ",reserveFund,stockID,amount FROM vCart "
		SQL = SQL & " WHERE tOrderNbr = '" & Request.Cookies("tempOrderID") & "'"
		SQL = SQL & " Order by choiceDT"
	end if
	RSresult = OpenSimpleRS(rsCart, SQL)

	if RSresult <> "Empty" then
		'�������Ȯ��
		howToPay = trim(request("howToPay"))
		if howToPay = "cash" then htpName ="�������Ա�"
		if howToPay = "card1" then htpName ="�ſ�ī��"

		'ȸ������ ���� ����
		if session("MbrID") <> "" then
			SQL = "SELECT * FROM vMember "
			SQL = SQL + " WHERE MbrID='" & session("MbrID") & "'"
			RSresult = OpenRS(rs,SQL,1)
			'Response.Write("RSresult=" + RSresult)
			if RSresult <> "Empty" then
				MbrID = trim(rs("MbrID"))
				MbrName = trim(rs("MbrName"))
				phone = trim(rs("phone"))
				cellularP = trim(rs("cellularP"))
				MbrEmail = trim(rs("MbrEmail"))
				AddrZip = trim(rs("AddrZip"))
				AddrCity = trim(rs("AddrCity"))
				AddrStt = trim(rs("AddrStt"))
				Call CloseRS(rs)
				'�����
				phoneArray = Split(phone,"-")
				cTEL1 = phoneArray(0)
				cTEL2 = phoneArray(1)
				cTEL3 = phoneArray(2)
				cellularPArray = Split(cellularP,"-")
				cMTEL1 = cellularPArray(0)
				cMTEL2 = cellularPArray(1)
				cMTEL3 = cellularPArray(2)
			end if
		end if 	'if session("MbrID") <> "" then


		'recordcnt = rsCart.RecordCount
		'������
		'totalpage = rs.pagecount
		'rs.absolutepage = page
		'GetString�� �޾Ƴ�
		'AllRec = rsCart.GetString(2, rsCart.PageSize) 	'(adClipString=2, RS.PageSize)
		'rows = split(AllRec,chr(13))
%>
      <TABLE cellSpacing=0 cellPadding=1 width=750 align="center" bgColor=#dfdfdf border=0>
        <TR>
          <TD> <TABLE width="100%" align="center" cellSpacing=0 cellPadding=0 border=0>
              <TR align="center" bgColor=#f2f2f2>
                <TD height=30>����</TD>
                <TD>�𵨸�</TD>
                <TD>��ǰ��</TD>
                <TD>ũ��</TD>
                <TD>����</TD>
                <TD> ����</TD>
				<TD>
                <% if session("MbrID") <> "" then %>�Ǹ�ȸ����
				<% else %>�Ǹ��Ϲݰ�<% end if %></TD>
                <TD>
				<% if session("MbrID") <> "" then %>�Ұ�ȸ����
                <% else %>�Ұ��Ϲݰ�<% end if %>				</TD>
                <TD> ������</TD>
                </TR>
              <%
		i = 1
		Do until rsCart.EOF
			cCode = rsCart("cCode")
			gCode = rsCart("gCode")
			gMnum = rsCart("gMnum")
			gName = rsCart("gName")
			gGname = rsCart("gGname")
			gPrice = rsCart("gPrice")
			reserveFund = rsCart("reserveFund")
			amount = rsCart("amount")
			'tOrderNbr = trim(rsCart("tOrderNbr"))
			'choiceDT = trim(rsCart("choiceDT"))
			'����
			if gGname <> "" then gName = gName & " (" & gGname & ")"

			if directBuy = "Y" Then  	'�������ż��ý�
				'���Լ��� �� ��� üũ
				Call CheckStock(GetCurrStock(gCode,gSize,gColor),-amount,"")
			else 	'����ī�带 ���ؼ� ���Խ�
				stockID = rsCart("stockID")
				if stockID <> "" then
					'���Լ��� �� ��� üũ
					info = PickUpValue("vMaster", "gName", "gCode='" & gCode & "'")
					Call CheckStock(GetCurrStock1(stockID),-amount,"* " & info & " *")
					'stockID�� ���ؼ� gCode, ũ��� ���� ���ϱ�
					ArrGetGPs = GetGoodsProperties(stockID)
					gSize = ArrGetGPs(1)
					gColor = ArrGetGPs(2)
				end if
			end if	'if directBuy = "Y" Then  	'�������ż��ý�
			'�� ���� ���϶� ó��
			if gSize = "" then gSize = "-"
			if gColor = "" then gColor = "-"

			SubSumPrice = 0
			SubSumPrice = gPrice * amount
			TotSumPrice = TotSumPrice + SubSumPrice
			if Len(i) < 2 then 	i = "0" & i
%>
              <TR align="center">
                <TD height=25 class=order><%= i %></TD>
                <TD><a href="../GoodsDetailBody.asp?c=<%= cCode %>&g=<%= gCode %>"><%= gMnum %></a></TD>
                <TD><IMG height=10 src="../../Images/TransparentImage.gif" width=10><%= gName %></TD>
                <TD><%= gSize %></TD>
                <TD><%= gColor %></TD>
                <TD valign="middle"><%= FormatNumber(amount,0) %></TD>
                <TD><%= FormatNumber(gPrice,0) %>��</TD>
                <TD><%= FormatNumber(SubSumPrice,0) %>��</TD>
                <TD><%= FormatNumber((reserveFund*amount),0) %>��</TD>
                </TR>
              <%
			rsCart.MoveNext
			i=i+1
		loop
%>
              <TR bgcolor="#FFFFFF">
                <TD height=30 class=order>&nbsp;</TD>
                <TD>&nbsp;</TD>
                <TD>&nbsp;</TD>
                <TD align="center">&nbsp;</TD>
                <TD align="center">&nbsp;</TD>
                <TD>&nbsp;</TD>
                  <TD align="right">�Ѱ�</TD>
                  <TD align="center" bgcolor="#FFFFFF"><%= FormatNumber(TotSumPrice,0) %>��
                    <% if TotSumPrice < 30000 then
						'��۷�
						deliCharge = 3500
					else
						deliCharge = 0
				  	end if
				  %>
                    + ��۷�(<%= FormatNumber(deliCharge,0) %>��) </TD>
                  <TD align="center">= <%= FormatNumber(TotSumPrice + deliCharge ,0) %>��</TD>
                </TR>
            </TABLE>
<%
		Call CloseRS(rsCart)
	else
		Response.Redirect(Application("SiteURLDir"))
 	end if	'if RSresult <> "Empty" then
%>
<input name="TotSumPrice" type="hidden" id="TotSumPrice" value="<%= TotSumPrice %>">
<input name="deliCharge" type="hidden" id="deliCharge" value="<%= deliCharge %>">
            </TD>
        </TR>
      </TABLE></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><img src="Images/icoOrderForm_client.gif" width="99" height="28"></td>
  </tr>
  <tr>
    <td><table width="750" border="0" align="center" cellpadding="1" cellspacing="0" bgcolor="#DFDFDF">
        <tr>
          <td><table width="750" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr bgcolor="#F2F2F2">
                <td width="110" height="30"> <div align="center"><span class="ordertext1">�̸�</span></div></td>
                <td width="264" height="30" bgcolor="#FFFFFF"> <IMG height=10 src="../../Images/TransparentImage.gif" width=10>
                  <input name="cName" type="text" id="MbrName" value="<%= MbrName %>" size="16" maxlength="25" style="ime-mode:active">
                  <input name="MbrID" type="hidden" id="MbrID" value="<%= MbrID %>">
                </td>
                <td width="110" height="30" bgcolor="#F2F2F2"> <div align="center"><span class="ordertext1">��ȭ��ȣ</span></div></td>
                <td width="266" height="30" bgcolor="#FFFFFF"> <IMG height=10 src="../../Images/TransparentImage.gif" width=10>
                  <INPUT name="cTEL1" id="cTEL1" value="<%= cTEL1 %>" size="4" maxlength="4">
                  -
                  <INPUT name="cTEL2" id="cTEL2" value="<%= cTEL2 %>" size="4" maxlength="4">
                  -
                  <INPUT name="cTEL3" id="cTEL3" value="<%= cTEL3 %>" size="4" maxlength="4"> </td>
              </tr>
              <tr bgcolor="#DFDFDF">
                <td height="1" colspan="4"><img src="https://image.interpark.com/ssl/template/blank.gif" width="10" height="1"></td>
              </tr>
              <tr bgcolor="#F2F2F2">
                <td width="110" height="30"> <div align="center"><span class="ordertext1">�̸���</span></div></td>
                <td height="30" bgcolor="#FFFFFF"> <IMG height=10 src="../../Images/TransparentImage.gif" width=10>
                  <input name="cEmail" type="text" id="cEmail" value="<%= MbrEmail %>" size="30" maxlength="50">
                </td>
                <td width="110"> <div align="center"><span class="ordertext1">�ڵ�����ȣ</span></div></td>
                <td bgcolor="#FFFFFF"> <IMG height=10 src="../../Images/TransparentImage.gif" width=10>
                  <INPUT name=cMTEL1 id="cMTEL1" value="<%= cMTEL1 %>" size=4 maxlength="4">
                  -
                  <INPUT name=cMTEL2 id="cMTEL2" value="<%= cMTEL2 %>" size=4 maxlength="4">
                  -
                  <INPUT name=cMTEL3 id="cMTEL3" value="<%= cMTEL3 %>" size=4 maxlength="4"></td>
              </tr>
              <tr bgcolor="#DFDFDF">
                <td height="1" colspan="4"><img src="https://image.interpark.com/ssl/template/blank.gif" width="10" height="1"></td>
              </tr>
              <tr>
                <td rowspan="3" align="left" bgcolor="#f2f2f2"><img src="../../Images/TransparentImage.gif" width="10" height="10" border="0">�߼����ּ�</td>
                <td height="30" colspan="3" bgcolor="#FFFFFF"> <img src="../../Images/TransparentImage.gif" width="10" height="10" border="0">
                  <input name="cAddrZip" type="text" id="cAddrZip" style="CURSOR: default;" value="<%= AddrZip %>" size="7" maxlength="7" readonly>
                  <a href="javascript:NewWindow('../../CommonAccessories/PostSeek/PostSeek.asp', frmOrderForm, frmOrderForm.cAddrZip, 426, 400);">
				  <img src="Images/icoOrderForm_addressFind.gif" width="81" height="20" border="0" align="absmiddle"></a></td>
              </tr>
              <tr>
                <td height="30" colspan="3" bgcolor="#FFFFFF"><img src="../../Images/TransparentImage.gif" width="10" height="10" border="0">
                  <input name="cAddrCity" type="text" id="cAddrCity" value="<%= AddrCity %>" size="50" maxlength="50" readonly></td>
              </tr>
              <tr>
                <td height="30" colspan="3" bgcolor="#FFFFFF"><img src="../../Images/TransparentImage.gif" width="10" height="10" border="0">
                  <input name="cAddrStt" type="text" id="cAddrStt" value="<%= AddrStt %>" size="20" maxlength="20" style="ime-mode:active"></td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td height="30" colspan="4">
                  <!--img src="https://image.interpark.com/ssl/template/blank.gif" width="10" height="8">
                  �� �ֹ��Ͻ� ��ǰ ���� �ڵ������� �ȳ� �޽���(SMS) �����帳�ϴ�. <br> <img src="https://image.interpark.com/ssl/template/blank.gif" width="25" height="1">
                  SMS�� ��ǰ������ �߼۵˴ϴ�. <img src="https://image.interpark.com/ssl/template/blank.gif" width="20" height="1">
                  <input type=radio name=SMSCHK checked>
                  �ްڽ��ϴ�.
                  <input type=radio name=SMSCHK >
                  ���� �ʰڽ��ϴ�. -->
                </td>
              <tr bgcolor="#DFDFDF">
                <td height="1" colspan="4"><img src="https://image.interpark.com/ssl/template/blank.gif" width="10" height="1"></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><img src="Images/icoOrderForm_toWhere.gif" width="99" height="28"></td>
  </tr>
  <tr>
    <td><table width="750" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="35">
          <input name="cbSameData" type="checkbox" id="cbSameData" value="" onclick="javascript:sameData(this.form);">
            �ֹ��������� ��ġ�ϸ� üũ�ϼ���.<br>
           <!-- ������ ���� ����� ����� �̿��� �� �ֽ��ϴ�. <img src="Images/icoOrderForm_previousAddress.gif" width="81" height="20" align="absmiddle" --></td>
        </tr>
      </table>
      <table width="750" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr bgcolor="#DFDFDF">
          <td height="1" colspan="4"><img src="https://image.interpark.com/ssl/template/blank.gif" width="10" height="1"></td>
        </tr>
        <tr>
          <td width="110" rowspan="3" align="left" bgcolor="#f2f2f2"><img src="../../Images/TransparentImage.gif" width="10" height="10" border="0">������ּ�</td>
          <td height="30" colspan="3" bgcolor="#FFFFFF"> <img src="../../Images/TransparentImage.gif" width="10" height="10" border="0">
            <input name="rAddrZip" type="text" id="rAddrZip" style="CURSOR: default;" size="7" maxlength="7" readonly>
            <a href="javascript:NewWindow('../../CommonAccessories/PostSeek/PostSeek.asp', frmOrderForm, frmOrderForm.rAddrZip, 426, 400);">
			<img src="Images/icoOrderForm_addressFind.gif" width="81" height="20" border="0" align="absmiddle">
            </a>(��/��/�� �̸� �Է�) </td>
        </tr>
        <tr>
          <td height="30" colspan="3" bgcolor="#FFFFFF"><img src="../../Images/TransparentImage.gif" width="10" height="10" border="0">
            <input name="rAddrCity" type="text" id="rAddrCity" size="50" maxlength="50" readonly></td>
        </tr>
        <tr>
          <td height="30" colspan="3" bgcolor="#FFFFFF"><img src="../../Images/TransparentImage.gif" width="10" height="10" border="0">
            <input name="rAddrStt" type="text" id="rAddrStt" size="20" maxlength="20" style="ime-mode:active"></td>
        </tr>
        <tr bgcolor="#DFDFDF">
          <td height="1" colspan="4"><img src="https://image.interpark.com/ssl/template/blank.gif" width="10" height="1"></td>
        </tr>
      </table>
      <table width="750" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr bgcolor="#F2F2F2">
          <td width="110" height="30"> <div align="center"> <span class="ordertext1">������
              ��</span> </div></td>
          <td width="264" height="30" colspan="3" bgcolor="#FFFFFF"> <IMG height=10 src="../../Images/TransparentImage.gif" width=10>
            <input name="rName" type="text" id="MbrName3" size="16" maxlength="25" style="ime-mode:active">
          </td>
        </tr>
        <tr bgcolor="#DFDFDF">
          <td height="1" colspan="4"><img src="https://image.interpark.com/ssl/template/blank.gif" width="10" height="1"></td>
        </tr>
        <tr bgcolor="#F2F2F2">
          <td height="30"> <div align="center"> <span class="ordertext1">��ȭ��ȣ</span>
            </div></td>
          <td height="30" bgcolor="#FFFFFF"> <IMG height=10 src="../../Images/TransparentImage.gif" width=10>
            <INPUT name="rTEL1" id="rTEL1" size=4 maxlength="4">
            -
            <INPUT name="rTEL2" id="rTEL2" size=4 maxlength="4">
            -
            <INPUT name="rTEL3" id="rTEL3" size=4 maxlength="4"></td>
          <td width="110"> <div align="center"> <span class="ordertext1">�ڵ��� ��ȣ</span>
            </div></td>
          <td width="266" bgcolor="#FFFFFF"> <IMG height=10 src="../../Images/TransparentImage.gif" width=10>
            <INPUT name="rMTEL1" id="rMTEL1" size=4 maxlength="4">
            -
            <INPUT name="rMTEL2" id="rMTEL2" size=4 maxlength="4">
            -
            <INPUT name="rMTEL3" id="rMTEL3" size=4 maxlength="4"></td>
        </tr>
        <tr bgcolor="#DFDFDF">
          <td height="1" colspan="4"><img src="https://image.interpark.com/ssl/template/blank.gif" width="10" height="1"></td>
        </tr>
        <tr bgcolor="#F2F2F2">
          <td width="110" height="30"> <div align="center"> <span class="ordertext1">��۽�
              ���ǻ���</span> </div></td>
          <td width="640" colspan="3" height="30" bgcolor="#FFFFFF" class="textsmall">
            <IMG height=10 src="../../Images/TransparentImage.gif" width=10> <input name="note" type="text" class="form350" id="note" size="30" maxlength="30">
            30�� �̳��� �ۼ� (��: ���ǿ� �ð� �ּ���.) </td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><img src="Images/icoOrderForm_payInfo.gif" width="83" height="28"></td>
  </tr>
  <tr>
    <td align="center"><table width="750" cellpadding="1" cellspacing="0">
        <tr>
          <td bgcolor="#dfdfdf"> <table width="750" cellpadding="0" cellspacing="0">
              <tr bgcolor="#FFFFFF">
                <td colspan="2">������ ���� �� ���������Դϴ�.</span></td>
              </tr>
              <tr>
                <td colspan="2"><img height="1" src="file:///D|/Projects/MwavShop/blank.gif" width="10"></td>
              </tr>
              <tr>
                <td width="110">������� </td>
                <td width="640" bgcolor="#ffffff" class="price"><IMG height=10 src="../../Images/TransparentImage.gif" width=10><%= htpName %></td>
              </tr>
              <tr>
                <td>�����ݾ� </td>
                <td class="price" bgcolor="#ffffff"><IMG height=10 src="../../Images/TransparentImage.gif" width=10>
				<%= FormatNumber(TotSumPrice,0) %>��
                </td>
              </tr>
            </table></td>
        </tr>
      </table>
<% if howToPay = "cash" then %>
      <table width="750" cellpadding="1" cellspacing="0">
        <tr>
          <td>�Ա����� ���� �� �Է����ּ���. </td>
        </tr>
        <tr>
          <td bgcolor="#dfdfdf"><table cellspacing="0" cellpadding="0">
              <tr>
                <td colspan="2"><img height="1" src="file:///D|/Projects/MwavShop/blank.gif" width="10"></td>
              </tr>
              <tr>
                <td width="110">�Ա��Ͻ� ���� </td>
                <td width="640" bgcolor="#ffffff" class="textsmall"><IMG height=10 src="../../Images/TransparentImage.gif" width=10>
                  <select name="bankInfo" class="bankInfo">
<%
	SQL = "SELECT bankInfo FROM vBankAccounts "
	SQL = SQL & " Where usable = 'Y' "
	SQL = SQL & " ORDER BY bankInfo"
	RSresult = OpenSimpleRS(rsOption,SQL)
	'rsOption.PageSize = rsOption.RecordCount
	if RSresult <> "Empty" then
		Response.write(vbTab & vbTab & "<option value="""" selected>8~ �Ա��Ͻ� ������ �����ϼ���. ~8</option>") & vbCRLF
		Do While Not rsOption.EOF
			Response.write(vbTab & vbTab & "<option value=""" & rsOption(0) & """>" & rsOption(0) & "</option>") & vbCRLF
			rsOption.MoveNext
		Loop
		call CloseRS(rsOption)
	else
		Response.write(vbTab & vbTab & "<option value="""">8~�Էµ� ������������� �����ϴ�.~8</option>") & vbCRLF
	end if	'if RSresult <> "Empty" then
%>
                  </select></td>
              </tr>
              <tr>
                <td>�Ա��ڸ� </td>
                <td class="textsmall" bgcolor="#ffffff"><IMG height=10 src="../../Images/TransparentImage.gif" width=10>
                  <input name="onlinePayer" type="text" size="20" maxlength="30">
                  (���� �Ա��Ͻ� ���� �̸��� ���� �ּ���) </td>
              </tr>
            </table></td>
        </tr>
      </table>
      <br> <table width="750" cellpadding="0" cellspacing="0">
        <tr>
          <td><img src="Images/opBullet.gif" width="11" height="11"></td>
          <td class="textpoint">������ �Աݽ� ���ǻ��� </td>
        </tr>
        <tr>
          <td></td>
          <td class="textsmall">- �Ա��ڸ�� ���� �Ա����� �̸��� �ٸ� ��쿡�� ��ǰ ����� �� �� �����ϴ�. <br>
            - �Ա��ڸ��� ������ �ּ���. <br>
            ... �߸��� �Ա��ڸ�&gt;&gt;��ǰ�̸�,��ȭ��ȣ,�ڵ�����ȣ,(��)������ũ,34000��,���¹�ȣ,�ۡ۴�ݰ�,��ۻ�����Ź
            �� </td>
        </tr>
        <tr>
          <td width="18"></td>
          <td width="732"><img src="Images/opDetail.gif" width="77" height="20"></td>
        </tr>
      </table>
<% else %>
�ſ�ī�����
<% end if %>

	  </td>
  </tr>
  <tr>
    <td><TABLE cellSpacing=0 cellPadding=5 width="100%" border=0>
        <TBODY>
          <TR>
            <TD width="50%" align="center"><Input type="image" img src="Images/icoOrderForm_order.gif" width="110" height="34"></TD>
          </TR>
          <TR>
            <TD align="center"><span class="textopinion">[����] �� �� Ŭ���Ͻø� �ߺ��Ǿ� �ֹ�
              ó�� �ǿ��� �� �� ���� Ŭ���ϼ���.</span></TD>
          </TR>
        </TBODY>
      </TABLE></td>
  </tr>
</table>
</form>
<% end if %>
