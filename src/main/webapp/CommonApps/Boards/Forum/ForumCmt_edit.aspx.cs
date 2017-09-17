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
//using Neovis.Web.Member.Business;
//using Neovis.Web.Boards.Business;
using MiddleTier.Boards.Business;
using MiddleTier.Boards.Comment;

using JinsLibrary;
using JinsLibrary.STATEMANAGE;

namespace KistelSite.CommonApps.Boards.Forum
{
	/// <summary>
	/// comment_edit�� ���� ��� �����Դϴ�.
	/// </summary>
	public class ForumCmt_edit : System.Web.UI.Page //Neovis.Web.Homepage.RootPage 
	{
		protected System.Web.UI.WebControls.ImageButton EditButton;
		protected System.Web.UI.WebControls.TextBox Comment;

		protected string db;
		protected System.Web.UI.WebControls.RequiredFieldValidator RequiredFieldValidator1;
		protected int cid;
	
		private void Page_Load(object sender, System.EventArgs e)
		{
			//�α��εǾ����� Ȯ��
			KistelSite.Admins.CompanyMgr.Staffs.LoginProcess.LoginOK();

			// ���⿡ ����� �ڵ带 ��ġ�Ͽ� �������� �ʱ�ȭ�մϴ�.
			db = Request.QueryString["db"];
			cid = int.Parse(Request.QueryString["cid"]);

			if (!Page.IsPostBack)
			{
				//CommentBiz objComment = new CommentBiz(db+"Comment", cid);
				BrdsCmtBiz objComment = new BrdsCmtBiz(db+"Comment", cid);
				
				//if (Context.User.Identity.Name == objComment.UserID)
				if (Cookie.Self["staff_id"] == objComment.UserID)
					Comment.Text = objComment.Comment;
				else
				{
					ClientAction.ShowMsgAndClose("�������� ������ �ƴմϴ�");
					//ErrorLogin("?db="+db+"&cid="+cid);
				}
			}
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
			this.EditButton.Click += new System.Web.UI.ImageClickEventHandler(this.EditButton_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void EditButton_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
			//SiteIdentity currUser = (SiteIdentity)Context.User.Identity;
			if (IsValid)
			{
				//CommentBiz objComment = new CommentBiz(db+"Comment");
				BrdsCmtBiz objComment = new BrdsCmtBiz(db+"Comment");


				//if (Context.User.Identity.IsAuthenticated)
					//objComment.Update(cid, currUser.UserID, currUser.UserName, Comment.Text);
					objComment.Update(cid, Cookie.Self["staff_id"], Cookie.Self["sName"], Comment.Text);

				ClientAction.ReloadOpenerClose();
			}
		}
	}
}
