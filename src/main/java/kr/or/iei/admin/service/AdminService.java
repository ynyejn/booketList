package kr.or.iei.admin.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.admin.dao.AdminDao;
import kr.or.iei.book.model.vo.Book;
import kr.or.iei.book.model.vo.BookPageData;
import kr.or.iei.member.model.vo.Member;


@Service("adminService")
public class AdminService {
	
	@Autowired
	@Qualifier("adminDao")
	private AdminDao dao;

	public ArrayList<Member> selectMember() {
		System.out.println("AdminService");
		List list = dao.selectMember();
		ArrayList<Member>alist = new ArrayList<Member>();
		
		return (ArrayList<Member>)list;
	}

	public BookPageData selectList1(int reqPage) {
		int numPerPage = 10;
		int totalCount = dao.bookTotalCount();
		int totalPage = 0;
		if(totalCount % numPerPage == 0) {
			totalPage = totalCount /numPerPage;
		}else {
			totalPage = totalCount / numPerPage + 1;
		}
		//조회해 올 게시물 시작번화와 끝번호연산
		int start = (reqPage - 1) * numPerPage + 1;
		int end =reqPage * numPerPage;
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end", end);
		
		ArrayList<Book> list = (ArrayList<Book>)dao.selectList1(map);
		
		String pageNavi = "";
		
		int pageNaviSize = 5;
		int pageNo = ((reqPage - 1) / pageNaviSize) * pageNaviSize + 1;
		if (pageNo != 1) {
			pageNavi += "<li><a href='/adminBookList.do?reqPage=" + (pageNo - pageNaviSize) + "&check=1&reqPage2=1'><span>«</span></a></li>";
		}
		for (int i = 0; i < pageNaviSize; i++) {
			if (reqPage == pageNo) {
				pageNavi += "<li class='active'><a href='#'><span>"+ pageNo  +"<span class='sr-only'>(current)</span></span></a></li>";
			} else {
				pageNavi += "<li><a href='/adminBookList.do?reqPage=" + pageNo + "&check=1&reqPage2=1'>" + pageNo + "</a></li>";
			}
			pageNo++;
			if (pageNo > totalPage) {
				break;
			}
		}
		if (pageNo <= totalPage) {
			pageNavi += "<li><a aria-label='Next' href='/adminBookList.do?reqPage=" + pageNo + "&check=1&reqPage2=1'><span>»</span></a></li>";
		}
		
		BookPageData bpd = new BookPageData(list, pageNavi);
		return bpd;
	}

	public BookPageData selectList2(int reqPage2) {
		int numPerPage = 10;
		int totalCount = dao.bookTotalCount2();
		int totalPage = 0;
		if(totalCount % numPerPage == 0) {
			totalPage = totalCount /numPerPage;
		}else {
			totalPage = totalCount / numPerPage + 1;
		}
		//조회해 올 게시물 시작번화와 끝번호연산
		int start = (reqPage2 - 1) * numPerPage + 1;
		int end =reqPage2 * numPerPage;
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end", end);
		
		ArrayList<Book> list = (ArrayList<Book>)dao.selectList2(map);
		
		String pageNavi = "";
		
		int pageNaviSize = 5;
		int pageNo = ((reqPage2 - 1) / pageNaviSize) * pageNaviSize + 1;
		if (pageNo != 1) {
			pageNavi += "<li><a href='/adminBookList.do?reqPage2=" + (pageNo - pageNaviSize) + "&check=2&reqPage=1'><span>«</span></a></li>";
		}
		for (int i = 0; i < pageNaviSize; i++) {
			if (reqPage2 == pageNo) {
				pageNavi += "<li class='active'><a href='#'><span>"+ pageNo  +"<span class='sr-only'>(current)</span></span></a></li>";
			} else {
				pageNavi += "<li><a href='/adminBookList.do?reqPage2=" + pageNo + "&check=2&reqPage=1'>" + pageNo + "</a></li>";
			}
			pageNo++;
			if (pageNo > totalPage) {
				break;
			}
		}
		if (pageNo <= totalPage) {
			pageNavi += "<li><a aria-label='Next' href='/adminBookList.do?reqPage2=" + pageNo + "&check=2&reqPage=1'><span>»</span></a></li>";
		}
		
		BookPageData bpd = new BookPageData(list, pageNavi);
		return bpd;
		
	}
}
