<%@ TRANSACTION = Required LANGUAGE = "VBScript" %>
<!-- caSetting Start -->
	<!--#include File = "../caSetting.asp" -->
<!-- caSetting  End -->

<%
	
	'Validation Check			
	qaMode = Request("qaMode")
	QAidx = Request("QAidx")
	gotoURL = Request.QueryString("gotoURL")
	'�����κ�
	if qaMode = "" Or QAidx = "" Or gotoURL = "" then Call ShowAlertMsg("�߸��� ��η� �����Ͽ����ϴ�.")
	

	
	if qaMode = "qd" then	'��������
		'����
		'if  CInt(Session("sLevel4")) < 2  And Session("MbrID") = ""  And  Session("userEmail") = "" then
		'	Call ShowAlertMsg("�߸��� ��η� �����Ͽ����ϴ�.")
		'end if
		if CInt(Session("sLevel4")) > 1 then		'�������̹Ƿ� ������ �����Ѵ�.
			'�ش������� �亯�� �ִٸ� ����
			Call DeleteRecord("vAnswer", "QAidx = " & QAidx)
			Call DeleteRecord("vQuestion", "QAidx = " & QAidx)
			alertMsg = "�ش������� �亯�� �����Ͽ����ϴ�."
		elseif Session("MbrID") <> "" Or Session("userEmail") <> "" then
			'ȸ���� �亯�� �ִ� ���� ���� �� ���� �������� ���ϰ� �Ѵ�.
			if PickUpValue("vAnswer", "QAidx", "QAidx = " & QAidx) <> "NoPickUp" then ShowAlertMsg("�亯�ִ� ���� ������ �� �����ϴ�.")
			Call DeleteRecord("vQuestion", "QAidx = " & QAidx)
			alertMsg = "�ش������� �����Ͽ����ϴ�."
		else 
			Call ShowAlertMsg("�߸��� ��η� �����Ͽ����ϴ�.")
		end if		'if CInt(Session("sLevel4")) < 2 then

		gotoURL = gotoURL & "?qaMode=li"
	elseif qaMode = "ad" then	'�亯����
		'����
		if CInt(Session("sLevel4")) < 2 then  
			Call ShowAlertMsg("������ �� �ִ� ������ �۽��ϴ�.")
		end if
		Call DeleteRecord("vAnswer", "QAidx = " & QAidx)
		alertMsg = "�亯�� �����Ͽ����ϴ�."

		gotoURL = gotoURL & "?qaMode=qav&qaStatusBit=0&QAidx=" & QAidx
	else
		Call ShowAlertMsg("�߸��� ��η� �����Ͽ����ϴ�.")
	end if		'if qaMode = "qd" then

	'�޼��������ְ� �������̵�
	
	Call GotoThePage(alertMsg, gotoURL)

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

