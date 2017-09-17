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



namespace KistelSite.CommonApps.BoardNotice
{
	/// <summary>
	/// bnList�� ���� ��� �����Դϴ�.
	/// </summary>
	public class bnList : System.Web.UI.Page
	{
		string bnG;
		protected System.Web.UI.WebControls.Label lbNotice;
		protected System.Web.UI.WebControls.Label lbPaging;
		protected System.Web.UI.WebControls.Label lbListBrief;
		protected System.Web.UI.WebControls.DataList dlNoticeList;

		private void Page_Load(object sender, System.EventArgs e)
		{
			//� �׷��� ����Ʈ�� ������ ���ΰ�?
			this.bnG = Request.QueryString["bnG"];
			if(!Page.IsPostBack) 
			{
				//������Ÿ��Ʋ
				JinsLibrary.STATEMANAGE.Session.Self["PageName"] = "�������׸��";

				//���� �������� �����մϴ�.      -1
				Paging.Self.SetCurrentPage(WebUtil.CurrentRequest["cp"]);
				//�����͹��̵�
				this.NoticeListBind();
			}
		}

		
		#region �������׸���Ʈ ���ε�
		protected void NoticeListBind()
		{
			DBLib dbUtil = new DBLib();
		
			//�������������ʱ�ȭ
			int topCnt;
			topCnt = Paging.Self.PageSize();
			
			string fieldNames,tableName,whereClause,orderBy;
			fieldNames = "bNotice_id,bnGroup,bnTitle,ISNULL(modifyDT, writeDT) as noticeDay,bnOrder";
			tableName = "t_BoardNotice";
			whereClause = "bnStatus > 1";
			if(bnG != null) whereClause += " AND bnGroup ='" +  bnG + "'";
			orderBy = "bnOrder DESC,bNotice_id DESC";		
			//SqlDataReader drNotice = dbUtil.Select_DR(topCnt,fieldNames,tableName,whereClause,orderBy);
			string subQryOrderBy = "bnOrder ASC,bNotice_id ASC";		
			
			//�ѷ��ڵ�� ����
			Paging.Self.TotRecordCount = dbUtil.GetRecordCount("t_BoardNotice",whereClause);			
			//Paging.Self.SetPagePortion(); ������� ����, AbsolutePage�� ���� ��Ȱ�� �Ѵ�. �� �������� ������ �����ؾ� �Ѵ�
			//������������
			SqlDataReader drNotice = dbUtil.Select_DR(topCnt,fieldNames,tableName,whereClause,orderBy, Paging.Self.SetPagePortion(), subQryOrderBy);
	//Response.End();

			if(drNotice.HasRows) {
				this.dlNoticeList.DataSource = drNotice;
				this.dlNoticeList.DataBind();
				
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
				lbNotice.Visible = true;
			}
			drNotice.Close();
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
