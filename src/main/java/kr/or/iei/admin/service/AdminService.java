package kr.or.iei.admin.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.admin.dao.AdminDao;
import kr.or.iei.apply.model.vo.Apply;
import kr.or.iei.apply.model.vo.ApplyPageData;
import kr.or.iei.book.model.vo.Book;
import kr.or.iei.book.model.vo.BookPageData;
import kr.or.iei.complain.model.vo.Complain;
import kr.or.iei.complain.model.vo.ComplainPageData;
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
		int end = reqPage*numPerPage;
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end", end);
		ArrayList<Member> list = (ArrayList<Member>)dao.selectMember(map);
		System.out.println(list.size());
		String pageNavi = "";
		
		int pageNaviSize = 5;
		int pageNo = ((reqPage - 1) / pageNaviSize) * pageNaviSize + 1;
		if (pageNo != 1) {
			pageNavi += "<li><a href='/memberList.do?reqPage=" + (pageNo - pageNaviSize) + "&reqPage=1'><span>«</span></a></li>";
		}
		for (int i = 0; i < pageNaviSize; i++) {
			if (reqPage == pageNo) {
				pageNavi += "<li class='active'><a href='#'><span>"+ pageNo  +"<span class='sr-only'>(current)</span></span></a></li>";
			} else {
				pageNavi += "<li><a href='/memberList.do?reqPage=" + pageNo + "&reqPage=1'>" + pageNo + "</a></li>";
			}
			pageNo++;
			if (pageNo > totalPage) {
				break;
			}
		}
		if (pageNo <= totalPage) {
			pageNavi += "<li><a aria-label='Next' href='/memberList.do?reqPage=" + pageNo + "&reqPage=1'><span>»</span></a></li>";
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

	public ApplyPageData selectList2(int reqPage2) {
		int numPerPage = 10;
		int totalCount = dao.TotalCount2();
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
		
		ArrayList<Apply> list = (ArrayList<Apply>)dao.selectList2(map);
		
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
		
		ApplyPageData apd = new ApplyPageData(list, pageNavi);
		return apd;
		
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

	public ApplyPageData selectList4(int reqPage2, String search, String searchTitle) {
		int numPerPage = 10;
		HashMap<String, String> map2 = new HashMap<String, String>();
		map2.put("search", search);
		map2.put("searchTitle", searchTitle);
		int totalCount = dao.TotalCount4(map2);
		int totalPage = 0;
		if(totalCount % numPerPage == 0) {
			totalPage = totalCount /numPerPage;
		}else {
			totalPage = totalCount / numPerPage + 1;
		}
		//조회해 올 게시물 시작번화와 끝번호연산
		String start = Integer.toString((reqPage2 - 1) * numPerPage + 1);
		String end = Integer.toString(reqPage2 * numPerPage);
		map2.put("start", start);
		map2.put("end", end);
		
		ArrayList<Apply> list = (ArrayList<Apply>)dao.selectList4(map2);
		
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
		
		ApplyPageData apd = new ApplyPageData(list, pageNavi);
		return apd;
		
	}

	public int deleteBookList(String[] params) {
		return dao.deletebookList(params);
	}

	public Book selectOneBookList(int bookNo) {
		return dao.selectOneBookList(bookNo);
	}

	public int detailOneBookDelete(int bookNo) {
		return dao.detailOneBookDelete(bookNo);
	}

	public Apply selectOneApplyList(int applyNo) {
		return dao.selectOneApplyList(applyNo);
	}

	public int detailOneApplyNo(int applyNo) {
		return dao.detailOneApplyNo(applyNo);
	}

	public int detailOneApplyYes(int applyNo) {
		return dao.detailOneApplyYes(applyNo);
	}

	public Book checkBookList(String Content) {
		System.out.println(Content);
		return dao.checkBookList(Content);
	}

	public int insertBookList(String[] insertContent) {
		return dao.insertBookList(insertContent);
	}

	public ComplainPageData complainSelectList1(int reqPage) {
		int numPerPage = 10;
		int totalCount = dao.complainTotalCount1();
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
		
		ArrayList<Complain> list = (ArrayList<Complain>)dao.complainSelectList1(map);
		
		String pageNavi = "";
		
		int pageNaviSize = 5;
		int pageNo = ((reqPage - 1) / pageNaviSize) * pageNaviSize + 1;
		if (pageNo != 1) {
			pageNavi += "<li><a href='/adminComplainList.do?reqPage=" + (pageNo - pageNaviSize) + "&check=1&reqPage2=1'><span>«</span></a></li>";
		}
		for (int i = 0; i < pageNaviSize; i++) {
			if (reqPage == pageNo) {
				pageNavi += "<li class='active'><a href='#'><span>"+ pageNo  +"<span class='sr-only'>(current)</span></span></a></li>";
			} else {
				pageNavi += "<li><a href='/adminComplainList.do?reqPage=" + pageNo + "&check=1&reqPage2=1'>" + pageNo + "</a></li>";
			}
			pageNo++;
			if (pageNo > totalPage) {
				break;
			}
		}
		if (pageNo <= totalPage) {
			pageNavi += "<li><a aria-label='Next' href='/adminComplainList.do?reqPage=" + pageNo + "&check=1&reqPage2=1'><span>»</span></a></li>";
		}
		
		ComplainPageData cpd = new ComplainPageData(list, pageNavi);
		return cpd;
	}
	
	public ComplainPageData complainSelectList2(int reqPage2) {
		int numPerPage = 10;
		int totalCount = dao.complainTotalCount2();
		int totalPage = 0;
		if(totalCount % numPerPage == 0) {
			totalPage = totalCount /numPerPage;
		}else {
			totalPage = totalCount / numPerPage + 1;
		}
		//조회해 올 게시물 시작번화와 끝번호연산
		int start = (reqPage2 - 1) * numPerPage + 1;
		int end = reqPage2 * numPerPage;
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end", end);
		
		ArrayList<Complain> list = (ArrayList<Complain>)dao.complainSelectList2(map);
		
		String pageNavi = "";
		
		int pageNaviSize = 5;
		int pageNo = ((reqPage2 - 1) / pageNaviSize) * pageNaviSize + 1;
		if (pageNo != 1) {
			pageNavi += "<li><a href='/adminComplainList.do?reqPage2=" + (pageNo - pageNaviSize) + "&check=2&reqPage=1'><span>«</span></a></li>";
		}
		for (int i = 0; i < pageNaviSize; i++) {
			if (reqPage2 == pageNo) {
				pageNavi += "<li class='active'><a href='#'><span>"+ pageNo  +"<span class='sr-only'>(current)</span></span></a></li>";
			} else {
				pageNavi += "<li><a href='/adminComplainList.do?reqPage2=" + pageNo + "&check=2&reqPage=1'>" + pageNo + "</a></li>";
			}
			pageNo++;
			if (pageNo > totalPage) {
				break;
			}
		}
		if (pageNo <= totalPage) {
			pageNavi += "<li><a aria-label='Next' href='/adminComplainList.do?reqPage2=" + pageNo + "&check=2&reqPage=1'><span>»</span></a></li>";
		}
		
		ComplainPageData cpd = new ComplainPageData(list, pageNavi);
		return cpd;
	}
	
	public ComplainPageData complainSelectList3(int reqPage, String search, String searchTitle) {
		int numPerPage = 10;
		HashMap<String, String> map2 = new HashMap<String, String>();
		map2.put("search", search);
		map2.put("searchTitle", searchTitle);
		
		int totalCount = dao.complainTotalCount3(map2);
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
		
		ArrayList<Complain> list = (ArrayList<Complain>)dao.complainSelectList3(map2);
		
		String pageNavi = "";
		
		int pageNaviSize = 5;
		int pageNo = ((reqPage - 1) / pageNaviSize) * pageNaviSize + 1;
		if (pageNo != 1) {
			pageNavi += "<li><a href='/adminComplainList.do?reqPage=" + (pageNo - pageNaviSize) + "&check=1&reqPage2=1&search="+search+"&searchTitle="+searchTitle+"'><span>«</span></a></li>";
		}
		for (int i = 0; i < pageNaviSize; i++) {
			if (reqPage == pageNo) {
				pageNavi += "<li class='active'><a href='#'><span>"+ pageNo  +"<span class='sr-only'>(current)</span></span></a></li>";
			} else {
				pageNavi += "<li><a href='/adminComplainList.do?reqPage=" + pageNo + "&check=1&search="+search+"&searchTitle="+searchTitle+"&reqPage2=1'>" + pageNo + "</a></li>";
			}
			pageNo++;
			if (pageNo > totalPage) {
				break;
			}
		}
		if (pageNo <= totalPage) {
			pageNavi += "<li><a aria-label='Next' href='/adminComplainList.do?reqPage=" + pageNo + "&check=1&reqPage2=1&search="+search+"&searchTitle="+searchTitle+"'><span>»</span></a></li>";
		}
		
		ComplainPageData cpd = new ComplainPageData(list, pageNavi);
		return cpd;
	}

	public ComplainPageData complainSelectList4(int reqPage2, String search, String searchTitle) {
		int numPerPage = 10;
		HashMap<String, String> map2 = new HashMap<String, String>();
		map2.put("search", search);
		map2.put("searchTitle", searchTitle);
		
		int totalCount = dao.complainTotalCount4(map2);
		int totalPage = 0;
		if(totalCount % numPerPage == 0) {
			totalPage = totalCount /numPerPage;
		}else {
			totalPage = totalCount / numPerPage + 1;
		}
		//조회해 올 게시물 시작번화와 끝번호연산
		String start = Integer.toString((reqPage2 - 1) * numPerPage + 1);
		String end = Integer.toString(reqPage2 * numPerPage);
		map2.put("start", start);
		map2.put("end", end);
		
		ArrayList<Complain> list = (ArrayList<Complain>)dao.complainSelectList4(map2);
		
		String pageNavi = "";
		
		int pageNaviSize = 5;
		int pageNo = ((reqPage2 - 1) / pageNaviSize) * pageNaviSize + 1;
		if (pageNo != 1) {
			pageNavi += "<li><a href='/adminComplainList.do?reqPage2=" + (pageNo - pageNaviSize) + "&check=1&reqPage=1&search="+search+"&searchTitle="+searchTitle+"'><span>«</span></a></li>";
		}
		for (int i = 0; i < pageNaviSize; i++) {
			if (reqPage2 == pageNo) {
				pageNavi += "<li class='active'><a href='#'><span>"+ pageNo  +"<span class='sr-only'>(current)</span></span></a></li>";
			} else {
				pageNavi += "<li><a href='/adminComplainList.do?reqPage2=" + pageNo + "&check=1&search="+search+"&searchTitle="+searchTitle+"reqPage=1'>" + pageNo + "</a></li>";
			}
			pageNo++;
			if (pageNo > totalPage) {
				break;
			}
		}
		if (pageNo <= totalPage) {
			pageNavi += "<li><a aria-label='Next' href='/adminComplainList.do?reqPage2=" + pageNo + "&check=1&reqPage=1&search="+search+"&searchTitle="+searchTitle+"'><span>»</span></a></li>";
		}
		
		ComplainPageData cpd = new ComplainPageData(list, pageNavi);
		return cpd;
	}

	public Complain selectOneComplainList(int complainNo) {
		return dao.selectOneComplainList(complainNo);
	}

	public int detailComplainYes(int complainNo) {
		return dao.detailComplainYes(complainNo);
	}

	public int detailComplainNo(int complainNo) {
		return dao.detailComplainNo(complainNo);
	}


	


}
