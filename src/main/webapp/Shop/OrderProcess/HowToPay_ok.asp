<!-- ShopSetting Start -->
	<!--#include File = "../../SiteSetting.asp" -->
<!-- ShopSetting End -->

<!-- fsShop_inc Start -->
	<!--#include File= "../../Include_asp/fsShop_inc.asp"-->
<!-- fsShop_inc End -->

<%
	'�������Ÿ� Ŭ���� ��ǰ�� �Ѿ� �´�.
	c = Request.Form("c")
	g = Request.Form("g")
	gSize = Request.Form("gSize")
	gColor = Request.Form("gColor")
	amount = Request.Form("amount")

	'��Ű�� ����ؾ� ������ ���ܵ� �̿밡���ϴ�.
	if Request.Cookies("tempOrderID") = "" then
		Response.Cookies("tempOrderID") = Session.SessionID
	end if


	'c,g ���� �ȳѾ� ����
	if c = "" or g = "" or Not IsNumeric(amount) then
		Call GotoThePage("���������� �����Դϴ�!!", Application("SiteURLDir"))
	end if

	'����ī�װ��� ��ǰ�̸��� �������� ������ ����
	gName = PickUpValue("vGoodsList_c", "gName", "gCode = '" & g & "'")
	if gName = "NoPickUp" then
		Call GotoThePage("�ش� ����ī�װ��� �������� �ʽ��ϴ�!!", Application("SiteURLDir"))
	end if

	if Right(g,1) <> "S" then
		'gSize,gColor�� �̿��Ͽ� ����� �ľ��Ѵ�. ����� 0 �����̸� �����Ҽ� ����.
		Call CheckStock(GetCurrStock(g,gSize,gColor),-amount,"")
	end if

Response.write "aaaaaaaaaaaaaaaa"
	'vPopularity�� clicksFigure�� 1����. --> ��ٱ���, �ٷα��� ����ش�.
	PopGoods = gPopularity(g, "choiceFigure")


	'p -> f -> d ; �ٷ� ������ ������ ���
	if session("MbrID") <> "" then
		Response.Redirect("OrderProcess.asp?opMode=p&c=" & c & "&g=" & g & "&amount=" & amount & "&gSize=" & gSize & "&gColor=" & gColor)
	else
		Response.Redirect("../../CommonAccessories/MbrUsers/muLoginDisplay.asp?NMLogin=Y&gtu=" & Server.URLEncode(Application("SiteRoot") & "ShopBody/OrderProcess/OrderProcess.asp?opMode=p&c=" & c & "&g=" & g & "&amount=" & amount))
	end if


	'Call GotoThePage(gName & "��(��) ����īƮ�� " & amount & "�� �־����ϴ�.", "../GoodsDetailBody.asp?c=" & c & "&g=" & g)
%>

<%
	'Server.Execute(Application("SiteRoot") & "Admin/Statistics/statsEngine.asp")
	Call CloseDB()
%>

