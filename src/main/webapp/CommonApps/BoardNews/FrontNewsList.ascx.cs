using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using JinsLibrary;
//using jc = JinsLibrary.CommonLibrary;

namespace KistelSite.CommonApps.BoardNews
{
	/// <summary>
	///		NoticeList�� ���� ��� �����Դϴ�.
	/// </summary>
	public class FrontNewsList : System.Web.UI.UserControl
	{
		protected System.Web.UI.WebControls.Panel pnNews;
		protected System.Web.UI.WebControls.Panel pnlNotice;
		protected System.Web.UI.WebControls.HyperLink hlMoreList;
		protected System.Web.UI.WebControls.Repeater rptNews;

		private void Page_Load(object sender, System.EventArgs e)
		{
			// ���⿡ ����� �ڵ带 ��ġ�Ͽ� �������� �ʱ�ȭ�մϴ�.
			if(!Page.IsPostBack) 
			{
				this.NewsBind();
			}
		}
		
		#region ���� ���ε�
		protected void NewsBind()
		{
			DBLib dbUtil = new DBLib();
			string qryString;
			qryString = "Select Top 5 bNews_id,bnsTitle,ISNULL(modifyDT, writeDT) as newsDay";
			qryString +=" FROM t_BoardNews ";
			qryString +=" WHERE bnsStatus > 1 ";
			qryString +=" Order By bnsOrder DESC, bNews_id DESC";
			
			SqlDataAdapter daNews = new SqlDataAdapter(qryString, dbUtil.SqlConnection);
			DataSet dsNews = new DataSet();
			daNews.Fill(dsNews, "BoardNews");
			dbUtil.SqlConnection.Close();
			
			this.rptNews.DataSource = dsNews;
			this.rptNews.DataMember = "BoardNews";
			this.rptNews.DataBind();		

			if(this.rptNews.Items.Count <= 0)
			{
				this.rptNews.Visible = false;
				this.pnNews.Visible = true;				
			}
				
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
		///		�����̳� ������ �ʿ��� �޼����Դϴ�. �� �޼����� ������
		///		�ڵ� ������� �������� ���ʽÿ�.
		/// </summary>
		private void InitializeComponent()
		{
			this.Load += new System.EventHandler(this.Page_Load);
		}
		#endregion


	}
}
