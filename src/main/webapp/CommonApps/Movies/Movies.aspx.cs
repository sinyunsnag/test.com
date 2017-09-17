using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace KistelSite.CommonApps.Movies
{
	/// <summary>
	/// Movies�� ���� ��� �����Դϴ�.
	/// </summary>
	public class Movies : System.Web.UI.Page
	{
		protected System.Web.UI.WebControls.LinkButton lbTermi;
		protected System.Web.UI.WebControls.Literal litPlayList;
	
		private void Page_Load(object sender, System.EventArgs e)
		{
			// ���⿡ ����� �ڵ带 ��ġ�Ͽ� �������� �ʱ�ȭ�մϴ�.
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
			this.lbTermi.Click += new System.EventHandler(this.lbTermi_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void lbTermi_Click(object sender, System.EventArgs e)
		{
			litPlayList.Text = "mms://211.238.38.238/test.wsx";
		}
	}
}
