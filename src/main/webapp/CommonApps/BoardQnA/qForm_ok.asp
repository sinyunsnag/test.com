<%@ TRANSACTION = Required LANGUAGE = "VBScript" %>
<!-- caSetting Start -->
	<!--#include File = "../caSetting.asp" -->
<!-- caSetting  End -->
<script language="JavaScript" src="../../Include_js/CommonFunctions.js"></script>
<script language="JavaScript" src="../../Include_js/Function.js"></script>

<%

	'qaMode �������� ���Է����� Ȯ��(�̰� �������� ����)
	qaMode = Request("qaMode")
	qTitle =trim(Request("qTitle"))
	pageName = Request("pageName")
	if qaMode = "" then Call ShowAlertMsg("�߸��� ��η� ���ӿ����ϴ�.")
	if Len(qTitle) < 2 then Call ShowAlertMsg("������ ª���ϴ�.")


		'���� �׽�Ʈ
		'For Each item IN Request.Form
		'	Response.Write(item)
		'	Response.Write(" = ")
		'	Response.Write("ReplaceTo(Request(""") & item & """), ""toDB"")"
		'	'Response.Write(Request.Form(item))
		'	Response.Write("<br>")
		'Next
		'Response.end

		'������ ���� DB�� �°� �����Ͽ� ������ �����Ѵ�.
		'qaMode = ReplaceTo(Request("qaMode"), "toDB")
		userName = ReplaceTo(Request("userName"), "toDB")
		userPW = ReplaceTo(Request("userPW"), "toDB")
		userPhone = ReplaceTo(Request("userPhone"), "toDB")
		userEmail = ReplaceTo(Request("userEmail"), "toDB")
		qGroup = Request("qGroup")
		qService = ReplaceTo(Request("qService"), "toDB")
		qTitle = ReplaceTo(Request("qTitle"), "toDB")
		qContent = ReplaceTo(Request("qContent"), "toDB")

		'���� �����
		'if Session("sID") <> "" then SvcStaff = Session("sName")& "(" & Session("sID") & ")"
        'if active <> "Y" then active = "N"

		'�������� ����
		IPaddress = Request.Servervariables("REMOTE_ADDR")
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if qaMode = "qi" then		'�������Է�

		QAidxNext = NextNumber("vQuestion", "QAidx", "", 0)
		'DB�� �������׵��

		SQL = "INSERT INTO vQuestion(QAidx,MbrID,userName,userPW,userPhone,userEmail,qGroup,qService,qTitle,qContent,writeOutDT,IPaddress) "
		SQL = SQL & " VALUES(?,?,?,?,?,?,?,?,?,?,GetDate(),?)"
		'dbConn.BeginTrans
		Set Cmd = Server.CreateObject("ADODB.Command")
		With Cmd
			.ActiveConnection = dbConn
			.CommandText = SQL
			.CommandType = adCmdText
			.Parameters.Append Cmd.CreateParameter("@QAidx", adInteger, adParamInput, 4, QAidxNext)
			.Parameters.Append Cmd.CreateParameter("@MbrID", adVarChar, adParamInput, 15, Session("MbrID"))
			.Parameters.Append Cmd.CreateParameter("@userName", adVarChar, adParamInput, 20, userName)
			.Parameters.Append Cmd.CreateParameter("@userPW", adVarChar, adParamInput, 15, userPW)
			.Parameters.Append Cmd.CreateParameter("@userPhone", adVarChar, adParamInput, 50, userPhone)
			.Parameters.Append Cmd.CreateParameter("@userEmail", adVarChar, adParamInput, 50, userEmail)
			.Parameters.Append Cmd.CreateParameter("@qGroup", adVarChar, adParamInput, 50, qGroup)
			.Parameters.Append Cmd.CreateParameter("@qService", adVarChar, adParamInput, 50, qService)
			.Parameters.Append Cmd.CreateParameter("@qTitle", adVarChar, adParamInput, 200, qTitle)
			.Parameters.Append Cmd.CreateParameter("@qContent", adVarChar, adParamInput, 5000, qContent)
			.Parameters.Append Cmd.CreateParameter("@IPaddress", adVarChar, adParamInput, 15, IPaddress)
			'.Parameters.Append Cmd.CreateParameter("@bnOrder", adUnsignedSmallInt, adParamInput, 2, bnOrder)
			.Execute ,,adExecuteNoRecords
		end With
		Set Cmd = nothing
		'dbConn.CommitTrans
		alertMsg = "���������� �����Ǿ����ϴ�."
		pageName = pageName & "?qaMode=qv&QAidx=" & QAidxNext

	elseif qaMode = "qu" then	'������ ����
		if CInt(Session("sLevel4")) < 2  And  Session("MbrID") = "" And Session("userEmail") = "" then
			Call ShowAlertMsg("������ �����ϴ�.")
		end if
		QAidx = Request("QAidx")
		if QAidx = "" then Call ShowAlertMsg("�߸��� ��η� �����Ͽ����ϴ�.")
		qaStatusBit = Request("qaStatusBit")
		'ȸ���� �亯�� �ִ� ���� ���� �� ���� �������� ���ϰ� �Ѵ�.
		if PickUpValue("vAnswer", "QAidx", "QAidx = " & QAidx) <> "NoPickUp" then Call ShowAlertMsg("�亯�ִ� ���� ������ �� �����ϴ�.")

		'DB�� �ش���� ����.
		SQL = "UPDATE vQuestion Set userPW=?,userPhone=?,userEmail=?,qGroup=?,qService=?"
		SQL = SQL & " ,qTitle=?,qContent=?,IPaddress=? "
		SQL = SQL & " WHERE QAidx=? "
		'dbConn.BeginTrans
		Set Cmd = Server.CreateObject("ADODB.Command")
		With Cmd
			.ActiveConnection = dbConn
			.CommandText = SQL
			.CommandType = adCmdText
			'.Parameters.Append Cmd.CreateParameter("@MbrID", adVarChar, adParamInput, 15, Session("MbrID"))
			'.Parameters.Append Cmd.CreateParameter("@userName", adVarChar, adParamInput, 20, userName)
			.Parameters.Append Cmd.CreateParameter("@userPW", adVarChar, adParamInput, 15, userPW)
			.Parameters.Append Cmd.CreateParameter("@userPhone", adVarChar, adParamInput, 50, userPhone)
			.Parameters.Append Cmd.CreateParameter("@userEmail", adVarChar, adParamInput, 50, userEmail)
			.Parameters.Append Cmd.CreateParameter("@qGroup", adVarChar, adParamInput, 50, qGroup)
			.Parameters.Append Cmd.CreateParameter("@qService", adVarChar, adParamInput, 50, qService)
			.Parameters.Append Cmd.CreateParameter("@qTitle", adVarChar, adParamInput, 200, qTitle)
			.Parameters.Append Cmd.CreateParameter("@qContent", adVarChar, adParamInput, 5000, qContent)
			.Parameters.Append Cmd.CreateParameter("@IPaddress", adVarChar, adParamInput, 15, IPaddress)
			.Parameters.Append Cmd.CreateParameter("@QAidx", adInteger, adParamInput, 4, QAidx)
			.Execute ,,adExecuteNoRecords
		end With
		Set Cmd = nothing
		'dbConn.CommitTrans

		alertMsg = "���������� �����Ǿ����ϴ�"
		pageName = pageName & "?qaMode=qav&qaStatusBit=" & qaStatusBit & "&QAidx=" & QAidx

	else
		ShowAlertMsg("�ý������ �Դϴ�.")
	end if

	'�޼��������ְ� �������̵�
	Call GotoThePage(alertMsg, pageName)

%>

<%
    ' The Transacted Script Commit Handler.  This sub-routine
    ' will be called if the transacted script commits.
    Sub OnTransactionCommit()
		'Response.Write "<P><B>������Ʈ�� ���������� �̷�������ϴ�</B>."
    End Sub


    ' The Transacted Script Abort Handler.  This sub-routine
    ' will be called if the script transacted aborts
    Sub OnTransactionAbort()
    	'Call goMsgPage("DBerr")
		'Response.Write "<P><B>������Ʈ�� ����� �̷������ �ʾҽ��ϴ�</B>."
    End Sub
%>
