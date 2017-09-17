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
using JinsLibrary.STATEMANAGE;

namespace KistelSite.CommonApps.BoardNews
{
	/// <summary>
	/// bnView�� ���� ��� �����Դϴ�.
	/// </summary>
	public class bnsView : System.Web.UI.Page
	{
		protected System.Web.UI.WebControls.Label bNews_id;
		protected System.Web.UI.WebControls.Label bnsGroup;
		protected System.Web.UI.WebControls.Label viewCount;
		protected System.Web.UI.WebControls.Label writeDT;
		protected System.Web.UI.WebControls.Label bnsSubTitle;
		protected System.Web.UI.WebControls.Label bnsContent;		
		protected System.Web.UI.WebControls.Label modifyDT;		
		protected System.Web.UI.WebControls.HyperLink btnList;
		protected System.Web.UI.WebControls.HyperLink btnCancle;
		protected System.Web.UI.WebControls.HyperLink hlPreData;
		protected System.Web.UI.WebControls.HyperLink hlNextData;
		protected System.Web.UI.WebControls.Label bnsTitle;

		DBLib dbUtil;
		string bnsID, bnsG;
				
		private void Page_Load(object sender, System.EventArgs e)
		{
			if(Request.QueryString["bnsID"] != null)
			{
				if(!Page.IsPostBack) 
				{
					//������Ÿ��Ʋ
					JinsLibrary.STATEMANAGE.Session.Self["PageName"] = "��ǰ���ⴺ������";

					//Response.Cache.SetExpires(DateTime.MinValue);
					//queryString = "?" + Server.UrlEncode(Request.QueryString.ToString());
					
					dbUtil = new DBLib();
					this.bnsID = Request.QueryString["bnsID"];
					this.bnsG = Request.QueryString["bnsG"];
			
					//��ȸ�� ����
					dbUtil.ChangeFigure("t_BoardNews", "viewCount", 1, "bNews_id=" + bnsID);
					//���ε�
					if(this.NewsViewBind())
					{
						//����Ʈ �׺���̼� ������	
						URLQuery.Self.SetQueryString();
//WebUtil.CurrentResponse.Write(URLQuery.Self.GetQueryString() + "Load" );						
						this.btnList.NavigateUrl = "/CommonApps/BoardNews/bnsList.aspx?" + URLQuery.Self.GetQueryString();
						//������  ������ ����
						this.GetPreNextData();
						//DB�ݱ�
						dbUtil.SqlConnection.Close();
					}
					else 
					{
						ClientAction.ShowMsgBack("�ش� �����Ͱ� �����ϴ�.");
					}
				}
			}
			else
				ClientAction.ShowMsgBack("�������� ������ �ƴմϴ�");							
		}

		#region ���� ���ε�
		protected Boolean NewsViewBind()
		{			
			string qryString = "Select bnsGroup,bnsTitle,bnsSubTitle,bnsContent,viewCount,staff_id,writeDT,modifyDT "
				+ " FROM t_BoardNews"
				+ " WHERE bNews_id=" + bnsID;
	
			SqlDataReader drNews;
			drNews = dbUtil.MyExecuteReader(qryString);
			if (drNews.Read()) 
			{
				this.bNews_id.Text = bnsID;
				this.bnsGroup.Text = drNews["bnsGroup"].ToString();
				this.viewCount.Text = drNews["viewCount"].ToString();
				this.writeDT.Text = drNews.GetDateTime(6).ToShortDateString();
				if (drNews["modifyDT"] != DBNull.Value) 
				{
					this.modifyDT.Text += "����������: " + drNews.GetDateTime(7).ToShortDateString();
					this.modifyDT.Visible = true;
				}				
				string tempTitle = drNews["bnsTitle"].ToString();
				this.bnsTitle.Text = tempTitle;
				this.bnsTitle.ToolTip = tempTitle;



				this.bnsSubTitle.Text = HTML.ReplaceTo(drNews["bnsSubTitle"].ToString(), "toHTML");
				if(this.bnsSubTitle.Text == "")
					this.bnsSubTitle.Text = this.bnsTitle.Text;
				this.bnsContent.Text = HTML.ReplaceTo(drNews["bnsContent"].ToString(), "toHTML");
				drNews.Close();
				return true;
			}
			else
				return false;
		}
		#endregion
		
		#region ������  ������ ����
		private void GetPreNextData()
		{
			string qryString;
			qryString = "SELECT bNews_id,bnsGroup,bnsTitle,bnsOrder,bnsStatus"
				+	" FROM t_BoardNews WHERE bnsStatus > 1 "
				+ " ORDER BY bnsOrder DESC,bNews_id DESC";
			DataTable dTable = dbUtil.MyFillTable(qryString);
			int i;
			for(i=0; i < dTable.Rows.Count-1; i++)
			{
				if(dTable.Rows[i]["bNews_id"].ToString() == bnsID)
					break;
				//Response.Write("cccccccccc = " + dTable.Rows[i]["bNews_id"].ToString() + "<br>");
			}
			//Response.Write("i = " + i.ToString() + "<br>");

			string strTemp;
			DataRow dRow;
			//������ ��������
			if(i < dTable.Rows.Count-1)
			{
				dRow = dTable.Rows[i+1];
				strTemp = "[" + dRow["bnsGroup"].ToString() + "] " + Text.ShortenString(dRow["bnsTitle"].ToString(), 40);
				this.hlPreData.Text = strTemp;
				this.hlPreData.NavigateUrl = Request.Url.AbsolutePath.ToString() + "?bnsID=" + dRow["bNews_id"].ToString();
				if(bnsG != null)
					this.hlPreData.NavigateUrl += "&bnsG="+bnsG;
			}
			else
			{
				this.hlPreData.Text = "�������� �����ϴ�";
				this.hlPreData.ForeColor = Color.Gray;
			}

			//������ ��������
			if(i > 0)
			{
				dRow = dTable.Rows[i-1];
				strTemp = "[" + dRow["bnsGroup"].ToString() + "] " + Text.ShortenString(dRow["bnsTitle"].ToString(), 40);
				this.hlNextData.Text = strTemp;
				this.hlNextData.NavigateUrl = Request.Url.AbsolutePath.ToString() + "?bnsID=" + dRow["bNews_id"].ToString();
				if(bnsG != null)
					this.hlNextData.NavigateUrl += "&bnsG="+bnsG;
			}
			else
			{
				this.hlNextData.Text = "�������� �����ϴ�";
				this.hlNextData.ForeColor = Color.Gray;
			}
			//			foreach (DataRow drow in dTable.Rows)
			//			{
			//				
			//				Response.Write("cccccccccc = " + drow["bNews_id"] +	" : " + drow["bnsTitle"] + ":" + drow["bnsOrder"] + "<br>");
			//				this.bnsContent.Text += "dddd = " + drow["bNews_id"] +	" : " + drow["bnsTitle"] + ":" + drow["bnsOrder"] + "<br>";
			//			}
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
