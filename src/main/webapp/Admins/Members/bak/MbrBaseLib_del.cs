using System;
using System.Web;
using System.Collections;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

using JinsLibrary;
using JinsLibrary.FILE;
using JinsLibrary.CONFIG;
using JinsLibrary.STATEMANAGE;

namespace KistelSite.Admins.Members
{
	public class MbrBase : MbrBaseLib
	{	
		public int member_id;
		public System.Int16 cbProMbr;
		//�⺻ȸ������		
		public string loginID;
		public string loginPW;
		public string MbrName;
		public string MbrEmail;
		public string phone;	
		public string cellularP;
		public string zipcode;
		public string address;
		public string findingID;        					
		public string findingA;
		public string SSN;
		public System.Int16 newsLetter;
		//ȸ����ġ
		//public System.Int16 mLevel;
		//public System.Int64 howMuch;
		//public int howMany;
		//public int RFund;
		//public int RFundAC;
		//public int point;
		//public int pointAC;
		//public int unpaid;
		//public int unpaidAC;
		public string rcmderID;
		public string IPaddress;
		//�ΰ�ȸ������
		public string homepage;
		public string messenger;
		public string hobbies;
		public string carInfo;
		public string children;
		public string avataImage;
		public string monthlyPay;
		public string mark;
		public string SLBirth;
		public string BirthDay;
		public string Married;			//���� ��ȥ�̶�........
		public string WeddingDay;
		//ȸ������
        public string company;
		public string jobType;
		public string officeP;
		public string oZipcode;
		public string oAddress;

		private DBLib dbUtil;
		private SqlCommand myCommand;
		//private SqlParameter[] mySqlParameters;
		
		public int Insert()
		{			
			FillSlqParameters("i");
			return dbUtil.ExecProcedure(myCommand,"sp_Members");
		}
		public int Update()
		{
			FillSlqParameters("u");
			return dbUtil.ExecProcedure(myCommand,"sp_Members");
		}
		public int Insert_OptionJob()
		{			
			FillSlqParameters("iu");
			return dbUtil.ExecProcedure(myCommand,"sp_MemberOption_Job");
		}
		public int Update_OptionJob()
		{
			FillSlqParameters("iu");
			return dbUtil.ExecProcedure(myCommand,"sp_MemberOption_Job");
		}		
		public void FillSlqParameters(string mode)	// mode i,u
		{
			myCommand = new SqlCommand();	//("sp_Members", dbUtil.SqlConnection);
			myCommand.CommandType = CommandType.StoredProcedure;

			myCommand.Parameters.Add("@member_id", SqlDbType.Int).Value				= member_id;
			if(mode != "iu")	//������
			{
				SqlParameter sp_mode = new SqlParameter("@sp_mode", SqlDbType.VarChar, 1);
				sp_mode.Value = mode;
				myCommand.Parameters.Add(sp_mode);
				
				myCommand.Parameters.Add("@cbProMbr", SqlDbType.Bit).Value				= cbProMbr;
				myCommand.Parameters.Add("@loginID", SqlDbType.VarChar, 15).Value		= loginID;
				myCommand.Parameters.Add("@loginPW", SqlDbType.VarChar, 15).Value		= loginPW;
				myCommand.Parameters.Add("@MbrName", SqlDbType.VarChar, 50).Value		= MbrName;
				myCommand.Parameters.Add("@MbrEmail", SqlDbType.VarChar, 50).Value		= MbrEmail;
				myCommand.Parameters.Add("@phone", SqlDbType.VarChar, 50).Value			= phone;
				myCommand.Parameters.Add("@cellularP", SqlDbType.VarChar, 50).Value		= cellularP;
				myCommand.Parameters.Add("@zipcode", SqlDbType.VarChar, 20).Value		= zipcode;
				myCommand.Parameters.Add("@address", SqlDbType.VarChar, 200).Value		= address;
				myCommand.Parameters.Add("@findingID", SqlDbType.TinyInt).Value			= findingID;
				myCommand.Parameters.Add("@findingA", SqlDbType.VarChar, 20).Value		= findingA;
				myCommand.Parameters.Add("@SSN", SqlDbType.VarChar, 50).Value			= SSN;
				myCommand.Parameters.Add("@newsLetter", SqlDbType.Bit).Value			= newsLetter;
				myCommand.Parameters.Add("@rcmderID", SqlDbType.VarChar, 15).Value		= rcmderID;
			}
			else	//�ΰ�����
			{
				myCommand.Parameters.Add("@homepage", SqlDbType.VarChar, 100).Value		= homepage;
				myCommand.Parameters.Add("@messenger", SqlDbType.VarChar, 100).Value	= messenger;
				myCommand.Parameters.Add("@hobbies", SqlDbType.VarChar, 100).Value		= hobbies;
				if(carInfo != "")
					myCommand.Parameters.Add("@carInfo", SqlDbType.TinyInt).Value			= carInfo;
				else
					myCommand.Parameters.Add("@carInfo", SqlDbType.TinyInt).Value			= DBNull.Value;
				if(children != "")
					myCommand.Parameters.Add("@children", SqlDbType.TinyInt).Value			= children;
				else
					myCommand.Parameters.Add("@children", SqlDbType.TinyInt).Value			= DBNull.Value;
				if(monthlyPay != "")
					myCommand.Parameters.Add("@monthlyPay", SqlDbType.TinyInt).Value		= monthlyPay;
				else
					myCommand.Parameters.Add("@monthlyPay", SqlDbType.TinyInt).Value		= DBNull.Value;
				myCommand.Parameters.Add("@avataImage", SqlDbType.VarChar, 50).Value	= avataImage;
				myCommand.Parameters.Add("@mark", SqlDbType.VarChar, 1000).Value		= mark;
				//��������
				myCommand.Parameters.Add("@company", SqlDbType.VarChar, 50).Value		= company;
				myCommand.Parameters.Add("@jobType", SqlDbType.VarChar, 30).Value		= jobType;
				myCommand.Parameters.Add("@officeP", SqlDbType.VarChar, 30).Value		= officeP;
				myCommand.Parameters.Add("@zipcode", SqlDbType.VarChar, 20).Value		= oZipcode;
				myCommand.Parameters.Add("@address", SqlDbType.VarChar, 200).Value		= oAddress;
				//���������
				myCommand.Parameters.Add("@SLBirth", SqlDbType.NChar, 1).Value			= SLBirth;
				if(BirthDay != "")
					myCommand.Parameters.Add("@BirthDay", SqlDbType.SmallDateTime).Value	= BirthDay;
				else
					myCommand.Parameters.Add("@BirthDay", SqlDbType.SmallDateTime).Value	= DBNull.Value;
				myCommand.Parameters.Add("@Married", SqlDbType.NChar, 1).Value		= Married;
				if(WeddingDay != "")
					myCommand.Parameters.Add("@WeddingDay", SqlDbType.SmallDateTime).Value	= WeddingDay;
				else
					myCommand.Parameters.Add("@WeddingDay", SqlDbType.SmallDateTime).Value	= DBNull.Value;
//HttpContext.Current.Response.Write("WeddingDay = " + WeddingDay +"<br>");
			}
			myCommand.Parameters.Add("@IPaddress", SqlDbType.VarChar, 50).Value		= IPaddress;
			////////////////
			myCommand.Parameters.Add("@returnValue", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
		}
		public MbrBase()
		{
			dbUtil = new DBLib();
		}
		
	}
	
	/// <summary>
	/// MbrBaseLib�� ���� ��� �����Դϴ�.      /// ���μ����� ���ٸ� �̰� �ʿ��Ѱ�?
	/// </summary>
	public class MbrBaseLib : System.Web.UI.Page
	{
		private static DBLib dbUtil;
		private static string whichList = "";
		//ȸ�������� ����
		public static void DeleteMember(string mode, string member_id)
		{
			dbUtil = new DBLib();
			//(������ ������Ʈ)
			if(mode == "d") 
			{
				string[] setNameValue = new string[2] 
				{ "leaveDT=GetDate()", "IPaddress = '" + WebUtil.CurrentRequest.UserHostAddress  + "_" + Cookie.Self["sLoginID"] + "'" };
				dbUtil.Update_EN("t_MemberValue", setNameValue , "member_id = " + member_id);
			} else if(mode == "dd") //�Խù� ��������(��������)
			{				
				MbrFilesMoveTo(member_id, dbUtil.Select_DR("avataImage","t_MemberOption","member_id=" + member_id));
				dbUtil.Delete_EN("t_MemberJob", "member_id = " + member_id);
				dbUtil.Delete_EN("t_MemberOption", "member_id = " + member_id);
				dbUtil.Delete_EN("t_MemberValue", "member_id = " + member_id);
				dbUtil.Delete_EN("t_Members", "member_id = " + member_id);
			}
			dbUtil.SqlConnection.Close();
			URLQuery.Self.Remove("mode");
			HttpContext.Current.Response.Redirect(whichList + "?" + URLQuery.Self.GetQueryString());
		}
		//ȸ�������� �������� ����(�����̵�) 
		public static void MbrFilesMoveTo(string member_id, SqlDataReader dr)
		{
			string avataImage = dr[0].ToString();
			//�����̹��� �̵�
			if(avataImage != "")
				FileLib.Self.FileMoveTo(SystemConfig.GetValue("MemberPicUploadDir") + avataImage, SystemConfig.GetValue("MemberPicUploadDir") + "Avata.bak/" + avataImage);
		}
		//���̵� �ߺ�Ȯ��
		public static bool LoginID_Exist(string loginID)
		{
			string member_id = GetMember_id(loginID);
			if(member_id == null)
				return false;		//�⺻������ �α��� ���̵� ����.
			else
			{
				if(IsMemberLeaved(member_id))
					return false;		//ȸ���� �������Ƿ� ���̵� ��밡��
				else
					return true;		//���̵����ϴ� ȸ�� ����.
			}
		}
		//Ż��ȸ���ΰ� Ȯ��
		public static bool IsMemberLeaved(string member_id)
		{
			dbUtil = new DBLib();
			if(dbUtil.GetRecordCount("t_MemberValue", "member_id='" + HTML.ReplaceToDB(member_id) + "' AND leaveDT IS NULL") > 0)
			{
				//DB�ݱ�
				dbUtil.SqlConnection.Close();
				return false;
			}
			else
				return true;
		}

		//member_id �޾Ƽ� ȸ�����̵� ����
		public static string GetLoginID(object member_id)
		{
			string loginID = "NoData";
		//HttpContext.Current.Response.Write(member_id + "<br>");
			dbUtil = new DBLib();
			SqlDataReader dr = dbUtil.Select_DR("loginID","t_Members", "member_id= "+ member_id ); //System.Convert.ToInt16
			if(dr.Read()) 
			{
				loginID = dr["loginID"].ToString(); 				
			}
			dr.Close();
			return loginID;
		}
		//member_id �޾Ƽ� ȸ���̸� ����
		public static string GetMbrName(object member_id)
		{
			string MbrName = "";
			//HttpContext.Current.Response.Write(member_id + "<br>");
			dbUtil = new DBLib();
			SqlDataReader dr = dbUtil.Select_DR("MbrName", "t_Members", "member_id="+ member_id );
			if(dr.Read()) 
			{
				MbrName = dr["MbrName"].ToString(); 				
			}
			dr.Close();
			return MbrName;
		}
		
		//LoginID �޾Ƽ� member_id ����
		public static string GetMember_id(object loginID)
		{
			string member_id = null;
			dbUtil = new DBLib();
			SqlDataReader dr = dbUtil.Select_DR("member_id", "t_Members", "loginID= '" + loginID + "'"); //System.Convert.ToInt16
			while(dr.Read()) 
			{	
				//����� ���� ����.
				member_id += dr["member_id"].ToString() + "\n";
			}
			//DataReader�� DBConnection�ݱ�
			dr.Close();			
			dbUtil.SqlConnection.Close();
			if(member_id != null)
				member_id = member_id.Substring(0,member_id.Length-1);
	//HttpContext.Current.Response.Write("member_id = " + member_id + "<br>");
			return member_id;
		}
		public static SqlDataReader GetMember_idFromLoginID(string loginID, bool isActiveMbr)
		{
			string whereClause = "loginID LIKE '%" + loginID + "%'";
			if(isActiveMbr)
				whereClause += " AND (retireDT Is Null OR retireDT = '')";
			dbUtil = new DBLib();
			SqlDataReader dr = dbUtil.Select_DR("member_id", "t_Members", whereClause); 
			//�������� ���ɼ� ������ dr�� �ѱ�.
			return dr; //�޴� �ʿ��� �ݾ� ��� ��.
		}	
		public static SqlDataReader GetMember_idFromName(string MbrName, bool isActiveMbr)
		{
			string whereClause = "MbrName LIKE '%" + MbrName + "%'";
			if(isActiveMbr)
				whereClause += " AND (retireDT Is Null OR retireDT = '')";
			dbUtil = new DBLib();
			SqlDataReader dr = dbUtil.Select_DR("member_id", "t_Members", whereClause); 
			//�������� ���ɼ� ������ dr�� �ѱ�.
			return dr; //�޴� �ʿ��� �ݾ� ��� ��.
		}
	
		//���� ȸ������
		public static string GetTotalMemberInfo()
		{
			return Cookie.Self["sName"] + "(" + Cookie.Self["loginID"] + ")";
		}

		public static string GetTotalMemberInfo(object member_id)
		{
			return GetMbrName(member_id) + "(" + GetLoginID(member_id) + ")";
		}


		//ddlSelMenu ���ÿ� ���� where ������ ����
		public static string GetSelMenuQuery(string selMenuValue)
		{
			string selMenuQuery = "";
			switch(selMenuValue)
			{ 
				case "255" :	//��ȸ��
					selMenuQuery = "(leaveDT Is Null OR leaveDT = '')";
					break;
				case "101" :	//����
					selMenuQuery = "(leaveDT Is Null OR leaveDT = '') AND mLevel=101";
					break;				
				case "5" :		//�ֿ��(�÷�Ƽ��)
					selMenuQuery = "(leaveDT Is Null OR leaveDT = '') AND mLevel=5";
					break;
				case "4" :		//�ֿ��(���)
					selMenuQuery = "(leaveDT Is Null OR leaveDT = '') AND mLevel=4";
					break;
				case "3" :		//�ֿ��(�ǹ�)
					selMenuQuery = "(leaveDT Is Null OR leaveDT = '') AND mLevel=3";
					break;
				case "2" :		//���ȸ��
					selMenuQuery = "(leaveDT Is Null OR leaveDT = '') AND mLevel=2";
					break;	
				case "1" :		//��ȸ��
					selMenuQuery = "(leaveDT Is Null OR leaveDT = '') AND mLevel=1";
					break;
				case "0" :		//�ҷ�ȸ��
					selMenuQuery = "mLevel=0";
					break;
				case "-1" :		//���ȸ��
					selMenuQuery = "(leaveDT Is NOT Null)";
					break;
				default:
					goto case "255";
			}
			return selMenuQuery;
		}
		//ddlSelMenu ���°� ���̺�
		public string GetStatusText(object ddlValue)
		{
			string returnValue = "";
			switch(ddlValue.ToString())
			{ 
				case "255" :	//��ȸ��
					returnValue = "��ȸ��";
					break;
				case "101" :	//����
					returnValue = "����";
					break;				
				case "5" :		//�ֿ��(�÷�Ƽ��)
					returnValue = "�ֿ��(�÷�Ƽ��)";
					break;
				case "4" :		//�ֿ��(���)
					returnValue = "�ֿ��(���)";
					break;
				case "3" :		//�ֿ��(�ǹ�)
					returnValue = "�ֿ��(�ǹ�)";
					break;
				case "2" :		//���ȸ��
					returnValue = "���ȸ��";
					break;	
				case "1" :		//��ȸ��
					returnValue = "��ȸ��";
					break;
				case "0" :		//�ҷ�ȸ��
					returnValue = "�ҷ�ȸ��";
					break;
				case "-1" :		//���ȸ��
					returnValue = "���ȸ��";
					break;
				default:
					returnValue = "Error";
					break;
			}
			return returnValue;			
		}

		public string GetNewsLetterText(object newsLetter)
		{
			return JinsLibrary.Text.BoolToYesNo(newsLetter);
		}

		public string GetMonthlyPayText(object monthlyPay)
		{
			if(monthlyPay.ToString() != "")
			{
				SortedList mySL =  JinsLibrary.XML.XmlLib.Self.GetResxList("MonthlyPay.resx");
				//if(mySL.ContainsKey(drMember["monthlyPay"]))
				return mySL[ Convert.ToInt16(monthlyPay) ].ToString();
			}
			else
				return "";
		}
		public string GetCarInfoText(object carInfo)
		{
			if(carInfo.ToString() != "")
			{
				SortedList mySL =  JinsLibrary.XML.XmlLib.Self.GetResxList("CarInfo.resx");
				//if(mySL.ContainsKey(drMember["monthlyPay"]))
				return mySL[ Convert.ToInt16(carInfo) ].ToString();
			}
			else
				return "";
		}
		public string GetWhichList(string ml)
		{
			whichList = "";
			switch(ml)
			{
				case ""	   :		//ȸ���⺻����Ʈ
				case "bsc" :	
					whichList = "MbrList.aspx";
					break;
				case "opt" :		//ȸ���ΰ�����Ʈ
					whichList = "MbrOptList.aspx";
					break;
				case "val" :		//ȸ���򰡸���Ʈ
					whichList = "MbrValList.aspx";
					break;
				default:
					goto case "bsc";
			}
			URLQuery.Self.Remove("ml");
			return whichList;	
		}

		public static void Modify(string member_id)
		{
			URLQuery.Self["mode"] = "u";
			URLQuery.Self["mbID"] = member_id;
			WebUtil.CurrentResponse.Redirect("MbrForm.aspx?"+ URLQuery.Self.GetQueryString());
		}
		public static void Delete(string member_id)
		{
			DeleteMember("d", member_id);
		}
		public static void Eliminate(string member_id)
		{
			DeleteMember("dd", member_id);
		}

		//CanView + CanModify = CanAccess;	CanView + CanModify + CanDelete = CanAllAccess
		public static Boolean CanAccess(string leaveDT)
		{
			if(Cookie.Self["DeptName"] == "��ȹ/����" && leaveDT == "")
				return true;
			else
				return false;
		}		
		public static Boolean CanDelete(string member_id)
		{
			if(CanAccess(string.Empty) && Convert.ToInt16(Cookie.Self["sLevel"]) >= 30)
				return true;
			else
				return false;
		}
		//������Ʈ�ѿ� "����"�� ǥ���Ҷ�
		public bool DisplayNone(bool hlView, bool ibModfy)
		{
			if(hlView || ibModfy)
			{
				return false;
			}
			else
				return true;
		}

		public MbrBaseLib()
		{
		}
	}
}
