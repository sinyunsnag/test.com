<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<SCRIPT LANGUAGE="JavaScript">
<!--
//  ��������////////////////////////////////////////////////////////
	var scrollerwidth = 160;
	var scrollerheight = 145;
	var num = 1; //��ũ���� ���߰� �Ҷ� ���
	//�����ִ� �ð�(��*1000)
	var waitingtime = 3000;
	//��ũ�� �ӵ�
	var scrollspeed = 30;
	var tvi = 0;	//������ ����� �ε���
	var vtvi = 0;	//���纸������ �ִ� div�� �ε���(0,1)
////////////////////////////////////////////////////////////////////
	var liveItems = new Array();
<%
	'ClassifiedG ="gSpecial", "gBest", "gReCMD",'''''''''''''' "gSet", "gPopular", "gRelated"
	i = 0
	selectedFields = "gCode,gMnum,gName,SMprice,Sprice,gOrder,displayOnly,buyable,gSpecial,gBest,gReCMD"
	if ClassifiedG ="gSpecial" then
		whereClause = "gSpecial='Y'"
		btClassifiedG = "SpecialGoodsBoxTitle.gif"
	elseif ClassifiedG ="gBest" then
		whereClause = "gBest='Y'"
		btClassifiedG = "BestGoodsBoxTitle.gif"
	elseif ClassifiedG ="gReCMD" then
		whereClause = "gReCMD='Y'"
		btClassifiedG = "ReCMDGoodsBoxTitle.gif"
	else
		whereClause = "gSpecial='Y' Or gBest='Y' Or gReCMD='Y'"
		btClassifiedG = "ClassifiedGoodsBoxTitle.gif"
	end if
	orderBy = "gOrder DESC"
	RSresult = SelectSimpleRecord(rsClassifiedG, selectedFields, "vClassifiedGoods", whereClause, orderBy)
	if RSresult = "NotEmpty" then
		Do until rsClassifiedG.EOF
			gCode = rsClassifiedG("gCode")
			gMnum = rsClassifiedG("gMnum")
			gName = rsClassifiedG("gName")
			SMprice = rsClassifiedG("SMprice")
			urlClassifiedG = Application("SiteRoot") & "ShopBody/GoodsDetailBody.asp?g=" & gCode
			'���� �̹��� ���ϱ�
			smallImage = PickUpValue("vMasterImages", "pName", "gCode = '" & gCode & "' And imgSize = 'S'")
			if smallImage = "NoPickUp" then smallImage ="iSdefault.gif"
			imgClassifiedG = Application("SiteRoot") & "Images/Goods_Images/" & smallImage
			'����Ȯ��
			if IsNumeric(SMprice) then SMprice = FormatNumber(SMprice,0)

%>

	liveItems[<%= i %>] = "<table cellspacing='0' cellpadding='0' border='0'><tr><td>" +
		"<a href='<%= urlClassifiedG %>'>" +
		"<img src='<%= imgClassifiedG %>' alt='<%= gMnum %>' vspace='2' border='0'></a>" +
		"</td></tr><td align='right' height='25'>" +
		"<a href='<%= urlClassifiedG %>'>" +
		"<font color='#330099'><strong><%= gName %><br><%= SMprice %>��</strong></font></a>" +
		"</td></<tr></table>"


<%
			i = i + 1
			rsClassifiedG.MoveNext()
		Loop
		CloseRS(rsClassifiedG)
	else
%>
		liveItems1[<%= i %>] = "�غ� ��"
<%
	end if 'if RSresult = "NotEmpty" then
%>

	function scrollingLiveList(divlist) {
		list = eval(divlist);
		//�ΰ��� div�� ��� �ø���.
		list[0].style.pixelTop -= num;
		list[1].style.pixelTop -= num;

		if (list[vtvi].style.pixelTop == 5) {	//����ٰ� �ٽ� ��ũ�� �Ǵ� �κ�
			setTimeout("scrollingLiveList(list)", waitingtime);
			//���� ������ div�� ��ġ�� ������ �����Ѵ�.
			tvi = (tvi < liveItems.length - 1) ? tvi+1 : 0 ;
			if (vtvi == 0) {
				vtvi = 1;
				list[1].style.pixelTop = scrollerheight;
				list[1].innerHTML = (tvi < liveItems.length) ? liveItems[tvi] : liveItems[0];
			} else {
				vtvi = 0;
				list[0].style.pixelTop = scrollerheight;
				list[0].innerHTML = (tvi < liveItems.length) ? liveItems[tvi] : liveItems[0];
			}
		} else {	//��ũ�� �Ǵ� �κ�
			//list[0].style.pixelTop -= num;
			//list[1].style.pixelTop -= num;
			setTimeout("scrollingLiveList(list)", scrollspeed);
		}
	}

	function onmouse_event() {
		num=0;
	}

	function mouseout_event() {
		num=1;
	}

	function startLiveList() {
		LiveList[0].innerHTML = liveItems[tvi];
		if (liveItems.length > 1) {
			//alert(liveItems.length);
			scrollingLiveList(LiveList);
		}
	}
	window.onload = startLiveList;
//-->
</SCRIPT>
<base href="<%= Application("SiteURLDir") %>ShopComponents/ClassifiedGoods/" target="_self">
<table cellpadding=0 cellspacing=0 border=0 width="150">
<tr>
<td><img src="Images/<%= btClassifiedG %>" width=150 height=35 border=0></td>
</tr>
<tr>
<td height=150 style="position:relative">
	<div onMouseOver="onmouse_event();" onMouseOut="mouseout_event();" style="position:absolute;width:160;height:37px;clip:rect(0 170 145 0);left:10;top:10;z-index:1">
		<div id="LiveList" style="position:absolute;width:160;left:10;top:10;visibility:visible;"></div>
		<div id="LiveList" style="position:absolute;width:160;left:10;top:10;visibility:visible;"></div>
	</div></td>
</tr>
</table>

<%
	ClassifiedG = ""
	btClassifiedG = ""
%>