<%@ TRANSACTION = Required LANGUAGE = "VBScript" %>
<!-- Header Start -->
	<!--#include File="../AdminHeader.asp"-->
<!-- Header End -->

<%
	MbrID = trim(request("MbrID"))
	'Validation Check
	if MbrID="" or Session("sLevel4")<3 then Call ShowAlertMsg("������ Ȯ���ϼ���")
	
	SQL = "UPDATE [vMbrHiddenValue] SET "
	SQL = SQL & " missYouDT = getdate() "
	SQL = SQL & " where MbrID = '" & MbrID & "'"
	dbConn.Execute SQL

	
	'������ ����Ÿ����
	Call GotoThePage("���������� ������ �����߽��ϴ�.", "MbrList.asp?refl=600")

%>

<%
    ' The Transacted Script Commit Handler.  This sub-routine
    ' will be called if the transacted script commits.
    Sub OnTransactionCommit()
		Response.Write "<P><B>������Ʈ�� ���������� �̷�������ϴ�</B>."
    End Sub


    ' The Transacted Script Abort Handler.  This sub-routine
    ' will be called if the script transacted aborts
    Sub OnTransactionAbort()
   		Call goMsgPage("DBerr")
		'Response.Write "<P><B>������Ʈ�� ����� �̷������ �ʾҽ��ϴ�</B>."
    End Sub
%>


<!-- Footer Start -->
	<!--#include File="../AdminFooter.asp"-->
<!-- Footer End -->
