namespace KistelSite.CommonApps.BoardPR
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;

	using JinsLibrary;
	using JinsLibrary.LIST;
	using JinsLibrary.CONFIG;
	using JinsLibrary.STATEMANAGE;
	/// <summary>
	///		BoardPR�� ���� ��� �����Դϴ�.
	/// </summary>
	public class BoardPR : System.Web.UI.UserControl
	{
		private DBLib dbUtil;
		private DataSet dsPR;
		private JinsLibrary.FILE.FileLib fUtil;
		
		protected System.Web.UI.UserControl	InfoMessages;
		protected System.Web.UI.WebControls.TextBox tbSearchString;
		protected System.Web.UI.WebControls.ImageButton ibSearch;
		protected System.Web.UI.WebControls.RegularExpressionValidator RegularExpressionValidator1;
		protected System.Web.UI.WebControls.RequiredFieldValidator RequiredFieldValidator2;
		protected System.Web.UI.WebControls.Repeater rptPR;
		protected System.Web.UI.WebControls.HyperLink hlList;

		private void Page_Load(object sender, System.EventArgs e)
		{
			if(!Page.IsPostBack) 
			{
				//�ʱ�ȭ
				this.InitializeSetting();
				//���� �������� �����մϴ�.      -1
				Paging.Self.SetCurrentPage(WebUtil.CurrentRequest["cp"]);
				this.PR_Bind();
			}	
		}
		//�ʱ�ȭ
		private void InitializeSetting()
		{
			this.hlList.NavigateUrl = Request.Path;
		}

		public string SearchResultDisplay(string srdMsg)
		{
			if(srdMsg != "")
				srdMsg =  "�˻���� : '<b>" + srdMsg + "</b>'�� �˻��� ����Դϴ�";
			return srdMsg;
		}
		#region IR�����͹��ε� ���ε�
		protected void PR_Bind()
		{			
			string fieldNames,whereClause,orderBy;
			fieldNames = "da_id,daName,daDescription";
			whereClause = "daStatus = 255 And daType='�������(IR)'"; //
			if(tbSearchString.Text.Trim() != "")
			{
				Paging.Self.SetCurrentPage(1);
				string search = HTML.ReplaceToDB(tbSearchString.Text);
				whereClause += " AND (daName LIKE '%" + search + "%'";
				whereClause += " OR daDescription LIKE '%" + search + "%')";
				//Response.Write("tbSearchString.Text=>> " + tbSearchString.Text);
			}
			
			orderBy = "da_id DESC";
			string subQryOrderBy = "da_id ASC";	//orderBy�� �ݴ�	
			
			//�������������ʱ�ȭ
			int topCnt;
			topCnt = Paging.Self.PageSize(10);
			dbUtil = new DBLib();
			//�ѷ��ڵ�� ����
			Paging.Self.TotRecordCount = dbUtil.GetRecordCount("t_DocumentAssets",whereClause);
			//������� ����, AbsolutePage�� ���� ��Ȱ�� �Ѵ�. �� �������� ������ �����ؾ� �Ѵ�//Paging.Self.SetPagePortion();
			//������������
			dsPR = dbUtil.Select_DS(topCnt,fieldNames,"t_DocumentAssets",whereClause,orderBy,Paging.Self.SetPagePortion(), subQryOrderBy);
			dbUtil.SqlConnection.Close();
			
			if(dsPR.Tables["t_DocumentAssets"].Rows.Count>0) 
			{
				this.rptPR.DataSource = dsPR.Tables["t_DocumentAssets"];
				this.rptPR.DataBind();
				rptPR.Visible = true;
				InfoMessages.Visible = false;
			}
			else 
			{
				rptPR.Visible = false;
				//����������Ʈ�� ���ε�
				//InfoMessages.LoadControl("../InfoMessages/InfoMessages.ascx");
				Literal lit = (Literal)InfoMessages.FindControl("litMsg");
				Literal litDetails = (Literal)InfoMessages.FindControl("litDetails");
				lit.Text = "�ڷᰡ �����ϴ�.";					
				litDetails.Text = SearchResultDisplay(this.tbSearchString.Text);
				InfoMessages.Visible = true;
				//Response.Write(InfoMessages.);
			}			
		}
		#endregion
		#region �������ϸ���Ʈ ���ε�
		protected void PRFileListBind(string df_id)
		{
			string fieldNames,whereClause,orderBy;
			fieldNames = "df_id,dfOrder,dfName,dfDescription,dfOriginName";
			whereClause = "df_id=" + df_id;
			orderBy = "dfOrder ASC";
			dbUtil = new DBLib();
			dsPR = dbUtil.Select_DS(fieldNames,"t_DocFileAssets",whereClause,orderBy);
			dbUtil.SqlConnection.Close();
		
		}
		#endregion
		private void rptPR_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
		{
			if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
			{
				//((Literal)e.Item.FindControl("litIDX")).Text = e.Item.ItemIndex.ToString();
				Label daName = (Label)e.Item.FindControl("daName"); // Text??	
				daName.ToolTip = daName.Text;
				daName.Text = Text.ShortenUniString(daName.Text, 100);
				
				Literal daDescription = (Literal)e.Item.FindControl("daDescription");
				daDescription.Text = HTML.ReplaceToHTML(daDescription.Text);


				Literal df_id = (Literal)e.Item.FindControl("df_id");
				this.PRFileListBind(df_id.Text);

				Repeater rptPRFile = (Repeater)e.Item.FindControl("rptPRFile");
				rptPRFile.DataSource = dsPR.Tables["t_DocFileAssets"];
				rptPRFile.DataBind();
				
				//dsPR.Tables["t_DocFileAssets"].Clear();
				dsPR.Clear();
			}
			else if(e.Item.ItemType == ListItemType.Header)
			{
				Literal litSearchResult = (Literal)e.Item.FindControl("litSearchResult");
				Literal litListBrief = (Literal)e.Item.FindControl("litListBrief");
				if(this.tbSearchString.Text != "")
				{
					litSearchResult.Visible = true;
					litSearchResult.Text = this.SearchResultDisplay(this.tbSearchString.Text);
				}
				else
					litSearchResult.Visible = false;
				litListBrief.Text = Paging.Self.ListSummary;

				//Response.Write("tbSearchString.Text= " + tbSearchString.Text);
			}
			else if(e.Item.ItemType == ListItemType.Footer) 
			{
				Literal litPaging = (Literal)e.Item.FindControl("litPaging");
				#region ����¡��ɱ���
				//���� ����� �ٽ� ä���־�~
				URLQuery.Self.SetQueryString();
				Paging.Self.Init_Violet();
				litPaging.Text = Paging.Self.GeneratePaging();
				#endregion
			}
		}
		
		protected void rptPRFile_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
		{
			if (e.CommandName == "select")
			{
				//dlFiles.EditItemIndex = -1;  
				//dlFiles.SelectedIndex = e.Item.ItemIndex;
				//BindDataList();
				Literal lit = (Literal)e.Item.Parent.Parent.FindControl("df_id");
				string df_id		= lit.Text;
				string dfOrder		= ((System.Web.UI.WebControls.Image)e.Item.FindControl("imgExtIcon")).AlternateText;
				string dfName		= e.CommandArgument.ToString();
				string dfOriginName = ((LinkButton)e.Item.FindControl("dfOriginName")).Text; // Text??

				//���ϴٿ�ε�� ���� -- �ٿ���� �� �����ؾ� �ϴµ�.....
				dbUtil = new DBLib();
				dbUtil.ChangeFigure("t_DocFileAssets", "dfDLcount", 1, "df_id=" + df_id + " And dfOrder=" + dfOrder);
				dbUtil.SqlConnection.Close();

				//���ϴٿ�ε�
				fUtil = new JinsLibrary.FILE.FileLib();
				fUtil.Open(SystemConfig.GetValue("DocUploadDir") + dfName);
				fUtil.DownLoad(dfOriginName);
			}  
		}
		
		//���ϻ�����˾Ƴ���
		protected string GetFileSize(object dfName)
		{
			JinsLibrary.FILE.FileLib fUtil = new JinsLibrary.FILE.FileLib();
			if(fUtil.FileExists(SystemConfig.GetValue("DocUploadDir") + dfName))
			{
				return MathLib.GetFileSizeUnit(fUtil.Length).ToString();
			}
			else
				return "-";
		}
		protected string GetExtIconUrl(object dfOriginName)
		{
			return "/Images/FileExtensions/" + JinsLibrary.IMAGE.ImageLib.Self.GetFileExtIconName(dfOriginName.ToString());
		}

		private void ibSearch_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
			
			//this.PR_BindValidate();
			//this.tbSearchString.TextChanged -= new System.EventHandler(this.tbSearchString_TextChanged);
		}
		private void tbSearchString_TextChanged(object sender, System.EventArgs e)
		{
			this.PR_BindValidate();
			//this.ibSearch.Click -= new System.Web.UI.ImageClickEventHandler(this.ibSearch_Click);
		}
		private void PR_BindValidate()
		{
			Page.Validate();
			//Response.Write("Page.IsValid = " + Page.IsValid.ToString() + "<br>");
			if(!Page.IsValid)
				return;
			else
				this.PR_Bind();
			//ClientAction.ShowMsgBack("��Ȯ�� �Է��ϼ���.");
		}
		#region Web Form �����̳ʿ��� ������ �ڵ�
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: �� ȣ���� ASP.NET Web Form �����̳ʿ� �ʿ��մϴ�.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// �����̳� ������ �ʿ��� �޼����Դϴ�.
		/// �� �޼����� ������ �ڵ� ������� �������� ���ʽÿ�.
		/// </summary>
		private void InitializeComponent()
		{    
			this.tbSearchString.TextChanged += new System.EventHandler(this.tbSearchString_TextChanged);
			this.rptPR.ItemDataBound += new System.Web.UI.WebControls.RepeaterItemEventHandler(this.rptPR_ItemDataBound);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		
	}
}
