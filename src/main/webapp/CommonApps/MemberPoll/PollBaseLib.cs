using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

using JinsLibrary;

namespace KistelSite.CommonApps.MemberPoll
{
	/// <summary>
	/// PollBaseLib�� ���� ��� �����Դϴ�.
	/// </summary>
	public class PollBaseLib : KistelSite.Admins.SiteMgr.PollMgr.PollBaseLib
	{
		//�׷����׸��� (����ؼ� ����)
		/*
		public static System.Web.UI.WebControls.Image DrawGraph(int point, int pollSum)
		{
			System.Web.UI.WebControls.Image imgCntGraph;
			double widthPercent = 0;
			if(pollSum > 0)
				widthPercent = Math.Round(MathLib.GetPercent(point, pollSum), 1);
			
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
		public PollBaseLib()
		{
			//
			// TODO: ���⿡ ������ ���� �߰��մϴ�.
			//
		}
	}
}
