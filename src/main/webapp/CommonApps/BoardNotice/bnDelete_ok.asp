<%@ TRANSACTION = Required LANGUAGE = "VBScript" %>
<!-- caSetting Start -->
	<!--#include File = "../caSetting.asp" -->
<!-- caSetting  End -->

<%
	
	'Validation Check
	if CInt(Session("sLevel4")) < 3 then  
		Call GotoThePage("������ �۽��ϴ�. �ٽ� �α����ϼ���.", "../../Admins/Staff/LoginBoxForStaff/LoginBoxForStaff.asp?gotoURL=" & gotoURL)
	end if
	
	bnIdx = CInt(request("bnIdx"))


	'����Ÿ����
	Call DeleteRecord("vBoardNotice", "bnIdx = " & bnIdx)

	'�޼��������ְ�/�θ����������ε�/�ڱ��ڽ�â�ݱ�
	Call ShowAlertMsgClose("�ش絥���Ͱ� ���������� �����ƽ��ϴ�.")


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
    	'Call goMsgPage("DBerr")
		'Response.Write "<P><B>������Ʈ�� ����� �̷������ �ʾҽ��ϴ�</B>."
    End Sub
%>

