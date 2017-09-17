<%@ Import namespace="JinsLibrary" %>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="FrontNewsList.ascx.cs" Inherits="KistelSite.CommonApps.BoardNews.FrontNewsList" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<base href='<%= Application["BaseHref"] %>CommonApps/BoardNews/' target=_self>


<asp:repeater id="rptNews" runat="server" EnableViewState="False">
<table width="344" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><HeaderTemplate><asp:HyperLink id="hlMoreList" runat="server" ImageUrl="/CommonApps/BoardNews/Images/Front_news001.gif"
									NavigateUrl="/CommonApps/BoardNews/bnsList.aspx"></asp:HyperLink></HeaderTemplate></td>
  </tr>  
  <tr>
    <td background="Images/Front_news002.gif"><table width="325" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="10" colspan="2"></td>
        </tr>
	  <tr>
        <td width="180"><img src="Images/Front_news_img001.gif" width="176" height="140"></td>
        <td>����� �װ��� ������ <br>
          �а� 10�Ⱑ��Ʈ �̴�����<br>
          ������ �麻 ��Ʈ��ũ�� <br>
          �ڸ��ű��� ������ <br>
          �����ߴ�. <br>
          ����ƴ� ���, ����, <br>
          ���� ���� ������Ʈ�� ....</td>
      </tr>
      <tr bgcolor="#AFAFAF">
        <td height="1" colspan="2"></td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td background="Images/Front_news002.gif"> <ItemTemplate><table width="325" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><img src="Images/Front_news_icon001.gif" width="5" height="7" align="absmiddle"> <a href='bnsView.aspx?bnsID=<%# DataBinder.Eval(Container.DataItem, "bNews_id") %>'>
									<%# Text.ShortenString(DataBinder.Eval(Container.DataItem, "bnsTitle","{0}"), 24) %>
								</a>
		</td>
							<!-- td width="70"><%# DataBinder.Eval(Container.DataItem, "newsDay", "{0:d}") %></td -->
      </tr>
      <tr>
        <td>&nbsp;</td>
      </tr>
    </table></ItemTemplate></td>
  </tr> 
  <tr>
    <td> <FooterTemplate><img src="Images/Front_news003.gif" width="344" height="22"></FooterTemplate></td>
  </tr>
  <tr>
  <SeparatorTemplate>
					<table width="98%" border="0" cellpadding="0" cellspacing="0" align="center">
						<tr>
							<td background="Images/dotline.gif" colspan="2" height="3"></td>
						</tr>
					</table>
	</SeparatorTemplate>
  </tr> 
</table>
</asp:repeater>



			<asp:panel id="pnNews" runat="server" Visible="False">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="150" align="center" bgcolor="#D4D0C8">���� �����Ͱ� �����ϴ�.</td>
              </tr>
            </table>
			</asp:Panel>
</td>
	</tr>
</table>
