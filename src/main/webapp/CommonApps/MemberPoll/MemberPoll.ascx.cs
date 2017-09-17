using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using JinsLibrary;
using JinsLibrary.STATEMANAGE;

namespace KistelSite.CommonApps.MemberPoll
{
	/// <summary>
	///		MemberPoll�� ���� ��� �����Դϴ�.
	/// </summary>
	public class MemberPoll : System.Web.UI.UserControl
	{
		private DBLib dbUtil;
		private SqlDataReader drPoll;
		private int poll_id;
		private int pollSum;
		protected System.Web.UI.WebControls.Label pTopic;
		protected System.Web.UI.WebControls.RadioButtonList rblExamples;
		protected System.Web.UI.WebControls.Panel pnViewResult;
		protected System.Web.UI.WebControls.HyperLink hlView;
		protected System.Web.UI.WebControls.RequiredFieldValidator RequiredFieldValidator1;
		protected System.Web.UI.WebControls.ImageButton btnVote;
		protected System.Web.UI.WebControls.ValidationSummary ValidationSummary1;
		
		private void Page_Load(object sender, System.EventArgs e)
		{
			if(!Page.IsPostBack) 
			{
				if( LoadPollMain() )
				{
					if(Cookie.Self["voted"] == "")
					{
						//�� �����ε�				
						this.PollExampleBind();
					}
					else
					{
						//�������
						this.ViewPollResult();
						this.btnVote.Visible = false;
						this.rblExamples.Visible = false;
						this.pnViewResult.Visible = true;
						this.hlView.Visible = true;
						this.hlView.NavigateUrl = "javascript:WindowOpen('/CommonApps/MemberPoll/PollView.aspx?poll_id=" + this.poll_id +"','poll','')";
					}
				}
				else
				{
					PostState.Self["poll_id"] = 0;
					pTopic.Text = "���� �����ϰ� ���� �ʽ��ϴ�.";		
					this.rblExamples.Visible = false;
					this.btnVote.Visible = false;
				}
			}			
		}

		#region �����κ� �ε�
		private bool LoadPollMain()
		{
			dbUtil = new DBLib();
		
			string fieldNames,tableName,whereClause,orderBy;
			fieldNames = "poll_id,pTopic";
			tableName = "t_PollMain";
			whereClause = "DATEDIFF(day, pBeginTime, '" + DateTime.Now.ToShortDateString() + "') >=0"; 
			whereClause += " AND DATEDIFF(day, pEndTime, '" + DateTime.Now.ToShortDateString() + "') <=0"; 
			//whereClause += " AND pEndTime >= '" + DateTime.Now.ToShortDateString() + "'";
			whereClause += " AND pDisplay = 1 AND IsStaff = 0";
			orderBy = "poll_id DESC";				
			
			//������������
			drPoll = dbUtil.Select_DR(1,fieldNames,tableName,whereClause,orderBy);
			//Response.End();

			if(drPoll.HasRows) 
			{
				drPoll.Read();
				PostState.Self["poll_id"] = drPoll["poll_id"].ToString();
				this.poll_id = Convert.ToInt32(drPoll["poll_id"]);
				pTopic.Text = drPoll["pTopic"].ToString();
				//��Űǥ�õ� 
				if(this.poll_id.ToString() != Cookie.Self["voted"])
					Cookie.Self.RemoveCookie("voted");
				drPoll.Close();
				return true;
			}
			else
				return false;

		}
		#endregion

		#region ���������ε�
		protected void PollExampleBind()
		{
			dbUtil = new DBLib();

			string fieldNames,tableName,whereClause,orderBy;
			fieldNames = "exNbr,example";
			tableName = "t_PollEX";
			whereClause = "poll_id =" + this.poll_id;
			orderBy = "exNbr";		
			//������������
			drPoll = dbUtil.Select_DR(fieldNames,tableName,whereClause,orderBy);

			if(drPoll.HasRows) 
			{
				rblExamples.DataSource = drPoll;
				
				rblExamples.DataValueField = "exNbr";
				rblExamples.DataTextField = "example";
				rblExamples.DataTextFormatString = "{0}";
				rblExamples.DataBind();
			}
			else 
			{
				rblExamples.ToolTip = "������ �����ϴ�.";
			}
			drPoll.Close();
		}
		#endregion
		
		#region ��ǥ�������
		private void ViewPollResult()
		{
			//�ѵ�ǥ�� ����
			//this.GetPollSum();
			this.pollSum = PollBaseLib.GetPollSum(this.poll_id);

			dbUtil = new DBLib();
			string fieldNames,tableName,whereClause,orderBy;
			fieldNames = "exNbr,example,pPoint";
			tableName = "t_PollEX";
			whereClause = "poll_id =" + this.poll_id;
			orderBy = "exNbr";		
			//������������
			drPoll = dbUtil.Select_DR(fieldNames,tableName,whereClause,orderBy);		

			Table pTable = new Table();
			TableRow tRow;
			TableCell tCell;
			while(drPoll.Read()) 
			{				
				tRow = new TableRow();
				tCell = new TableCell();
				tCell.ColumnSpan = 2;
				tCell.Text = drPoll["exNbr"].ToString() + "." + drPoll["example"].ToString();
				//Create a new cell and add it to the row.//�ุ���
				tRow.Cells.Add(tCell);					
				pTable.Rows.Add(tRow);
				
				tRow = new TableRow();
				tCell = new TableCell();
				tCell.Width = Unit.Percentage(2);
				//tCell.BackColor = Color.LightGreen;
				tCell.Text = "&nbsp;";
				tRow.Cells.Add(tCell);
				
				tCell = new TableCell();
				tCell.CssClass = "sTxt1";
			
				System.Web.UI.WebControls.Image imgBar = PollBaseLib.DrawGraph(Convert.ToInt32(drPoll["pPoint"]), this.pollSum);
				tCell.Controls.Add(imgBar);
				tCell.Controls.Add(new LiteralControl("&nbsp;" + imgBar.AlternateText));
				tRow.Cells.Add(tCell);
				
				pTable.Width = Unit.Percentage(100);
				pTable.BorderWidth = 0;
				pTable.CellPadding = 0;
				pTable.CellSpacing = 0;
				pTable.Rows.Add(tRow);
			}
			drPoll.Close();			
			pnViewResult.Controls.Add(pTable);
		}

		//�ѵ�ǥ��(�������� ����)
		private void GetPollSum()
		{			
			string qryString;
			dbUtil = new DBLib();
			qryString = "SELECT SUM(pPoint) FROM t_PollEX "
				+	" Where poll_id = " + this.poll_id 
				+	" GROUP BY poll_id";
			this.pollSum = dbUtil.MyExecuteScalar(qryString);
		}
		/*
		//�׷����׸���(�������� ����--��������� �̻������ ����)
		private System.Web.UI.WebControls.Image DrawGraph(int point)
		{
			System.Web.UI.WebControls.Image imgCntGraph;
			double widthPercent = 0;
			if(this.pollSum > 0)
				widthPercent = Math.Round(MathLib.GetPercent(point, this.pollSum), 1);
			
			imgCntGraph = new System.Web.UI.WebControls.Image();
			imgCntGraph.ImageUrl = @"/CommonApps/MemberPoll/Images/green.gif";
			imgCntGraph.Width = Unit.Percentage(widthPercent * 1.4);
			imgCntGraph.Height = 10;
			imgCntGraph.AlternateText = Unit.Percentage(widthPercent).ToString();
			imgCntGraph.ImageAlign = ImageAlign.AbsMiddle;
			imgCntGraph.Visible = true;
			return imgCntGraph;
		}
		*/
		#endregion

		//��ǥ
		private void btnVote_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
			Page.Validate();
			if(!Page.IsValid)
				ClientAction.ShowMsgBack("��Ȯ�� �Է��ϼ���.");

			dbUtil = new DBLib();
			string whereClause =	"poll_id =" + PostState.Self["poll_id"].ToString();
			whereClause +=			" AND exNbr =" + rblExamples.SelectedValue;

			if(dbUtil.ChangeFigure("t_PollEX", "pPoint", 1, whereClause) > 0)
			{
				Cookie.Self.SetCookie("voted", PostState.Self["poll_id"].ToString(), 1);
				Cookie.Self.SetCookie("votedDay", System.DateTime.Today.ToString(), 1);
				ClientAction.ShowMsgAndGoUrl("[" + rblExamples.SelectedValue +"." + rblExamples.SelectedItem.Text + "] �� ��ǥ�Ͽ����ϴ�.", Request.Url.ToString());
			}	
			else
				ClientAction.ShowInfoMsg("����!!");
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
		///		�����̳� ������ �ʿ��� �޼����Դϴ�. �� �޼����� ������
		///		�ڵ� ������� �������� ���ʽÿ�.
		/// </summary>
		private void InitializeComponent()
		{
			this.btnVote.Click += new System.Web.UI.ImageClickEventHandler(this.btnVote_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion


		#region ���� ��ǥ��Ű����
		private void Button1_Click(object sender, System.EventArgs e)
		{
			Cookie.Self["voted"] = null;
			Cookie.Self.RemoveCookie("voted");		
		}
		#endregion




	}
}
