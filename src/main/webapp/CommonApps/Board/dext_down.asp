<!-- Config Start -->
	<!--#include File = "../../Config/Config.asp" -->
<!-- Config End -->

<!-- DB Connection -->
	<!--#include File = "../../Config/Connection/DBconnection.asp" -->
<!-- DB Connection -->

<!-- Function Start -->
	<!--#include File= "../../Include_asp/CommonFunctions.asp"-->
	<!--#include File="../../Include_asp/Functions.asp"-->
<!-- Function End -->

<% 
	Response.Clear()	'�� �ּ�ó��������...
	Response.Buffer = False 
%>


<%
	'����Ʈ�� ������� ������������ �˾ƺ���.
	Call SiteRun()
%>

<!-- #include File="BoardInfo_inc.asp" -->
<!-- #include File="../../Include_asp/fsBoard_inc.asp" -->
<%

	bID=Request.QueryString("bID")
	bNbr=Request.QueryString("bNbr")
	mode=Request.QueryString("mode")
	fOrder=Request.QueryString("fOrder")

	Call ChangeStatus(bFilesTable, "fDLcount=fDLcount+1", "bNbr=" & bNbr & " And fOrder=" & fOrder)
	fName = PickUpValue(bFilesTable, "fName", "bNbr=" & bNbr & " And fOrder=" & fOrder)
%>
<%
	user_agent = Request.ServerVariables("HTTP_USER_AGENT")
	If InStr(user_agent, "MSIE") > 0 Then
	    'IE 5.0�� ���.
	    If InStr(user_agent, "MSIE 5.0") > 0 Then
	        content_disp = "inline;filename="
	        contenttype = "application/x-msdownload"
	    'IE 5.0�� �ƴ� ���.
	    Else
	        content_disp = "inline;filename="
	        contenttype = "application/unknown"
	    End If
	Else
	    'Netscape�� ��Ÿ �������� ���.
	    content_disp = "attachment;filename="
	    contenttype = "application/unknown"
	End If

	filepath = Server.MapPath("FileData")&"\"&bID&"\"& fName

	Response.AddHeader "Content-Disposition", content_disp & fName
	set objFS = Server.CreateObject("Scripting.FileSystemObject")
	set objF = objFS.GetFile(filepath)
	Response.AddHeader "Content-Length", objF.Size
	set objF = nothing
	set objFS = nothing
	Response.ContentType = contenttype
	Response.CacheControl = "public"

	Set objDownload = Server.CreateObject("DEXT.FileDownload")
	objDownload.Download filepath
	Set objDownload = Nothing

%>