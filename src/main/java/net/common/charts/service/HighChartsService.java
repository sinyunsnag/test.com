package net.common.charts.service;

import net.common.charts.vo.DataVO;
import net.common.charts.vo.SeriesVO;
import net.common.charts.dao.HighChartsDAO;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.annotation.Resource;

@Service
public class HighChartsService {
	
	@Resource(name = "highChartsDAO")
	private HighChartsDAO HighChartsDAO;
	
	
    public DataVO getLineChartData1() {
        List<SeriesVO> list = new ArrayList<SeriesVO>();
        list.add(new SeriesVO("Tokyo",  new double[] {7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6}));
        list.add(new SeriesVO("New York", new double[] {0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5}));
        list.add(new SeriesVO("London", new double[] {3.9, 4.2, 5.7, 8.5, 12.9, 15.2, 15.0, 16.6, 14.2, 10.3, 6.6, 4.8}));

        String[] categories = new String[] {"9 Jan '13", "8 Feb '13","5 Mar '13","12 Apr '13","14 May '13","21 Jun '13","30 Jul '13","8 Aug '13","5 Sep '13","17 Oct '13","23 Nov '13","5 Dec '13"};
        return new DataVO("chart1-container", "LineChart Title", "통계", "Run Dates", Arrays.asList(categories), list);
    }

    public DataVO getLineChartData2() {
        List<SeriesVO> list = new ArrayList<SeriesVO>();
        list.add(new SeriesVO("Munich", new double[] {8.0, 6.9, 9.5, 12.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6}));

        String[] categories = new String[] {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
        return new DataVO("chart2-container", "LineChart Title", "통계", "Run Dates", Arrays.asList(categories), list);
    }



    public DataVO selectListWeeklyUsers() {
     
    	List<SeriesVO> list = HighChartsDAO.selectListWeeklyUsers();
       
        
        String[] categories = new String[] {"4 Jan '13", "14 Feb '13","15 Mar '13","11 Apr '13","19 May '13","23 Jun '13","3 Jul '13","8 Aug '13","5 Sep '13","17 Oct '13","23 Nov '13","5 Dec '13"};
        return new DataVO("chart3-container", "LineChart Title", "통계", "Run Dates", Arrays.asList(categories), list);
    }

}
