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
using JinsLibrary.LIST;
using JinsLibrary.STATEMANAGE;
using KistelSite.Admins.CompanyMgr.Staffs;

namespace KistelSite.CommonApps.Board
{
	/// <summary>
	/// bList�� ���� ��� �����Դϴ�.
	/// </summary>
	public class bList : BoardBaseLib
	{
		string tableName = "t_DocumentAssets", whereClause;
		public static int SelMenuValue = 34;

		protected System.Web.UI.WebControls.HyperLink hlInsert;
		protected System.Web.UI.WebControls.HyperLink hlAllList;
		protected System.Web.UI.WebControls.Label lbPaging;
		protected System.Web.UI.WebControls.Label lbInfoList;
		protected System.Web.UI.WebControls.DataGrid dataGrid;
		protected System.Web.UI.WebControls.Label lbListBrief;
		protected System.Web.UI.WebControls.Label lbSearchResult;
		protected System.Web.UI.WebControls.DropDownList ddlSelMenu;
		protected System.Web.UI.WebControls.Button btnSearch;
		protected System.Web.UI.WebControls.TextBox tbSearchString;
		protected System.Web.UI.WebControls.DropDownList ddlSearch;
		protected System.Web.UI.HtmlControls.HtmlForm frmNotice;

	
		public void SearchResultDisplay()
		{
			if(tbSearchString.Text != "")
			{
				lbSearchResult.Text="�˻���� : <b>" + ddlSearch.SelectedItem.Text + "</b>���� <b>";
				lbSearchResult.Text += tbSearchString.Text + "</b>�� �˻��� ����Դϴ�";
				lbSearchResult.Visible = true;
			}
			else
				lbSearchResult.Visible = false;			
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			//ClientAction.GoUrl(4, "BoardInfo_inc.asp");

			//�α��εǾ����� Ȯ��
			//KistelSite.Admins.CompanyMgr.Staffs.LoginProcess.LoginOK();
			//������Ÿ��Ʋ����
			JinsLibrary.ClientAction.AddBrowserTitleBar("�Խ��Ǹ���Ʈ");

			//Response.End();
			#region ���������� �׽�Ʈ			
			//	if(AppVariable.Self["application"] != null)
			//		ClientAction.ShowInfoMsg(AppVariable.Self["application"].ToString());
			//	if(Session["session"] != null)
			//		ClientAction.ShowInfoMsg(Session["session"].ToString());			
			//	if(DataCache.Self["dataCache"] != null)
			//		ClientAction.ShowInfoMsg(JinsLibrary.STATEMANAGE.DataCache.Self["dataCache"].ToString());
			//	ClientAction.ShowInfoMsg(JinsLibrary.CONFIG.TableConfig.nameNJ);
			#endregion
			//������ư�� Ŭ���� ���"d" //�Խù� ������������"dd"
			if(Request.QueryString["mode"] != null)
			{
				BoardBaseLib.DeleteDoc(Request.QueryString["mode"], WebUtil.CurrentRequest["daID"]);
				HttpContext.Current.Response.Redirect( Request.Url.AbsolutePath.ToString() +"?"+ URLQuery.Self.GetQueryString());
			}
			if(!Page.IsPostBack) 
			{
				//���� �������� �����մϴ�.      -1
				Paging.Self.SetCurrentPage(WebUtil.CurrentRequest["cp"]);
				//�޴����ø���Ʈ ���ε�
				SelMenuBind();
				//�������ø޴�
				if(Request.QueryString["smv"] != null)
					this.ddlSelMenu.SelectedValue = Request.QueryString["smv"];
				SelMenuValue = Convert.ToInt16(ddlSelMenu.SelectedValue);
				//���ǹ� ����
				SetWhereClause();
				//�����͹��̵�
				this.DocListBind();
				//�����Է� ��ũ���ε�
				InsertButtonLink();
			}
		}

		//�޴����ø���Ʈ ���ε�
		protected void SelMenuBind()
		{
			if(Cookie.Self["DeptName"] == "��ȹ/����")
				JinsLibrary.CONTROL.Util.DDLAddItem(ref ddlSelMenu, "�ı��û����", "0");
		}	

		#region ��������Ʈ ���ε�
		protected void DocListBind()
		{
			DBLib dbUtil = new DBLib();
			//�������������ʱ�ȭ
			int topCnt;
			topCnt = Paging.Self.PageSize(20);
			
			string fieldNames,whereClause,orderBy;
			fieldNames = "da_id,daCategory,daType,daName,daStatus,staff_id,ISNULL(daModifyDT, daRegisterDT) as docDay, DNSecurity, SLSecurity";
			whereClause = this.whereClause;
			orderBy = "daType ASC, docDay DESC";
			string subQryOrderBy = "daType DESC, docDay ASC";	//orderBy�� �ݴ�	
			
			//�ѷ��ڵ�� ����
			Paging.Self.TotRecordCount = dbUtil.GetRecordCount(this.tableName,whereClause);			
			//������� ����, AbsolutePage�� ���� ��Ȱ�� �Ѵ�. �� �������� ������ �����ؾ� �Ѵ�//Paging.Self.SetPagePortion();
			//������������
			SqlDataReader drList = dbUtil.Select_DR(topCnt,fieldNames,this.tableName,whereClause,orderBy,Paging.Self.SetPagePortion(), subQryOrderBy);

			if(drList.HasRows) 
			{
				//this.dataList.DataSource = drList;
				//this.dataList.DataBind();		//���ε��ϱ� ���� drList.Read();���� ����.
				
				this.dataGrid.DataSource = drList;
				this.dataGrid.DataKeyField = "da_id";
				this.dataGrid.DataBind();		//���ε��ϱ� ���� drList.Read();���� ����.

				#region ����¡��ɱ���
				//���� ����� �ٽ� ä���־�~
				URLQuery.Self.SetQueryString();
				//Paging.Self.Init_Green();
				this.lbPaging.Text = Paging.Self.GeneratePaging();
				this.lbListBrief.Text = Paging.Self.ListSummary;
				#endregion		
				//������� ������� �־����� �־�����
				lbInfoList.Visible = false;
				lbListBrief.Visible = true;
				dataGrid.Visible = true;
				lbPaging.Visible = true;
			}
			else 
			{
				//������� ������� �־����� �־�����
				lbInfoList.Visible = true;
				lbListBrief.Visible = false;
				dataGrid.Visible = false;
				lbPaging.Visible = false;
			}
			//HttpContext.Current.Response.Write("DBConnection=" + dbUtil.SqlConnection.);
			drList.Close();
			dbUtil.SqlConnection.Close();
		}
		#endregion

		private void SetWhereClause()
		{
			this.whereClause = BoardBaseLib.GetSelMenuQuery(ddlSelMenu.SelectedValue);
			if(tbSearchString.Text != "")
			{
				//���� �������� �����մϴ�.      ; 1
				Paging.Self.SetCurrentPage(1);

				string search = "";
				tbSearchString.Text = HTML.ReplaceToDB(tbSearchString.Text);

				switch(ddlSearch.SelectedItem.Value)
				{         
					case "daCategory":
					case "daType":
						search = " LIKE '" + tbSearchString.Text +  "%'";
						this.whereClause += " AND (" + ddlSearch.SelectedItem.Value + search + ")";
						break;
					case "daName":
					case "DeptName":
					case "daDescription":
						search = " LIKE '%" + tbSearchString.Text +  "%'";
						this.whereClause += " AND (" + ddlSearch.SelectedItem.Value + search + ")";
						break;
					case "da_id":
					case "staff_id":
						if(ddlSearch.SelectedItem.Value == "da_id")
							search = "=" + tbSearchString.Text;
						else
							search = "=" + StfBaseLib.GetStaff_id(tbSearchString.Text);
						
						this.whereClause += " AND (" + ddlSearch.SelectedItem.Value + search + ")";
						break;
						//case "DeptName":
						//	search = "=" + tbSearchString.Text;
						//	break;
						//	case "DeptID":
						//	string deptID = BoardBaseLib.GetDeptID(tbSearchString.Text);
						//	if(deptID != null) 
						//	search = " = " + deptID;
						//	else
						//	search = " Is Null";
						//	this.whereClause += " AND (" + ddlSearch.SelectedItem.Value + search + ")";
						//	JinsLibrary.WebUtil.CurrentResponse.Write("������= " +this.whereClause + "<br>");
						//	JinsLibrary.CommonLib.WebUtil.CurrentResponse.End();
						//	break;					
					default:            
						goto case "daCategory";
				}
			}
			SearchResultDisplay();
		}		
				

		private void ddlSelMenu_SelectedIndexChanged(object sender, System.EventArgs e)
		{		
			//������ ��ȣ�� �����ؾ� ������ �ȳ�.
			URLQuery.Self.Remove("cp");
			URLQuery.Self["cp"] = "1";
			Paging.Self.SetCurrentPage(1);

			//�޴����� ����ƽ����
			SelMenuValue = Convert.ToInt16(ddlSelMenu.SelectedValue);

			SetWhereClause();
			DocListBind();
			//������ �̺�Ʈ����Ǹ� ȥ��
			this.tbSearchString.TextChanged -= new System.EventHandler(this.tbSearchString_TextChanged);
			this.btnSearch.Click -= new System.EventHandler(this.btnSearch_Click);
		}
		private void btnSearch_Click(object sender, System.EventArgs e)
		{
			SetWhereClause();
			DocListBind();
			this.tbSearchString.TextChanged -= new System.EventHandler(this.tbSearchString_TextChanged);
		}
		private void tbSearchString_TextChanged(object sender, System.EventArgs e)
		{
			SetWhereClause();
			DocListBind();
			this.btnSearch.Click -= new System.EventHandler(this.btnSearch_Click);
		}
		private void InsertButtonLink() 
		{
			URLQuery.Self["mode"] = "i";
			this.hlInsert.NavigateUrl = "DocForm.aspx?" + URLQuery.Self.GetQueryString();
		}
		private void dataGrid_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
		{
			if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
			{
				string tempDAName = e.Item.Cells[3].Text;
				e.Item.Cells[3].ToolTip = tempDAName;
				e.Item.Cells[3].Text = Text.ShortenUniString(tempDAName, 38);
				//				ImageButton ibKeepMail = (ImageButton)e.Item.FindControl("ibKeepMail"); // Text??
				//				if(MailBaseLib.SelMenuValue == 2)
				//					ibKeepMail.Attributes["onClick"] = "return SubmitJ('������ �����Ͻ÷ƴϱ�?', 'this.form', null);";
				//				else
				//					ibKeepMail.Visible = false;
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
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
