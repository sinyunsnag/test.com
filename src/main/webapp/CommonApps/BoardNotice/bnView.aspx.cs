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

namespace KistelSite.CommonApps.BoardNotice
{
	/// <summary>
	/// bnView�� ���� ��� �����Դϴ�.
	/// </summary>
	public class bnView : System.Web.UI.Page
	{
		protected System.Web.UI.WebControls.Label bNotice_id;
		protected System.Web.UI.WebControls.Label bnGroup;
		protected System.Web.UI.WebControls.Label viewCount;
		protected System.Web.UI.WebControls.Label writeDT;
		protected System.Web.UI.WebControls.Label bnSubTitle;
		protected System.Web.UI.WebControls.Label modifyDT;
		protected System.Web.UI.WebControls.HyperLink btnList;
		protected System.Web.UI.WebControls.HyperLink btnCancle;
		protected System.Web.UI.WebControls.HyperLink hlPreData;
		protected System.Web.UI.WebControls.HyperLink hlNextData;
		protected System.Web.UI.WebControls.Label bnTitle;

		DBLib dbUtil;
		string bnID, bnG;
		protected System.Web.UI.WebControls.Label bnContent;		
		
		private void Page_PreRender(object sender, System.EventArgs e)
		{
			//URLQuery.Self.GetQueryString();
		}
		private void Page_Load(object sender, System.EventArgs e)
		{
			if(Request.QueryString["bnID"] != null)
			{
				if(!Page.IsPostBack) 
				{
					//������Ÿ��Ʋ
					JinsLibrary.STATEMANAGE.Session.Self["PageName"] = "�������׺���";

					dbUtil = new DBLib();
					this.bnID = Request.QueryString["bnID"];
					this.bnG = Request.QueryString["bnG"];
					//��ȸ�� ����
					dbUtil.ChangeFigure("t_BoardNotice", "viewCount", 1, "bNotice_id=" + bnID);
					//���ε�
					if(this.NoticeViewBind())
					{
						//����Ʈ �׺���̼� ������	
						URLQuery.Self.SetQueryString();
//WebUtil.CurrentResponse.Write(URLQuery.Self.GetQueryString() + "Load" );						
						this.btnList.NavigateUrl = "/CommonApps/BoardNotice/bnList.aspx?" + URLQuery.Self.GetQueryString();
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

		#region �������� ���ε�
		protected Boolean NoticeViewBind()
		{			
			string qryNoticeView = "Select staff_id,bnGroup,bnTitle,bnSubTitle,bnContent,viewCount,writeDT,modifyDT "
				+ " FROM t_BoardNotice"
				+ " WHERE bNotice_id=" + bnID;
	
			SqlDataReader drNotice;
			drNotice = dbUtil.MyExecuteReader(qryNoticeView);
			if (drNotice.Read()) 
			{
				this.bNotice_id.Text = bnID;
				this.bnGroup.Text = drNotice["bnGroup"].ToString();
				this.viewCount.Text = drNotice["viewCount"].ToString();
				this.writeDT.Text = drNotice.GetDateTime(6).ToShortDateString();
				if (drNotice["modifyDT"] != DBNull.Value) 
				{
					this.modifyDT.Text += "����������: " + drNotice.GetDateTime(7).ToShortDateString();
					this.modifyDT.Visible = true;
				}				
				this.bnTitle.Text = HTML.ReplaceTo(drNotice["bnTitle"].ToString(), "toHTML");
				this.bnSubTitle.Text = HTML.ReplaceTo(drNotice["bnSubTitle"].ToString(), "toHTML");
				if(this.bnSubTitle.Text == "")
					this.bnSubTitle.Text = this.bnTitle.Text;
				this.bnContent.Text = HTML.ReplaceTo(drNotice["bnContent"].ToString(), "toHTML");
				drNotice.Close();
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
			qryString = "SELECT bNotice_id, bnGroup, bnTitle"
				+	" FROM t_BoardNotice WHERE bnStatus > 1 "
				+ " ORDER BY bnOrder DESC,bNotice_id DESC";
			DataTable dTable = dbUtil.MyFillTable(qryString);
			int i;
			for(i=0; i < dTable.Rows.Count-1; i++)
			{
				if(dTable.Rows[i]["bNotice_id"].ToString() == bnID)
					break;
				//Response.Write("cccccccccc = " + dTable.Rows[i]["bNotice_id"].ToString() + "<br>");
			}
			//Response.Write("i = " + i.ToString() + "<br>");

			string strTemp;
			DataRow dRow;
			//������ ��������
			if(i < dTable.Rows.Count-1)
			{
				dRow = dTable.Rows[i+1];
				strTemp = "[" + dRow["bnGroup"].ToString() + "] " + Text.ShortenString(dRow["bnTitle"].ToString(), 40);
				this.hlPreData.Text = strTemp;
				this.hlPreData.NavigateUrl = Request.Url.AbsolutePath.ToString() + "?bnID=" + dRow["bNotice_id"].ToString();
				if(bnG != null)
					this.hlPreData.NavigateUrl += "&bnsG="+bnG;
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
				strTemp = "[" + dRow["bnGroup"].ToString() + "] " + Text.ShortenString(dRow["bnTitle"].ToString(), 40);
				this.hlNextData.Text = strTemp;
				this.hlNextData.NavigateUrl = Request.Url.AbsolutePath.ToString() + "?bnID=" + dRow["bNotice_id"].ToString();
				if(bnG != null)
					this.hlNextData.NavigateUrl += "&bnsG="+bnG;
			}
			else
			{
				this.hlNextData.Text = "�������� �����ϴ�";
				this.hlNextData.ForeColor = Color.Gray;
			}
			//			foreach (DataRow drow in dTable.Rows)
			//			{
			//				
			//				Response.Write("cccccccccc = " + drow["bNotice_id"] +	" : " + drow["bnTitle"] + ":" + drow["bnsOrder"] + "<br>");
			//				this.bnsContent.Text += "dddd = " + drow["bNotice_id"] +	" : " + drow["bnTitle"] + ":" + drow["bnsOrder"] + "<br>";
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
