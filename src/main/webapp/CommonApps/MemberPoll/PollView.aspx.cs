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

namespace KistelSite.CommonApps.MemberPoll
{
	/// <summary>
	/// PollView�� ���� ��� �����Դϴ�.
	/// </summary>
	public class PollView : System.Web.UI.Page
	{
		private DBLib dbUtil;
		private SqlDataReader drPoll;
		private int poll_id;
		private int pollSum;
		protected System.Web.UI.WebControls.Label pTopic;
		protected System.Web.UI.WebControls.PlaceHolder phViewResult;
		protected System.Web.UI.WebControls.Label period;


		private void Page_Load(object sender, System.EventArgs e)
		{
			
			if(!Page.IsPostBack) 
			{
				//��ũ�� ũ�⺯��
				ClientAction.WindowResizeTo(500,500);


				if(Request.QueryString["poll_id"] != null)
				{	
					this.poll_id = Convert.ToInt32(Request.QueryString["poll_id"]);
					//�������
					if(this.LoadPollMain())
                        this.ViewPollResult();
					else
						phViewResult.Visible = false;
				}
				else
				{
					ClientAction.ShowMsgAndClose("�������� ������ �ƴմϴ�");
				}
			}
		}

		#region �����κ� �ε�
		private bool LoadPollMain()
		{
			dbUtil = new DBLib();
		
			string fieldNames,tableName,whereClause,orderBy;
			fieldNames = "poll_id,pTopic,pBeginTime,pEndTime";
			tableName = "t_PollMain";
			whereClause = "DATEDIFF(day, pBeginTime, '" + DateTime.Now.ToShortDateString() + "') >=0"; 
			whereClause += " AND DATEDIFF(day, pEndTime, '" + DateTime.Now.ToShortDateString() + "') <=0"; 
			whereClause += " AND pDisplay = 1 AND IsStaff = 0";
			whereClause += " AND poll_id = " + this.poll_id;
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
				//�Ⱓ����
				period.Text = PollBaseLib.GetPeriod(drPoll["pBeginTime"], drPoll["pEndTime"]);
				drPoll.Close();
				return true;
			}
			else 
			{
				PostState.Self["poll_id"] = 0;
				pTopic.Text = "���� �����ϰ� ���� �ʽ��ϴ�.";				
				return false;
			}
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

			pTable.Width = Unit.Percentage(100);
			pTable.BorderWidth = 1;
			pTable.BorderStyle = BorderStyle.Solid;				
			pTable.BorderColor = Color.LightBlue;
			pTable.CellPadding = 1;
			pTable.CellSpacing = 2;
			

			tRow = new TableRow();
			tRow.HorizontalAlign = HorizontalAlign.Center;
			tRow.Height = 30;
			tRow.BackColor = JinsLibrary.IMAGE.ImageLib.Self.ColorFromArgb("d2","f1","ff");		//Color.FromArgb(Convert.ToInt32("d2",16),Convert.ToInt32("f1",16) ,Convert.ToInt32("ff",16));

			tCell = new TableCell();
			tCell.CssClass = "header";
			tCell.Text = "����";
			tRow.Cells.Add(tCell);					
			tCell = new TableCell();
			tCell.CssClass = "header";
			tCell.Width = 50;
			tCell.Text = "��ǥ��";
			tRow.Cells.Add(tCell);
			tCell = new TableCell();
			tCell.CssClass = "header";
			tCell.Text = "�׷���";
			tRow.Cells.Add(tCell);
			pTable.Rows.Add(tRow);

			while(drPoll.Read()) 
			{				
				tRow = new TableRow();
				tCell = new TableCell();
				tCell.Text = "&nbsp;" + drPoll["exNbr"].ToString() + "." + drPoll["example"].ToString();
				tRow.Cells.Add(tCell);					
				
				tCell = new TableCell();
				tCell.BackColor = JinsLibrary.IMAGE.ImageLib.Self.ColorFromArgb("f4","fc","ff");
				tCell.Text = drPoll["pPoint"].ToString() + " ǥ";
				tCell.HorizontalAlign = HorizontalAlign.Center;
				tRow.Cells.Add(tCell);					

				tCell = new TableCell();
				System.Web.UI.WebControls.Image imgBar = PollBaseLib.DrawGraph(Convert.ToInt32(drPoll["pPoint"]), this.pollSum);
				tCell.Controls.Add(imgBar);
				tCell.Controls.Add(new LiteralControl("&nbsp;" + imgBar.AlternateText));
				tRow.Cells.Add(tCell);					
				
				pTable.Rows.Add(tRow);

			}
			tRow = new TableRow();
			tRow.BackColor = JinsLibrary.IMAGE.ImageLib.Self.ColorFromArgb("d2","f1","ff");
			tCell = new TableCell();
			tRow.Height = 20;
			tCell.ColumnSpan = 3;
			tRow.HorizontalAlign = HorizontalAlign.Center;
			tCell.Text = "[�ѵ�ǥ�� : " + this.pollSum.ToString() + "ǥ]";
			tRow.Cells.Add(tCell);
			pTable.Rows.Add(tRow);

			drPoll.Close();			
			phViewResult.Controls.Add(pTable);
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
