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

//using Neovis.Web.Boards.Business;
//using Neovis.Web.Member.Business;

using MiddleTier.Boards.Comment;
using MiddleTier.Boards.Business;

using JinsLibrary;
using JinsLibrary.STATEMANAGE;


namespace KistelSite.CommonApps.Boards.Forum
{
	/// <summary>
	/// comment_delete�� ���� ��� �����Դϴ�.
	/// </summary>
	public class ForumCmt_delete : System.Web.UI.Page //Neovis.Web.Homepage.RootPage 
	{
		protected int id, cid, pageNo;
		protected string db;

		private void Page_Load(object sender, System.EventArgs e)
		{
			//�α��εǾ����� Ȯ��
			KistelSite.Admins.CompanyMgr.Staffs.LoginProcess.LoginOK();

			// ���⿡ ����� �ڵ带 ��ġ�Ͽ� �������� �ʱ�ȭ�մϴ�.
			//if(Context.User.Identity.IsAuthenticated)
			//{
				if (Request.QueryString["db"] == null)
					ClientAction.ShowMsgBack("���̺���� �����ϴ�. �ٽ� �����Ͻʽÿ�.");
				else
					db = Request.QueryString["db"];

				id = int.Parse(Request.QueryString["id"]);
				cid = int.Parse(Request.QueryString["cid"]);
				pageNo = int.Parse(Request.QueryString["pageno"]);

				//CommentBiz objComment = new CommentBiz(db+"Comment", cid);
				BrdsCmtBiz objComment = new BrdsCmtBiz(db+"Comment", cid);

			
			//Response.Write("--> " + objComment.UserID);
			
				//if (objComment.UserID == Context.User.Identity.Name)
				if (objComment.UserID == Cookie.Self["staff_id"])
				{
					int rowsAffected = objComment.Delete(cid);

					if(rowsAffected == 1)
					{
						Response.Redirect("ForumView.aspx?db="+db+"&id="+id+"&pageno="+pageNo);
					}
					else
					{
						ClientAction.ShowMsgBack("�ڸ�Ʈ ������ �����Ͽ����ϴ�.");
					}
				}
			
			//}
		}

		#region Web Form �����̳ʿ��� ������ �ڵ�
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: �� ȣ���� ASP.NET Web Form �����̳ʿ� �ʿ��մϴ�.
			//
			base.OnInit(e);
			InitializeComponent();
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
