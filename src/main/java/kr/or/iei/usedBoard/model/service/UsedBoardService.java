package kr.or.iei.usedBoard.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.iei.spot.model.vo.Spot;
import kr.or.iei.spot.model.vo.SpotPageData;
import kr.or.iei.usedBoard.model.dao.UsedBoardDao;
import kr.or.iei.usedBoard.model.vo.UsedBoard;
import kr.or.iei.usedBoard.model.vo.UsedBoardPageData;
import kr.or.iei.usedBoard.model.vo.UsedComment;
import kr.or.iei.usedBoard.model.vo.UsedFiles;

@Service
public class UsedBoardService {
	@Autowired
	private UsedBoardDao dao;

	public UsedBoardPageData selectAllUsedList(int reqPage) {
		HashMap<String, String> map = new HashMap<String, String>();
		
		int numPerPage=10; //한페이지당 게시물 수
		int totalCount = dao.totalCount();//총 게시물 수를 구해오는 dao호출
		System.out.println("총게시글수: "+totalCount);
		//총 페이지 수를 연산
		int totalPage= 0;
		if(totalCount%numPerPage==0) { //딱떨어지면
			totalPage = totalCount/numPerPage;
		}else {	//몇개남으면
			totalPage = totalCount/numPerPage+1;
		}
		
		int start = (reqPage-1)*numPerPage+1;
		int end = reqPage*numPerPage;

		
		map.put("start", String.valueOf(start));
		map.put("end", String.valueOf(end));
		List list = dao.selectAllList(map);
		ArrayList<UsedBoard> list2=(ArrayList<UsedBoard>)list; 
		//페이지 네비게이션 작성시작
		String pageNavi="";
		//페이지 네비게이션 길이
		int pageNaviSize = 5;
		int pageNo=((reqPage-1)/pageNaviSize)*pageNaviSize+1;//페이지네비 시작페이지넘버
		
		//이전버튼
		if(pageNo!=1) { 
			pageNavi +="<a class='heading' href='/goAdminUsedBoard.do?reqPage='"+(pageNo-pageNaviSize)+">이전</a>";
		}
		//숫자
		for(int i=0; i<pageNaviSize; i++) {
			if(reqPage==pageNo) {  
				pageNavi += "<span class='selectPage'>"+pageNo+"</span>";
			}else {
				pageNavi+="<a class='naviBtn' href = '/goAdminUsedBoard.do?reqPage='>"+pageNo+"</a>";
			}
			pageNo++;
			if(pageNo>totalPage) {
				break;
			}
		}
		//다음버튼 ,위의 숫자표시부분을통하면서 pageNo가 네비의 다음단위의 첫페이지로 바뀌어있는상태 
		//ex) pageNo 1로시작햇으면 5번for문통하면서 6돼있음
		if(pageNo <= totalPage) { //그pageNo가 있는페이지면 이동가능하게해둠(pageNo+pageNaviSize)
			pageNavi += "<a class='heading' href='/goAdminUsedBoard.do?reqPage='"+pageNo+">다음</a>";
		}
		//받아온게시물리스트와 작성한 페이지 네비를 객체에 함께 담아 전달
		UsedBoardPageData upd = new UsedBoardPageData(list2, pageNavi);
		return upd;
	}

	@Transactional
	public int insertBoard(UsedBoard ub) {
		return dao.insertBoard(ub);
	}

	public UsedBoard checkUsedPw(UsedBoard ub) {
		return dao.checkUsedPw(ub);
	}

	@Transactional
	public UsedBoard selectOneBoard(int usedNo) {
		dao.updateReadCount(usedNo);
		return dao.selectOneBoard(usedNo);
	}
	@Transactional
	public int deleteBoard(int usedNo) {
		return dao.deleteBoard(usedNo);
	}
	
	@Transactional
	public int insertComment(UsedComment uc, ArrayList<UsedFiles> fileList, int usedStatus) {
		int result1 = dao.insertComment(uc);
		int result2 = dao.insertFiles(fileList);
		if((usedStatus==1 && !uc.getCommentWriter().equals("admin"))||uc.getCommentWriter().equals("admin")) {
			UsedBoard ub = new UsedBoard();
			ub.setMemberId(uc.getCommentWriter());
			ub.setUsedStatus(usedStatus);
			ub.setUsedNo(uc.getUsedNo());
			int result = dao.updateUsedStatus(ub);
		}
		return result1+result2;
	}

	public ArrayList<UsedComment> selectComment(int usedNo) {
		List list = dao.selectComment(usedNo);
		for(int i=0; i<list.size();i++) {
			UsedComment uc =(UsedComment)list.get(i);
			int commentNo= uc.getCommentNo();
			List ufList = dao.selectFiles(commentNo);
			uc.setUsedFiles((ArrayList<UsedFiles>)ufList);
		}
		return (ArrayList<UsedComment>)list;
	}
}
