<%@ TRANSACTION="Required" LANGUAGE="VBScript" CODEPAGE="949" %>
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
	On Error Resume Next

	dim bbs,bNbr,userPW,mode
	dim allfile,allfile1,allfile2,allfile3,allfile4,test
	dim userName,bTitle,userEmail,homepage,secretPW,link1,link2,IPaddress,notice,tagHTML,secret,replyEmail,writeday
	dim filesize1,filesize_ok,fs,strname,strext,strext_1,strfilename1,aname1,filename1,oldfilename1
	dim filesize2,strfilename2,aname2,filename2,oldfilename2
	dim filesize3,strfilename3,aname3,filename3,oldfilename3
	dim filesize4,strfilename4,aname4,filename4,oldfilename4
	dim i_width1,i_height1,i_width2,i_height2,i_width3,i_height3,i_width4,i_height4



	'DefaultPath�� ������ ���� EveryOne �б�, ����, ���� ������ �־�� �մϴ�.
	'�׷��� DEXTUpload ��ü ������ DefaultPath�� ���� ������ �����ø� C:\ �� ���� �ϰ� �˴ϴ�.
	'C:\�� EveryOne ������ �ֽðų� �Ǵ� DefaultPath�� ���� ���ֽð� �װ��� ������ �ֽø� �˴ϴ�.
	Set bbs = Server.CreateObject("DEXT.FileUpload")
	'bbs.DefaultPath = "C:\"
	bID = bbs.form("bID")

%>

<!-- #include File="BoardInfo_inc.asp" -->
<!-- #include File="../../Include_asp/fsBoard_inc.asp" -->


<%


	if maxsize <> "" then
		maxsize = maxsize * 1024000		'���� ��ƾ(M������ ��ȯ)
	else
		Set Rs = dbConn.Execute("Select maxsize From vBoardUpload Where bID='"&bID&"'")
		maxsize = Rs(0)*1024000
		Rs.Close
	end if

	bbs.DefaultPath = Server.MapPath("FileData")&"\"&bID&"\"
	bbs.UploadTimeout = 3600

	bNbr = bbs("bNbr")
	page = bbs("page")
	mode = bbs("mode")

	if Session("MbrID") <> "" then
		userPW = PickUpValue("vMember", "MbrID", "MbrID = '" & Session("MbrID") & "'")
	else
		userPW = bbs("userPW")
		if Trim(userPW)="" then	Response.Redirect "inc/error.asp?no=11"
	end if	'if Session("MbrID") <> "" then

	set allfile1 = bbs("allfile1")(1)
	if upFormCnt > 1 then set allfile2 = bbs("allfile2")(1)
	if upFormCnt > 2 then set allfile3 = bbs("allfile3")(1)
	if upFormCnt > 3 then set allfile4 = bbs("allfile4")(1)


%>

<script LANGUAGE="VBScript" RUNAT="Server">
Function CheckWord(CheckValue)
	CheckValue = replace(CheckValue, "&" , "&amp;")
	CheckValue = replace(CheckValue, "<", "&lt;")
	CheckValue = replace(CheckValue, ">", "&gt;")
	CheckValue = replace(CheckValue, "'", "''")
	CheckWord=CheckValue
End Function
</script>

<%
	dim strext_error,strext_img

	strext_error = "asp,aspx,php,php3,php4,cgi,asa"
	strext_img = "jpg,jpeg,gif,pcx,bmp"
%>

<%
	' DEXT ���ε� ���ۺκ� 1
	If allfile1<>"" Then '���ε��� ������ �ִٸ�
		filesize1=allfile1.FileLen
		if filesize1 < maxsize then
			filesize_ok = "ok"

			if bbs("oldfilename1")<>"" then
				oldfilename1 = Server.MapPath("FileData")&"\"&bID&"\"& bbs("oldfilename1")		'�տ��� ���� ������ �ҷ��ͼ�..
				bbs.DeleteFile oldfilename1			'�� ������ �����Ѵ�.
				fOldName1 = Mid(oldfilename1, instrRev(oldfilename1, "\") + 1)
			end if

			Set fs = Server.CreateObject("Scripting.FileSystemObject")
			filename1 = allfile1.FileName								'�����̸��� ���Ѵ�.
			strname = mid(filename1, 1 , instrrev(filename1,".")-1)	'���ϸ��� ���Ѵ�.
			strext = Lcase(Mid(filename1, InstrRev(filename1, ".") + 1))'Ȯ������ ���Ѵ�.

			if Instr(strext_error,right(Lcase(strext),3)) > 0 then
				Response.Redirect "inc/error.asp?no=12&strext="&strext	'���� Ȯ���ڸ� ���� ������ ���ε� �ɰ�� �����޼��� ���.
			End if

			if Instr(strext_img,right(Lcase(strext),3)) > 0 then
				i_w1 = allfile1.imagewidth
				i_h1 = allfile1.imageheight
			else
				i_w1 = 0
				i_h1 = 0
			End if

			strfilename1 = bbs.DefaultPath & filename1
			aname1=bbs("allfile1").Saveas(strfilename1,false)
			filename1= Mid(aname1, InstrRev(aname1, "\") + 1)

			Set fs=Nothing

			if bbs("oldfilename1")<>"" then
				SQL = "Update " & bFilesTable &" set fName = '" & filename1 & "'"
				SQL = SQL & ",fSize = " & filesize1
				SQL = SQL & ",fOldName ='" & fOldName1 & "'"
				SQL = SQL & ",fDLcount = 0 "
				SQL = SQL & " where bNbr = " & bNbr
				SQL = SQL & " And fOrder = 1"
				dbConn.Execute SQL
			end if

		else	'������ Ŭ���
			Response.Redirect "inc/error.asp?no=10"
		end if
	else	'If allfile1<>"" Then '���ε��� ������ ���ٸ�.
		if mode <> "edit" then
			filename1=""
			filesize1=""
			i_w1 = 0
			i_h1 = 0
		else
			if bbs("del_file1") = "1" then
				oldfilename1 = Server.MapPath("FileData")&"\"&bID&"\"&bbs("oldfilename1")		'�տ��� ���� ������ �ҷ��ͼ�..
				bbs.DeleteFile oldfilename1										'�� ������ �����Ѵ�.
				filename1=""
				filesize1=""
				i_w1 = 0
				i_h1 = 0
				Call DeleteRecord(bFilesTable, "bNbr = " & bNbr & " And fOrder=1")
			else
				filename1=bbs("oldfilename1")
				filesize1=bbs("oldfilesize1")
				i_w1 = bbs("i_w1")
				i_h1 = bbs("i_h1")
			end if
		end if
	end if
	' DEXT ���ε� ���κ�
%>
<%
	' DEXT ���ε� ���ۺκ� 2
	If allfile2<>"" Then '���ε��� ������ �ִٸ�
		filesize2=allfile2.FileLen
		if filesize2 < maxsize then
			filesize_ok = "ok"

			if bbs("oldfilename2")<>"" then
				oldfilename2 = Server.MapPath("FileData")&"\"&bID&"\"&bbs("oldfilename2")		'�տ��� ���� ������ �ҷ��ͼ�..
				bbs.DeleteFile oldfilename2											'�� ������ �����Ѵ�.
				fOldName2 = Mid(oldfilename2, instrRev(oldfilename2, "\") + 1)
			end if

			Set fs = Server.CreateObject("Scripting.FileSystemObject")
			bbs.DefaultPath = Server.MapPath("FileData")&"\"&bID&"\"				'������ ����� ���
			filename2 = allfile2.FileName								'�����̸��� ���Ѵ�.
			strname = mid(filename2, 1 , instrrev(filename2,".")-1)	'���ϸ��� ���Ѵ�.
			strext = Lcase(Mid(filename2, InstrRev(filename2, ".") + 1))'Ȯ������ ���Ѵ�.

			if Instr(strext_error,right(Lcase(strext),3)) > 0 then
				Response.Redirect "inc/error.asp?no=12&strext="&strext	'���� Ȯ���ڸ� ���� ������ ���ε� �ɰ�� �����޼��� ���.
			End if

			if Instr(strext_img,right(Lcase(strext),3)) > 0 then
				i_w2 = allfile2.imagewidth
				i_h2 = allfile2.imageheight
			else
				i_w2 = 0
				i_h2 = 0
			End if

			strfilename2 = bbs.DefaultPath & filename2

			aname2=bbs("allfile2").Saveas(strfilename2,false)

			filename2= Mid(aname2, InstrRev(aname2, "\") + 1)

			Set fs=Nothing

		if bbs("oldfilename2")<>"" then
			SQL = "Update " & bFilesTable &" set fName = '" & filename2 & "'"
			SQL = SQL & ",fSize = " & filesize2
			SQL = SQL & ",fOldName ='" & fOldName2 & "'"
			SQL = SQL & ",fDLcount = 0 "
			SQL = SQL & " where bNbr = " & bNbr
			SQL = SQL & " And fOrder = 2"
			dbConn.Execute SQL
		end if

		else
			Response.Redirect "inc/error.asp?no=10"
		end if

	else

		if mode <> "edit" then
			filename2=""
			filesize2=""
			i_w2 = 0
			i_h2 = 0
		else
			if bbs("del_file2") = "1" then
				if bbs("oldfilename2") <> "" then
					oldfilename2 = Server.MapPath("FileData")&"\"&bID&"\"&bbs("oldfilename2")		'�տ��� ���� ������ �ҷ��ͼ�..
					bbs.DeleteFile oldfilename2							'�� ������ �����Ѵ�.
					filename2=""
					filesize2=""
					i_w2 = 0
					i_h2 = 0
				end if
				Call DeleteRecord(bFilesTable, "bNbr = " & bNbr & " And fOrder=2")
			else
				filename2=bbs("oldfilename2")
				filesize2=bbs("oldfilesize2")
				i_w2 = bbs("i_w2")
				i_h2 = bbs("i_h2")
			end if
		end if
	end if

	' DEXT ���ε� ���κ�
%>
<%
	' DEXT ���ε� ���ۺκ� 3
	If allfile3<>"" Then '���ε��� ������ �ִٸ�

		filesize3=allfile3.FileLen

		if filesize3 < maxsize then

			filesize_ok = "ok"

			if bbs("oldfilename3")<>"" then
				oldfilename3 = Server.MapPath("FileData")&"\"&bID&"\"&bbs("oldfilename3")		'�տ��� ���� ������ �ҷ��ͼ�..
				bbs.DeleteFile oldfilename3											'�� ������ �����Ѵ�.
				fOldName3 = Mid(oldfilename3, instrRev(oldfilename3, "\") + 1)
			end if

			Set fs = Server.CreateObject("Scripting.FileSystemObject")
			bbs.DefaultPath = Server.MapPath("FileData")&"\"&bID&"\"				'������ ����� ���
			filename3 = allfile3.FileName								'�����̸��� ���Ѵ�.
			strname = mid(filename3, 1 , instrrev(filename3,".")-1)	'���ϸ��� ���Ѵ�.
			strext = Lcase(Mid(filename3, InstrRev(filename3, ".") + 1))'Ȯ������ ���Ѵ�.

			if Instr(strext_error,right(Lcase(strext),3)) > 0 then
				Response.Redirect "inc/error.asp?no=12&strext="&strext	'���� Ȯ���ڸ� ���� ������ ���ε� �ɰ�� �����޼��� ���.
			End if

			if Instr(strext_img,right(Lcase(strext),3)) > 0 then
				i_w3 = allfile3.imagewidth
				i_h3 = allfile3.imageheight
			else
				i_w3 = 0
				i_h3 = 0
			End if

			strfilename3 = bbs.DefaultPath & filename3


			aname3=bbs("allfile3").Saveas(strfilename3,false)


			filename3= Mid(aname3, InstrRev(aname3, "\") + 1)

			Set fs=Nothing

		if bbs("oldfilename3")<>"" then
			SQL = "Update " & bFilesTable &" set fName = '" & filename3 & "'"
			SQL = SQL & ",fSize = " & filesize3
			SQL = SQL & ",fOldName ='" & fOldName3 & "'"
			SQL = SQL & ",fDLcount = 0 "
			SQL = SQL & " where bNbr = " & bNbr
			SQL = SQL & " And fOrder = 3"
			dbConn.Execute SQL
		end if


		else
			Response.Redirect "inc/error.asp?no=10"
		end if

	else
		if mode <> "edit" then
			filename3=""
			filesize3=""
			i_w3 = 0
			i_h3 = 0
		else
			if bbs("del_file3") = "1" then
				oldfilename3 = Server.MapPath("FileData")&"\"&bID&"\"&bbs("oldfilename3")		'�տ��� ���� ������ �ҷ��ͼ�..
				bbs.DeleteFile oldfilename3										'�� ������ �����Ѵ�.
				filename3=""
				filesize3=""
				i_w3 = 0
				i_h3 = 0
				Call DeleteRecord(bFilesTable, "bNbr = " & bNbr & " And fOrder=3")
			else
				filename3=bbs("oldfilename3")
				filesize3=bbs("oldfilesize3")
				i_w3 = bbs("i_w3")
				i_h3 = bbs("i_h3")
			end if
		end if
	end if

	' DEXT ���ε� ���κ�
%>
<%
	' DEXT ���ε� ���ۺκ� 4
	If allfile4<>"" Then '���ε��� ������ �ִٸ�

		filesize4=allfile4.FileLen

		if filesize4 < maxsize then

			filesize_ok = "ok"

			if bbs("oldfilename4")<>"" then
				oldfilename4 = Server.MapPath("FileData")&"\"&bID&"\"&bbs("oldfilename4")		'�տ��� ���� ������ �ҷ��ͼ�..
				bbs.DeleteFile oldfilename4											'�� ������ �����Ѵ�.
				fOldName4 = Mid(oldfilename4, instrRev(oldfilename4, "\") + 1)
			end if

			Set fs = Server.CreateObject("Scripting.FileSystemObject")
			bbs.DefaultPath = Server.MapPath("FileData")&"\"&bID&"\"				'������ ����� ���
			filename4 = allfile4.FileName								'�����̸��� ���Ѵ�.
			strname = mid(filename4, 1 , instrrev(filename4,".")-1)	'���ϸ��� ���Ѵ�.
			strext = Lcase(Mid(filename4, InstrRev(filename4, ".") + 1))'Ȯ������ ���Ѵ�.

			if Instr(strext_error,right(Lcase(strext),3)) > 0 then
				Response.Redirect "inc/error.asp?no=12&strext="&strext	'���� Ȯ���ڸ� ���� ������ ���ε� �ɰ�� �����޼��� ���.
			End if

			if Instr(strext_img,right(Lcase(strext),3)) > 0 then
				i_w4 = allfile4.imagewidth
				i_h4 = allfile4.imageheight
			else
				i_w4 = 0
				i_h4 = 0
			End if

			strfilename4 = bbs.DefaultPath & filename4


			aname4=bbs("allfile4").Saveas(strfilename4,false)


			filename4= Mid(aname4, InstrRev(aname4, "\") + 1)

			Set fs=Nothing


			if bbs("oldfilename4")<>"" then
				SQL = "Update " & bFilesTable &" set fName = '" & filename4 & "'"
				SQL = SQL & ",fSize = " & filesize4
				SQL = SQL & ",fOldName ='" & fOldName4 & "'"
				SQL = SQL & ",fDLcount = 0 "
				SQL = SQL & " where bNbr = " & bNbr
				SQL = SQL & " And fOrder = 4"
				dbConn.Execute SQL
			end if


		else
			Response.Redirect "inc/error.asp?no=10"
		end if

	else

		if mode <> "edit" then
			filename4=""
			filesize4=""
			i_w4 = 0
			i_h4 = 0
		else
			if bbs("del_file4") = "1" then
				oldfilename4 = Server.MapPath("FileData")&"\"&bID&"\"&bbs("oldfilename4")		'�տ��� ���� ������ �ҷ��ͼ�..
				bbs.DeleteFile oldfilename4										'�� ������ �����Ѵ�.
				filename4=""
				filesize4=""
				i_w4 = 0
				i_h4 = 0
				Call DeleteRecord(bFilesTable, "bNbr = " & bNbr & " And fOrder=4")
			else
				filename4=bbs("oldfilename4")
				filesize4=bbs("oldfilesize4")
				i_w4 = bbs("i_w4")
				i_h4 = bbs("i_h4")
			end if
		end if
	end if

	' DEXT ���ε� ���κ�


%>

<%
	if not(allfile1<>"") or not(allfile2<>"") or not(allfile3<>"") or not(allfile4<>"") or filesize_ok="ok" then

		userName = ReplaceTo(bbs("userName"), "toDB")

		bTitle = ReplaceTo(bbs("bTitle"), "toDB")
		if bTitle = "" then bTitle = "������ �����ϴ�."

		userEmail = ReplaceTo(bbs("userEmail"), "toDB")

		homepage = Trim(bbs("homepage"))
		if left(homepage,7) = "http://" then
			homepage = mid(homepage,8)
		end if

		link1 = Trim(bbs("link1"))
		if left(link1,7) = "http://" then
			link1 = mid(link1,8)
		end if
		link2 = Trim(bbs("link2"))
		if left(link2,7) = "http://" then
			link2 = mid(link2,8)
		end if

	bContent = ReplaceTo(bbs("bContent"), "toDB")
	IPaddress = request.ServerVariables("REMOTE_HOST")
	notice = ReplaceTo(bbs("notice"), "toDB")

	if mode <> "edit" then
		if notice = "1" then	'�̷� ��� �߻����� ���� ���߿� �����.
			SQL="SELECT MAX(bNbr) FROM "& bBodyTable &" where bNbr > 100000000"
			Set rs = dbConn.Execute(SQL)

			if IsNULL(rs(0)) then
				bNbr = 100000001
			else
				bNbr = rs(0)+1
			end if
		else
			SQL="SELECT MAX(bNbr) FROM "& bBodyTable &" where bNbr < 100000000"
			Set rs = dbConn.Execute(SQL)
			if IsNULL(rs(0)) then
				bNbr = 1
			else
				bNbr = rs(0)+1
			end if
		end if
		'���ڵ�� ����
		Call CloseRS(rs)
	end if

	tagHTML = bbs("tagHTML")
	secretPW = bbs("secretPW")
	replyEmail = bbs("replyEmail")

	'if secret = "1" then
	'	secretPW = bbs("secretPW")
	'elseif secret = "2" then
	'	secretPW = userPW
	'end if

	if left(now,2) = "20" then
		writeday = mid(now,3)
	else
		writeday = now
	end if


	'�亯ó���κ�
  	dim o_userEmail,o_title,re,reSame,reID,reID2,newreID,newreSame
  	if mode = "reply" then
		SQL = "SELECT userEmail,bTitle,replyGrp,reSame,reID,replyEmail FROM "&bBodyTable&" where bNbr="&bbs("bNbr")
		Set rs = dbConn.Execute(SQL)

		o_userEmail = rs("userEmail")
		o_title = rs("bTitle")
		replyGrp = rs("replyGrp")
	    	reSame = rs("reSame")
	    	reID = rs("reID")
	    	replyEmail = rs("replyEmail")

		SQL = "SELECT * FROM "&bBodyTable&" where replyGrp="& replyGrp &" and reID>"& reID &" and reSame <= "& reSame &" order by reID"
		Set rs = dbConn.Execute(SQL)

		if rs.BOF or rs.EOF then
			SQL = "SELECT * FROM "&bBodyTable&" where replyGrp="& replyGrp &" and reID > "& reID &" and reSame > "& reSame &" order by reID DESC"
		else
			reID2 = rs("reID")
			SQL = "SELECT * FROM "&bBodyTable&" where replyGrp="& replyGrp &" and reID > "& reID &" and reID< " & reID2 & " and reSame > " & reSame & " order by reID DESC"
	    	end if
		Set rs = dbConn.Execute(SQL)

		if not (rs.BOF or rs.EOF) then
			reID= rs("reID")
	    	end if

	    	SQL = "UPDATE " & bBodyTable & " SET reID = reID + 1 where replyGrp = "& replyGrp & " and reID > " & reID
		dbConn.Execute(SQL)

		newreID = reID + 1
		newreSame = reSame + 1

		if use_mail = "True" And replyEmail = 1 then
			call reply_email()
		end if

	else
		replyGrp = bNbr
		newreSame = 0
		newreID = 0
	end if
	'�亯ó���κ� ��


	call process_write()


	if bbs("sw") <> "" then
		Response.Redirect "bList.asp?bID="&bID&"&page="&page&"&st="&bbs("st")&"&sc="&bbs("sc")&"&sn="&bbs("sn")&"&sw="&bbs("sw")
	else
		Response.Redirect "bList.asp?bID="&bID&"&page="&page
	end if
	Set bbs = nothing


end if







If Err Then
	Response.Write "Error occured : <BR>"
	Response.Write Err.Description
	' �ܺ� ���� �߻����� ���ε� �۾��� ����ϰ��� �� ���
	uploadform.DeleteAllSavedFiles
End If

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
		Response.Write "<P><B>������Ʈ�� ����� �̷������ �ʾҽ��ϴ�</B>."
    End Sub
%>