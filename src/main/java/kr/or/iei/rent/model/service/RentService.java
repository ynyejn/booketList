package kr.or.iei.rent.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.book.model.vo.Book;
import kr.or.iei.book.model.vo.BookAndReview;
import kr.or.iei.book.model.vo.BookAndReviewPageData;
import kr.or.iei.cart.model.dao.CartDao;
import kr.or.iei.cart.model.vo.Cart;
import kr.or.iei.rent.model.dao.RentDao;

@Service("rentService")
public class RentService {
	@Autowired
	@Qualifier("rentDao")
	private RentDao dao;
	@Autowired
	@Qualifier("cartDao")
	private CartDao cartDao;
	
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
			pageNavi += "<a href='/rent/searchBookDetail.do?reqPage="+(pageNo-1)+"&bookAttr="+bookAttr+"&inputText="+inputText+"&sort="+sort+"'>[이전]</a>";
		}
		for(int i=0; i<pageNaviSize; i++) {
			if(reqPage == pageNo) {
				pageNavi += "<span>"+pageNo+"</span>";
			}else {
				pageNavi += "<a href='/rent/searchBookDetail.do?reqPage="+(pageNo)+"&bookAttr="+bookAttr+"&inputText="+inputText+"&sort="+sort+"'>"+pageNo+"</a>";
			}
			pageNo++;
			if(pageNo>totalPage) {
				break;
			}
		}
		if(pageNo <= totalPage) {
			pageNavi += "<a href='/rent/searchBookDetail.do?reqPage="+(pageNo)+"&bookAttr="+bookAttr+"&inputText="+inputText+"&sort="+sort+"'>[다음]</a>";
		}
		
		BookAndReviewPageData bd = new BookAndReviewPageData((ArrayList<BookAndReview>)list, pageNavi);
		return bd;
	}

	public int insertCart(ArrayList<Cart> cartList) {
		//중복제거
		System.out.println("서비스 카트사이즈 :"+cartList.size());
		System.out.println("서비스 카트사이즈 :"+cartList.get(0));
//		System.out.println("서비스 카트사이즈 :"+cartList.get(1));
		int result = 0;
		for(int i=0; i< cartList.size(); i++) {
			int count = cartDao.dupChk(cartList.get(i));
			if(count == 0) {
				result += cartDao.insertCart(cartList.get(i));
			}
		}
		System.out.println("insert : "+result);
		return result;
	}

}
