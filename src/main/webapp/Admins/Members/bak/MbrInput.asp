<!-- Header Start -->
	<!--#include File="../AdminHeader.asp"-->
<!-- Header End -->
<%
	'������ ���� üũ
	if Session("sLevel4") < 3 then Call goMsgPage("NoWay")

	'���̵��� ������ �������� ���Է����� Ȯ��
	SelMode =trim(Request.QueryString("SelMode"))
	MbrID =trim(Request.QueryString("MbrID"))

	if SelMode = "i" then
		TopMsg = "�� ȸ���� ����ϼ���."
		submitMSG = "���ο� ȸ������ ����Ͻðڽ��ϱ�?"

		MbrPW = "1234567"
		mailing = "True"
		level4 = 1


	elseif SelMode = "u" then
		TopMsg =  MbrID & "�� ���� ��������� �Է��ϼ���."
		submitMSG = "��������� ���� �Ͻðڽ��ϱ�?"

		if MbrID <> "" then
			SQL = "SELECT * FROM vMemberValues "
			SQL = SQL + " WHERE MbrID='" & MbrID & "'"
			RSresult = OpenRS(rs,SQL,1)
			'Response.Write("RSresult=" + RSresult)
			if RSresult = "Empty" then
				Call ShowAlertMsg("�ش����ڴ� �����ϴ�.")
			end if
			'set rs = db.Execute(sql)
		else
			Call ShowAlertMsg("���̵� �Է��ϼ���")
		end if

		MbrID = trim(rs("MbrID"))
		MbrPW = trim(rs("MbrPW"))
		MbrName = trim(rs("MbrName"))
		phone = trim(rs("phone"))
		cellularP = trim(rs("cellularP"))
		MbrEmail = trim(rs("MbrEmail"))
		sex = trim(rs("sex"))
		AddrZip = trim(rs("AddrZip"))
		AddrCity = trim(rs("AddrCity"))
		AddrStt = trim(rs("AddrStt"))
		findingID = trim(rs("findingID"))
		'Question = trim(rs("Question"))
		findingA = trim(rs("findingA"))
		SSN1 = trim(rs("SSN1"))
		SSN2 = trim(rs("SSN2"))
		birthSL = trim(rs("birthSL"))
		birthDate = trim(rs("birthDate"))
		wedSL = trim(rs("wedSL"))
		wedDate = trim(rs("wedDate"))
		buyable = trim(rs("buyable"))
		hobbies = trim(rs("hobbies"))
		homepage = trim(rs("homepage"))
		mark = trim(rs("mark"))
		avataImage = trim(rs("avataImage"))
		rcmderID = trim(rs("rcmderID"))
		level4 = trim(rs("level4"))
		HowMuch = trim(rs("HowMuch"))
		HowMany = trim(rs("HowMany"))
		RFund = trim(rs("RFund"))
		RFundAC = trim(rs("RFundAC"))
		unpaid = trim(rs("unpaid"))
		unpaidAC = trim(rs("unpaidAC"))
		mailing = trim(rs("mailing"))
		joinDT = trim(rs("joinDT"))
		recentLogin = trim(rs("recentLogin"))
		missYouDT = trim(rs("missYouDT"))
		IPaddress = trim(rs("IPaddress"))
		'��������
		company = trim(rs("company"))
		DeptName = trim(rs("DeptName"))
		MbrClass = trim(rs("MbrClass"))
		jobID = trim(rs("jobID"))
		officeP = trim(rs("officeP"))
		faxNbr = trim(rs("faxNbr"))
		officeZip = trim(rs("officeZip"))
		officeCity = trim(rs("officeCity"))
		officeStt = trim(rs("officeStt"))
		salaryID = trim(rs("salaryID"))
		Call CloseRS(rs)

		'��������
		if buyable = "" Or IsNull(buyable) then buyable = "&nbsp;"
		if SalaryID <> "" then
			Salary = PickUpValue("vSalary", "sRange", "SalaryID = " & SalaryID )
		else
			Salary = "-"
		end if

		if IsNumeric(SSN1) then
			if CInt(Left(SSN1, 2)) <= 99 then
				age = Year(now) - CInt(19&Left(SSN1, 2)) + 1
			else
				age = Year(now) - CInt(20&Left(SSN1, 2)) + 1
			end if
		else
			age = "?"
		end if
	end if 		'if SelMode = "i" then
%>

<base href="<%= Application("SiteURLDir") %>Admin/Members/" target="_self">
<script language="Javascript" src="<%= Application("SiteURLDir") %>Include_js/Function.js"></script>
<script language="JavaScript" src="<%= Application("SiteURLDir") %>CommonAccessories/MbrUsers/mu_inc.js"></script>
<table width="750" border="0" cellspacing="0" cellpadding="0">
<form name="frmMbr" method="post">
<input name="SelMode" type="hidden" id="SelMode" value="<%= SelMode %>">
  <tr>
    <td align="center">
<table width="600" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td><table width="600" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td colspan="4"> <% Call TopMsgHtml(topMsg,120) %> </td>
                      </tr>
                      <tr>
                        <td width="120" height="20" bgcolor="#F7FFF0">���̵�</td>
                        <td colspan="3"> <% if MbrID = "" then %> <input name="MbrID" type="text" id="MbrID" value="<%= MbrID %>" size="15" maxlength="15" style="ime-mode:inactive">
                          &nbsp;&nbsp; <input type="button" name="btnMbrID" value="�ߺ�Ȯ��" onClick="javascript:IDcheckExists('vMember',frmMbr.MbrID,'Yes','../../CommonAccessories/IDSeek/IDseekWithXML.asp');">
                          <% else Response.Write(MbrID) %> <input name="MbrID" type="hidden" id="MbrID3" value="<%= MbrID %>">
                          <% end if %> </td>
                      </tr>
                      <tr>
                        <td height="20" bgcolor="#F7FFF0">�̸�</td>
                        <td colspan="3"><input name="MbrName" type="text" id="MbrName" value="<%= MbrName %>" size="16" maxlength="16" style="ime-mode:active">
                          ( <select name="sex" id="sex">
                            <option value="��" <%= WriteSelected(sex, "��") %>>��</option>
                            <option value="��" <%= WriteSelected(sex, "��") %>>��</option>
                          </select>:<%= age %>) </td>
                      </tr>
                      <tr>
                        <td width="120" height="20" bgcolor="#F7FFF0">&nbsp;</td>
                        <td colspan="3">&nbsp;</td>
                      </tr>
                      <tr>
                        <td height="20" bgcolor="#F7FFF0">��ȭ��ȣ</td>
                        <td colspan="3"><input name="phone" type="text" id="phone" value="<%= phone %>" size="18" maxlength="18">
                          ex) 02-6214-7039 </td>
                      </tr>
                      <tr>
                        <td height="20" bgcolor="#F7FFF0">�ڵ���</td>
                        <td colspan="3"><input name="cellularP" type="text" id="cellularP" value="<%= cellularP %>" size="18" maxlength="18">
                          ex) 017-311-7039 </td>
                      </tr>
                      <tr>
                        <td height="20" bgcolor="#F7FFF0">����</td>
                        <td colspan="3"><input name="MbrEmail" type="text" id="MbrEmail" value="<%= MbrEmail %>" size="20" maxlength="50"></td>
                      </tr>
                      <tr>
                        <td height="20" bgcolor="#F7FFF0">&nbsp;</td>
                        <td colspan="3">&nbsp;</td>
                      </tr>
                      <tr>
                        <td height="20" bgcolor="#F7FFF0">�����ȣ</td>
                        <td colspan="3">
						<a href="javascript:NewWindow('../../CommonAccessories/PostSeek/PostSeek.asp', frmMbr, frmMbr.AddrZip, 426, 400);">
                          <input name="AddrZip" type="text" id="AddrZip" style="CURSOR: default;" value="<%= AddrZip %>" size="7" maxlength="7" readonly>
                          <img src="../../CommonAccessories/PostSeek/Images/search1.gif" width="24" height="24" border=0>
                          </a></td>
                      </tr>
                      <tr>
                        <td height="20" bgcolor="#F7FFF0">�ּ�</td>
                        <td colspan="3"><input name="AddrCity" type="text" id="AddrCity" value="<%= AddrCity %>" size="50" maxlength="50"></td>
                      </tr>
                      <tr>
                        <td height="20" bgcolor="#F7FFF0">���ּ�</td>
                        <td colspan="3"><input name="AddrStt" type="text" id="AddrStt" value="<%= AddrStt %>" size="20" maxlength="20" style="ime-mode:active"></td>
                      </tr>
                      <tr>
                        <td height="20" bgcolor="#F7FFF0">&nbsp;</td>
                        <td colspan="3">&nbsp; </td>
                      </tr>
                      <tr>
                        <td bgcolor="#F7FFF0">�������</td>
                        <td> <input name="birthDate" type="text" id="birthDate" value="<%= birthDate %>" size="10" maxlength="10">
                          <select name="birthSL" id="birthSL">
                            <option value="��" <%= WriteSelected(birthSL, "��") %>>���</option>
                            <option value="��" <%= WriteSelected(birthSL, "��") %>>����</option>
                          </select></td>
                        <td width="120" bgcolor="#F7FFF0">��ȥ�����</td>
                        <td><input name="wedDate" type="text" id="wedDate" value="<%= wedDate %>" size="10" maxlength="10">
                          <select name="wedSL" id="wedSL">
                            <option value="��" <%= WriteSelected(wedSL, "��") %>>���</option>
                            <option value="��" <%= WriteSelected(wedSL, "��") %>>����</option>
                          </select></td>
                      </tr>
                      <tr>
                        <td height="20" bgcolor="#F7FFF0">��������ǰ</td>
                        <td colspan="3">
<% Call CheckDetailOption("vBuyableItems", "bwText", "bwText", "bIDX", Split(buyable,"&nbsp;")) %>
                        </td>
                      </tr>
                      <tr>
                        <td bgcolor="#F7FFF0">���</td>
                        <td colspan="3">
                          <input name="hobbies" type="text" id="hobbies" value="<%= hobbies %>" size="50" maxlength="70"></td>
                      </tr>
                      <tr>
                        <td bgcolor="#F7FFF0">Ȩ������</td>
                        <td colspan="3">http://
                          <input name="homepage" type="text" id="homepage" value="<%= homepage %>" size="40" maxlength="50" style="ime-mode:inactive"></td>
                      </tr>
                      <tr>
                        <td height="20" bgcolor="#F7FFF0">���ϸ���û</td>
                        <td colspan="3">
                          <input name="mailing" type="checkbox" id="mailing" value="1" <%= WriteRadioChecked(mailing, "True") %>>
                          ��û </td>
                      </tr>
                      <tr>
                        <td height="20" bgcolor="#F7FFF0">�ϰ���� ��</td>
                        <td colspan="3"><textarea name="mark" cols="70" rows="10" wrap="hard" id="textarea" style="ime-mode:active"><%= mark %></textarea></td>
                      </tr>
                      <tr>
                        <td height="20" bgcolor="#F7FFF0">&nbsp;</td>
                        <td colspan="3">&nbsp; </td>
                      </tr>
                      <tr>
                        <td height="20" bgcolor="#F7FFF0">ã������</td>
                        <td colspan="3">
                          <select name="findingID" id="findingID">
                            <% Call SelectOption("vFindingUserInfo", "findingID", findingID) %>
                          </select></td>
                      </tr>
                      <tr>
                        <td height="20" bgcolor="#F7FFF0">ã���</td>
                        <td colspan="3">
                          <input name="findingA" type="text" id="findingA" value="<%= findingA %>" size="20" maxlength="20" style="ime-mode:active"></td>
                      </tr>
                      <tr>
                        <td height="20" bgcolor="#F7FFF0">������</td>
                        <td><%= joinDT %> </td>
                        <td width="120" bgcolor="#F7FFF0">��õ���̵�</td>
                        <td>
                          <input name="rcmderID" type="text" id="rcmderID" value="<%= rcmderID%>" size="12" maxlength="12" style="ime-mode:inactive"></td>
                      </tr>
                      <tr bgcolor="#E0FFC1">
                        <td height="20">&nbsp;</td>
                        <td colspan="3" bgcolor="#E0FFC1">��������
                          <% if company = "" or IsNull(company) then Response.Write(" - ���Խ� �Է����� �ʾҾ�") end if%>
                          (�ּұ��Ի���- ȸ���, ����, ��ȭ��ȣ)</td>
                      </tr>
                      <tr>
                        <td height="20" bgcolor="#F7FFF0">ȸ���</td>
                        <td colspan="3">
                          <input name="company" type="text" id="company" value="<%= company %>" size="20" maxlength="20" style="ime-mode:active"></td>
                      </tr>
                      <tr>
                        <td bgcolor="#F7FFF0">�μ�/����</td>
                        <td colspan="3">
                          <input name="DeptName" type="text" id="company3" value="<%= DeptName %>" size="20" maxlength="20" style="ime-mode:active">
                          /
                          <input name="MbrClass" type="text" id="MbrClass" value="<%= MbrClass %>" size="10" maxlength="10" style="ime-mode:active"></td>
                      </tr>
                      <tr>
                        <td height="20" bgcolor="#F7FFF0">����(����)</td>
                        <td colspan="3">
                          <select name="jobID" id="jobID">
                            <% Call SelectOption("vJobs", "jobID", jobID) %><%= jobID %>
                          </select></td>
                      </tr>
                      <tr>
                        <td height="20" bgcolor="#F7FFF0">��ȭ��ȣ</td>
                        <td>
<input name="officeP" type="text" id="officeP" value="<%= officeP %>" size="18" maxlength="18"></td>
                        <td width="120" height="20" bgcolor="#F7FFF0">�ѽ���ȣ</td>
                        <td>
<input name="faxNbr" type="text" id="faxNbr" value="<%= faxNbr %>" size="18" maxlength="18"></td>
                      </tr>
                      <tr>
                        <td height="20" bgcolor="#F7FFF0">�����ȣ</td>
                        <td colspan="3">
						 <a href="javascript:NewWindow('../../CommonAccessories/PostSeek/PostSeek.asp', frmMbr, frmMbr.officeZip, 426, 400);">
                          <input name="officeZip" type="text" id="officeZip" style="CURSOR: default;" value="<%= officeZip %>" size="7" maxlength="7" readonly>
                          <img src="../../CommonAccessories/PostSeek/Images/search1.gif" width="24" height="24" border=0>
                          </a></td>
                      </tr>
                      <tr>
                        <td height="20" bgcolor="#F7FFF0">�ּ�</td>
                        <td colspan="3">
                          <input name="officeCity" type="text" id="officeCity" value="<%= officeCity %>" size="50" maxlength="50"></td>
                      </tr>
                      <tr>
                        <td height="20" bgcolor="#F7FFF0">���ּ�</td>
                        <td colspan="3">
                          <input name="officeStt" type="text" id="officeStt" value="<%= officeStt %>" size="20" maxlength="20" style="ime-mode:active"></td>
                      </tr>
                      <tr>
                        <td height="20" bgcolor="#F7FFF0">����</td>
                        <td colspan="3">
                          <select name="salaryID" id="salaryID">
                            <% Call SelectOption("vSalary", "salaryID", salaryID) %>
                          </select>
                          (����:����)<%= salaryID %></td>
                      </tr>
                      <% if Session("sLevel4") >= 2 then %>
                      <tr>
                        <td height="100" bgcolor="#E0FFC1">��������׸�</td>
                        <td colspan="3" valign="top"><table width="100%" border="0" cellspacing="2" cellpadding="1">
                            <tr bgcolor="#F7FFF0">
                              <th width="33%">��й�ȣ</th>
                              <th width="33%">ȸ�����</th>
                              <th width="33%">�ֹι�ȣ</th>
                            </tr>
                            <tr align="center">
                              <td height="30"><input name="MbrPW" type="text" id="MbrPW" value="<%= MbrPW %>" size="15" maxlength="15" style="ime-mode:inactive">
                              </td>
                              <td>
                                <select name="level4" id="select">
                                  <option value="0" <%= WriteSelected(Cint(level4), 0) %>>0</option>
                                  <option value="1" <%= WriteSelected(Cint(level4), 1) %>>1</option>
                                  <option value="2" <%= WriteSelected(Cint(level4), 2) %>>2</option>
                                  <option value="3" <%= WriteSelected(Cint(level4), 3) %>>3</option>
                                  <option value="4" <%= WriteSelected(Cint(level4), 4) %>>4</option>
                                  <% if Session("sLevel4") >= 5 then %>
                                  <option value="5" <%= WriteSelected(Cint(level4), 5) %>>5</option>
                                  <% end if %>
                                </select>
                                (0~4)</td>
                              <td>
<input name="SSN1" type="text" id="SSN1" value="<%= SSN1 %>" size="6" maxlength="6">-<input name="SSN2" type="text" id="SSN2" value="<%= SSN2 %>" size="7" maxlength="7">
                              </td>
                            </tr>
                          </table>



			<% if SelMode = "u" then %>
                          <table width="100%" border="0" cellspacing="2" cellpadding="1">
                            <tr bgcolor="#F7FFF0">
                              <th width="33%">�����Ѿ�/Ƚ��</th>
                              <th width="33%">��/��������Ʈ</th>
                              <th width="33%">��/�����̳���</th>
                            </tr>
                            <tr align="center">
                              <td height="30"><font face="����" size="2" color="#000000"><%= HowMuch %>/<%= HowMany %></font></td>
                              <td><font face="����" size="2" color="#000000"><%= RFund %>/<%= RFundAC %></font></td>
                              <td><font face="����" size="2" color="#000000"><%= unpaid %>/<%= unpaidAC %></font></td>
                            </tr>
                          </table>
                          <table width="100%" border="0" cellspacing="2" cellpadding="1">
                            <tr bgcolor="#F7FFF0">
                              <th width="33%">�ֱٷα���</th>
                              <th width="33%">�ֱ�IP</th>
                              <th width="33%">Ż����</th>
                            </tr>
                            <tr align="center">
                              <td height="30"><%= recentLogin %> </td>
                              <td><%= IPaddress %> </td>
                              <td><%= missYouDT %> </td>
                            </tr>
                          </table>
				<% end if %>
						  </td>
                      </tr>
                      <% end if %>
                      <tr>
                        <td bgcolor="#F7FFF0">&nbsp;</td>
                        <td height="120" colspan="3">
                          <% if SelMode = "i" then %>
                          <input name="Button" type="button" id="Button" onClick="SubmitJ('<%= submitMSG %>',this.form, 'MbrInput_ok.asp?SelMode=i');" value="��ȸ�����">
                          <% end if %>
                          <% if SelMode = "u" then %>
                          <input name="btnUpdate" type="button" id="btnUpdate" onClick="JavaScript:SubmitJ('������ �����մϱ�?', this.form, 'MbrInput_ok.asp?SelMode=u')" value="����Ȯ��">
                          <% end if %>
                          <input type="button" name="Button" value="�ڷ�" onClick="history.back();"></td>
                      </tr>
                    </table></td>
                </tr>
              </table></td>
  </tr>
</form>
</table>



<!-- Footer Start -->
	<!--#include File="../AdminFooter.asp"-->
<!-- Footer End -->
