<!-- Header Start -->
	<!--#include File="../AdminHeader.asp"-->
<!-- Header End -->
<base href="<%= Application("SiteURLDir") %>Admin/Staffs/" target="_self">
<%

   if request("page")="" then
      page=1
   else
      page=request("page")
   end if

	active = request("active")

	search = request("search")
	SearchString =request("SearchString")
	arry_search = Split(search,"-")

	'response.write arry_search(0)
	'response.write arry_search(1)
	'response.end



	SQL = "SELECT * FROM vStfMarketerList "
	if search <> "" and SearchString <> "" then
		SQL = SQL & " Where " & arry_search(0) & " like '%" & SearchString & "%' "
	end if
	if search <> "" and SearchString <> "" then
		SQL = SQL & " and active='Y' "
	else
		SQL = SQL & " Where active='Y' "
	end if
	SQL = SQL & " ORDER BY sName DESC"
	staffStatus = "Ȱ�� "

	RSresult = OpenRS(rs,SQL,50)
	recordcnt = rs.RecordCount

	'������
	totalpage = rs.pagecount
	rs.absolutepage = page

	if search <> "" and SearchString <> "" then
		if RSresult = "Empty" then
			Call goMsgPage("NoData" & "-" & arry_search(1) & "-" & SearchString)
		end if
		TopMsg = """" & arry_search(1) & """���� """ & SearchString & """(��)�� �˻��� ��� " & recordcnt & "���� " & staffStatus & "���������͸� ã�ҽ��ϴ�."
	else
		if RSresult = "Empty" then Call goMsgPage("NoStf")
		TopMsg = recordcnt & "���� " & staffStatus & "���θ��� �����͸� ã�ҽ��ϴ�."
	end if


%>

	 <table width="98%" border="0" align="center" cellspacing="2">
        <tr>
          <td height="25" colspan="10" align="center"> <table width="50%" border="0" align="right" cellspacing="0">
              <form method="POST" action="">
                <tr>
                  <td align="right"> <font color="#004080" face="Century Gothic"><small><strong>Search
                    &nbsp;&nbsp; </strong></small></font> <select name="search" size="1" style="font-family: ����ü">
                      <option value="Sname-�̸�" <%= writeSelected(search, "Sname-�̸�") %>>�̸�</option>
                      <option value="sID-���̵�" <%= writeSelected(search, "sID-���̵�") %>>���̵�</option>
                      <option value="deptName-�μ�" <%= writeSelected(search, "deptName-�μ�") %>>�μ�</option>
                      <option value="StaffID-���" <%= writeSelected(search, "StaffID-���") %>>���</option>
                      <option value="Semail-����" <%= writeSelected(search, "Semail-����") %>>����</option>
                      <option value="cellularP-�ڵ���"<%= writeSelected(search, "cellularP-�ڵ���") %>>�ڵ���</option>
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
          <td colspan="10"> <% Call topMsgHtml(TopMsg,120) %>
          </td>
        </tr>
        <tr bgcolor="#FF9D9D">
          <td align="center"><strong><font face="����" size="2" color="#FFFFFF">���̵�</font></strong></td>
          <td align="center"><strong><font face="����" size="2" color="#FFFFFF">������</font></strong></td>
          <td align="center"><strong><font face="����" size="2" color="#FFFFFF">���</font></strong></td>
          <td height="25" align="center"><strong><font face="����" size="2" color="#FFFFFF">�μ�</font></strong></td>
          <td height="25" align="center"><strong><font face="����" size="2" color="#FFFFFF">����</font></strong></td>
          <td align="center" bgcolor="#FF8686"><strong><font face="����" size="2" color="#FFFFFF">���θ��</font></strong></td>
          <td align="center" bgcolor="#FF8686"><strong><font face="����" size="2" color="#FFFFFF">��ġ</font></strong></td>
          <td align="center" bgcolor="#FF8686"><strong><font face="����" size="2" color="#FFFFFF">�Ҽ�����</font></strong></td>
          <td align="center" bgcolor="#FF8686"><strong><font face="����" size="2" color="#FFFFFF">������</font></strong></td>
          <td align="center"><strong><font face="����" size="2" color="#FFFFFF">�����޴�</font></strong></td>
        </tr>
        <%
i = 1
Do until rs.EOF Or i>rs.PageSize
	'����
	sID = trim(rs("pID"))
	pNumber = trim(rs("pNumber"))
	pResults = trim(rs("pResults"))

	if (Cint(pResults) = 0 or Cint(pNumber) = 0) then
		estimation = 0
	else
		estimation  =  Round(Csng((Cint(pResults)/Cint(pNumber)))*100.0, 3)
	end if
	belongTo = trim(rs("belongTo"))
	pVoluntaryDT = left(trim(rs("pVoluntaryDT")),10)
	staffID = trim(rs("staffID"))
	sName = trim(rs("sName"))
	sClass = trim(rs("sClass"))
	deptName = trim(rs("deptName"))


	if homepage <> "" then homepage = "<a href=""http://" & homepage & """ target=""_blank"">http://" & homepage & "</a>"


%>
        <tr>
          <td align="center" bgcolor="#FFFDFD"><font face="����" size="2" color="#000000"><a href="StfView.asp?sID=<%= sID %>&SelMode=v"><%= sID %></a></font></td>
          <td align="center" bgcolor="#FFFDFD"><font face="����" size="2" color="#000000"><a href="mailto:<%= sEmail %>"><%= sName %></a></font></td>
          <td align="center" bgcolor="#FFFDFD"><font face="����" size="2" color="#000000"><%= StaffID %></font></td>
          <td height="25" align="center" bgcolor="#FFFDFD"><font face="����" size="2" color="#000000"><%= deptName %></font></td>
          <td height="25" align="center" bgcolor="#FFFDFD"><font face="����" size="2" color="#000000"><%= Sclass %></font></td>
          <td align="center" bgcolor="#FFFDFD"><font face="����" size="2" color="#000000"><%= pResults %>/<%= pNumber %></font></td>
          <td align="center" bgcolor="#FFFDFD"><font face="����" size="2" color="#000000"><%= estimation %>%</font></td>
          <td align="center" bgcolor="#FFFDFD"><font face="����" size="2" color="#000000"><a href="StfView.asp?sID=<%= belongTo %>&SelMode=v"><%= belongTo %></a></font></td>
          <td align="center" bgcolor="#FFFDFD"><font face="����" size="2" color="#000000"><%= pVoluntaryDT %></font></td>
          <td align="center" bgcolor="#FFFDFD"><font face="����" size="2" color="#000000">
            <% if Session("sLevel4")>2 then %>
            <a href="StfInput.asp?sID=<%= sID %>&SelMode=u"><b>����</b></A>
            <a href="StfView.asp?sID=<%= sID %>&SelMode=v"><b>����</b></A>
            <% else %>
            <b>�ش���Ѿ���</b>
            <% end if %>
            </font></td>
        </tr>
        <%
rs.MoveNext
i=i+1
loop


  	Call CloseRS(rs)

%>
        <tr>
          <td height="25" colspan="10" align="center" bgcolor="#FFEEEE"><font face="����" size="2" color="#000000">
            <% if page <> 1 then%>
            &lt; <a href="StfList.asp?page=<%=page-1%>">����������</a>
            &gt;
            <%end if%>
            <% if Cint(page) <> Cint(totalpage) then%>
            &lt; <a href="StfList.asp?page=<%=page+1%>">����������</a>
            &gt;
            <% end if%>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=page%> page / <%=totalpage%> pages </font></td>
        </tr>
      </table>



<!-- Footer Start -->
	<!--#include File="../AdminFooter.asp"-->
<!-- Footer End -->
