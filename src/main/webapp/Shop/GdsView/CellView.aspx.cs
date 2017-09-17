using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

using JinsLibrary;
using JinsLibrary.FILE;
using JinsLibrary.CONFIG;
using JinsLibrary.STATEMANAGE;
using App_Code.Goods.Cell;

namespace SHOP
{
    public partial class Shop_GdsView_CellView : System.Web.UI.Page
    {
        private DBLib _dbUtil;
        private string _gfName, _GdsUploadDir;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["gcid"] != null)
            {
                if (!Page.IsPostBack)
                {
                     //<%=App_Code.ADMIN.AdminLocations.MakeLocation("gcv")%> 
                    JinsLibrary.STATEMANAGE.Session.Self["PageName"] = "�޴���������";

                    GdsCellBaseLib.Self.gCode_id = Convert.ToInt32(Request.QueryString["gcid"]);
                    //����üũ
                    //if (!GdsCellBaseLib.Self.CanView())
                    //    ClientAction.ShowMsgBack("�ش� ������ �����ϴ�.");
                    //���ε�
                    CellViewBind();
                    //�����ʱ�ȭ
                    this.InitializeSetting();
                    //��ư�����ʱ�ȭ
                    //this.InitializeButtonCreation();
                }
            }
            else
            {
	            ClientAction.ShowMsgBack("�䱸�Ͻ� URL�� ������ �������� �ʽ��ϴ�.");
            }
        }



        //�����ʱ�ȭ
        private void InitializeSetting()
        {
            //�ڹٽ�ũ��Ʈ ������ ���
            if (!Page.ClientScript.IsClientScriptIncludeRegistered(this.GetType(), "shop"))
                Page.ClientScript.RegisterClientScriptInclude(this.GetType(), "shop", "/Shop/shop.js");

            //print area
            this.hlPrint.NavigateUrl = "javascript:GetPrint('print_area');"; //this.bnPrint.Attributes["Onclick"] = "GetPrint('print_area');";
        }

        /// <summary>
        /// ��ư�����ʱ�ȭ
        /// </summary>
        private void InitializeButtonCreation()
        {
            //����Ʈ�� ���� �����ΰ�
            hlList.NavigateUrl = GdsCellBaseLib.Self.GetWhichList(Request.QueryString["ml"]);
            if (GdsCellBaseLib.Self.CanAccess())
            {
                //������ư �����
                //ibModfy.ToolTip = "����";
                //ibModfy.Attributes["onClick"] = "return ConfirmJ('�����Ͻðڽ��ϱ�?');";
                //ibModfy.Visible = true;
            }
            if (GdsCellBaseLib.Self.CanStopPosting(this.gCode_id.Text))
            {
                //�Խ�������ư �����
                //ibStopPosting.ToolTip = "�Խ�����";
                //ibStopPosting.Attributes["onClick"] = "return ConfirmJ('�����Ͻðڽ��ϱ�?');";
                //ibStopPosting.Visible = true;
            }
            /*
            if(CanDelete(this.gcID) && ibDelete.Visible == false)
            {
                //����������ư �����
                ibEliminate.ToolTip = "��������";
                ibEliminate.Attributes["onClick"] = "return ConfirmJ('��ǰ�ڷḦ ������ �����Ͻðڽ��ϱ�?');";
                ibEliminate.Visible = true;
            }
            */
        }


        #region ��ǰ������ ���ε�
        private void CellViewBind()
        {            
            _dbUtil = new DBLib();
            string qryString = "Select gCode_id,gName,modelNbr,custPrice,newPrice,transPrice,joinPrice,USimmPrice,Mfger,keywords,specSummary,gOrder,status,fruitRate,postStart,postEnd,point,reserveFund,registerDT,updateDT,register,IPaddress"
                + " FROM t_GoodsCell WHERE gCode_id=" + GdsCellBaseLib.Self.gCode_id;
            qryString += ";Select fileName,fileDESC"
                + " FROM t_GdsCellFiles WHERE gCode_id=" + GdsCellBaseLib.Self.gCode_id + " AND fileName LIKE 'S2%'";
            qryString += ";Select scOptions, currStock "
                + " FROM t_CellStockCurrent WHERE gCode_id=" + GdsCellBaseLib.Self.gCode_id + " AND StkEnable = 1"
                + " ORDER BY scOrder DESC";
            SqlDataReader drGoods = _dbUtil.MyExecuteReader(qryString);
            if (drGoods.Read())			//�⺻����
            {
                //this.fvCell.Controls[gCode_id]//
                this.gCode_id.Text = drGoods["gCode_id"].ToString();
                this.modelNbr.Text = drGoods["modelNbr"].ToString();
                this.gName.Text = drGoods["gName"].ToString();
                Title = String.Format("�������� > �޴������� > {0}({1})", gName.Text, modelNbr.Text);
                this.keywords.Text = drGoods["keywords"].ToString();
                this.custPrice.Text = MathLib.GetComma(drGoods["custPrice"]);
                this.newPrice.Text = MathLib.GetComma(drGoods["newPrice"]);
                this.transPrice.Text = MathLib.GetComma(drGoods["transPrice"]);
                this.joinPrice.Text = MathLib.GetComma(drGoods["joinPrice"]);
                this.USimmPrice.Text = MathLib.GetComma(drGoods["USimmPrice"]);
                this.Mfger.Text = drGoods["Mfger"].ToString();
                //this.fruitRate.Text = MathLib.GetComma(drGoods["fruitRate"]);
                //this.gOrder.Text = MathLib.GetComma(drGoods["gOrder"]);
                this.point.Text = MathLib.GetComma(drGoods["point"]);
                this.reserveFund.Text = MathLib.GetComma(drGoods["reserveFund"]);
                //this.registerDT.Text = drGoods["registerDT"].ToString();
                //this.updateDT.Text = drGoods["updateDT"].ToString();
                //this.register.Text = drGoods["register"].ToString();
                this.specSummary.Text = drGoods["specSummary"].ToString();
                this.status.Text = GdsCellBaseLib.Self.GetStatusText(drGoods["status"]);
                if (drGoods["status"].ToString() == "10")
                {
                    hlAskPrice.Visible = true;
                    hlAskPrice.NavigateUrl = "/CustomerServices/QnA/QnA_Master.aspx?qgrp=quota&qgi=" + Server.UrlEncode(modelNbr.Text);
                }
                hlAskGoods.NavigateUrl = "/CustomerServices/QnA/QnA_Master.aspx?qnaCX=form&qgrp=gds&qgi=" + Server.UrlEncode(modelNbr.Text);

                //Response.Write(drGoods["status"].ToString());
                //�ԽñⰣ
                string postEnd = drGoods["postEnd"].ToString();			//�Խ�������
                this.litDisplayTerm.Text = drGoods["postStart"].ToString() + " ~ ";
                if (postEnd != "")
                    this.litDisplayTerm.Text += postEnd;
                else
                    this.litDisplayTerm.Text += "�����Խ�";

                //Ư����ǰ����
                if (GdsCellBaseLib.Self.IsPopularGoods(this.gCode_id.Text))
                {
                    this.GoodsClass.Text = "�α��ǰ, ";
                    imgPopular.ImageUrl = "/Shop/Images/popular.gif";
                    imgPopular.Visible = true;
                }

                SortedList slSG = GdsCellBaseLib.Self.GetSpecificGcID(this.gCode_id.Text);
                for (int i = 0; i < slSG.Count; i++)
                {
                    //Response.Write(String.Format("\t{0}:\t{1}", slSG.GetKey(i), slSG.GetByIndex(i)));
                    this.GoodsClass.Text += slSG.GetByIndex(i) + ", ";
                    if (slSG.GetKey(i).ToString() == "1")
                    {
                        imgRecommand.Visible = true;
                    }
                    else if (slSG.GetKey(i).ToString() == "3")
                    {
                        imgBest.Visible = true;
                    }
                    else if (slSG.GetKey(i).ToString() == "5")
                    {
                        imgSpecial.Visible = true;
                    }
                }
                if (GoodsClass.Text.Length > 2)
                    this.GoodsClass.Text = GoodsClass.Text.Substring(0, GoodsClass.Text.Length - 2);

                //��ǰ������ ����
                _GdsUploadDir = SystemConfig.GetValue("GdsUploadDir") + "GC" + this.gCode_id.Text + "/";
                this.hlLargeImages.NavigateUrl = "javascript:GoLargeImageView('" + GdsCellBaseLib.Self.gCode_id + "');";

                //htmlPage������Ȯ��
                string htmlPage = "";
                //if (drGoods["htmlPage"].ToString() != "")
                //    htmlPage = drGoods["htmlPage"].ToString();
                //else
                htmlPage = _GdsUploadDir + "Detail_" + gCode_id.Text + ".html";

                //Detail.htmlȮ��
                if (FileLib.Self.FileExist(htmlPage))
                {
                    pnDetailedHTML.Visible = true;
                    //WebUtil.CurrentResponse.Write("htmlPage = " + htmlPage);
                    this.litHTML.Text = FileLib.Self.LoadHtmlPage(Application["BaseHref"].ToString(), htmlPage);
                    //this.litHTML.Text = GdsCellBaseLib.Self.LoadHtmlPage(Application["BaseHref"].ToString(), htmlPage);
                }
                //else if (drGoods["htmlPage"].ToString() != "")
                //{
                //    pnDetailedHTML.Visible = true;
                //    this.litHTML.Text = "���ϰ�ο���";
                //}

                //string strSendonemail	= this.MbrName.Text + " <" + this.hlEmail.Text +">;";
                //this.hlEmail.NavigateUrl = "../Mine/Mail/MailForm.aspx?s=" + strSendonemail;
                if (drGoods.NextResult())	//�̹�����������
                {
                    if (drGoods.HasRows)
                    {
                        this.hlLargeImages.Visible = true;
                        this.dlGdsImages.DataSource = drGoods;
                        this.dlGdsImages.DataBind();		//���ε��ϱ� ���� drGds.Read();���� ����.
                    }
                }
                if (drGoods.NextResult())	//��Ź����
                {
                    while (drGoods.Read())
                    {
                        this.currStock.Text += drGoods["scOptions"].ToString()  + " => " + drGoods["currStock"].ToString() + "<br>&nbsp;&nbsp;";
                    }
                    if (this.currStock.Text == "")
                        this.currStock.Text = "���������ƴ�";
                }
                //DR,DB�ݱ�
                drGoods.Close();
                _dbUtil.SqlConnection.Close();
            }
            else
			{
	            CompanyItems_CIMasterPage_wide master = this.Master;    //MainMasterPage master = (MainMasterPage)this.Master;
                master.FindControl("ucClientMessage").Visible = true;
                master.LitMsgText = "The Goods Don't Exist!!";
                master.LitDetailsText = "�䱸�Ͻ� ��ǰ�� ������ �������� �ʽ��ϴ�.";
                master.HlBackVisible = true;
                tblCellView.Visible = false;
			}
        }

        private void GoodsStockViewBind()
        {

        }
        #endregion





        //protected void ibModfy_Click(object sender, ImageClickEventArgs e)
        //{
        //    ibModfy.Visible = false;
        //    GdsCellBaseLib.Self.Modify(this.gCode_id.Text);
        //}

        //protected void ibEliminate_Click(object sender, ImageClickEventArgs e)
        //{
        //    //ibEliminate.Visible = false;
        //    //Eliminate(this.gCode_id.Text);
        //}
        //protected void ibStopPosting_Click(object sender, ImageClickEventArgs e)
        //{
        //    ibStopPosting.Visible = false;
        //    GdsCellBaseLib.Self.Delete(this.gCode_id.Text);
        //}


        protected void dlGdsImages_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                //((Literal)e.Item.FindControl("litIDX")).Text = e.Item.ItemIndex.ToString();

                //���ϸ�ũ
                //HyperLink hlEmail = (HyperLink)e.Item.FindControl("hlEmail");
                //string strSendonemail = ((System.Data.Common.DbDataRecord)e.Item.DataItem).GetValue(2) + " <" + hlEmail.ToolTip +">;";
                //hlEmail.NavigateUrl = "../Mine/Mail/MailForm.aspx?m=" + strSendonemail;
                //URLQuery.Self["gcID"] = ((System.Data.Common.DbDataRecord)e.Item.DataItem).GetValue(0).ToString();

                string standardImgText;
                _gfName = ((System.Data.Common.DbDataRecord)e.Item.DataItem).GetValue(0).ToString();
                //�̹���ó��
                System.Web.UI.WebControls.Image imgGdsImages = (System.Web.UI.WebControls.Image)e.Item.FindControl("imgGdsImages");
                imgGdsImages.ImageUrl = _GdsUploadDir + _gfName;
                imgGdsImages.Attributes["style"] = "CURSOR: hand";
                if (_gfName.IndexOf("Basic") > 0)
                {
                    standardImgText = "Basic";
                    imgGdsImages.ToolTip = "ǥ�غ���";
                    //�⺻����Ʈ��
                    this.imgGoods.ImageUrl = _GdsUploadDir + _gfName;
                }
                else if (_gfName.IndexOf("Front") > 0)
                {
                    standardImgText = "Front";
                    imgGdsImages.ToolTip = "���麸��";
                }
                else if (_gfName.IndexOf("Left") > 0)
                {
                    standardImgText = "Left";
                    imgGdsImages.ToolTip = "�����麸��";
                }
                else if (_gfName.IndexOf("Rear") > 0)
                {
                    standardImgText = "Rear";
                    imgGdsImages.ToolTip = "�ĸ麸��";
                }
                else if (_gfName.IndexOf("Right") > 0)
                {
                    standardImgText = "Right";
                    imgGdsImages.ToolTip = "�����麸��";
                }
                else if (_gfName.IndexOf("Top") > 0)
                {
                    standardImgText = "Top";
                    imgGdsImages.ToolTip = "���麸��";
                }
                else if (_gfName.IndexOf("Bottom") > 0)
                {
                    standardImgText = "Bottom";
                    imgGdsImages.ToolTip = "�Ʒ��麸��";
                }
                else if (_gfName.IndexOf("Inside") > 0)
                {
                    standardImgText = "Inside";
                    imgGdsImages.ToolTip = "���κ���";
                }
                else if (_gfName.IndexOf("Magnify") > 0)
                {
                    standardImgText = "Magnify";
                    imgGdsImages.ToolTip = "Ȯ�뺸��";
                }
                else if (_gfName.IndexOf("Ani") > 0)
                {
                    standardImgText = "Ani";
                    imgGdsImages.ToolTip = "�ִϸ��̼Ǻ���";
                }
                else
                {
                    standardImgText = _gfName.Substring(3, 5);
                    standardImgText.Replace("-", "");
                    imgGdsImages.ToolTip = ((System.Data.Common.DbDataRecord)e.Item.DataItem).GetValue(1).ToString();
                }
                imgGdsImages.Attributes["OnMouseover"] = "javascript:forms[0]." + imgGoods.ClientID + ".src = " + imgGdsImages.ClientID + ".src;";
            }

            /*
                        else if(e.Item.ItemType == ListItemType.Header)
                        {
                            Literal litSearchResult = (Literal)e.Item.FindControl("litSearchResult");
                            Literal litListBrief = (Literal)e.Item.FindControl("litListBrief");

                            litSearchResult.Text = this.SearchResultDisplay(this.tbSearchString.Text);
                            litListBrief.Text = Paging.Self.ListSummary;
                            //���� ���°� �޸𸮷� �ø�(���������� ����)
                            SetQueryString();
                            #region ����¡��ɱ���
                            Paging.Self.Init_Violet();
                            this.litPaging.Text = Paging.Self.GeneratePaging();
                            #endregion
                        }
                        else if(e.Item.ItemType == ListItemType.Footer)
                        {
                            //����¡����� ���⿡ �����Ǿ�� �ϳ� �������̽��� �����Ƿ� ������� ����
                            //Literal litPaging = (Literal)e.Item.FindControl("litPaging");
                        }
            */
        }

    }
}