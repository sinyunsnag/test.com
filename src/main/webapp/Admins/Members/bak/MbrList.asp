<!-- AdminHeader Start -->
	<!--#include File="../AdminHeader.asp"-->
<!-- AdminHeader End -->
<base href="<%= Application("SiteURLDir") %>Admin/Members/" target="_self">
<%
   if request("page")="" then
      page=1
   else
      page=request("page")
   end if

	Mbr = request("Mbr")

	search = request("search")
	SearchString =request("SearchString")
	arry_search = Split(search,"-")

	'response.write arry_search(0)
	'response.write arry_search(1)
	'response.end



	SQL = "SELECT MbrID,MbrName,phone,cellularP,MbrEmail,SSN1,SSN2,level4,HowMuch,HowMany"
	SQL = SQL & ",RFund,RFundAC,unpaid,unpaidAC,joinDT,recentLogin,company FROM vMbrList "

	if search <> "" and SearchString <> "" then
		SQL = SQL & " Where " & arry_search(0) & " like '%" & SearchString & "%' "
	end if
	'��Ȱ��ȸ��
	if Mbr = "miss" then
		if search <> "" and SearchString <> "" then
			SQL = SQL & " and missYouDT is not null "
		else
			SQL = SQL & " Where missYouDT is not null "
		end if
		memberStatus = "Ż���û "
	elseif Mbr = "lvl0" then
		if search <> "" and SearchString <> "" then
			SQL = SQL & " and level4=0 "
		else
			SQL = SQL & " Where level4=0 "
		end if
		memberStatus = "�ҷ� "
	else
		if search <> "" and SearchString <> "" then
			SQL = SQL & " and (missYouDT is null) and (level4>0) "
		else
			SQL = SQL & " Where (missYouDT IS NULL) and (level4>0) "
		end if
		memberStatus = "���� "
	end if


	if Mbr = "royal" then
		SQL = SQL & " ORDER BY HowMuch DESC, RFundAC DESC "
		memberStatus = "�ξ� "
	elseif Mbr ="recent" then
		SQL = SQL & " ORDER BY recentLogin DESC "
		memberStatus = "�ֱٹ湮 "
	else
		SQL = SQL & " ORDER BY joinDT DESC "
	end if


	
	RSresult = OpenAdvRS(rs, SQL, 70, 1, 3)
	if RSresult <> "Empty" then
		recordcnt = rs.RecordCount
		'������
		totalpage = rs.pagecount
		rs.absolutepage = page
		'GetString�� �޾Ƴ�
		AllRec = rs.GetString(2, rs.PageSize) 	'(adClipString=2, RS.PageSize)
        rows = split(AllRec,chr(13))
	end if
	
		

	if search <> "" and SearchString <> "" then
		if not IsArray(rows) then Call goMsgPage("NoData" & "-" & arry_search(1) & "-" & SearchString)
		TopMsg = """" & arry_search(1) & """���� """ & SearchString & """(��)�� �˻��� ��� " & recordcnt & "���� " & memberStatus & "ȸ�������͸� ã�ҽ��ϴ�."
	else
		if not IsArray(rows) then Call goMsgPage("NoMbr")
		TopMsg = recordcnt & "���� " & memberStatus & "ȸ�������͸� ã�ҽ��ϴ�."
	end if



%>
	 <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="25" align="center"> <table width="50%" border="0" align="right" cellspacing="0">
              <form method="POST" action="">
                <tr>
                  <td align="right"> <font color="#004080" face="Century Gothic"><small><strong>Search
                    &nbsp;&nbsp; </strong></small></font> <select name="search" size="1" style="font-family: ����ü">
                      <option value="MbrName-�̸�" <%= writeSelected(search, "MbrName-�̸�") %>>�̸�</option>
                      <option value="MbrID-���̵�" <%= writeSelected(search, "MbrID-���̵�") %>>���̵�</option>
                      <option value="phone-�Ϲ���ȭ" <%= writeSelected(search, "phone-�Ϲ���ȭ") %>>�Ϲ���ȭ</option>
                      <option value="cellularP-�ڵ���"<%= writeSelected(search, "cellularP-�ڵ���") %>>�ڵ���</option>
                      <option value="MbrEmail-����" <%= writeSelected(search, "MbrEmail-����") %>>����</option>
                    </select> <input name="SearchString" type="text" style="border: 1px dashed" value="<%= SearchString %>" size="20">
                    <input type="submit" value=" �� �� " name="btn" style="background-color: rgb(238,238,238); color: rgb(0,47,94); font-weight: bolder">
                  </td>
                  <td width="30" height="50">&nbsp;</td>
                </tr>
              </form>
            </table>
            <br clear="all"> </td>
        </tr>
        <tr>
          <td> <% Call topMsgHtml(TopMsg,120) %> </td>
        </tr>
        <tr>
          <td><table width="100%" border="0" align="center" cellpadding="1" cellspacing="2">
              <tr bgcolor="#5CC765">
                <td align="center"><strong><font face="����" size="2" color="#FFFFFF">���̵�</font></strong></td>
                <td align="center"><strong><font face="����" size="2" color="#FFFFFF">ȸ����(�)</font></strong></td>
                <td align="center"><strong><font face="����" size="2" color="#FFFFFF">������ȣ</font></strong></td>
                <td align="center"><strong><font face="����" size="2" color="#FFFFFF">�ڵ���</font></strong></td>
                <td height="25" align="center"><strong><font face="����" size="2" color="#FFFFFF">���</font></strong></td>
                <td align="center"><strong><font face="����" size="2" color="#FFFFFF">�����Ѿ�/Ƚ��</font></strong></td>
                <td align="center"><strong><font color="#FFFFFF" size="2" face="����">��/��������Ʈ</font></strong></td>
                <td align="center"><strong><font color="#FFFFFF" size="2" face="����">��/�����̳���</font></strong></td>
                <td align="center"><strong><font face="����" size="2" color="#FFFFFF">�ֱٷα���</font></strong></td>
                <td align="center"><strong><font face="����" size="2" color="#FFFFFF">������</font></strong></td>
                <td align="center"><strong><font face="����" size="2" color="#FFFFFF">�����޴�</font></strong></td>
              </tr>
              <%
'i = 1
'Do until rs.EOF Or i>rs.PageSize

	'����
	 for j=0 to Ubound(rows)-1
	     cols = split(rows(j),chr(9))
			MbrID  = trim(cols(0))
			MbrName = trim(cols(1))
			phone = trim(cols(2))
			cellularP = trim(cols(3))
			MbrEmail = trim(cols(4))
			SSN1 = trim(cols(5))
			SSN2 = trim(cols(6))
			level4 = trim(cols(7))
			HowMuch = trim(cols(8))
			HowMany = trim(cols(9))
			RFund = trim(cols(10))
			RFundAC = trim(cols(11))
			unpaid = trim(cols(12))
			unpaidAC = trim(cols(13))
			joinDT = trim(cols(14))
			recentLogin = trim(cols(15))
			company = trim(cols(16))


			if IsNumeric(SSN1) then
				if CInt(Left(SSN1, 2)) <= 99 then
					age = Year(now) - CInt(19&Left(SSN1, 2)) + 1
				else
					age = Year(now) - CInt(20&Left(SSN1, 2)) + 1
				end if
			else
				age = "?"
			end if

			joinDT = left(joinDT,10)


%>
              <tr bgcolor="#FDFFFB">
                <td align="center"><font face="����" size="2" color="#000000"><a href="MbrView.asp?MbrID=<%= MbrID %>&SelMode=v"><%= MbrID %></a></font></td>
                <td align="center"><font face="����" size="2" color="#000000"><a href="mailto:<%= sEmail %>"><%= MbrName %>(<%= age %>)</a></font></td>
                <td align="center"><font face="����" size="2" color="#000000"><%= phone %></font></td>
                <td align="center"><font face="����" size="2" color="#000000"><%= cellularP %></font></td>
                <td height="25" align="center"><font face="����" size="2" color="#000000"><%= level4 %></font></td>
                <td align="center"><font face="����" size="2" color="#000000"><%= HowMuch %>/<%= HowMany %></font></td>
                <td align="center"><font face="����" size="2" color="#000000"><%= RFund %>/<%= RFundAC %></font></td>
                <td align="center"><font face="����" size="2" color="#000000"><%= unpaid %>/<%= unpaidAC %></font></td>
                <td align="center"><font face="����" size="2" color="#000000"><%= recentLogin %></font></td>
                <td align="center"><font face="����" size="2" color="#000000"><%= joinDT %></font></td>
                <td align="center"><font face="����" size="2" color="#000000">
                  <% if Session("sLevel4")>2 then %>
                  <a href="MbrInput.asp?MbrID=<%= MbrID %>&SelMode=u"><b>����</b></A>
                  <a href="MbrView.asp?MbrID=<%= MbrID %>&SelMode=v"><b>����</b></A>
                  <% else %>
                  <b>�ش���Ѿ���</b>
                  <% end if %>
                  </font></td>
              </tr>
              <%
          next
'rs.MoveNext
'i=i+1
'loop


  	Call CloseRS(rs)

%>
              <tr bgcolor="#F7FFF0">
                <td height="25" colspan="11" align="center"><font face="����" size="2" color="#000000">
                  <% if page <> 1 then%>
                  &lt; <a href="MbrList.asp?page=<%=page-1%>">����������</a>
                  &gt;
                  <%end if%>
                  <% if Cint(page) <> Cint(totalpage) then%>
                  &lt; <a href="MbrList.asp?page=<%=page+1%>">����������</a>
                  &gt;
                  <% end if%>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=page%> page / <%=totalpage%> pages </font></td>
              </tr>
            </table></td>
        </tr>
      </table>



<!-- AdminFooter Start -->
	<!--#include File="../AdminFooter.asp"-->
<!-- AdminFooter End -->
