using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using JinsLibrary;
using JinsLibrary.LIST;
using JinsLibrary.STATEMANAGE;

namespace KistelSite.CommonApps.BoardNews
{
	/// <summary>
	/// bnList�� ���� ��� �����Դϴ�.
	/// </summary>
	public class bnsList : System.Web.UI.Page
	{
		string bnsG;
		protected System.Web.UI.WebControls.Label lbNews;
		protected System.Web.UI.WebControls.Label lbPaging;
		protected System.Web.UI.WebControls.Label lbListBrief;
		protected System.Web.UI.WebControls.DataList dlNewsList;

		private void Page_Load(object sender, System.EventArgs e)
		{
			//� �׷��� ����Ʈ�� ������ ���ΰ�?
			this.bnsG = Request.QueryString["bnsG"];
			if(!Page.IsPostBack) 
			{
				//������Ÿ��Ʋ
				JinsLibrary.STATEMANAGE.Session.Self["PageName"] = "��ǰ���ⴺ�����";

				//���� �������� �����մϴ�.      -1
				Paging.Self.SetCurrentPage(WebUtil.CurrentRequest["cp"]);
				//�����͹��̵�
				this.NewsListBind();
			}
		}

		
		#region �������׸���Ʈ ���ε�
		protected void NewsListBind()
		{
			DBLib dbUtil = new DBLib();
		
			//�������������ʱ�ȭ
			int topCnt;
			topCnt = Paging.Self.PageSize();
			
			string fieldNames,tableName,whereClause,orderBy;
			fieldNames = "bNews_id,bnsGroup,bnsTitle,ISNULL(modifyDT, writeDT) as newsDay,bnsOrder";
			tableName = "t_BoardNews";
			whereClause = "bnsStatus > 1";
			if(bnsG != null) whereClause += " AND bnsGroup ='" +  bnsG + "'";
			orderBy = "bnsOrder DESC,bNews_id DESC";		
			//SqlDataReader drNews = dbUtil.Select_DR(topCnt,fieldNames,tableName,whereClause,orderBy);
			string subQryOrderBy = "bnsOrder ASC,bNews_id ASC";		
			
			//�ѷ��ڵ�� ����
			Paging.Self.TotRecordCount = dbUtil.GetRecordCount("t_BoardNews",whereClause);			
			//Paging.Self.SetPagePortion(); ������� ����, AbsolutePage�� ���� ��Ȱ�� �Ѵ�. �� �������� ������ �����ؾ� �Ѵ�
			//������������
			SqlDataReader drNews = dbUtil.Select_DR(topCnt,fieldNames,tableName,whereClause,orderBy, Paging.Self.SetPagePortion(), subQryOrderBy);
	//Response.End();

			if(drNews.HasRows) {
				this.dlNewsList.DataSource = drNews;
				this.dlNewsList.DataBind();
				
				#region ����¡��ɱ���
				//���� ����� �ٽ� ä���־�~
				URLQuery.Self.SetQueryString();

				Paging.Self.Init_Violet();
				this.lbPaging.Text = Paging.Self.GeneratePaging();
				this.lbListBrief.Text = Paging.Self.ListSummary;
				#endregion		
			}
			else 
			{
				lbNews.Visible = true;
			}
			drNews.Close();
			dbUtil.SqlConnection.Close();
		}
		#endregion

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
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

	}
}
