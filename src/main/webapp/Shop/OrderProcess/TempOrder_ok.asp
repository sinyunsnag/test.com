<!-- ShopSetting Start -->
	<!--#include File = "../../SiteSetting.asp" -->
<!-- ShopSetting End -->

<!-- fsShop_inc Start -->
	<!--#include File= "../../Include_asp/fsShop_inc.asp"-->
<!-- fsShop_inc End -->

<%
	'��ǰ�ڵ�
	c = Request.Form("c")
	g = Request.Form("g")
	gSize = Request.Form("gSize")
	gColor = Request.Form("gColor")
	amount = Request.Form("amount")

	'��Ű�� ����ؾ� ������ ���ܵ� �̿밡���ϴ�.
	if Request.Cookies("tempOrderID") = "" then
		Response.Cookies("tempOrderID") = Session.SessionID
	end if


	'c,g ���� �ȳѾ� ����
	if c = "" or g = "" or Not IsNumeric(amount) then
		Call GotoThePage("���������� �����Դϴ�!!", Application("SiteURLDir"))
	end if
	'����ī�װ��� ��ǰ�̸��� �������� ������ ����
	gName = PickUpValue("vGoodsList_c", "gName", "gCode = '" & g & "'")
	if gName = "NoPickUp" then
		Call GotoThePage("�ش� ����ī�װ��� �������� �ʽ��ϴ�!!", Application("SiteURLDir"))
	end if

	if Right(g,1) <> "S" then
		'gSize,gColor�� �̿��Ͽ� ����� �ľ��Ѵ�. ����� 0 �����̸� �����Ҽ� ����.
		Call CheckStock(GetCurrStock(g,gSize,gColor),-amount,"")
	end if

	'20�� �̻��̸� ���̻� �߰��ȵ�.
	SQL = "SELECT COUNT(*) AS Cnt FROM vTempOrder "
	SQL = SQL & " Where tOrderNbr = '" & Request.Cookies("tempOrderID") & "'"
	SQL = SQL & " GROUP BY tOrderNbr, DATEPART(dayofyear , choiceDT) "
	RSresult = OpenSimpleRS(rsCnt, SQL)
	if RSresult <> "Empty" then
		if rsCnt(0) > 20 then
			Call CloseRS(rsCnt)
			Call GotoThePage("20�������� ��ǰ�� ����īƮ�� �����Ͻ� �� �ֽ��ϴ�.", "GoodsDetailBody.asp?c=" & c & "&g=" & g)
		end if
	end if


	'��ٱ��Ͽ�  ��ǰ DB�Է�
	Set Cmd = Server.CreateObject("ADODB.Command")
	With Cmd
		'dbConn.BeginTrans
		.ActiveConnection = dbConn
		.CommandType = adCmdText
	'��ǰ������Ƽ�� stockID���ϱ�
	whereClause = "tOrderNbr ='" & Request.Cookies("tempOrderID") & "' And cCode =" & c & " And gCode ='" & g & "'"
	whereClause = whereClause & " And stockID ='" & GetStockID(g,gSize,gColor) & "'"
	whereClause = whereClause & " And DATEPART(dayofyear , choiceDT) = DATEPART(dayofyear , Getdate())"
	tOrderNbr = PickUpValue("vTempOrder", "tOrderNbr", whereClause)

	if tOrderNbr = "NoPickUp" then
		stat_Key = Request.Cookies("stat_Key")
		if stat_Key = "" then stat_Key = "NULL"
		sqlTorder = "INSERT INTO vTempOrder(tOrderNbr,cCode,gCode,stockID,amount,stat_Key)"
		sqlTorder = sqlTorder & " VALUES(?,?,?,?,?," & stat_Key & ")"
		.CommandText = sqlTorder
		.Parameters.Append Cmd.CreateParameter("@tOrderNbr", adChar, adParamInput, 10, Request.Cookies("tempOrderID"))
		.Parameters.Append Cmd.CreateParameter("@cCode", adUnsignedTinyInt, adParamInput, 1, c)
		.Parameters.Append Cmd.CreateParameter("@gCode", adChar, adParamInput, 15, g)
		.Parameters.Append Cmd.CreateParameter("@stockID", adVarChar, adParamInput, 50, GetStockID(g,gSize,gColor))
		.Parameters.Append Cmd.CreateParameter("@amount", adUnsignedTinyInt, adParamInput, 1, amount)
		.Execute ,,adExecuteNoRecords
		'dbConn.CommitTrans
	else
		sqlTorder = "UPDATE vTempOrder Set amount = amount + ?"
		sqlTorder = sqlTorder & " WHERE tOrderNbr = ? And cCode=? And gCode = ? And DATEPART(dayofyear , choiceDT) = DATEPART(dayofyear , Getdate())"
		.CommandText = sqlTorder
		.Parameters.Append Cmd.CreateParameter("@amount", adUnsignedTinyInt, adParamInput, 1, amount)
		.Parameters.Append Cmd.CreateParameter("@tOrderNbr", adChar, adParamInput, 10, Request.Cookies("tempOrderID"))
		.Parameters.Append Cmd.CreateParameter("@cCode", adUnsignedTinyInt, adParamInput, 1, c)
		.Parameters.Append Cmd.CreateParameter("@gCode", adChar, adParamInput, 15, g)
		.Execute ,,adExecuteNoRecords
	end if

	end With
	Set Cmd = nothing

'Response.write sql
'Response.end

	'c -> p -> f -> d
	Response.Redirect("OrderProcess.asp?opMode=c")

	'Call GotoThePage(gName & "��(��) ����īƮ�� " & amount & "�� �־����ϴ�.", "../GoodsDetailBody.asp?c=" & c & "&g=" & g)
%>

<%
	'Server.Execute(Application("SiteRoot") & "Admin/Statistics/statsEngine.asp")
	Call CloseDB()
%>

