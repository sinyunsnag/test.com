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

using JinsLibrary;

namespace KistelSite.CommonApps.Calendar
{
	/// <summary>
	/// Calendar�� ���� ��� �����Դϴ�.
	/// </summary>
	public class Calendar : System.Web.UI.Page
	{
		private DateTime sDate;
		protected System.Web.UI.WebControls.TextBox EndTime;
		protected System.Web.UI.WebControls.Calendar calBasic;
		protected System.Web.UI.WebControls.Label lbCalDisplay;
		protected System.Web.UI.WebControls.HyperLink hlReset;
		protected System.Web.UI.WebControls.ImageButton ibCalDone;
		protected System.Web.UI.WebControls.HyperLink hlClose;
		protected System.Web.UI.WebControls.RequiredFieldValidator RequiredFieldValidator1;
		protected System.Web.UI.WebControls.TextBox BeginTime;
	
		private void Page_Load(object sender, System.EventArgs e)
		{
			//������Ÿ��Ʋ����
			ClientAction.AddBrowserTitleBar("Calendar Helper");
			if(!Page.IsPostBack) 
			{
				//Page_Load���� �߻��� �̺�Ʈ���� �̸� �˼� �ִ°�? 
				//string evtSender = Request["__EVENTTARGET"];   //'�̺�Ʈ�߻� ��Ʈ�� ID
				//string evtArg = Request["__EVENTARGUMENT"];    //'�̺�Ʈ�߻� �Ű�����
				//Response.Write("���⿵ --> " +  evtSender);
				hlReset.NavigateUrl = Request.Url.ToString();// + "?" + URLQuery.Self.GetQueryString();
			} 
			else
			{
				calBasic.SelectedDate = System.DateTime.MinValue;
			}
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
			this.calBasic.DayRender += new System.Web.UI.WebControls.DayRenderEventHandler(this.calBasic_DayRender);
			this.calBasic.SelectionChanged += new System.EventHandler(this.calBasic_SelectionChanged);
			this.ibCalDone.Click += new System.Web.UI.ImageClickEventHandler(this.ibCalDone_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void calBasic_SelectionChanged(object sender, System.EventArgs e)
		{
			this.sDate = calBasic.SelectedDate;			
			if(sDate < DateTime.Today)
			{
				ClientAction.ShowMsgBack("���� ��¥�� ������ �� �����ϴ�.");
			}
			
		
			if(this.BeginTime.Text=="")
			{
				this.BeginTime.Text =  sDate.ToShortDateString();
				this.lbCalDisplay.Text = "�������� �����ϼ���.";
			}
			else if(this.EndTime.Text=="")
			{
				if(sDate < Convert.ToDateTime(this.BeginTime.Text))
				{
					ClientAction.ShowMsgBack("�������� �����Ϻ��� ������ �� �����ϴ�.");
				}
					
				this.EndTime.Text =  sDate.ToShortDateString();
				this.lbCalDisplay.Text = "�Ⱓ������ �Ϸ������ Ȯ���� Ŭ���ϼ���.";
			}
			else
			{
				this.BeginTime.Text = sDate.ToShortDateString();
				this.EndTime.Text = "";
				this.lbCalDisplay.Text = "�ٽ� �Ⱓ������ �մϴ�.";
			}
			

			//Response.Write("<br><br>");
			//Response.Write("this.BeginTime.Text ->" + this.BeginTime.Text + "<br>");
			//Response.Write("sDate ->" + sDate.ToShortDateString() + "<br>");
		}

		private void calBasic_DayRender(object sender, System.Web.UI.WebControls.DayRenderEventArgs e)
		{
			if(e.Day.Date.ToShortDateString() == this.BeginTime.Text)
			{
				e.Cell.BackColor = Color.Pink;
				//e.Cell.Controls.Add(new LiteralControl("<br><font size='1'>*</font>"));
			}
			if(e.Day.Date.ToShortDateString() == this.EndTime.Text)
			{
				e.Cell.BackColor = Color.Purple;
				e.Cell.ForeColor = Color.White;
			}
			
			if(e.Day.IsSelected)
				e.Cell.BackColor = Color.Purple;
		}

		private void ibCalDone_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
			Page.Validate();
			if(!Page.IsValid)
				ClientAction.ShowMsgBack("�������� �Է��ϼ���.");

			if(this.EndTime.Text == "")
				this.EndTime.Text= "2079-06-06";
		
			string javaScript = @"
			<script language=""javascript"">
			<!--
				opener.window.document.{0}.{1}.value = frmCal.BeginTime.value;
				opener.window.document.{0}.{2}.value = frmCal.EndTime.value;
				window.close();
			-->
			</script>
			";
			string [] arrPeriod = Request.QueryString["period"].Split("-".ToCharArray(),2);
			javaScript = String.Format(javaScript, Request.QueryString["frmName"], arrPeriod[0], arrPeriod[1]);
			
			//if (!page.IsStartupScriptRegistered("_javaScript"))
				Page.RegisterStartupScript("_javaScript", javaScript);
		}
	}
}
