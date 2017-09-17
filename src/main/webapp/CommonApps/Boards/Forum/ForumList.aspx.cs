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
using MiddleTier.Boards.Comment;

using JinsLibrary;


namespace KistelSite.CommonApps.Boards.Forum
{
	/// <summary>
	/// list�� ���� ��� �����Դϴ�.
	/// </summary>
	public class ForumList : System.Web.UI.Page
	{
		protected System.Web.UI.WebControls.Label SearchLabel;
		protected System.Web.UI.WebControls.Label PageCountLabel;
		protected System.Web.UI.WebControls.DataList BoardList;
		protected System.Web.UI.WebControls.Label PageListLabel;
		protected System.Web.UI.WebControls.DropDownList KeyFieldList;
		protected System.Web.UI.WebControls.TextBox KeyWordTextBox;
		protected System.Web.UI.WebControls.ImageButton SearchButton;
		protected System.Web.UI.WebControls.HyperLink HomeLink;
		protected System.Web.UI.WebControls.HyperLink BackLink;
		protected System.Web.UI.WebControls.HyperLink NextLink;
	
		protected string db;
		protected int pageNo, pageSize;
		protected int recordCount, totalPageNumber;
		protected string keyField, keyWord;
		protected bool searchStatus = false;

		private void Page_Load(object sender, System.EventArgs e)
		{
			// ���⿡ ����� �ڵ带 ��ġ�Ͽ� �������� �ʱ�ȭ�մϴ�.
			if (Request.QueryString["db"] == null)
			{
				ClientAction.ShowMsgBack("���̺���� �������� �ʾҽ��ϴ�.");
			}
			else
				db = Request.QueryString["db"];
			
			if (Request.QueryString["pageno"] == null)
				pageNo = 1;
			else
				pageNo = int.Parse(Request.QueryString["pageno"]);

			// �˻����� ������ ����
			if (Request.QueryString["keyword"] == null)
			{
				if (KeyWordTextBox.Text != "")
				{
					keyField = KeyFieldList.SelectedItem.Value;
					keyWord = KeyWordTextBox.Text;
					searchStatus = true;
					SearchOutput();
				}
			}
			else
			{
				keyField = Request.QueryString["keyfield"];
				keyWord = Request.QueryString["keyword"];
				searchStatus = true;
				SearchOutput();
			}

			// �˻� ���ǿ� ���� ����Ʈ ����
			if (!searchStatus)
			{
				GetBoardList();
			}
			else
			{
				if (Page.IsPostBack)
				{
					pageNo = 1;
				}

				GetSearchBoardList();
			}

			// Ȩ ��ư �Ӽ� ����
			if (pageNo == 1 && searchStatus == false)
			{
				HomeLink.ImageUrl = "Images/img/home2.gif";
				HomeLink.NavigateUrl = "";
			}
			else
			{
				HomeLink.NavigateUrl = "ForumList.aspx?db="+db;
			}
		}

		private void GetBoardList()
		{
			QnaBiz objBoard = new QnaBiz(db);
			
			recordCount = objBoard.GetBoardRecordCount();			
			//recordCount.CompareTo("ccc");

			totalPageNumber = objBoard.GetTotalPageNumber(recordCount);

			PageCountLabel.Text = "Total : " + recordCount.ToString() + ", [" + pageNo.ToString() + "/" + totalPageNumber.ToString() + "] Page";

			BoardList.DataSource = objBoard.GetBoardList(pageNo);
			BoardList.DataMember = "Board";
			
			BoardList.DataBind();
			
			//Response.Write("--> " + pageNo.ToString() + "<br>");
			//Response.End();
			


			GetPageList(pageNo, recordCount, totalPageNumber);
		}

		private void GetSearchBoardList()
		{
			QnaBiz objBoard = new QnaBiz(db);
			
			recordCount = objBoard.GetBoardRecordCount(keyField, keyWord);
			totalPageNumber = objBoard.GetTotalPageNumber(recordCount);
			
			PageCountLabel.Text = "Total : " + recordCount.ToString() + ", [" + pageNo.ToString() + "/" + totalPageNumber.ToString() + "] Page";

			BoardList.DataSource = objBoard.GetBoardList(pageNo, keyField, keyWord);
			BoardList.DataMember = "BoardSearch";
			BoardList.DataBind();
			
			GetPageList(pageNo, recordCount, totalPageNumber);
		}

		private void GetPageList(int PageNo, int RecordCount, int TotalPageCount)
		{
			int PageToLength = 20;
			int FromPage, ToPage;
			string Path;

			FromPage = (int)(PageNo-1)/PageToLength*PageToLength+1;

			if ((FromPage+PageToLength-1)<TotalPageCount)
				ToPage = FromPage+PageToLength-1;
			else
				ToPage = TotalPageCount;


			// ���� 10�� ǥ��
			if ((int)((PageNo-1)/PageToLength)>0)
			{
				if (searchStatus == false)
					Path = "<a href='ForumList.aspx?db="+db+"&pageno=" + (FromPage-1).ToString() + "'><img src=Images/img/pback1.gif border=0 align=absmiddle></a> ";
				else
					Path = "<a href='ForumList.aspx?db="+db+"&pageno=" + (FromPage-1).ToString() + "&keyfield="+keyField+"&keyword="+Server.UrlEncode(keyWord)+"'><img src=Images/img/pback1.gif border=0 align=absmiddle></a> ";
			}
			else
			{
				Path = "<img src=Images/img/pback2.gif border=0 align=absmiddle> ";
			}

			// ������ �ٷΰ���
			for (int i = FromPage; i <= ToPage; i++)
			{
				if (i == PageNo)
					Path += "<b>" + i.ToString() + "</b> ";
				else
					if (searchStatus == false)
					Path += "<a href='ForumList.aspx?db="+db+"&pageno=" + i.ToString() + "'>" + i.ToString() + "</a> ";
				else
					Path += "<a href='ForumList.aspx?db="+db+"&pageno=" + i.ToString() + "&keyfield="+keyField+"&keyword="+Server.UrlEncode(keyWord)+"'>" + i.ToString() + "</a> ";
			}

			// ���� 10�� ǥ��
			if (ToPage < TotalPageCount)
				if (searchStatus == false)
					Path += "<a href='ForumList.aspx?db="+db+"&pageno=" + (ToPage+1).ToString() + "'><img src=Images/img/pnext1.gif border=0 align=absmiddle></a>";
				else
					Path += "<a href='ForumList.aspx?db="+db+"&pageno=" + (ToPage+1).ToString() + "&keyfield="+keyField+"&keyword="+Server.UrlEncode(keyWord)+"'><img src=Images/img/pnext1.gif border=0 align=absmiddle></a>";
			else
				Path += "<img src=Images/img/pnext2.gif border=0 align=absmiddle>";

			PageListLabel.Text = Path;

			if (PageNo > 1)
			{
				if (!searchStatus)
					BackLink.NavigateUrl="ForumList.aspx?db="+db+"&pageno=" + (PageNo-1).ToString();
				else
					BackLink.NavigateUrl="ForumList.aspx?db="+db+"&pageno=" + (PageNo-1).ToString() + "&keyfield="+keyField+"&keyword="+Server.UrlEncode(keyWord);
			}
			else
			{
				BackLink.ImageUrl = "Images/img/back2.gif";
			}

			if (PageNo < TotalPageCount)
			{
				if (!searchStatus)
					NextLink.NavigateUrl="ForumList.aspx?db="+db+"&pageno=" + (PageNo+1).ToString();
				else
					NextLink.NavigateUrl="ForumList.aspx?db="+db+"&pageno=" + (PageNo+1).ToString() + "&keyfield="+keyField+"&keyword="+Server.UrlEncode(keyWord);
			}
			else
			{
				NextLink.ImageUrl = "Images/img/next2.gif";
			}
		}

		protected string PageLinkURL(int boardID)
		{
			string path;
			if (!searchStatus)
				path = "ForumView.aspx?db="+db+"&id=" + boardID.ToString() + "&pageno=" + pageNo;
			else
				path = "ForumView.aspx?db="+db+"&id=" + boardID.ToString() + "&pageno=" + pageNo + "&keyfield=" + keyField + "&keyword=" + Server.UrlEncode(keyWord);

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

		protected string GetSubject(string subject)
		{
			string retVal;

			retVal = subject;

			if (subject.Length > 30)
			{
				retVal = subject.Substring(0, 30) + "..";
			}

			if (keyField == "subject")
			{
				retVal = subject.Replace(keyWord, "<b><font color=red>" + keyWord + "</font></b>");
			}

			return retVal;
		}

		private void SearchOutput()
		{
			SearchLabel.Text = "[�˻��� :" + keyWord + "]";
			KeyFieldList.Visible = false;
			KeyWordTextBox.Visible = false;
			SearchButton.Visible = false;
		}

		protected string GetNewItem(DateTime regDate)
		{
			string retVal = "";
			
			// New �Խù� ǥ�� : ((�ۼ��ð�+1��)-����ð� > 0)
			if (DateTime.Compare(regDate.AddHours(24), DateTime.Now) > 0)
				retVal = "<img src='Images/img/new.gif' align=absmiddle border=0>";

			return retVal;

		}

		protected string GetCommentCount(int id)
		{
			int commentCount;
			string retVal;


			BrdsCmtBiz objComment = new BrdsCmtBiz(db+"Comment");

			commentCount = objComment.GetBoardRecordCount(id);        // <---------- ����

			
			if (commentCount == 0)
				retVal = "";
			else
				retVal = "("+commentCount.ToString()+")";

			return retVal;
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
