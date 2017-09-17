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


using MiddleTier.Boards.Business;
using MiddleTier.Boards.Comment;



using JinsLibrary;
using JinsLibrary.STATEMANAGE;

namespace KistelSite.CommonApps.Boards.Forum
{
	/// <summary>
	/// view�� ���� ��� �����Դϴ�.
	/// </summary>
	public class ForumView : System.Web.UI.Page //Neovis.Web.Homepage.RootPage 
	{
		protected System.Web.UI.WebControls.Label IDLabel;
		protected System.Web.UI.WebControls.Label WriterLabel;
		protected System.Web.UI.WebControls.Label RegDateLabel;
		protected System.Web.UI.WebControls.Label VisitedLabel;
		protected System.Web.UI.WebControls.Label SubjectLabel;
		protected System.Web.UI.WebControls.Label ContentLabel;
		protected System.Web.UI.WebControls.HyperLink ListLink;
		protected System.Web.UI.WebControls.HyperLink BackLink;
		protected System.Web.UI.WebControls.HyperLink NextLink;
		protected System.Web.UI.WebControls.HyperLink EditLink;
		protected System.Web.UI.WebControls.HyperLink ReplyLink;
		protected System.Web.UI.WebControls.DataList BoardList;
	
		protected string db;
		protected int pageNo, id;
		protected string keyField, keyWord;
		protected System.Web.UI.WebControls.ImageButton DeleteButton;
		protected System.Web.UI.WebControls.DataList CommentList;
		protected System.Web.UI.WebControls.ImageButton CommentButton;
		protected System.Web.UI.WebControls.TextBox Comment;
		protected System.Web.UI.HtmlControls.HtmlForm ViewForm;
		protected bool searchStatus = false;

		private void Page_Load(object sender, System.EventArgs e)
		{
			//�α��εǾ����� Ȯ��
			KistelSite.Admins.CompanyMgr.Staffs.LoginProcess.LoginOK();
			
			// ���⿡ ����� �ڵ带 ��ġ�Ͽ� �������� �ʱ�ȭ�մϴ�.
			DeleteButton.Attributes.Add("OnClick", "return confirm('�Խù��� ���� �Ͻðڽ��ϱ�?');");
			CommentButton.Attributes.Add("OnClick", "return confirm('�ڸ�Ʈ�� ��� �Ͻðڽ��ϱ�?');");
			string content;

			if (Request.QueryString["db"] == null)
				ClientAction.ShowMsgBack("���̺���� �������� �ʾҽ��ϴ�.");
			else
				db = Request.QueryString["db"];

			// �˻����� ������ ����
			if (Request.QueryString["keyword"] != null)
			{
				keyField = Request.QueryString["keyfield"];
				keyWord = Request.QueryString["keyword"];
				searchStatus = true;
			}

			// ���⿡ ����� �ڵ带 ��ġ�Ͽ� �������� �ʱ�ȭ�մϴ�.
			if (Request.QueryString["pageno"] == null)
				pageNo = 1;
			else
				pageNo = int.Parse(Request.QueryString["pageno"]);

			id = int.Parse(Request.QueryString["id"]);
			
			if (!Page.IsPostBack)
			{
				QnaBiz objBoard = new QnaBiz(db, id);

				// �Խ��� ID ���� ����
				if (!searchStatus)
					objBoard.GetBoardIDInfo(id);
				else
					objBoard.GetBoardIDInfo(id, keyField, keyWord);

				if(objBoard.Email != null)
				{
					WriterLabel.Text = "<a href='mailto:" + objBoard.Email + "'>" + objBoard.Writer + "</a>";
				}
				else
				{
					WriterLabel.Text = objBoard.Writer;
				}

				if (objBoard.ListNum == 0)
					IDLabel.Text = "-";
				else
					IDLabel.Text = objBoard.ListNum.ToString();

				RegDateLabel.Text = objBoard.RegDate;
				VisitedLabel.Text = objBoard.Visited.ToString();

				// �˻��� �� �� �� ��ȯ
				if (keyField == "subject")
				{
					SubjectLabel.Text = Server.HtmlEncode(objBoard.Subject).Replace(keyWord, "<b><font color=red>"+keyWord+"</font></b>");
				}
				else
				{
					SubjectLabel.Text = Server.HtmlEncode(objBoard.Subject);
				}

				content = objBoard.Content;
				if(objBoard.Html)
				{
					ContentLabel.Text = content;
				}
				else
				{
					content = Server.HtmlEncode(content);
					content = content.Replace("\n","\n<br>");

					ContentLabel.Text = content;
				}

				if (keyField == "content")
					ContentLabel.Text = ContentLabel.Text.Replace(keyWord, "<b><font color=red>"+keyWord+"</font></b>");

				if(objBoard.PrevID == 0)
					BackLink.ImageUrl = "Images/img/back2.gif";
				else
				{
					if (!searchStatus)
						BackLink.NavigateUrl = "ForumView.aspx?db="+db+"&pageno=" + pageNo + "&id=" + objBoard.PrevID;
					else
						BackLink.NavigateUrl = "ForumView.aspx?db="+db+"&pageno=" + pageNo + "&id=" + objBoard.PrevID + "&keyfield=" + keyField + "&keyword=" + Server.UrlEncode(keyWord);
				}

				if(objBoard.NextID == 0)
					NextLink.ImageUrl = "Images/img/next2.gif";
				else
				{
					if (!searchStatus)
						NextLink.NavigateUrl = "ForumView.aspx?db="+db+"&pageno=" + pageNo + "&id=" + objBoard.NextID;
					else
						NextLink.NavigateUrl = "ForumView.aspx?db="+db+"&pageno=" + pageNo + "&id=" + objBoard.NextID + "&keyfield=" + keyField + "&keyword=" + Server.UrlEncode(keyWord);
				}

				// ���
				if (!searchStatus)
					ListLink.NavigateUrl = "ForumList.aspx?db="+db+"&pageno="+pageNo;
				else
					ListLink.NavigateUrl = "ForumList.aspx?db="+db+"&pageno="+pageNo+"&keyfield="+keyField+"&keyword="+Server.UrlEncode(keyWord);


				ReplyLink.NavigateUrl = "ForumReply.aspx?db=" + db + "&pageno=" + pageNo + "&id=" + id;

				// �ڽ��� �Խù��� ���
				if (Context.User.Identity.Name == objBoard.Passwd)
				{
					//�亯, ���� �� ������ư ��ũ
					EditLink.NavigateUrl = "edit.aspx?db=" + db + "&pageno=" + pageNo + "&id=" + id;
				}
				else
				{
					EditLink.Visible = false;
					DeleteButton.Visible = false;
					objBoard.IncreaseVisited(id);
				}				

				if (objBoard.GetRefIDCount(db, objBoard.RefID) > 1)
				{
					BoardList.Visible = true;
					GetRefList(objBoard.RefID);
				}
			}

			CommentListBind();
		}

		private void CommentListBind()
		{
			// �ڸ�Ʈ ��� ���ε�
			BrdsCmtBiz objComment = new BrdsCmtBiz(db+"Comment");
			CommentList.DataSource = objComment.GetBoardList(id);
			CommentList.DataBind();
		}

		private void GetRefList(int refID)
		{
			QnaBiz objBoard = new QnaBiz(db);
			
			BoardList.DataSource = objBoard.GetRefList(refID);
			BoardList.DataBind();
		}

		protected string PageLinkURL(int boardID)
		{
			string path;
			if (id == boardID)
			{
				path = "";
			}
			else
			{
				if (!searchStatus)
					path = "ForumView.aspx?db="+db+"&id=" + boardID.ToString() + "&pageno=" + pageNo;
				else
					path = "ForumView.aspx?db="+db+"&id=" + boardID.ToString() + "&pageno=" + pageNo + "&keyfield=" + keyField + "&keyword=" + Server.UrlEncode(keyWord);
			}
			return path;
		}

		protected string ListNum(int listNum)
		{
			string listNumHtml = listNum.ToString();

			if (listNum == 0)
			{
				listNumHtml = "";
			}

			return listNumHtml;
		}

		protected string ReplyList(int reLevel)
		{
			string subjectHtml = "";

			if (reLevel != 0)
			{
				for (int i = 1; i <= reLevel; i++)
				{
					subjectHtml += "<img src='Images/img/blank.gif' border='0' width='15' height='7'>";
				}
				subjectHtml += "<img src='Images/img/re.gif' border='0' align='absmiddle'>";
			}

			return subjectHtml;
		}

		protected string GetSubject(int boardID, string subject)
		{
			if (id == boardID)
				return "<b>"+subject+"</b>";
			else
				return subject;

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
			this.DeleteButton.Click += new System.Web.UI.ImageClickEventHandler(this.DeleteButton_Click);
			this.CommentButton.Click += new System.Web.UI.ImageClickEventHandler(this.CommentButton_Click);
			this.ID = "Form";
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void DeleteButton_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
			int result, rowsAffected;

			if(IsValid)
			{
				QnaBiz objBoard = new QnaBiz(db);
				result = objBoard.IsValidatePasswd(id, Context.User.Identity.Name);

				if(result == 1)
				{
					rowsAffected = objBoard.Delete(id);

					if(rowsAffected == 1)
					{
						Response.Redirect("ForumList.aspx?db="+db+"&pageno="+pageNo);
					}
					else
					{
						ClientAction.ShowMsgBack("������ �����Ͽ����ϴ�.");
					}
				}
				else
				{
					ClientAction.ShowMsgBack("������ �ۼ��� �Խù��� ������ �� �ֽ��ϴ�.");
				}
			}		
		}

		private void CommentButton_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
			string userID, userName;
			int result;

			if (Comment.Text.Length > 0)
			{
				//if(Context.User.Identity.IsAuthenticated)
				//{
					BrdsCmtBiz objComment = new BrdsCmtBiz(db+"Comment");

					//SiteIdentity currUser = (SiteIdentity)Context.User.Identity;
					userName =  Cookie.Self["sName"];//currUser.NickName;
					userID = Cookie.Self["staff_id"];//currUser.UserID;

					result = objComment.Insert(id, userID, userName, Server.HtmlEncode(Comment.Text));

					if (result == 1)
					{
						Response.Redirect("ForumView.aspx?db="+db+"&id="+id+"&pageno="+pageNo);
					}
					else
					{
						ClientAction.ShowMsgBack("��Ͽ� �����Ͽ����ϴ�.");
					}
				//}
				//else
				//{
				//	ErrorLogin("?db=" + db + "&id=" + id + "&pageno=" + pageNo);
				//}
			}

		}

		protected string GetCommentEdit(int cid, string userID)
		{
			string retVal = "";
			//if (Context.User.Identity.Name == userID)
			if (Cookie.Self["staff_id"] == userID)
			{
				retVal = "<a href='Javascript:EditComment(\"ForumCmt_edit.aspx?db="+db+"&cid="+cid+"\");'><img src='Images/img/cedit.gif' border='0' alt='�ڸ�Ʈ ����'></a>";
			}
			return retVal;
		}

		protected string GetCommentDelete(int cid, string userID)
		{
			string retVal = "";
			//if (Context.User.Identity.Name == userID)
			if (Cookie.Self["staff_id"] == userID)
			{
				retVal = "<a href=\"Javascript:DeleteComment('"+db+"','"+id+"','"+cid+"','"+pageNo+"');\"><img src='Images/img/cdelete.gif' border='0' alt='�ڸ�Ʈ ����'></a>";
			}
			return retVal;
		}

	}
}
