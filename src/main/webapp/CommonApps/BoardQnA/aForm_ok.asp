<%@ TRANSACTION = Required LANGUAGE = "VBScript" %>
<!-- caSetting Start -->
	<!--#include File = "../caSetting.asp" -->
<!-- caSetting  End -->
<script language="JavaScript" src="../../Include_js/CommonFunctions.js"></script>
<script language="JavaScript" src="../../Include_js/Function.js"></script>

<%

	if CInt(Session("sLevel4")) < 2 then
		Call ShowAlertMsg("������ �����ϴ�.")
	end if


	'qaMode �������� ���Է����� Ȯ��(�̰� �������� ����)
	qaMode = Request("qaMode")
	QAidx = Request("QAidx")
	aTitle =trim(Request("aTitle"))
	pageName = Request("pageName")

	if qaMode = "" Or QAidx = "" then Call ShowAlertMsg("�߸��� ��η� ���ӿ����ϴ�.")
	if Len(aTitle) < 2 then Call ShowAlertMsg("������ ª���ϴ�.")


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
		SvcStaff = Request("SvcStaff")
		aTitle = ReplaceTo(Request("aTitle"), "toDB")
		aContent = ReplaceTo(Request("aContent"), "toDB")

		'���� �����
		'if Session("sID") <> "" then SvcStaff = Session("sName")& "(" & Session("sID") & ")"

		'�������� ����
		IPaddress = Request.Servervariables("REMOTE_ADDR")
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if qaMode = "ai" then		'�������Է�

		'DB�� �亯���׵��
		SQL = "INSERT INTO vAnswer(QAidx,SvcStaff,aTitle,aContent,writeOutDT,IPaddress) "
		SQL = SQL & " VALUES(?,?,?,?,GetDate(),?)"
		'dbConn.BeginTrans
		Set Cmd = Server.CreateObject("ADODB.Command")
		With Cmd
			.ActiveConnection = dbConn
			.CommandText = SQL
			.CommandType = adCmdText
			.Parameters.Append Cmd.CreateParameter("@QAidx", adInteger, adParamInput, 4, QAidx)
			.Parameters.Append Cmd.CreateParameter("@SvcStaff", adVarChar, adParamInput, 50, SvcStaff)
			.Parameters.Append Cmd.CreateParameter("@aTitle", adVarChar, adParamInput, 200, aTitle)
			.Parameters.Append Cmd.CreateParameter("@aContent", adVarChar, adParamInput, 5000, aContent)
			.Parameters.Append Cmd.CreateParameter("@IPaddress", adVarChar, adParamInput, 15, IPaddress)
			'.Parameters.Append Cmd.CreateParameter("@bnOrder", adUnsignedSmallInt, adParamInput, 2, bnOrder)
			.Execute ,,adExecuteNoRecords
		end With
		Set Cmd = nothing
		'dbConn.CommitTrans
		alertMsg = "�亯������ �ԷµǾ����ϴ�."
		'pageName = pageName & "?qaMode=qav&QAidx=" & QAidx

	elseif qaMode = "au" then	'������ ����

		'DB�� �ش���� ����.
		SQL = "UPDATE vAnswer Set SvcStaff=?,aTitle=?,aContent=?,IPaddress=? "
		SQL = SQL & " WHERE QAidx=? "
		'dbConn.BeginTrans
		Set Cmd = Server.CreateObject("ADODB.Command")
		With Cmd
			.ActiveConnection = dbConn
			.CommandText = SQL
			.CommandType = adCmdText
			.Parameters.Append Cmd.CreateParameter("@SvcStaff", adVarChar, adParamInput, 50, SvcStaff)
			.Parameters.Append Cmd.CreateParameter("@aTitle", adVarChar, adParamInput, 200, aTitle)
			.Parameters.Append Cmd.CreateParameter("@aContent", adVarChar, adParamInput, 5000, aContent)
			.Parameters.Append Cmd.CreateParameter("@IPaddress", adVarChar, adParamInput, 15, IPaddress)
			.Parameters.Append Cmd.CreateParameter("@QAidx", adInteger, adParamInput, 4, QAidx)
			.Execute ,,adExecuteNoRecords
		end With
		Set Cmd = nothing
		'dbConn.CommitTrans

		alertMsg = "�亯������ �����Ǿ����ϴ�"


	else
		ShowAlertMsg("�ý������ �Դϴ�.")
	end if

	'�޼��������ְ� �������̵�
	pageName = pageName & "?qaMode=qav&qaStatusBit=1&QAidx=" & QAidx
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
