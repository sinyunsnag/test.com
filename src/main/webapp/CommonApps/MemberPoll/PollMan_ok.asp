<!-- ShopSetting Start -->
	<!--#include File = "../../SiteSetting.asp" -->
<!-- ShopSetting End -->
<%
	
	
	pMode = Request("pMode")
	'투표하놈 체크 확인(vaildation)
	if Request.Cookies("poolAvail") = "true" and pMode <> "v" then   
		Call ShowAlertMsgClose("투표를 하셨습니다.")
	end if
	
	
	
	pNbr = Request("pNbr")
	exNbr = Request("exNbr")
	
	'숫자인증
	if not IsNumeric(pNbr) and not IsNumeric(exNbr) then
		Call ShowAlertMsgClose("무효값입니다.")
	end if

	if pMode <> "v" then 
		'투표수 증가	
		SQL = "UPDATE vPollEX SET getPoints = getPoints + 1 "
		SQL = SQL & " Where pNbr = ? and exNbr = ? "
		Set Cmd = Server.CreateObject("ADODB.Command")
		With Cmd
			.ActiveConnection = dbConn
			.CommandText = SQL
			.CommandType = adCmdText
	
			.Parameters.Append Cmd.CreateParameter("@pNbr", adUnsignedTinyInt, adParamInput, 2, pNbr)
			.Parameters.Append Cmd.CreateParameter("@exNbr", adUnsignedSmallInt, adParamInput, 2, exNbr)
			'.Parameters.Append Cmd.CreateParameter("@gCode", adChar, adParamInput, 15, gCode)
			.Execute ,,adExecuteNoRecords
			end With
		Set Cmd = nothing
	
		'투표하놈 체크
		Response.Cookies("poolAvail") = "true"
		Response.Cookies("poolAvail").Expires  = DateAdd("h", 1, now)        '1시간뒤 쿠키삭제
	end if		'if pMode <> "v" then 

	'총 투표수 
	SQL = "SELECT SUM(getPoints) AS pollSum FROM vPollEX "
	SQL = SQL & " Where vPollEX.pNbr = " & pNbr 
	SQL = SQL & " GROUP BY pNbr "
	RSresult = OpenRS(sumRS,SQL,1)
	if RSresult <> "Empty" then
		pollSum = trim(sumRS(0))
		Call CloseRS(sumRS)
	end if
'Response.write sql	
	'해당 투표사항
	SQL = "SELECT vPollMain.pTopic,vPollMain.pBeginTime,vPollMain.pEndTime, " 
        SQL = SQL & " vPollMain.pRegisterDT, vPollEX.example, vPollEX.getPoints "
	SQL = SQL & " FROM vPollEX INNER JOIN vPollMain ON vPollEX.pNbr = vPollMain.pNbr "
	SQL = SQL & " Where vPollEX.pNbr = " & pNbr 
	
	RSresult = OpenRS(pollRS,SQL,1)
	'Response.Write("RSresult=" + RSresult)
	if RSresult <> "Empty" then
		pTopic = trim(pollRS("pTopic"))
		pBeginTime = trim(pollRS("pBeginTime"))
		pEndTime = trim(pollRS("pEndTime"))
		'pRegisterDT = trim(pollRS("pTopic"))
		
		'매핑
		pBeginTime = Left(pBeginTime,12)
		if pEndTime = "" then 
			pEndTime = "미정"
		else 
			pEndTime = Left(pEndTime,12)
		end if
		pTime = Left(pBeginTime,12) & " ~ " & pEndTime
%>

<html>
<head>
<title>설문조사</title>
	<meta name="keywords" content="설문조사(폴)">
	<meta name="description" content="최고의 캠코더 전문사이트">
	<meta name="GENERATOR" Content="Microsoft Visual Studio.NET 7.0">
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	
	<link href="<%= Application("SiteURLDir") %>Include_css/Style.css" rel="stylesheet" type="text/css">
	<link href="<%= Application("SiteURLDir") %>Include_css/Object.css" rel="stylesheet" type="text/css">
	<!--script language="JavaScript" src="Include_js/CommonFunctions.js"></script>
	<script language="JavaScript" src="Include_js/Function.js"></script-->
    <style type="text/css">
<!--
.style1 {color: #660099}
-->
    </style>
</head>
<base href="<%= Application("SiteURLDir") %>CommonAccessories/PollMan/" target="_self">
<body>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="4" cellpadding="2">
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <th width="100" height="30" align="center" bgcolor="#66CCFF">제목</th>
        <td><%= pTopic %></td>
      </tr>
      <tr>
        <th height="30" align="center" bgcolor="#66CCFF">기간</th>
        <td><%= pTime %></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="2" cellpadding="1">
      <tr align="center" bgcolor="#D2F1FF">
        <th height="25">예문</th>
        <th>특표수</th>
        <th>그래프</th>
      </tr>
<% 
	Do until pollRS.EOF
		example = trim(pollRS("example"))
		getPoints = trim(pollRS("getPoints"))
		if getPoints = 0 or pollSum = 0 then
			getPercent = 0
		else
			getPercent = getPoints / pollSum * 100			
		end if
%>
      <tr>
        <td height="25"><%= example %></td>
        <td width="100" align="center" bgcolor="#F4FCFF"><%= getPoints %>표</td>
        <td><img src="Images/green.gif" width="<%= getPercent %>%" height="15"></td>
      </tr>
<%
		pollRS.MoveNext
	Loop
%>	  
    </table></td>
  </tr>
  <tr>
    <td height="100" align="center">
	<% 'Call CloseWinddowButton("투표창 닫기") %>
    <!-- CloseButton Start -->
      <!--#include File = "../CloseButton/CloseButton.asp" --> 
    <!-- CloseButton End -->	
	</td>
  </tr>
</table>
<%
		Call CloseRS(pollRS)
	end if  'if RSresult <> "Empty" then
%>
</body>
</html>