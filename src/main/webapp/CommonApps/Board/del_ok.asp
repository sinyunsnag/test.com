<!-- ShopSetting Start -->
	<!--#include File = "../../SiteSetting.asp" -->
<!-- ShopSetting End -->
<%
	'���⿡ ���
%>

<!-- #include File="BoardInfo_inc.asp" -->
<!-- #include File="../../Include_asp/fsBoard_inc.asp" -->



<%

	dim bNbr,mode,form_pin,MbrID,replyGrp,reSame,reID,updatesql,sql2,mem_auth,reply_ok
	dim fName,filename2,filename3,filename4,fs,po_write,po_comment

	page = Request.QueryString("page")
	mode = Request.QueryString("mode")


	dim cart_num	'�뷮����

	if mode="del_cart" and Request.Form("cart")="" then Response.Redirect "inc/error.asp?no=3"
	if mode="del_cart" then
		if CInt(Session("sLevel4")) < 2 then Response.Redirect "inc/error.asp?no=4"
		cart_num = Request.Form("cart").count
	else
		cart_num = 1
	end if

	i=1
	Do until i > cart_num

	if mode="del_cart" then
		bNbr = Request.Form("cart")(i)

		SQL="SELECT userPW FROM "&bBodyTable&" where bNbr="&bNbr
		Set rs = dbConn.Execute(SQL)

		form_pin = rs(0)
	else
		bNbr = Request.QueryString("bNbr")

		if Session("MbrID") <> "" and Request.QueryString("mem") = "ok" then
			SQL="SELECT MbrID,userPW FROM "&bBodyTable&" where bNbr="&bNbr
			Set rs = dbConn.Execute(SQL)

			if Session("MbrID") <> rs(0) and CInt(Session("sLevel4")) > 1 then
				Response.Redirect "inc/error.asp?no=4"
			end if
			form_pin = rs(1)
		else
			form_pin = Request.Form("form_pin")
		end if
	end if



	'�Խù� ���� ��������.
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	selectedFields = "MbrID,replyGrp,reSame,reID"
	whereClause = "bNbr=" & bNbr
	if (CInt(Session("sLevel4")) < 2) then
		whereClause = whereClause & " and userPW='" & form_pin & "'"
	end if
	orderBy = ""
	RSresult = SelectSimpleRecord(rs, selectedFields, bBodyTable, whereClause, orderBy)
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if RSresult = "NotEmpty" then
		MbrID = rs("MbrID")
		replyGrp = rs("replyGrp")
		reSame = rs("reSame")
		reID = rs("reID")
	else
		Response.Redirect "inc/error.asp?no=2" 'if rs.eof or rs.bof then
	end if	'if RSresult = "NotEmpty" then


	'��ϱ� ������ ������������
	SQL = "Select fName From " & bFilesTable & " Where bNbr=" & bNbr
	SQL = SQL & " Order by fOrder "
	RSresult = OpenSimpleRS(fRS,SQL)
	if RSresult <> "Empty" then
		Set fs = Server.CreateObject("Scripting.FileSystemObject")
		Do until fRS.EOF
			fName = fRS("fName")
			If fName <> "" Then
				fName = Server.MapPath("FileData")&"\"&bID&"\"& fName
				fs.DeleteFile(fName)
			End If
		    	fRS.Movenext
	    		'fNum = fNum + 1
  		Loop
  		set fs = Nothing
  		Call CloseRS(fRS)
  		'�ش����ϰ��� ���̺��ڵ� ����
  		Call DeleteRecord(bFilesTable, "bNbr = " & bNbr)
	end if	'if RSresult <> "Empty" then




	SQL="SELECT * FROM "&bBodyTable&" where replyGrp="&replyGrp&" and reSame > "&reSame&" and reID > "&reID
	Set rs = dbConn.Execute(SQL)

	if not rs.EOF then '���� ������� �ۿ� �亯���� �������..

		SQL="SELECT * FROM "&bBodyTable&" where replyGrp="&replyGrp&" and reSame > "&reSame&" and reID = "&reID+1
		Set rs=dbConn.Execute(SQL)

		if not rs.EOF then
			dim del_name
			if Session("MbrID")="admin" then
				del_name="������"
			else
				del_name="�ۼ���"
			end if

			UPDATESQL = "UPDATE "&bBodyTable&" set userPW = ''"
			UPDATESQL = UPDATESQL & ", userEmail = ''"
			UPDATESQL = UPDATESQL & ", homepage = ''"
			UPDATESQL = UPDATESQL & ", bTitle = '" & del_name & "�� ���� ���� �����Ǿ����ϴ�.'"
			UPDATESQL = UPDATESQL & ", link1 = ''"
			UPDATESQL = UPDATESQL & ", link2 = ''"
			UPDATESQL = UPDATESQL & ", bContent = '�� ���� "&del_name&"�� ���� ���� �����Ǿ����ϴ�." & vbCrLf & "�Ʒ��� �亯���� �־��� ������ ���������� ���� �ʾ����� �˷��帳�ϴ�." & vbCrLf & vbCrLf & "'"
			UPDATESQL = UPDATESQL & " where bNbr =  " & bNbr
			dbConn.Execute UPDATESQL
			reply_ok=1
		end if

	else 	'���� ������� �ۿ� �亯���� �������..
		reply_ok=0

		'�ش�Խù��� ���õ� Ŀ��Ʈ���̺��ڵ� ����
		Call DeleteRecord(bCmtTable, "bNbr = " & bNbr)

		UPDATESQL = "Update " & bBodyTable & " Set reID = reID-1 where  replyGrp = " & replyGrp & " and reID > " & reID
		dbConn.Execute UPDATESQL

		SQL2 = "DELETE FROM " & bBodyTable & " where bNbr ="&bNbr
		dbConn.Execute SQL2
	end if


	'��� ������ ����Ʈ �谨
	'if mem_auth > 0 then
	'	sql = "select po_write,po_comment from member where MbrID='"&MbrID&"'"
	'	Set rs= dbConn.Execute(SQL)
     '
	'	po_write=rs(0)
	'	po_comment=rs(1)
     '
	'	if reply_ok <> 1 and po_write > 0 then
	'		SQL = "Update member set po_write=po_write-1,point=point-10 where MbrID='"&MbrID&"'"
	'		db.execute SQL
	'	end if
	'end if

	'	dim j,com_count,com_name,rs2
	'	sql = "select count(com_num) from inno_comment where com_num=" & bNbr
	'	Set rs= dbConn.Execute(SQL)
     '
	'	com_count=rs(0)
     '
     '
	'	j=1
	'	Do until j > com_count
     '
	'	SQL2 = "SELECT com_mem_id FROM inno_comment where com_num=" & bNbr &" and com_id="&j
	'		Set rs2= dbConn.Execute(sql2)
	'		if rs2(0) <> "" and po_comment > 0 then
	'			SQL = "Update member set po_comment=po_comment-1,point=point-5 where MbrID='"&rs2(0)&"'"
	'			db.execute SQL
	'		end if
	'		j=j+1
	'	loop

		'�ش�Խù��� ���õ� Ŀ��Ʈ���̺��ڵ� ����
		Call DeleteRecord(bCmtTable, "bNbr = " & bNbr)

		i=i+1
	loop

	Call CloseRS(Rs)

	Response.Redirect "bList.asp?bID="&bID
%>