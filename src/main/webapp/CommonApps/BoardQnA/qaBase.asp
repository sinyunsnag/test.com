<% ' �� ��Ŭ��带 ���ø� ��ܵ� ���Խ�Ų��. %>
<!-- caSetting Start -->
	<!--# include File = "../caSetting.asp" -->
<!-- caSetting  End -->
<base href="<%= Application("SiteURLDir") %>CommonAccessories/BoardQnA/" target="_self">
<script language="JavaScript" src="qa_inc.js"></script>

<%
	'qaMode = qi, qu, qd, qv, vali, li, qav, ai, au, ad, av
	qaMode = Request("qaMode")

	'�ʱⰪ
	'gotoURL = Request.ServerVariables("PATH_INFO")
	pageName = Request.ServerVariables("PATH_INFO")
	if qaMode = "" then qaMode="qi"
%>


<!--- User �Է� �� ���� ��  ---->
<%
		if qaMode = "qi" or qaMode = "qu" then
%>
<!-- qForm Start -->
	<!--#include File = "qForm.asp" -->
<!-- qForm  End -->
<%
		end if 	'if qaMode = "qi" or qaMode = "qu" then
%>
<!--- User �Է� �� ���� �� (End) ---->




<!--- User ��������  ---->
<%
		if qaMode = "qv" then
%>
<!-- qView Start -->
	<!--#include File = "qView.asp" -->
<!-- qView  End -->
<%
		end if 	'if qaMode = "i" then
%>
<!--- User �������� (End) ---->



<!--- User �����ϱ�  ---->
<%
		if qaMode = "vali" then
%>
<!-- qaValidate Start -->
	<!--#include File = "qaValidate.asp" -->
<!-- qaValidate  End -->
<%
		end if 	'if qaMode = "i" then
%>
<!--- User �����ϱ� (End) ---->




<!------- QnA List ------>
<%
		if qaMode = "li" then
%>
<!-- qaList Start -->
	<!--#include File = "qaList.asp" -->
<!-- qaList  End -->
<%
		end if 	'if qaMode = "i" then
%>
<!--- QnA List (End) ---->




<!------- q/a view ------>
<%
		if qaMode = "qav" then
%>
<!-- qView Start -->
	<!--#include File = "qView.asp" -->
<!-- qView  End -->
<!-- aView Start -->
	<!--#include File = "aView.asp" -->
<!-- aView  End -->
<%
		end if 	'if qaMode = "qav" then
%>
<!--- q/a view (End) ---->



<!--- ������ �Է� �� ���� ��  ---->
<%
		if qaMode = "ai" or qaMode = "au" then
%>
<!-- aForm Start -->
	<!--#include File = "aForm.asp" -->
<!-- aForm End -->
<%
		end if 	'if qaMode = "ai" or qaMode = "au" then
%>
<!--- ������ �Է� �� ���� �� (End) ---->

