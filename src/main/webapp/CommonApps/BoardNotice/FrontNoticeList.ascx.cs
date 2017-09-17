namespace KistelSite.CommonApps.BoardNotice
{
	using System;
	using System.Data;
	using System.Data.SqlClient;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	
	using JinsLibrary;
	
	//using jc = JinsLibrary.CommonLibrary;

	/// <summary>
	///		NoticeList�� ���� ��� �����Դϴ�.
	/// </summary>
	public class FrontNoticeList : System.Web.UI.UserControl
	{
		protected System.Web.UI.WebControls.Panel pnlNotice;
		protected System.Web.UI.WebControls.HyperLink hlMoreList;
		protected System.Web.UI.WebControls.Repeater rptNotice;

		private void Page_Load(object sender, System.EventArgs e)
		{
			if(!Page.IsPostBack) 
			{
				this.NoticeBind();
			}
		}
		
		#region �������� ���ε�
		protected void NoticeBind()
		{
			DBLib dbUtil = new DBLib();
			string qryString;
			qryString = "Select Top 5 bNotice_id,bnTitle,ISNULL(modifyDT, writeDT) as noticeDay";
			qryString +=" FROM t_BoardNotice ";
			qryString +=" WHERE bnStatus > 1 ";
			qryString +=" Order By bnOrder DESC, bNotice_id DESC";
			
			SqlDataAdapter daNotice = new SqlDataAdapter(qryString, dbUtil.SqlConnection);
			DataSet dsNotice = new DataSet();
			daNotice.Fill(dsNotice, "BoardNotice");
			dbUtil.SqlConnection.Close();
			
			this.rptNotice.DataSource = dsNotice;
			this.rptNotice.DataMember = "BoardNotice";
			this.rptNotice.DataBind();		

			if(this.rptNotice.Items.Count <= 0)
			{
				this.rptNotice.Visible = false;
				this.pnlNotice.Visible = true;	
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
