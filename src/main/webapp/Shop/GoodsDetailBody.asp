<!-- ShopSetting Start -->
	<!--#include File = "../SiteSetting.asp" -->
<!-- ShopSetting End -->

<!-- fsShop_inc Start -->
<!--#include File= "../Include_asp/fsShop_inc.asp"-->
<!-- fsShop_inc End -->

<%
	session("PageTitleName") = "��ǰ�󼼺���"
	secondLevel =" > ��ǰ�󼼺���"
%>

<html>
<head>
<title>��ǰ�󼼺���</title>
	<meta name="keywords" content="ķ�ڴ� ī�޶� �޸�">
	<meta name="description" content="�ְ��� ķ�ڴ� ��������Ʈ">
	<meta name="GENERATOR" Content="Microsoft Visual Studio.NET 7.0">
	<meta http-equiv="refresh" content="<%= refl %>">
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

	<link href="../Include_css/Style.css" rel="stylesheet" type="text/css">
	<link href="../Include_css/Object.css" rel="stylesheet" type="text/css">
	<script language="JavaScript" src="../Include_js/CommonFunctions.js"></script>
	<script language="JavaScript" src="../Include_js/Function.js"></script>
</head>

<body>

<table width="800" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
	<!-- FrontHeader Start -->
     <!--#include File = "../SiteHeader/FrontHeader.asp" -->
    <!-- FrontHeader End -->
	</td>
  </tr>
  <tr>
    <td><table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="30" colspan="2">
	<!-- FrontHeader Start -->
     <!--#include File = "../ShopComponents/MainMenu/MainMenuBar.asp" -->
    <!-- FrontHeader End -->		  </td>
        </tr>
        <tr>
          <td height="120" colspan="2">
	<!-- FlashDisplay Start -->
    <!--#include File = "../ShopComponents/FlashDisplay/FlashDisplay.asp" -->    
    <!-- FlashDisplay End -->
		  </td>
        </tr>
        <tr bgcolor="#E9FEFE">
          <td width="160">
		<!-- SelectedCategory Start -->
		<!--#include File = "../ShopComponents/SelectedCategory/SelectedCategory.asp" -->
		<!-- SelectedCategory End -->		  </td>
          <td width="640">
            <!-- LocationBar Start -->
            <!--#include File = "../ShopComponents/LocationBar/LocationBar.asp" -->
		  <!-- LocationBar End -->          </td>
        </tr>
        <tr>
          <td height="500" valign="top">
			<!-- SubMenu Start -->
            <!--#include File = "../ShopComponents/SubMenu/SubMenu.asp" -->
            <!-- MainMenu End -->
            <br> <br>
            <!-- RelatedGoods Start -->
            <!--#include File = "../ShopComponents/ClassifiedGoods/RelatedGoods/RelatedGoods.asp" -->
            <!-- RelatedGoods End -->
            <br> <br>
			<% ClassifiedG ="gSpecial" %>
			<!-- SpecialGoods Start -->
            <!--#include File = "../ShopComponents/ClassifiedGoods/GoodsClass.asp" -->
            <!-- SpecialGoods End -->
            <br><br>
		  </td>
          <td valign="top">

<%
 	' ��ǰ���� �ǸŰ��� Ȯ�� ;  0-���û�ǰ, 1-�Ͻ�ǰ��, 2-������� ��
	' --  ī�װ� ���� Ȯ�� ; ���� -��������
	' -  displayOnly <> Y ; ���û�ǰ
	' -  ������ > 0, null (�������� �ϰ� ��ǰ ������Ƽ�� �ϳ��� ��� �ΰ��̻��� ������������ �˼� ����) ; �Ͻ�ǰ��
	' -  vMSrelationship = ���� ; ������� ��
	' -  buyable = 1 only	; ȭ�鿡 ��Ÿ���� ����.

	'��ǰ�ڵ�
	g = Request.QueryString("g")
	'g ���� �ȳѾ� ����
	if g = "" then
		Call GotoThePage("���������� �����Դϴ�!!", Application("SiteRoot"))
	end if

	'�ش� ��ǰ ���� ��������
	SQL = "SELECT * From vGoodsValues "
	SQL = SQL & " Where gCode =  '" & g & "'"
	SQL = SQL & " And buyable =  1 "

	RSresult = OpenSimpleRS(rsGS, SQL)
	if RSresult = "Empty" then
		Call GotoThePage("���� �ش�Ǵ� ��ǰ�� �����ϴ�.", Application("SiteRoot"))
	else
		'gCode = trim(rsGS("gCode"))
		gMnum = trim(rsGS("gMnum"))
		gName = trim(rsGS("gName"))
		gGname = trim(rsGS("gGname"))
		Mfger = trim(rsGS("Mfger"))
		originOfP = trim(rsGS("originOfP"))
		SMprice = trim(rsGS("SMprice"))
		Sprice = trim(rsGS("Sprice"))
		'gOrder = trim(rsGS("gOrder"))
		gDesc = trim(rsGS("gDesc"))
		displayOnly = trim(rsGS("displayOnly"))
		'buyable = trim(rsGS("buyable"))
		reserveFund = trim(rsGS("reserveFund"))
		gRegisterDT = Left(trim(rsGS("gRegisterDT")), 10)
		'IPaddress = trim(rsGS("IPaddress"))

		'salesFigure = trim(rsGS("salesFigure"))
		'choiceFigure = trim(rsGS("choiceFigure"))
		'clicksFigure = trim(rsGS("clicksFigure"))
		'pReflectedDT = trim(rsGS("pReflectedDT"))
		gSpecial = trim(rsGS("gSpecial"))
		gBest = trim(rsGS("gBest"))
		gReCMD = trim(rsGS("gReCMD"))
		Call CloseRS(rsGS)

		''''''''''''''''''''
		'���û�ǰ �ΰ��
		if displayOnly = "Y" then gTotState = "* ���û�ǰ"


		'��Ʈ��ǰ�� ��� �� ���빰�� ��� �ľ�. ������� -->
		lastOneChar = Right(g,1)
		if lastOneChar = "S" then
			selectedFields = "gCodes,stockID"
			whereClause = "gCodeSet =  '" & g & "'"
			orderBy = "gCodes DESC"
			RSresult = SelectSimpleRecord(rsSet, selectedFields, "vMasterSet", whereClause, orderBy)
			if RSresult = "NotEmpty" then
				Do until rsSet.EOF
					if rsSet("stockID") <> "" then	'��Ʈ��ǰ�� �����׸��� �ϳ� �ϳ� ���üũ�� �Ѵٴ� ����.
							 if GetCurrStock1(stockID) <= 0 then gTotState = "* �Ͻ�ǰ��"
					end if
					rsSet.MoveNext()
				Loop

				rsSet.MoveFirst() 	'�ٽ� ������ �������.
				arrSet = rsSet.GetRows(,,Split(selectedFields,","))
				Call CloseRS(rsSet)

				'for i = 0 to UBOUND(arrSet,1)
				'	for j = 0 to UBOUND(arrSet,2)
				'		Response.Write "[" & j & "," & i & "] " & arrSet(j,i) & " "
				'	next
				'	Response.Write "<br>"
				'next
			end if 'if RSresult = "NotEmpty" then

		else
			'��ǰ�Ӽ� ����
			selectedFields = "gSize,gColor"
			whereClause = "gCode='" & g & "' And StkEnable=1"
			orderBy = "stockID"
			RSresult = SelectSimpleRecord(rsStk, selectedFields, "vCurrMstock", whereClause, orderBy)
			if RSresult = "NotEmpty" then		'����� ����ؾ� �ϴ� ���.
				'��Ź�� ���õ� ��ü���ڵ�
				arrStk = rsStk.GetRows(,,Split(selectedFields,","))
				Call CloseRS(rsStk)
				'for i = 0 to UBOUND(arrStk,1)
				'	for j = 0 to UBOUND(arrStk,2)
				'		Response.Write "[" & i & "," & j & "] " & arrStk(i,j) & " "
				'	next
				'	Response.Write "<br>"
				'next

				'���� �ϳ���� �̾߱�� currStock�� �� ���������� �˼� �ִٴ� ���̴�.
				if Ubound(arrStk,2) <= 0 then
					currStock = PickUpValue("vCurrMstock", "currStock", "gCode = '" & g & "'")
					if currStock <= 0 then gTotState = "* �Ͻ�ǰ��"
				end if

				'������� ����Ӽ��� ������ �ִ� ��ǰ�� ���
				'������Ӽ� ���ϱ�'rsStk.Filter = "gColor" 'rsStk.Filter = adFilterNone
				SQL = "SELECT TOP 100 PERCENT gSize FROM vCurrMstock "
				SQL = SQL & "WHERE gCode = '" & g & "' And (gSize <> '' Or gSize IS NOT NULL) "
				SQL = SQL & "GROUP BY gSize, gsOrder "
				SQL = SQL & "ORDER BY gsOrder, gSize "
				RSresult = OpenSimpleRS(rsSize, SQL)
				if RSresult = "NotEmpty" then '������Ӽ��� ������ �ִ� ��ǰ�� ���
					arrSize = rsSize.GetRows(,,"gSize")
					Call CloseRS(rsSize)
					'for i = 0 to UBOUND(arrSize,2)
	  				'	Response.Write "column1:" & arrSize(0,i)
					'next
				end if
				'����Ӽ� ���ϱ�
				SQL = "SELECT TOP 100 PERCENT gColor FROM vCurrMstock "
				SQL = SQL & "WHERE gCode = '" & g & "' And (gColor <> '' Or gColor IS NOT NULL) "
				SQL = SQL & "GROUP BY gColor "
				SQL = SQL & "ORDER BY gColor "
				RSresult = OpenSimpleRS(rsColor, SQL)
				if RSresult = "NotEmpty" then '������Ӽ��� ������ �ִ� ��ǰ�� ���
					arrColor = rsColor.GetRows(,,"gColor")
					Call CloseRS(rsColor)
					'for i = 0 to UBOUND(arrColor,2)
	  				'	Response.Write "column1:" & arrColor(0,i)
					'next
				end if

			end if 'if RSresult = "NotEmpty" then
		end if	'lastOneChar = "S" then



		'�����ڰ� ���ų� ���� ����� ���(���� ���)
		expirationDT = PickUpValue("vMSrelationship", "expirationDT", "gCode = '" & g & "'")
		if IsDate(expirationDT) then expirationDT = CDate(expirationDT)	'NULL�� �ƴ϶� ��¥���¸� ������
		if expirationDT = "NoPickUp" or expirationDT < Date() then gTotState = "* ������� ��"
		'Response.Write(expirationDT &  " - " & Date())



		'�߰� �̹��� ���ϱ�
		middleImage = PickUpValue("vMasterImages", "pName", "gCode = '" & g & "' And imgSize = 'M'")
		if middleImage = "NoPickUp" then middleImage ="iMdefault.gif"
		'ū �̹��� ���ϱ�
		bigImage = PickUpValue("vMasterImages", "pName", "gCode = '" & g & "' And imgSize = 'B'")

		'vPopularity�� clicksFigure�� 1����.
		PopGoods = gPopularity(g, "clicksFigure")

	end if 'if RSresult = "Empty" then
%>


<base href="<%= Application("SiteURLDir") %>ShopBody/" target="_self">
<script language="JavaScript" src="GoodsDetailBody_inc.js"></script>
		  <table width="100%" height="500" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td valign="top">
                  <table width="98%" border="0" cellspacing="0" cellpadding="0">
                    <tr valign="top">
                      <td width="45%" align="center"><img src="../Images/Goods_Images/<%= middleImage %>" alt="<%= gName %>" border="0"> <br>
	<% if bigImage <> "NoPickUp" then %>
		<a href="JavaScript:OpenWindow('../ShopComponents/ZoomImage/ZoomImage.asp?g=<%= g %>','bigImg','scrollbars=yes,resizable=yes,width=500,height=500');"><img src="Images/gZoomIcon.gif" width="93" height="24" border="0"></a><br>
	<% end if %>    <a href="javascript:history.go(-1);"><img src="Images/before.gif" width=110 height=34 vspace="20" border=0></a> </td>
                      <td width="55%"><table width="96%" border="0" align="center" cellpadding="2" cellspacing="2">
                        <tr>
                          <td width="150">�𵨹�ȣ</td>
                          <td><%= gMnum %></td>
                        </tr>
                        <tr>
                          <td>��ǰ��</td>
                          <td><%= gName %></td>
                        </tr>
                        <tr>
                          <td>�Ϲݻ�ǰ��</td>
                          <td><%= gGname %></td>
                        </tr>
                        <tr>
                          <td>������/������</td>
                          <td><%= Mfger %> / <%= originOfP %></td>
                        </tr>
                        <tr>
                          <td>ȸ����/�Ϲݰ�</td>
                          <td><%= FormatCurrency(SMprice) %> / <%= FormatCurrency(Sprice) %></td>
                        </tr>
                        <tr>
                          <td>������</td>
                          <td><%= FormatCurrency(reserveFund) %></td>
                        </tr>
                        <tr>
                          <td>��ǰ�����</td>
                          <td><%= gRegisterDT %></td>
                        </tr>
                        <tr align="right">
                          <td height="30" colspan="2"><%
                           		'��ǰ���Ȯ��
								if gSpecial <> "N" then Response.write("���伣��ǰ - ")
								if gBest <> "N" then Response.write("��ȹ��ǰ - ")
								if gReCMD <> "N" then Response.write("��õ��ǰ - ")
								if PopGoods <> "N" then Response.write("�α��ǰ - ")
								if lastOneChar = "S" then Response.write("��Ʈ��ǰ")
%></td>
                          </tr>
                      </table>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
<form action="OrderProcess/TempOrder_ok.asp" method="post" name="frmOrder" onsubmit="//return CheckShoppingCart(this);">
                          <tr>
                            <td width="200" valign="middle">
							<% if gTotState <> "" then
									Response.Write(gTotState)
								else
							 %>

							<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
                            <% 	if IsArray(arrSize) then %>
							  <tr>
                                <td align="center">��ǰũ��</td>
                                <td>
									<select name="gSize" onChange="GetDropDownLists('size');">
								<% if UBOUND(arrSize,2) > 1 Then %>
									<option value="">�����ϼ���</option>
								<% End If %>
								<% for i = 0 to UBOUND(arrSize,2) %>
									<option value="<%= arrSize(0,i) %>"><%= arrSize(0,i) %></option>
								<% next	%>
                                	</select>
								</td>
                              </tr>
                            <%
								end if
								if IsArray(arrSize) then
							%>
							  <tr>
                                <td align="center">��ǰ����</td>
                                <td>
									<select name="gColor" onChange="GetDropDownLists('color');">
								<% if UBOUND(arrColor,2) > 1 Then %>
									<option value="">�����ϼ���</option>
								<% End If %>
								<% for i = 0 to UBOUND(arrColor,2) %>
									<option value="<%= arrColor(0,i) %>"><%= arrColor(0,i) %></option>
								<% next	%>
                                	</select>

								</td>
                              </tr>
							<% 	end if %>
                              <tr>
                                <td align="center">�ֹ�����</td>
                                <td><INPUT name="amount" id="amount" value="1" size="3" maxLength="3"  style="TEXT-ALIGN: center" autocomplete="off">
��</td>
                              </tr>
                            </table>
							 <input name="c" type="hidden" id="cCode" value="<%= c %>">
							 <input name="g" type="hidden" id="gCode" value="<%= g %>">
							 <br>
							 <a href="JavaScript:CheckShoppingCart(frmOrder, 'directBuy')">
							 <IMG src="Images/directBuy.gif" alt="�ٷα����ϱ�" name="directBuy" width="130" height="30" vspace="5" border="0" style="CURSOR:HAND"></a>

							 <a href="JavaScript:CheckShoppingCart(frmOrder, 'goodsToCart')">
							 <IMG src="Images/goodsToCart.gif" alt="����īƮ�� �ֱ�" name="goodsToCart" width="130" height="30" vspace="5" border="0" style="CURSOR:HAND"></a>
                             <%	end if %>
							 </td>
                            <td valign="bottom"><a href="ChosenGoods_ok.asp?c=<%= c %>&g=<%= g %>"><img src="Images/wantToBuyItem.gif" alt="�� �صα�" width="116" height="30" border="0"></a><!-- img src="Images/commentAfterBuying.gif" alt="�̿��ı⾲��" width="116" height="30"><br--></td>
                          </tr>
</form>
                        </table></td>
                    </tr>
                  </table>
                  <br>

<%
	'��Ʈ��ǰ�� ��� ���÷���
	if lastOneChar = "S" then
%>
                  <table width="98%" border="0" cellpadding="0" cellspacing="0">
                    <tr valign="bottom">
                      <td height="30" colspan="2" valign="middle">*��Ʈ��ǰ</td>
                    </tr>
                    <tr>
                      <td height="25" colspan="2">
					  ��Ʈ��ǰ�� �Ϻ��׸��� �ٸ� ǰ������ ��ü�� �� �ֽ��ϴ�. ��Ȯ�� ������ ����ڿ��� �����ϼ���.</td>
                    </tr>
                    <tr>
                      <td colspan="2">

					  <table width="100%" border="0" cellspacing="3" cellpadding="10">
                        <tr>
<%

	for i = 0 to UBOUND(arrSet,2)
		'for j = 0 to UBOUND(arrSet,1)
			'Response.Write "[" & j & "," & i & "] " & arrSet(j,i) & " "
		'next
		'Response.Write "<br>"

		gCodes = arrSet(0,i)
		'stockID = arrSet(1,i)

		selectedFields = "gCode,gMnum,gName,SMprice,displayOnly,buyable,reserveFund"
		whereClause = "gCode='" & gCodes & "'"
		orderBy = "gOrder"
		RSresult = SelectSimpleRecord(rsSet, selectedFields, "vMaster", whereClause, orderBy)
		if RSresult = "NotEmpty" then
			gCode = rsSet("gCode")
			gMnum = rsSet("gMnum")
			gName = rsSet("gName")
			SMprice = rsSet("SMprice")
			displayOnly = rsSet("displayOnly")
			buyable = rsSet("buyable")
			reserveFund = rsSet("reserveFund")

			'��Ʈ��ǰ �׸���� (buyable = 0)
			c = PickUpValue("vGoodsList_c", "cCode", "gCode = '" & gCode & "'")
			if buyable = "False" Or c = "NoPickUp" then
				ahref = "disabled"
			end if

			'����
			if Len(gName) < 10 then
				gTitle = gName & " (" & gMnum & ")"
			else
				gTitle = gName & "<br>(" & gMnum & ")"
			end if

		'���� �̹��� ���ϱ�
			smallImage = PickUpValue("vMasterImages", "pName", "gCode = '" & gCode & "' And imgSize = 'S'")
			if smallImage = "NoPickUp" then smallImage ="iSdefault.gif"
		else
			'���ڵ尡 ����.
		end if 'if RSresult = "NotEmpty" then

%>

                          <td valign="top"><table width="150" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                              <td align="center" bgcolor="#CCCCCC"><%= gTitle %></td>
                            </tr>
                            <tr>
                              <td align="center">
<% if ahref <> "disabled" then %><a href="GoodsDetailBody.asp?c=<%= c %>&g=<%= gCode %>"><% end if 'if ahref <> "disabled" then %>
<img src="../Images/Goods_Images/<%= smallImage %>" width="100" height="100" hspace="5" vspace="5" border="0"><% if ahref <> "disabled" then %></a><% end if  'if ahref <> "disabled" then %></td>
                            </tr>
                            <tr>
                              <td align="center"><!-- ȸ���� : \1,200,000 --></td>
                            </tr>
                          </table></td>
<%
	   		if ((i+1) mod 4) = 0 then
				Response.write("</TR><TR>")
			end if
	next
%>

                          </tr>
                      </table></td>
                    </tr>
                  </table>
				  <br>
<%
	'��Ʈ��ǰ�� ��� ���÷���
	end if 	'if lastOneChar = "S" then
%>
<!-- table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>���⿣ �������ų���. </td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table -->
                  <table width="98%" border="0" cellpadding="0" cellspacing="0">
                    <tr valign="bottom">
                      <td height="30" colspan="2"><img src="Images/gDescription.gif" width="627" height="27"></td>
                    </tr>
                    <tr>
                      <td colspan="2"><%= gDesc %></td>
                    </tr>
                  </table>
                  <br>
		  <!--------------   static page  loading ------------------>
<%
	fPath = Application("SiteRoot") & "ContentsParts/detailedGoodsInfo/g" & g & "/g" & g & ".asp"
	'Response.write fPath
	if IsFileExist(fPath) = 1 then 
		Response.Write("<base href=" & Application("DomainURL") & fPath & " target=""_self"">")
		Server.Execute(fPath)
	end if
%>				  
				  </td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td colspan="2">
            <!-- FrontFooter Start -->
            <!--#include File = "../SiteFooter/FrontFooter.asp" -->            
            <!-- FrontFooter End -->
          </td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html>

<script language="JavaScript" type="text/JavaScript">
<!--
	//evalGoodsCnt = parseInt(form.elements("amount").value);
	arrSize = new Array(<%= UBOUND(arrStk,2)+1 %>);
	arrColor = new Array(<%= UBOUND(arrStk,2)+1 %>);
<%
	if lastOneChar <> "S" then
		for i = 0 to UBOUND(arrStk,1)
			for j = 0 to UBOUND(arrStk,2)
				if i=0 then
%>
					arrSize[<%=j%>] =  '<%= arrStk(i,j) %>';
<%
				else
%>
					arrColor[<%=j%>] = '<%= arrStk(i,j) %>';
<%
				end if
			next
		next
	end if 'if lastOneChar <> "S" then
%>
	//document.write("<br>");
	//document.write(arrColor);

function GetDropDownLists(which) {
	idxSize = frmOrder.gSize.selectedIndex;
	idxColor = frmOrder.gColor.selectedIndex;

	if(which == "size" && idxSize != 0) {
		selectedItem = frmOrder.gSize.options[idxSize].text;
		var tempListItems = new Array();
		var tempListItemsIdx = 0;

		for(i=0; i<arrSize.length; i++) {
			//���õ� ũ����� ����� �����ϴ��� �˻�.
			if(selectedItem == arrSize[i]) {

				if(arrColor[i] != "" ) {
					var itmExist = false;

					for(j=0; j<tempListItems.length; j++) {
						if(arrColor[i] == tempListItems[j]){
							itmExist = true;
							return;
						}
					}
					if(itmExist != true) {
	//alert(arrSize[i] + "--" + selectedItem + "--" + arrColor[i] + "--" + tempListItems.length);
						tempListItems[tempListItemsIdx] = arrColor[i];
						tempListItemsIdx += 1;
					}
				}
			}
		}
		PutDropDownLists(document.frmOrder.gColor, tempListItems);

	} else if(which == "color" && idxColor != 0) {

		selectedItem = frmOrder.gColor.options[idxColor].text;
		var tempListItems = new Array();
		var tempListItemsIdx = 0;

		for(i=0; i<arrColor.length; i++) {
			//���õ� ũ����� ����� �����ϴ��� �˻�.
			if(selectedItem == arrColor[i]) {

				if(arrSize[i] != "" ) {
					var itmExist = false;

					for(j=0; j<tempListItems.length; j++) {
						if(arrSize[i] == tempListItems[j]){
							itmExist = true;
							return;
						}
					}
					if(itmExist != true) {
	//alert(arrSize[i] + "--" + selectedItem + "--" + arrColor[i] + "--" + tempListItems.length);
						tempListItems[tempListItemsIdx] = arrSize[i];
						tempListItemsIdx += 1;
					}
				}
			}
		}

		PutDropDownLists(document.frmOrder.gSize, tempListItems);
	} else {
		//�ΰ��� ���� '�����ϼ���' �ϰ�� �ʱ⺹��.
		location.reload();
	}
}


function PutDropDownLists(sel, tempListItems) {
	//alert(sel.name);

	selIdx = sel.selectedIndex
	selText = sel.options[selIdx].text;

	selLength = sel.length;
	//���� ����Ʈ�޴�����
	for(i=1; i<selLength; i++) {
		sel.options[1] = null;
	}

	//alert(tempListItems);
	//���ο� ����Ʈ�޴��߰�
	for(i=0; i < tempListItems.length; i++) {
		sel.options[i+1] = new Option(tempListItems[i],tempListItems[i]);
		//sel.options[i].text = tempListItems[i-1];
		//sel.options[i].value = tempListItems[i-1];
	}

	//alert(selText);
	//����Ʈ�� ����
	selLength = sel.length;
	for(i=1; i<selLength; i++) {
		if (selText ==  sel.options[i].text) {
			sel.options[i].selected = true;
		}
	}
}
-->
</script>
