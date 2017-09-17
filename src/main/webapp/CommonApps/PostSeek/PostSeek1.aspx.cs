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

namespace SkyShop.INC.UTIL
{
	/// <summary>
	/// PopZipSearch�� ���� ��� �����Դϴ�.
	/// </summary>
	public class PopZipSearch : System.Web.UI.Page
	{
		#region ����
		protected System.Web.UI.WebControls.Panel St_Panel;
		protected System.Web.UI.WebControls.Panel Ed_Panel;
		protected System.Web.UI.WebControls.TextBox tb_Dong;
		protected System.Web.UI.WebControls.ImageButton imgBtn_Search;
		protected System.Web.UI.WebControls.DropDownList selAddr;
		protected System.Web.UI.WebControls.Label lblResult;
		protected DataSet dsResult;		
		protected ZipCodeData zipCode;
		//��ȿ�� �˻�
		protected System.Web.UI.WebControls.RequiredFieldValidator RequiredFieldValidator1;
		protected System.Web.UI.WebControls.ValidationSummary ValidationSummary1;
		#endregion
	
		#region ������Ͽ� �Ķ���� ��������
		protected string GetParams()
		{
			return string.Format("'{0}','{1}','{2}'",Request.QueryString["firTarget"],Request.QueryString["secTarget"], this.selAddr.ClientID);
		}
		#endregion

		private void Page_Load(object sender, System.EventArgs e)
		{
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
			this.tb_Dong.TextChanged += new System.EventHandler(this.tb_Dong_TextChanged);
			this.imgBtn_Search.Click += new System.Web.UI.ImageClickEventHandler(this.imgBtn_Search_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		#region �ּҰ˻� ��ư �̺�Ʈ		
		private void tb_Dong_TextChanged(object sender, EventArgs e)
		{
			this.imgBtn_Search_Click(this,null);
		}

		private void imgBtn_Search_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
			try
			{		
				zipCode = new ZipCodeData();
				dsResult = zipCode.Search(this.tb_Dong.Text);
				
				if(dsResult.Tables[0].Rows.Count > 0)
				{
					this.St_Panel.Visible = false;
					this.Ed_Panel.Visible = true;
					this.selAddr.DataSource = dsResult;
					this.selAddr.DataTextField = "TEXT";
					this.selAddr.DataValueField = "VALUE";
					this.selAddr.DataBind();
				}
				else
					this.lblResult.Text = "�˻��� ����� �����ϴ�.";
			}
			catch(Exception ex)
			{
				Response.Write(ex.ToString());
			}
		}
		#endregion

//		private void DataList1_ItemCommand(object source, System.Web.UI.WebControls.DataListCommandEventArgs e)
//		{				
//			string zipcode, address;
//
//			try
//			{
//				if(e.CommandName == "Zip_Click")
//				{
//					zipCode = new ZipCodeData();
//					DataRow zipRow = zipCode.Search(Convert.ToInt32(e.CommandArgument));
//
//					zipcode = zipRow["ZIPCODE"].ToString();
//					address = zipRow["SIDO"].ToString() + " " +  zipRow["GUGUN"].ToString() + " " +  zipRow["DONG"].ToString();
//
//					Page.RegisterStartupScript("setDate","<script>opener.document.all." + Request.QueryString["firTarget"] + ".value = '" + zipcode + "';opener.document.all." + Request.QueryString["secTarget"] + ".value = '" + address + "';self.close();</script>");
//				}
//			}
//			catch(Exception ex)
//			{
//				Response.Write(ex.ToString());
//			}
//		}

//		protected string GetScript(object data)
//		{
//			DataRowView dr = (DataRowView)data;
//			
//			string zipcode, address;
//			string strValue = "";
//			
//			try
//			{
//				zipCode = new ZipCodeData();
//				DataRow zipRow = zipCode.Search(Convert.ToInt32(dr["IDXNO"].ToString()));
//
//				zipcode = zipRow["ZIPCODE"].ToString();
//				address = zipRow["SIDO"].ToString() + " " +  zipRow["GUGUN"].ToString() + " " +  zipRow["DONG"].ToString();
//
//				strValue = string.Format("javascript:SetAddress('{0}','{1}','{2}','{3}')", Request.QueryString["firTarget"], zipcode, Request.QueryString["secTarget"], address);
//			}
//			catch(Exception ex)
//			{
//				Response.Write(ex.ToString());
//			}
//			
//			return strValue;
//		}
	}
}
