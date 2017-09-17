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
using MiddleTier.Boards.Business;
//using Neovis.Web.Member.Business;

using JinsLibrary;
using JinsLibrary.STATEMANAGE;

namespace KistelSite.CommonApps.Boards.Forum
{
	/// <summary>
	/// reply�� ���� ��� �����Դϴ�.
	/// </summary>
	public class ForumReply : System.Web.UI.Page //Neovis.Web.Homepage.RootPage 
	{
		protected System.Web.UI.WebControls.TextBox Subject;
		protected System.Web.UI.WebControls.RequiredFieldValidator Requiredfieldvalidator3;
		protected System.Web.UI.WebControls.CheckBox HtmlCheck;
		protected System.Web.UI.WebControls.Label ReplyLabel;
		protected System.Web.UI.WebControls.TextBox Content;
		protected System.Web.UI.WebControls.RequiredFieldValidator Requiredfieldvalidator4;
		protected System.Web.UI.WebControls.ImageButton RegisterButton;

		protected string db;
		protected int pageNo, id;
		protected string content;
	
		private void Page_Load(object sender, System.EventArgs e)
		{
			// ���⿡ ����� �ڵ带 ��ġ�Ͽ� �������� �ʱ�ȭ�մϴ�.
			if (Request.QueryString["db"] == null)
			{
				ClientAction.ShowMsgBack("���̺���� �����ϴ�. �ٽ� �����Ͻʽÿ�.");
			}
			else
			{
				db = Request.QueryString["db"];

				if (Request.QueryString["pageno"] == null)
					pageNo = 1;
				else
					pageNo = int.Parse(Request.QueryString["pageno"]);

				// ���̺� ���� ���� ��쿡 ���������� �ִ��� Ȯ��
				//if (!Context.User.Identity.IsAuthenticated)
				//{
				//	ErrorLogin("?db=" + db + "&pageno=" + pageNo + "&id=" + Request.QueryString["id"]);
				//}
				//else
				//{
					id = int.Parse(Request.QueryString["id"]);
					if (!Page.IsPostBack)
					{
						QnaBiz objBoard = new QnaBiz(db, id);
				
						if (objBoard.Html)
							content = objBoard.Content;
						else
						{
							content = Server.HtmlEncode(objBoard.Content);
							content = content.Replace("\n","\n<br>");
						}

						ViewState["refID"] = objBoard.RefID;
						ViewState["reStep"] = objBoard.ReStep;
						ViewState["reLevel"] = objBoard.ReLevel;
					}
				//}
			}
		}

		private void RegisterButton_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
			int result;
			int refID, reStep, reLevel;

			string writer, email, passwd, content;
			//SiteIdentity currUser = (SiteIdentity)Context.User.Identity;

			content = Request.Form["WebEditor"];

			refID = (int)ViewState["refID"];
			reStep = (int)ViewState["reStep"];
			reLevel = (int)ViewState["reLevel"];

			if(IsValid)
			{
				QnaBiz objBoard = new QnaBiz(db);

				writer = Cookie.Self["sName"]; //currUser.NickName;
				email = Cookie.Self["sEmail"]; //currUser.Email;
				passwd = Cookie.Self["staff_id"];//currUser.UserID;

				result = objBoard.Insert(Subject.Text, writer, email, passwd, HtmlCheck.Checked, refID, reStep, reLevel, content);

				if (result == 1)
				{
					Response.Redirect("ForumList.aspx?db="+db);
				}
				else
				{
					ClientAction.ShowMsgBack("��Ͽ� �����Ͽ����ϴ�.");
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
			this.RegisterButton.Click += new System.Web.UI.ImageClickEventHandler(this.RegisterButton_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
