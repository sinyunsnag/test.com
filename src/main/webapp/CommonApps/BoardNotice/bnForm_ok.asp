<%@ TRANSACTION = Required LANGUAGE = "VBScript" %>
<% ' �� ��Ŭ��带 ���Խ�Ų��. %>
<!-- caSetting Start -->
	<!--#include File = "../caSetting.asp" -->
<!-- caSetting  End -->

<script language="JavaScript" src="../../Include_js/CommonFunctions.js"></script>
<script language="JavaScript" src="../../Include_js/Function.js"></script>

<%


	'������ ���� üũ
	if Session("sLevel4") < 3 then Call ShowAlertMsgClose("������ �ٽ� üũ�ϼ���.")

	'bnMode �������� ���Է����� Ȯ��
	bnMode = Request("bnMode")
	bnTitle =trim(Request("bnTitle"))

	if bnMode = "" then Call ShowAlertMsgClose("�߸��� ��η� ���ӿ����ϴ�.")
	if Len(bnTitle) < 2 then Call ShowAlertMsg("������ ª���ϴ�.")
		
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
		bnMode = ReplaceTo(Request("bnMode"), "toDB")
		bnIdx = ReplaceTo(Request("bnIdx"), "toDB")
		bnGroup = ReplaceTo(Request("bnGroup"), "toDB")
		bnService = ReplaceTo(Request("bnService"), "toDB")
		bnTitle = ReplaceTo(Request("bnTitle"), "toDB")
		bnSubTitle = ReplaceTo(Request("bnSubTitle"), "toDB")
		bnContent = ReplaceTo(Request("bnContent"), "toDB")
		bnOrder = Request("bnOrder")

		'���� �����
		if Session("sID") <> ""	then SvcStaff = Session("sName")& "(" & Session("sID") & ")"
		if bnOrder = "" And not IsNumeric(bnOrder) then Call ShowAlertMsgClose("�������� �߸��ƽ��ϴ�.")
		'if active <> "Y" then active = "N"


	if bnMode = "i" then		'�������Է�
		
		'�������� ����
		'IPaddress = Request.Servervariables("REMOTE_ADDR")

		bnIdxNext = NextNumber("vBoardNotice", "bnIdx", "", 0)
		'�������׵��
		'DB�� �ش���� �Է�.
		SQL = "INSERT INTO vBoardNotice(bnIdx,SvcStaff,bnGroup,bnService,bnTitle,bnSubTitle,bnContent,viewCount,noticeDT,bnOrder) "
		SQL = SQL & " VALUES(?,?,?,?,?,?,?,0,GetDate(),?)"
		'dbConn.BeginTrans
		Set Cmd = Server.CreateObject("ADODB.Command")
		With Cmd
			.ActiveConnection = dbConn
			.CommandText = SQL
			.CommandType = adCmdText
			.Parameters.Append Cmd.CreateParameter("@bnIdx", adInteger, adParamInput, 4, bnIdxNext)
			.Parameters.Append Cmd.CreateParameter("@SvcStaff", adVarChar, adParamInput, 40, SvcStaff)
			.Parameters.Append Cmd.CreateParameter("@bnGroup", adVarChar, adParamInput, 50, bnGroup)
			.Parameters.Append Cmd.CreateParameter("@bnService", adVarChar, adParamInput, 50, bnService)
			.Parameters.Append Cmd.CreateParameter("@bnTitle", adVarChar, adParamInput, 250, bnTitle)
			.Parameters.Append Cmd.CreateParameter("@bnSubTitle", adVarChar, adParamInput, 250, bnSubTitle)
			.Parameters.Append Cmd.CreateParameter("@bnContent", adVarChar, adParamInput, 8000, bnContent)
			.Parameters.Append Cmd.CreateParameter("@bnOrder", adUnsignedSmallInt, adParamInput, 2, bnOrder)
			.Execute ,,adExecuteNoRecords
		end With
		Set Cmd = nothing
		'dbConn.CommitTrans


		alertMsg = "���ο� �ڷḦ �Է��Ͽ����ϴ�."

	elseif bnMode = "u" then	'������ ����

		'DB�� �ش���� ����.
		SQL = "UPDATE vBoardNotice Set SvcStaff=?,bnGroup=?,bnService=?,bnTitle=?,bnSubTitle=?,bnContent=? "
		SQL = SQL & " ,modifyDT=GetDate(),bnOrder=?"
		SQL = SQL & " WHERE bnIdx=? "
		'dbConn.BeginTrans
		Set Cmd = Server.CreateObject("ADODB.Command")
		With Cmd
			.ActiveConnection = dbConn
			.CommandText = SQL
			.CommandType = adCmdText
			.Parameters.Append Cmd.CreateParameter("@SvcStaff", adVarChar, adParamInput, 40, SvcStaff)
			.Parameters.Append Cmd.CreateParameter("@bnGroup", adVarChar, adParamInput, 50, bnGroup)
			.Parameters.Append Cmd.CreateParameter("@bnService", adVarChar, adParamInput, 50, bnService)
			.Parameters.Append Cmd.CreateParameter("@bnTitle", adVarChar, adParamInput, 250, bnTitle)
			.Parameters.Append Cmd.CreateParameter("@bnSubTitle", adVarChar, adParamInput, 250, bnSubTitle)
			.Parameters.Append Cmd.CreateParameter("@bnContent", adVarChar, adParamInput, 8000, bnContent)
			.Parameters.Append Cmd.CreateParameter("@bnOrder", adUnsignedSmallInt, adParamInput, 2, bnOrder)
			.Parameters.Append Cmd.CreateParameter("@bnIdx", adInteger, adParamInput, 4, bnIdx)
			.Execute ,,adExecuteNoRecords
		end With
		Set Cmd = nothing
		'dbConn.CommitTrans

		alertMsg = "�����Ͱ� �����Ǿ����ϴ�"

	else
		Call ShowAlertMsgClose("�ý������ �Դϴ�.")
	end if

	'�޼��������ְ�/�θ����������ε�/�ڱ��ڽ�â�ݱ�
	Call ShowAlertMsgClose(alertMsg)

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
