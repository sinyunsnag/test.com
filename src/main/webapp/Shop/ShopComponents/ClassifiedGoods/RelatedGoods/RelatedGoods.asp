<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<SCRIPT LANGUAGE="JavaScript">
<!--
//  ��������////////////////////////////////////////////////////////
	var scrollerwidth3 = 160;
	var scrollerheight3 = 145;
	var num3 = 1; //��ũ���� ���߰� �Ҷ� ���
	//�����ִ� �ð�(��*1000)
	var waitingtime3 = 3000;
	//��ũ�� �ӵ�
	var scrollspeed3 = 30;
	var tvi3 = 0;	//������ ����� �ε���
	var vtvi3 = 0;	//���纸������ �ִ� div�� �ε���(0,1)
////////////////////////////////////////////////////////////////////
	var liveItems3 = new Array();
<%
	g = Request.QueryString("g")
	'g ���� �ȳѾ� ����

	if g <> "" then		'gCode�� ���� �ƴϿ��߸� ���õ� ��ǰ�� ã�� ���� �ִ�
		selectedFields = "gRelCode"
		whereClause = "gCode='" & g & "'"
		orderBy = "gCode"
		RSresult = SelectSimpleRecord(rsREL, selectedFields, "vRelatedGoods", whereClause, orderBy)

		if RSresult = "NotEmpty" then
			i = 0			'arrREL = rsREL.GetRows(,,Split(selectedFields,","))
			Do until rsREL.EOF
				gRelCode = rsREL("gRelCode")
Response.write "// " &  gRelCode & " " & i
				'ClassifiedG ="gSpecial", "gBest", "gReCMD", "gSet", "gPopular", "gRelated"
				selectedFields = "gCode,gMnum,gName,SMprice,Sprice,gOrder,displayOnly,buyable"
				whereClause = "gCode='" & gRelCode & "'"
				orderBy = "gOrder DESC"
				RSresult = SelectSimpleRecord(rsRELG, selectedFields, "vPopularGoods", whereClause, orderBy)

				if RSresult = "NotEmpty" then

					gCode = rsRELG("gCode")
					gMnum = rsRELG("gMnum")
					gName = rsRELG("gName")
					SMprice = rsRELG("SMprice")
					urlClassifiedG = Application("SiteRoot") & "ShopBody/GoodsDetailBody.asp?g=" & gCode
					'���� �̹��� ���ϱ�
					smallImage = PickUpValue("vMasterImages", "pName", "gCode = '" & gCode & "' And imgSize = 'S'")
					if smallImage = "NoPickUp" then smallImage ="iSdefault.gif"
					imgClassifiedG = Application("SiteRoot") & "Images/Goods_Images/" & smallImage
					'����Ȯ��
					if IsNumeric(SMprice) then SMprice = FormatNumber(SMprice,0)
%>

		liveItems3[<%= i %>] = "<table cellspacing='0' cellpadding='0' border='0'><tr><td>" +
			"<a href='<%= urlClassifiedG %>'>" +
			"<img src='<%= imgClassifiedG %>' alt='<%= gMnum %>' vspace='2' border='0'></a>" +
			"</td></tr><td align='right' height='25'>" +
			"<a href='<%= urlClassifiedG %>'>" +
			"<font color='#330099'><strong><%= gName %><br><%= SMprice %>��</strong></font></a>" +
			"</td></<tr></table>"
<%

					CloseRS(rsRELG)
					i = i + 1
				end if 'if RSresult = "NotEmpty" then
				rsREL.MoveNext()
			Loop
			CloseRS(rsREL)
		end if 'if RSresult = "NotEmpty" then

		ClassifiedG = ""
%>

	function scrollingLiveList3(divlist) {
		list1 = eval(divlist);
		//�ΰ��� div�� ��� �ø���.
		list1[0].style.pixelTop -= num3;
		list1[1].style.pixelTop -= num3;

		if (list1[vtvi3].style.pixelTop == 5) {	//����ٰ� �ٽ� ��ũ�� �Ǵ� �κ�
			setTimeout("scrollingLiveList3(list1)", waitingtime3);
			//���� ������ div�� ��ġ�� ������ �����Ѵ�.
			tvi3 = (tvi3 < liveItems3.length - 1) ? tvi3+1 : 0 ;
			if (vtvi3 == 0) {
				vtvi3 = 1;
				list1[1].style.pixelTop = scrollerheight3;
				list1[1].innerHTML = (tvi3 < liveItems3.length) ? liveItems3[tvi3] : liveItems3[0];
			} else {
				vtvi3 = 0;
				list1[0].style.pixelTop = scrollerheight3;
				list1[0].innerHTML = (tvi3 < liveItems3.length) ? liveItems3[tvi3] : liveItems3[0];
			}
		} else {	//��ũ�� �Ǵ� �κ�
			//list1[0].style.pixelTop -= num3;
			//list1[1].style.pixelTop -= num3;
			setTimeout("scrollingLiveList3(list1)", scrollspeed3);
		}
	}

	function onmouse_event3() {
		num3=0;
	}

	function mouseout_event3() {
		num3=1;
	}

	function startLiveList3() {
		LiveList1[0].innerHTML = liveItems3[tvi3];
		if (liveItems3.length > 1) {
			//alert(liveItems3.length);
			scrollingLiveList3(LiveList1);
		}
	}
	//window.onload = startLiveList3;
//-->
</SCRIPT>
<%
	if i > 0 then
%>
<base href="<%= Application("SiteURLDir") %>ShopComponents/ClassifiedGoods/RelatedGoods/" target="_self">
<table cellpadding=0 cellspacing=0 border=0 width="150">
<tr>
<td><img src="Images/RelatedGoodsBoxTitle.gif" width=150 height=35 border=0></td>
</tr>
<tr>
<td height=150 style="position:relative">
	<div onMouseOver="onmouse_event3();" onMouseOut="mouseout_event3();" style="position:absolute;width:160;height:37px;clip:rect(0 170 145 0);left:10;top:10;z-index:1">
		<div id="LiveList1" style="position:absolute;width:160;left:10;top:10;visibility:visible;"></div>
		<div id="LiveList1" style="position:absolute;width:160;left:10;top:10;visibility:visible;"></div>
	</div></td>
</tr>
</table>
<SCRIPT LANGUAGE="JavaScript">
<!--
	startLiveList3();
//-->
</SCRIPT>

<%
		end if 		'if i > 0 then
	end if	'if g <> "" then		'gCode�� ���� �ƴϿ��߸� ���õ� ��ǰ�� ã�� ���� �ִ�
%>