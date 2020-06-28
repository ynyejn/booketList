package kr.or.iei.spot.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.iei.spot.model.dao.SpotDao;
import kr.or.iei.spot.model.vo.Spot;
import kr.or.iei.spot.model.vo.SpotPageData;

@Service
public class SpotService {
	@Autowired
	private SpotDao dao;
	
	public SpotPageData selectAllSpot(int reqPage) {
		int numPerPage=5; //한페이지당 게시물 수
		int totalCount = dao.totalCount();//총 게시물 수를 구해오는 dao호출
		System.out.println("총스팟수: "+totalCount);
		//총 페이지 수를 연산
		int totalPage= 0;
		if(totalCount%numPerPage==0) { //딱떨어지면
			totalPage = totalCount/numPerPage;
		}else {	//몇개남으면
			totalPage = totalCount/numPerPage+1;
		}
		
		int start = (reqPage-1)*numPerPage+1;
		int end = reqPage*numPerPage;

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("start", String.valueOf(start));
		map.put("end", String.valueOf(end));
		List list = dao.selectAllSpot(map);
		ArrayList<Spot> list2=(ArrayList<Spot>)list; 
		//페이지 네비게이션 작성시작
		String pageNavi="";
		//페이지 네비게이션 길이
		int pageNaviSize = 5;
		int pageNo=((reqPage-1)/pageNaviSize)*pageNaviSize+1;//페이지네비 시작페이지넘버
		
		//이전버튼
		if(pageNo!=1) { 
			pageNavi +="<a class='btn' href='/noticeList?reqPage="+(pageNo-pageNaviSize)+"'>이전</a>";
		}
		//숫자
		for(int i=0; i<pageNaviSize; i++) {
			if(reqPage==pageNo) {  
				pageNavi += "<span class='selectPage'>"+pageNo+"</span>";
			}else {
				pageNavi+="<a class='btn' href = '/noticeList?reqPage="+pageNo+"'>"+pageNo+"</a>";
			}
			pageNo++;
			if(pageNo>totalPage) {
				break;
			}
		}
		//다음버튼 ,위의 숫자표시부분을통하면서 pageNo가 네비의 다음단위의 첫페이지로 바뀌어있는상태 
		//ex) pageNo 1로시작햇으면 5번for문통하면서 6돼있음
		if(pageNo <= totalPage) { //그pageNo가 있는페이지면 이동가능하게해둠
			pageNavi += "<a class='btn' href='/noticeList?reqPage="+pageNo+"'>다음</a>";
		}
		//받아온게시물리스트와 작성한 페이지 네비를 객체에 함께 담아 전달
		SpotPageData spd = new SpotPageData(list2, pageNavi);
		return spd;
	}

	public ArrayList<Spot> selectAllLocalName() {
		// TODO Auto-generated method stub
		return null;
	}

}
