<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<% if opMode = "p" then %>
<script language="JavaScript" type="text/JavaScript">
<!--
function checkOrder() {
	var frm = document.frmPay;
	var inPT = 0;
	var i = 0;
	for(i=0; i<frm.howToPay.length; i++)
	{
		if(frm.howToPay[i].checked)
		{
			inPT = parseInt(frm.howToPay[i].value);
			break;
		}
	}

	if(i==frm.howToPay.length)
	{
		alert("��������� ������ �ֽʽÿ�.");
		return false;
	}
}
//alert("<%= Request("g") %>")
-->
</script>


<%
	'ȸ��, ��ȸ�� ��Ȯ��.
	NMLoggedin = trim(request("NMLoggedin"))
	if (session("MbrID") = "" and NMLoggedin <> "Y") Or (session("MbrID") <> "" and NMLoggedin = "Y") then
		Call GotoThePage("��ð� �ֹ����·� �����ϸ� �����ճ���. ������ ���� �α׾ƿ��մϴ�.\n���ֹ��ϼ���. ", Application("SiteURLDir") & "CommonAccessories/MbrUsers/muExit.asp")
	end if
	
		cCode = Request.QueryString("c")
		gCode = Request.QueryString("g")
		gSize = Request.QueryString("gSize")
		gColor = Request.QueryString("gColor")	
		amount = Request.QueryString("amount")
		if cCode <> "" And gCode <> "" And amount <> "" Then directBuy = "Y"	'�������ż��ý�		
%>
<form name="frmPay" action="OrderProcess.asp?opMode=f" method="post">
<input name="cCode" type="hidden" id="cCode" value="<%= cCode %>">
<input name="gCode" type="hidden" id="gCode" value="<%= gCode %>">
<input name="gSize" type="hidden" id="gSize" value="<%= gSize %>">
<input name="gColor" type="hidden" id="gColor" value="<%= gColor %>">
<input name="amount" type="hidden" id="amount" value="<%= amount %>">
<input name="NMLoggedin" type="hidden" id="NMLoggedin" value="<%= NMLoggedin %>">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
    <TABLE cellSpacing=0 cellPadding=5 width=750 border=0>
          <TR>
       <TD width="130" ><IMG height=28 src="Images/icoHowToPay_items.gif" width=116>
        </TD>
        <TD>
        </TD>
     </TR>
    </TABLE></td>
  </tr>
  <tr>
    <td>
<%

	'����īƮ�� �ִ� ���밡������
	if directBuy = "Y" Then  	'�������ż��ý�
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
  <TD>
	<TABLE width="100%" align="center" cellSpacing=0 cellPadding=0 border=0>
           <TR align="center" bgColor=#f2f2f2>
		  <TD height=30>����</TD>
		  <TD>�𵨸�</TD>
		  <TD>��ǰ��</TD>
		  <TD>ũ��</TD>
		  <TD>����</TD>
		  <TD> ����</TD>
		  <TD>
		  <% if session("MbrID") <> "" then %>�Ǹ�ȸ����<% else %>�Ǹ��Ϲݰ�<% end if %>
		  </TD>		  
		  <TD>
		  <% if session("MbrID") <> "" then %>�Ұ�ȸ����<% else %>�Ұ��Ϲݰ�<% end if %>
		  </TD>
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
				
			if directBuy <> "Y" Then  	'����ī�带 ���ؼ� ���Խ�
				'stockID�� ���ؼ� gCode, ũ��� ���� ���ϱ�
				stockID = rsCart("stockID")
				if stockID <> "" then 
					ArrGetGPs = GetGoodsproperties(stockID)
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
	<TR>
	  <TD height=25 align="center" class=order><%= i %></TD>
	  <TD align="center"><a href="../GoodsDetailBody.asp?c=<%= cCode %>&g=<%= gCode %>"><%= gMnum %></a></TD>
	  <TD><IMG height=10 src="../../Images/TransparentImage.gif" width=10>
		<%= gName %></TD>
	  <TD align="center"><%= gSize %></TD>
	  <TD align="center"><%= gColor %></TD>
	  <TD align="center" valign="middle"><%= FormatNumber(amount,0) %></TD>
	  <TD align="center"><%= FormatNumber(gPrice,0) %>��</TD>
	  <TD align="center"><%= FormatNumber(SubSumPrice,0) %>��
	  </TD>
	  <TD align="center"><%= FormatNumber(reserveFund * amount,0) %>��</TD>
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
                  <TD align="center" bgcolor="#FFFFFF">
				  <%= FormatNumber(TotSumPrice,0) %>�� 
				  <% if TotSumPrice < 30000 then 		
						'��۷�
						deliCharge = 3000
					else 
						deliCharge = 0	
				  	end if 
				  %>
					 + ��۷�(<%= FormatNumber(deliCharge,0) %>��)
				  </TD>
				  <TD align="center"> = <%= FormatNumber(TotSumPrice + deliCharge ,0) %>��</TD>
                </TR>
              </TABLE></TD>
          </TR>
        </TABLE>
<%
		Call CloseRS(rsCart)
	else
		Response.Redirect(Application("SiteURLDir"))
 	end if	'if RSresult <> "Empty" then
%>



  </TD>
</TR>
</TABLE>
      </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><TABLE cellSpacing=0 cellPadding=0 width=750 align="center" border=0>
        <TR>
          <TD width=18 height=25><IMG height=11 src="Images/opBullet.gif" width=11></TD>
          <TD class=textpoint height=25>������ �ȳ�</TD>
        </TR>
        <TR>
          <TD>&nbsp;</TD>
          <TD> �������� �ڵ������� �����Ǹ� �̺�Ʈ �Ⱓ �� ����ó�� ����� �� �ֽ��ϴ�. <br>
            ��, �������� �ǰ����κп� ���ؼ��� �����˴ϴ�. ���� ���������� �������� ��� �������� ������ �ʽ��ϴ�.<BR>
          </TD>
        </TR>
        <TR>
          <TD height=25><IMG src="Images/opBullet.gif" width="11" height="11"></TD>
          <TD class=textpoint height=25>��ۺ� �ȳ�</TD>
        </TR>
        <TR>
          <TD height=20>&nbsp;</TD>
          <TD>3���� �̻��� ��ۺ� �����ϴ�.
            <!-- a href="javascript:openPage('/sitemap/html/DelvPay.html','','488','500')">
          <img height=20 src="Images/opDetail.gif" width=77 align=absMiddle border=0></a -->
          </TD>
        </TR>
    </TABLE></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
    <TABLE cellSpacing=0 cellPadding=5 width=100% align="center" border=0>
        <TR>
          <TD><IMG height=28 src="Images/icoHowToPay_select.gif"
            width=117><SPAN class=textsmall> </SPAN></TD>
        </TR>
        <TR>
          <TD>
            <TABLE cellSpacing=0 cellPadding=1 width=752 align="center"
              border=0>
                <TR>
                  <TD class=text vAlign=bottom>�������Ա��� �Ա��ڸ�� ���� �Ա����� �̸��� �ٸ� ��쿡 ��ǰ ����� �� �� �����ϴ�.
                  <!-- ����/BCī��" (����, ���� ���) ������ �ݵ�� ���������� �����ϼž� �մϴ�. <A
                  href="http://www.interpark.com/card/card_bckb.html"><IMG
                  height=20 src="Images/icoHowToPay_KB.gif" width=155
                  border=0></A><BR>
                    ���������� 10�����̻� ������ ������������ �ʼ��Դϴ� �����ź��� �ٸ�ī�带 �̿����ּ��� --> </TD>
                </TR>
          </TABLE></TD>
        </TR>
        <TR>
          <TD>
          <TABLE cellSpacing=0 cellPadding=0 width=700 align="center" border=0>
              <TR bgColor=#f2f2f2>
                <TD width=20 height=30>
                    <INPUT type=radio value="cash" name="howToPay">
                </TD>
                <TD class=text width=230 height=30>
					�������Ա�
                  </TD>
                <TD width=20 height=30>
                    <INPUT type=radio value="card1" name="howToPay">
                </TD>
                <TD class=text width=230 height=30>
                  �ſ�ī��</TD>
                <!-- TD class=text width=20 height=30><INPUT
                  onclick="checkRealAmt('298000.0',this.value);showLayer('N','F','Cash');hideLayer('Multi');hideLayer('Finger');hideLayer('Online');checkMember();"
                  type=radio value=26 name=howToPay>
                </TD>
                <TD class=text width=230 height=30>
                  <DIV align=left>�ſ�ī��(����)</TD>
              </TR>
              <TR bgColor=#f2f2f2>
                <TD class=text width=20 height=30><INPUT
                  onclick="checkRealAmt('298000.0',this.value);showLayer('N','F','Cash');hideLayer('Multi');hideLayer('Finger');showDisplay('Online')"
                  type=radio value=7 name=howToPay>
                </TD>
                <TD class=text width=230 height=30>
                  <DIV align=left>����/BCī��(��������)</TD>
                <TD height=30><INPUT
                  onclick="checkRealAmt('298000.0',this.value);showLayer('N','F','Cash');hideLayer('Multi');showDisplay('Finger');hideLayer('Online')"
                  type=radio value=29 name=howToPay>
                </TD>
                <TD class=text width=230 height=30>
                  <DIV align=left>���� ���ͳݹ�ŷ</TD>
                <TD class=text height=30><INPUT disabled
                  onclick="checkRealAmt('298000.0',this.value);showLayer('N','F','Multi');hideLayer('Cash');hideLayer('Finger');hideLayer('Online')"
                  type=radio value=21 name=howToPay>
                </TD>
                <TD class=text width=230 height=30>
                  <DIV align=left>���̹�ĳ��(0��)</TD>
              </TR -->
          </TABLE></TD>
        </TR>
    </TABLE></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
    <TABLE cellSpacing=0 cellPadding=5 width="100%" border=0>
       <TR>
        <TD width="50%" align="right">
        <a href="javascript:history.go(-1);">
        <IMG height=34 src="Images/opBefore.gif" width=110 border=0></a></TD>
        <TD width="50%">
          <INPUT name="image" type=image src="Images/opNext.gif" width=110 height=34 border=0 onclick="javascript:return checkOrder();"> </TD>
        </TR>
    </TABLE></td>
  </tr>
</table>
</form>
<% end if %>