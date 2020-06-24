package kr.or.iei.rent.model.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.book.model.vo.Book;
import kr.or.iei.book.model.vo.BookAndReview;
import kr.or.iei.book.model.vo.BookAndReviewPageData;
import kr.or.iei.book.model.vo.BookData;
import kr.or.iei.rent.model.dao.RentDao;

@Service("rentService")
public class RentService {
	@Autowired
	@Qualifier("rentDao")
	private RentDao dao;
	//책검색 메인페이지 가기.
	public BookAndReviewPageData selectBookPage(int reqPage) {
		int totalCount = dao.totalCount();
		System.out.println("totalcount : "+totalCount);		
		int numPerPage = 5;
		int totalPage = 0;
		if(totalCount % numPerPage ==0) {
			totalPage = totalCount / numPerPage;
		}else {
			totalPage = totalCount / numPerPage+1;
		}
		int start = (reqPage-1)*numPerPage+1;
		int end = reqPage * numPerPage;
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end",end);
		
		List list = dao.bookAllPage(map);
		
		String pageNavi ="";
		int pageNaviSize = 5;
		int pageNo = ((reqPage-1)/pageNaviSize)*pageNaviSize+1;
		//페이지 네비 [이전] [현재] [다음]
		if(pageNo != 1) {
			pageNavi += "<a href='/rent/goBookSearch.do?reqPage="+(pageNo-1)+"'>[이전]</a>";
		}
		for(int i=0; i<pageNaviSize; i++) {
			if(reqPage == pageNo) {
				pageNavi += "<span>"+pageNo+"</span>";
			}else {
				pageNavi += "<a href='/rent/goBookSearch.do?reqPage="+pageNo+"'>"+pageNo+"</a>";
			}
			pageNo++;
			if(pageNo>totalPage) {
				break;
			}
		}
		if(pageNo <= totalPage) {
			pageNavi += "<a href='/rent/goBookSearch.do?reqPage="+pageNo+"'>[다음]</a>";
		}
		
		BookAndReviewPageData bd = new BookAndReviewPageData((ArrayList<BookAndReview>)list, pageNavi);
		return bd;
	}

	public ArrayList<Book> selectBookList(String bookName) {
		List list = dao.selectBookList(bookName);
		return (ArrayList<Book>)list;
	}
	
	//책 검색해서 가기
	public BookAndReviewPageData searchBookDetail(int reqPage, String categorySelect, String bookAttr, String inputText, String sort) {
		HashMap<String, String> map2 = new HashMap<String, String>();
		map2.put("categorySelect", categorySelect);
		map2.put("bookAttr", bookAttr);
		map2.put("inputText", inputText);
		map2.put("sort", sort);
		
		int totalCount = dao.searchBookDetailTotalCount(map2);
		System.out.println("totalCount : "+totalCount);
		int numPerPage = 5;
		int totalPage = 0;
		if(totalCount % numPerPage ==0) {
			totalPage = totalCount / numPerPage;
		}else {
			totalPage = totalCount / numPerPage+1;
		}
		int start = (reqPage-1)*numPerPage+1;
		int end = reqPage * numPerPage;
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		HashMap<String, HashMap<?,?>> map3 = new HashMap<String, HashMap<?,?>>();
		map.put("start", start);
		map.put("end",end);
		
		map3.put("map", map);
		map3.put("map2", map2);
//		List list = dao.bookAllPage(map);
		List list = dao.searchBookDetail(map3);
		System.out.println("list.size():"+list.size());
		
		String pageNavi ="";
		int pageNaviSize = 5;
		int pageNo = ((reqPage-1)/pageNaviSize)*pageNaviSize+1;
		//페이지 네비 [이전] [현재] [다음]
		if(pageNo != 1) {
			pageNavi += "<a href='/rent/goBookSearch.do?reqPage="+(pageNo-1)+"&bookAttr="+bookAttr+"&inputText="+inputText+"&sort="+sort+"'>[이전]</a>";
		}
		for(int i=0; i<pageNaviSize; i++) {
			if(reqPage == pageNo) {
				pageNavi += "<span>"+pageNo+"</span>";
			}else {
				pageNavi += "<a href='/rent/goBookSearch.do?reqPage="+(pageNo)+"&bookAttr="+bookAttr+"&inputText="+inputText+"&sort="+sort+"'>"+pageNo+"</a>";
			}
			pageNo++;
			if(pageNo>totalPage) {
				break;
			}
		}
		if(pageNo <= totalPage) {
			pageNavi += "<a href='/rent/goBookSearch.do?reqPage="+(pageNo)+"&bookAttr="+bookAttr+"&inputText="+inputText+"&sort="+sort+"'>[다음]</a>";
		}
		
		BookAndReviewPageData bd = new BookAndReviewPageData((ArrayList<BookAndReview>)list, pageNavi);
		return bd;
	}

}
