<!-- caSetting Start -->
	<!--#include File = "../caSetting.asp" -->
<!-- caSetting  End -->
<%
	qaMode = Request.Form("qaMode")
	gotoURL = Request("gotoURL")
	
	if qaMode = "nmLogin" then
	
		userEmail = trim(Request.Form("userEmail"))
		userPW = trim(Request.Form("userPW"))
		
		if Len(userEmail) < 3 Or Len(userPW) < 1 then Call ShowAlertMsg("�����ּҿ� �н����带 Ȯ���ϼ���")
			
		if PickUpValue("vQuestion", "QAidx", "userEmail = '" & userEmail & "' And userPW='" & userPW & "'") = "NoPickUp" then 
			Call ShowAlertMsg("������ ������ �����ϴ�.")
		end if
		''''''''''''''''''''''''''''''''''''''''����'''''''''''''''''''''''''''''''''''''
		Session("userEmail") = userEmail
		Session("userPW") = userPW
		gotoURL	= gotoURL & "?qaMode=li"

	else
		Session("userEmail") = ""
		Session("userPW") = ""
		gotoURL	= gotoURL & "?qaMode=vali"
	end if	'if qaMode = "nmLogin" then

		'���� �������ΰ�?
		Response.Redirect(gotoURL)
	
%>

<% 
	'Server.Execute(Application("SiteRoot") & "Admin/Statistics/statsEngine.asp") 
	Call CloseDB()
%>

