<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<% 
NMmyPg = trim(request("NMmyPg"))
if NMmyPg = "Y" then %>

<base href="<%= Application("SiteURLDir") %>ShopComponents/NonMbrMyPgLogin/" target="_self">
<img src="../../Images/TransparentImage.gif" width="50" height="30">
<TABLE cellSpacing=0 cellPadding=1 width=704 bgColor=#59ae52 border=0> 
  <TR> 
    <TD> <TABLE cellSpacing=0 cellPadding=1 width=702 bgColor=#ffffff border=0> 
        <TR> 
          <TD> <TABLE cellSpacing=0 cellPadding=0 width=700 border=0> 
              <TR> 
                <TD bgColor=#59ae52 height=40><FONT 
                              color=#59ae52>...</FONT> ��ȸ�� �α��� >LOGIN for Guest</TD> 
              </TR> 
              <TR> 
                <TD bgColor=#ededed height=100> 
				<TABLE cellSpacing=0 cellPadding=0 width=650 align=center border=0> 
                    <FORM name="frmNMmyPg" method="post" action="<%= Request.QueryString("gtu") %>"> 
                      <TR> 
                        <TD width=80 height=46 align="middle">�ֹ���ȣ</TD> 
                        <TD width="200"><IMG src="../../Images/TransparentImage.gif" width="10" height="10"> 
                          <INPUT name="orderNbr" id="orderNbr" size="20" maxLength="30">						</TD> 
                        <TD width="80">����</TD> 
                        <TD><IMG src="../../Images/TransparentImage.gif" width="10" height="10">
                          <input name="clientName" type="text" id="clientName" size="12" maxlength="12" style="ime-mode:active"></TD> 
                      </TR> 
                      <TR> 
                        <TD height=70 align="middle">&nbsp;</TD> 
                        <TD align="right"> <input type="image" src="Images/ok.gif" width="112" height="36" border="0"></TD> 
                        <TD>&nbsp;</TD>
                        <TD>&nbsp;</TD>
                      </TR> 
                      <TR> 
                        <TD colSpan=4>��ȸ���� ��� �ֹ���ȣ�� �ֹ��ڸ��� �������� �ֹ������� ��ȸ�Ͻ� �� �ֽ��ϴ�. <br> 
                          �ֹ���ȣ�� &quot;-&quot; �� �����ϼ���. <BR> 
                        </TD> 
                      </TR> 
                    </FORM> 
                </TABLE></TD> 
              </TR> 
            </TABLE></TD> 
        </TR> 
      </TABLE></TD> 
  </TR> 
</TABLE>
<% end if %>