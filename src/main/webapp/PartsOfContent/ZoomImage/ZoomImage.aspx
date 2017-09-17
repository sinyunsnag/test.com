﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ZoomImage.aspx.cs" Inherits="WebRoot.PartsOfContent.ZoomImage.ZoomImage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="robots" content="noindex,nofollow"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="/App_Themes/Objects.css" rel="stylesheet" type="text/css"/>
    <link href="/App_Themes/OverallPage.css" rel="stylesheet" type="text/css"/>
    <script language="JavaScript" src="/CommonLibrary/CommonLibrary.js" type="text/javascript"></script> 
    <title>확대이미지(ZoomImage)</title>
</head>
<body>
    <form id="frmZoom" runat="server">
    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="45">
                            <img src="Images/zoom_001.gif" height ="25">
                        </td>
                        <td background="Images/zoom_002.gif">
                            &nbsp;
                        </td>
                        <td width="25">
                            &nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td background="Images/zoom_007.gif">
                            &nbsp;
                        </td>
                        <td align="center">
                            <asp:Image ID="imgZoom" runat="server" ImageUrl="Images/DefaultImage.gif" Width="194px" Height="256px"/>
                        </td>
                        <td background="Images/zoom_008.gif">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td width="25">
                            &nbsp;</td>
                        <td height="62" align="right" background="Images/zoom_005.gif">
                            <asp:HyperLink ID="hlClose" runat="server" NavigateUrl="javascript:self.close();"
                                ImageUrl="Images/btnClose_ViewImages.gif">닫기버튼</asp:HyperLink>
                        </td>
                        <td width="25">
                            &nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
    <script language="javascript">
        /*
        function ResizeWindow(img) { 
        imgWidth=eval("window."+img+".width");       // 이미지의 넓이 
        imgHeight=eval("window."+img+".height");      // 이미지의 높이 
	
        if( imgWidth < 370 ){ 
        imgWidth=380; 
        } 
        else {
        imgWidth=imgWidth+40; 
        } 
        window.self.resizeTo(imgWidth,imgHeight + 100); // 창 열기 
        alert(imgWidth)
        } 
        // Load the first image
        //var im = new Image();
        //im.src = bigImage.src; //"Images/Goods_Images/<'%= bigImage %>";
        // When it's loaded, do something else
        //while (im.readyState != "complete") { // Just loop round, doing nothing 
        //}
        //document.onload = ResizeWindow("imgZoom");
        //alert("aaaa");
        */	
    </script>
</body>
</html>
