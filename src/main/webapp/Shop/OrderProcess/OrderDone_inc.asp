<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<% if opMode = "d" then %>
<%
	'�� ��ǰ�ֹ�����
	orderNbr = Request("orderNbr")
	SQL = "SELECT orderNbr,subNbr,gCode,gMnum,gName,stockID,amount,gPrice,gClass,cbNbr,reserveFund "	
	SQL = SQL & " FROM vCurrentOrder "
	SQL = SQL & " WHERE orderNbr = '" & orderNbr & "'"	
	RSresult = OpenSimpleRS(coRS, SQL)
	if RSresult = "Empty" then
		Call GotoThePage("���������� �����Դϴ�!!", Application("SiteURLDir"))
	end if
	
	'vOrderDoneInfo����
	SQL = "SELECT note,howToPay,payInfoDetail,orderDT,rName,rPhone,rCellularP,rAddrZip,rAddrCity,rAddrStt "
	SQL = SQL & " FROM vOrderDoneInfo "
	SQL = SQL & " WHERE orderNbr = '" & orderNbr & "'"	
'Call ShowMeTheValues(SQL)		
	RSresult = OpenSimpleRS(doneRS, SQL)
	if RSresult = "Empty" then
		Call GotoThePage("���������� �����Դϴ�!!", Application("SiteURLDir"))
	end if
	note = trim(doneRS("note"))
	howToPay = trim(doneRS("howToPay"))
	payInfoDetail = trim(doneRS("payInfoDetail"))
	orderDT = trim(doneRS("orderDT"))
	rName = trim(doneRS("rName"))
	rPhone = trim(doneRS("rPhone"))
	rCellularP = trim(doneRS("rCellularP"))
	rAddrZip = trim(doneRS("rAddrZip"))
	rAddrCity = trim(doneRS("rAddrCity"))
	rAddrStt = trim(doneRS("rAddrStt"))
	Call CloseRS(doneRS)
	'����
	onlinePayer = Left(payInfoDetail,InStr(payInfoDetail,"-")-1)
	payInfoDetail = MID(payInfoDetail,InStr(payInfoDetail,"-")+1)
	if rCellularP <> "" then rCellularP = ", �ڵ���: " & rCellularP

%>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="60" valign="top"><TABLE cellSpacing=0 cellPadding=0 width=750 align=center border=0>
      <TR>
        <TD width=19 height=25><IMG height=11 
                  src="Images/opBullet.gif" width=11></TD>
        <TD width=731 height=25>
          <% if session("MbrID") <> "" then %>
          <font color="#3366CC"><%= session("MbrID") %></font>�Բ��� �ֹ��Ͻ�
          <% end if %>
      ������ ������ �����ϴ�.</TD>
      </TR>
      <TR>
        <TD height=20>&nbsp;</TD>
        <TD><FONT color=#ff0000>- �� �������� ����Ʈ �� �νø� �� ���մϴ�. </FONT>
            <!-- �ֹ� ó���� ���� �ñ��Ͻ� ���� �����ø� <A 
                  href="http://www.interpark.com/gate/sos/SOSMainList.jsp?COMM_001=0000100000&amp;COMM_002=0&amp;MAJOR=SOS0102&amp;TEAM=&amp;STATUS=&amp;TY=A&amp;PS=20&amp;FROM=&amp;TO="><STRONG><FONT 
                  color=#ff0000>SOS�Խ���</FONT></STRONG></A>�� �̿��Ͻñ� �ٶ��ϴ�.--></TD>
      </TR>
    </TABLE></td>
  </tr>
  <tr>
    <td><IMG height=28 src="Images/icoOrderDone_item.gif" width=123></td>
  </tr>
  <tr>
    <td><TABLE cellSpacing=0 cellPadding=1 width=750 align=center bgColor=#dfdfdf border=0>      
        <TR>
          <TD>
            <TABLE cellSpacing="0" cellPadding="0" width="100%" align="center" border="0">
			<TR bgColor="#f2f2f2">
			  <TD width="110" height="30" align="center">�ֹ���ȣ </TD>
			  <TD width=640 bgColor="#ffffff" height="30">
			  <IMG height=10 src="../../Images/TransparentImage.gif" width=10> <%= orderNbr %> 
			  </TD>
			</TR>
          </TABLE></TD>
        </TR>
      
    </TABLE></td>
  </tr>
  <tr>
    <td><TABLE cellSpacing=0 cellPadding=1 width=750 align="center" bgColor=#dfdfdf border=0>
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
                <% else %>�Ұ��Ϲݰ�<% end if %>
				</TD>
                <TD> ������</TD>
              </TR>
              <%
		i = 1
		Do until coRS.EOF
			subNbr = coRS("subNbr")
			gCode = coRS("gCode")
			gMnum = coRS("gMnum")
			gName = coRS("gName")
			stockID = coRS("stockID")
			amount = coRS("amount")
			gPrice = coRS("gPrice")
			gClass = coRS("gClass")
			cbNbr = coRS("cbNbr")
			reserveFund = coRS("reserveFund")
			'����
			'stockID�� ���ؼ� gCode, ũ��� ���� ���ϱ�
			if stockID <> "" then 
				ArrGetGPs = GetGoodsProperties(stockID)
				gSize = ArrGetGPs(1) 
				gColor = ArrGetGPs(2)  
			end if
			'�� ���� ���϶� ó�� 				
			if gSize = "" then gSize = "-"
			if gColor = "" then gColor = "-"
			
			SubSumPrice = 0
			SubSumPrice = gPrice * amount
			TotSumPrice = TotSumPrice + SubSumPrice
			if Len(subNbr) < 2 then 	subNbr = "0" & subNbr
%>
              <TR align="center">
                <TD height=25 class=order><%= subNbr %></TD>
                <TD><a href="../GoodsDetailBody.asp?c=<%= cCode %>&g=<%= gCode %>"><%= gMnum %></a></TD>
                <TD><%= gName %></TD>
                <TD><%= gSize %></TD>
                <TD><%= gColor %></TD>
                <TD valign="middle"><%= FormatNumber(amount,0) %></TD>
                <TD><%= FormatNumber(gPrice,0) %>��</TD>
                <TD><%= FormatNumber(SubSumPrice,0) %>��</TD>
                <TD><%= FormatNumber((reserveFund*amount),0) %>��</TD>
              </TR>
              <%
			coRS.MoveNext
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
		Call CloseRS(coRS)
%>
	  </TD>
        </TR>
      </TABLE></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><img height=28 
                  src="Images/icoOrderDone_payInfo.gif" 
                  width=123></td>
  </tr>
  <tr>
    <td><TABLE cellSpacing=0 cellPadding=1 width=750 align=center 
            bgColor=#dfdfdf border=0>
      <FORM name=form4 action="" method=post>
        
          <TR>
            <TD><!-- ���� ���� ���� -->
                <TABLE cellSpacing=0 cellPadding=0 width=750 align=center 
                  border=0>
                  
                    <TR bgColor=#f2f2f2>
                      <TD width=110 height=30>
                        <DIV align=center><SPAN>�������</DIV></TD>
                      <TD class=text width=640 bgColor=#ffffff height=30><IMG height=10 src="../../Images/TransparentImage.gif" width=10> <%= howToPay %></TD>
                    </TR>
                    <TR bgColor=#dfdfdf>
                      <TD colSpan=2 height=1><IMG src="../../Images/TransparentImage.gif" height="1"></TD>
                    </TR>
                    <TR bgColor=#f2f2f2>
                      <TD height=30>
                        <DIV align=center><SPAN>�Ա���������</DIV></TD>
                      <TD class=text bgColor=#ffffff height=30><IMG height=10 src="../../Images/TransparentImage.gif" width=10> <%= payInfoDetail %></TD>
                    </TR>
                    <TR bgColor=#dfdfdf>
                      <TD colSpan=2 height=1><IMG src="../../Images/TransparentImage.gif" height="1"></TD>
                    </TR>
                    <TR bgColor=#f2f2f2>
                      <TD width=110 height=30>
                        <DIV align=center><SPAN>�����ݾ�</DIV></TD>
                      <TD class=price bgColor=#ffffff height=30><IMG height=10 src="../../Images/TransparentImage.gif" width=10> <%= FormatNumber(TotSumPrice + deliCharge ,0) %>��</TD>
                    </TR>
                    <TR bgColor=#dfdfdf>
                      <TD colSpan=2 height=1><IMG src="../../Images/TransparentImage.gif" height="1"></TD>
                    </TR>
                    <TR bgColor=#f2f2f2>
                      <TD height=30>
                        <DIV align=center><SPAN>�Ա��ڸ�</DIV></TD>
                      <TD bgColor=#ffffff height=30><IMG height=10 src="../../Images/TransparentImage.gif" width=10> <%= onlinePayer %>��</TD>
                    </TR>
                  
                </TABLE>
                <!-- ���� ���� ���� ��--></TD>
          </TR>
      </FORM>
    </TABLE>
      <TABLE cellSpacing=0 cellPadding=0 width=750 align=center border=0>        
          <TR>
            <TD width=19 height=25><IMG height=11 src="Images/opBullet.gif" width=11></TD>
            <TD width=731 height=25>���ǻ���</TD>
          </TR>
          <TR>
            <TD height=25>&nbsp;</TD>
            <TD height=25><FONT color=#ff0000>
			- �Ա��ڸ�� ���� �Ա����� �̸��� �ٸ� ��쿡�� ��ǰ ����� �� �� �����ϴ�.<BR>
            - ������ �Ա��Ͻ� ��, �ݵ�� �Ա��� �� &quot;<FONT color="#0066CC"><%= onlinePayer %></font>&quot;��� �Ա��� ������ �Ա��ϼž� �մϴ�.
			</FONT>
			</TD>
          </TR>
        
    </TABLE></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><img height=28 src="Images/icoOrderDone_toWhere.gif" width=123></td>
  </tr>
  <tr>
    <td><TABLE cellSpacing=0 cellPadding=1 width=750 align=center border=0>
        <TR>
          <TD bgColor=#dfdfdf>
            <TABLE cellSpacing=0 cellPadding=0 width=750 align=center border=0>
                <TR bgColor=#f2f2f2>
                  <TD width=110 height=30 align="center">������ ��</TD>
                  <TD class=text width=640 bgColor=#ffffff height=30><IMG height=10 src="../../Images/TransparentImage.gif" width=10> <%= rName %>��</TD>
                </TR>
                <TR bgColor=#dfdfdf>
                  <TD colSpan=2 height=1></TD>
                </TR>
                <TR bgColor=#f2f2f2>
                  <TD width=110 height=30 align="center">�ּ�</TD>
                  <TD class=text bgColor=#ffffff height=30><IMG height=10 src="../../Images/TransparentImage.gif" width=10>
				  [<%= rAddrZip %>]  &nbsp;<%= rAddrCity %>&nbsp; <%= rAddrStt %>
				   </TD>
                </TR>
                <TR bgColor=#dfdfdf>
                  <TD colSpan=2 height=1><IMG src="../../Images/TransparentImage.gif" height="1"></TD>
                </TR>
                <TR bgColor=#f2f2f2>
                  <TD height=30 align="center">������ȣ</TD>
                  <TD class=text bgColor=#ffffff height=30><IMG height=10 src="../../Images/TransparentImage.gif" width=10> ��ȭ��ȣ: <%= rPhone %> <%= rCellularP %></TD>
                </TR>
                <TR bgColor=#dfdfdf>
                  <TD colSpan=2 height=1><IMG src="../../Images/TransparentImage.gif" height="1"></TD>
                </TR>
                <TR bgColor=#f2f2f2>
                  <TD height=30 align="center">�޼��� ����</TD>
                  <TD class=text bgColor=#ffffff height=30><IMG height=10 src="../../Images/TransparentImage.gif" width=10> <%= note %></TD>
                </TR>
              
          </TABLE></TD>
        </TR>
      
    </TABLE>
      <TABLE cellSpacing=0 cellPadding=0 width=750 align=center 
              border=0>
        
          <TR>
            <TD width=18 height=25><IMG height=11 src="Images/opBullet.gif" width=11></TD>
            <TD width=732 height=25>��� �ȳ�</TD>
          </TR>
          <TR>
            <TD height=25>&nbsp;</TD>
            <TD height=25><FONT color=#ff0000><% '- �ֹ��Ͻ� ��ǰ�� ��ǰ ���� ���� ���� ���� ��۵� �� �ֽ��ϴ�. %></FONT></TD>
          </TR>
        
    </TABLE></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><img src="Images/icoOrderDone_etc.gif" width=81 height=28></td>
  </tr>
  <tr>
    <td><TABLE cellSpacing=0 cellPadding=1 width=750 align=center 
              border=0>
      <FORM name=form4 action="" method=post>
        
          <TR>
            <TD bgColor=#dfdfdf>
              <TABLE cellSpacing=0 cellPadding=0 width=750 align=center 
                  border=0>
                  <TR bgColor=#dfdfdf>
                    <TD colSpan=2 height=1><IMG src="../../Images/TransparentImage.gif" height="1"></TD>
                  </TR>
                  <TR bgColor=#f2f2f2>
                    <TD width=110 height=55>
                      <DIV align=center><SPAN>��ȯ/ȯ�� ����</DIV></TD>
                    <TD width="640" height=55 bgColor=#ffffff><p><IMG height=10 src="../../Images/TransparentImage.gif" width=10> <SPAN 
                        class=text>�����񽺼��� : <%= Application("firmPhone") %><br>
                      <IMG height=10 src="../../Images/TransparentImage.gif" width=10> �̸��� : <a href="mailto:<%= Application("firmEmail") %>"><%= Application("firmEmail") %></a><BR>
                      <IMG height=10 src="../../Images/TransparentImage.gif" width=10> �ѽ� : <%= Application("firmFax") %></p>                      </TD>
                  </TR>
                
            </TABLE></TD>
          </TR>
      </FORM>
    </TABLE>
      <!--TABLE cellSpacing=0 cellPadding=0 width=750 align=center 
              border=0>
        
          <TR>
            <TD width=18 height=25><IMG height=11 
                  src="Images/opBullet.gif" width=11></TD>
            <TD width=732 height=25>��Ÿ ����</TD>
          </TR>
          <TR>
            <TD height=25>&nbsp;</TD>
            <TD height=25>- �ڼ��� ������ <A 
                  href="http://www.interpark.com/gate/faq/InterparkCyberGuestCenter.jsp?COMM_001=0000100000&amp;COMM_002=1&amp;PAGE=main"><SPAN>�̿�ȳ�</A>���� Ȯ���Ͻ� �� �ֽ��ϴ�.<BR>
              - �ŷ���������(���ݰ�꼭, �¶����Ա���, �ſ�ī�� ������ǥ)�� <A 
                  href="https://www.interpark.com/sitemap/MyPageLogin.jsp?COMM_001=0000100000&amp;COMM_002=0"><SPAN>MY PAGE</A>�� �ֹ��������� ��û�Ͻ� �� �ֽ��ϴ�.<BR>
                          - <B>��������(�ſ�ī�������ǥ,�Ա���,���ݰ�꼭) ����� �ڵ����� ��ġ���� ���� ��� <A 
                  href="http://e-tax.interpark.com/interpark/tax/files/TopShield.exe"><FONT 
                  color=red>����</FONT></A>�� Ŭ���ϼ���.</B> </TD>
          </TR>
        
    </TABLE--></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><TABLE cellSpacing=0 cellPadding=5 width="100%" border=0>
      
        <TR>
          <TD width="50%" align="right">
			<A href="javascript:window.print();">
			<IMG src="Images/icoOrderDone_print.gif" width=110 height=34 border=0></A>
			</TD>
          <TD width="50%"><a href="<%= Application("SiteURLDir") %>"><img src="Images/icoOrderDone_mypage.gif" width="110" height="34" border="0"></a> </TD>
        </TR>
    </TABLE></td>
  </tr>
</table>
<%		%>
<% end if %>