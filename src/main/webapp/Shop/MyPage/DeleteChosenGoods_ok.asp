<!-- ShopSetting Start -->
	<!--#include File = "../../SiteSetting.asp" -->
<!-- ShopSetting End -->

<%
	'��ǰ�ڵ�
	MbrID = Request.QueryString("MbrID")
	gCode = Request.QueryString("g")
	'MbrID, gCode ���� �ȳѾ� ����
	if MbrID = "" or gCode = "" then
		Call ShowAlertMsg("���������� �����Դϴ�!!")
	end if

	'���� ��ǰ DB�Է�
	Set Cmd = Server.CreateObject("ADODB.Command")
	With Cmd
		.ActiveConnection = dbConn
		.CommandType = adCmdText
		SQL = "DELETE FROM vChosenGoods"
		SQL = SQL & " WHERE MbrID = ? and gCode = ?"
		.CommandText = SQL
		.Parameters.Append Cmd.CreateParameter("@MbrID", adVarChar, adParamInput, 15, MbrID)
		.Parameters.Append Cmd.CreateParameter("@gCode", adChar, adParamInput, 15, gCode)
		.Execute ,,adExecuteNoRecords
	end With
	Set Cmd = nothing		

	Call GotoThePage("�ش��ǰ�� �����߽��ϴ�.", "MyPage.asp")
	
%>	
<% 
	'Server.Execute(Application("SiteRoot") & "Admin/Statistics/statsEngine.asp") 
	Call CloseDB()
%>