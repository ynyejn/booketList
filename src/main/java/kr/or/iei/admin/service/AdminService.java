package kr.or.iei.admin.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.admin.dao.AdminDao;
import kr.or.iei.book.model.vo.Book;
import kr.or.iei.book.model.vo.BookPageData;
import kr.or.iei.member.model.vo.Member;
import kr.or.iei.member.model.vo.MemberPageData;


@Service("adminService")
public class AdminService {
	
	@Autowired
	@Qualifier("adminDao")
	private AdminDao dao;

	public MemberPageData selectMember(int reqPage, int selectCount) {
		System.out.println("AdminService");
		int numPerPage = selectCount;
		int totalCount = dao.memberTotalCount();
		System.out.println(totalCount);
		int totalPage = 0;
		if(totalCount % numPerPage ==0) {
			totalPage = totalCount/numPerPage;
		}else {
			totalPage = totalCount/numPerPage+1;
		}
		int start = (reqPage -1)*numPerPage +1;
		System.out.println(start);
		int end = reqPage*numPerPage;
		System.out.println(end);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end", end);
		ArrayList<Member> list = (ArrayList<Member>)dao.selectMember(map);
		System.out.println(list.size());
		String pageNavi = "";
		int pageNaviSize = 5;
		int pageNo = ((reqPage - 1) / pageNaviSize) * pageNaviSize + 1;
		if (pageNo != 1) {
			pageNavi += "<li><a href='/memberList.do?reqPage=" + (pageNo - pageNaviSize) + "&selectCount="+selectCount+"'><span>«</span></a></li>";
		}
		for (int i = 0; i < pageNaviSize; i++) {
			if (reqPage == pageNo) {
				pageNavi += "<li class='active'><a href='#'><span>"+ pageNo  +"<span class='sr-only'>(current)</span></span></a></li>";
			} else {
				pageNavi += "<li><a href='/memberList.do?reqPage=" + pageNo + "&selectCount="+selectCount+"'>" + pageNo + "</a></li>";
			}
			pageNo++;
			if (pageNo > totalPage) {
				break;
			}
		}
		if (pageNo <= totalPage) {
			pageNavi += "<li><a aria-label='Next' href='/memberList.do?reqPage=" + pageNo + "&selectCount="+selectCount+"'><span>»</span></a></li>";
		}
		
		MemberPageData mpd = new MemberPageData(list,pageNavi);
		return mpd;

	}
	public MemberPageData MemberSearchList(String selectColumn, String search, int reqPage, int selectCount) {
		int numPerPage = selectCount;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("selectColumn", selectColumn);
		map.put("search", search);
		int totalCount = dao.selectMemberTotalCount(map);
		System.out.println("서치멤버리스트개수 : "+totalCount);
		int totalPage = 0;
		if(totalCount % numPerPage ==0) {
			totalPage = totalCount/numPerPage;
		}else {
			totalPage = totalCount/numPerPage+1;
		}
		int start = (reqPage -1)*numPerPage +1;
		System.out.println("시작번호 : "+start);
		int end = reqPage*numPerPage;
		System.out.println("끝번호 : "+end);
		map.put("start", start);
		map.put("end", end);
		ArrayList<Member> list = (ArrayList<Member>)dao.selectMemberList(map);
		System.out.println("리스트 사이즈 : "+list.size());
		
		String pageNavi = "";
		int pageNaviSize = 5;
		int pageNo = ((reqPage - 1) / pageNaviSize) * pageNaviSize + 1;
		
		if (pageNo != 1) {
			//pageNavi += "<li><a href='/memberSearchList.do?reqPage=" + (pageNo - pageNaviSize) + "&selectCount="+10+"&selectColumn="+selectColumn+"&search="+search+"'><span>«</span></a></li>";
			pageNavi += "<li><a href='javascript:void(0)' onclick='searchPageNavi(this)'><span>«</span></a></li>";
		}
		
		for (int i = 0; i < pageNaviSize; i++) {
			if (reqPage == pageNo) {
				pageNavi += "<li class='active'><a href='#'><span>"+ pageNo  +"<span class='sr-only'>(current)</span></span></a></li>";
			} else {
				//href='/memberSearchList.do?reqPage=" + pageNo + "&selectCount="+10+"&selectColumn="+selectColumn+"&search="+search+"'
				pageNavi += "<li><a href='javascript:void(0)' onclick='searchPageNavi(this)'>" + pageNo + "</a></li>";
			}
			pageNo++;
			if (pageNo > totalPage) {
				break;
			}
		}
		
		if (pageNo <= totalPage) {
			//pageNavi += "<li><a aria-label='Next' href='/memberSearchList.do?reqPage=" + pageNo + "&selectCount="+10+"&selectColumn="+selectColumn+"&search="+search+"'><span>»</span></a></li>";
			pageNavi += "<li><a aria-label='Next' href='javascript:void(0)' onclick='searchPageNavi(this)'><span>»</span></a></li>";
		}
		
		MemberPageData mpd = new MemberPageData(list,pageNavi);
		return mpd;

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

	public BookPageData selectList3(int reqPage, String search, String searchTitle) {
		int numPerPage = 10;
		HashMap<String, String> map2 = new HashMap<String, String>();
		map2.put("search", search);
		map2.put("searchTitle", searchTitle);
		int totalCount = dao.bookTotalCount3(map2);
		int totalPage = 0;
		if(totalCount % numPerPage == 0) {
			totalPage = totalCount /numPerPage;
		}else {
			totalPage = totalCount / numPerPage + 1;
		}
		//조회해 올 게시물 시작번화와 끝번호연산
		String start = Integer.toString((reqPage - 1) * numPerPage + 1);
		String end = Integer.toString(reqPage * numPerPage);
		map2.put("start", start);
		map2.put("end", end);
		
		ArrayList<Book> list = (ArrayList<Book>)dao.selectList3(map2);
		
		String pageNavi = "";
		
		int pageNaviSize = 5;
		int pageNo = ((reqPage - 1) / pageNaviSize) * pageNaviSize + 1;
		if (pageNo != 1) {
			pageNavi += "<li><a href='/adminBookList.do?reqPage=" + (pageNo - pageNaviSize) + "&check=1&reqPage2=1&search="+search+"&searchTitle="+searchTitle+"'><span>«</span></a></li>";
		}
		for (int i = 0; i < pageNaviSize; i++) {
			if (reqPage == pageNo) {
				pageNavi += "<li class='active'><a href='#'><span>"+ pageNo  +"<span class='sr-only'>(current)</span></span></a></li>";
			} else {
				pageNavi += "<li><a href='/adminBookList.do?reqPage=" + pageNo + "&check=1&reqPage2=1&search="+search+"&searchTitle="+searchTitle+"'>" + pageNo + "</a></li>";
			}
			pageNo++;
			if (pageNo > totalPage) {
				break;
			}
		}
		if (pageNo <= totalPage) {
			pageNavi += "<li><a aria-label='Next' href='/adminBookList.do?reqPage=" + pageNo + "&check=1&reqPage2=1&search="+search+"&searchTitle="+searchTitle+"'><span>»</span></a></li>";
		}
		
		BookPageData bpd = new BookPageData(list, pageNavi);
		return bpd;
	}

	public BookPageData selectList4(int reqPage2, String search, String searchTitle) {
		return null;
	}
	
}
