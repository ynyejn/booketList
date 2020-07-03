package kr.or.iei.rent.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.google.gson.JsonArray;

import kr.or.iei.book.model.vo.Book;
import kr.or.iei.book.model.vo.BookAndReview;
import kr.or.iei.book.model.vo.BookAndReviewPageData;
import kr.or.iei.book.model.vo.PreferencePageData;
import kr.or.iei.cart.model.dao.CartDao;
import kr.or.iei.cart.model.vo.Cart;
import kr.or.iei.member.model.vo.Member;
import kr.or.iei.rent.model.dao.RentDao;
import kr.or.iei.rent.model.vo.Rent;
import kr.or.iei.rent.model.vo.RentAndCount;
import kr.or.iei.review.model.dao.ReviewDao;
import kr.or.iei.review.model.vo.Review;
import net.sf.json.JSONArray;
import sun.reflect.generics.visitor.Reifier;

@Service("rentService")
public class RentService {
	@Autowired
	@Qualifier("rentDao")
	private RentDao dao;
	@Autowired
	@Qualifier("cartDao")
	private CartDao cartDao;
	@Autowired
	@Qualifier("reviewDao")
	private ReviewDao reviewDao;
	
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
			pageNavi += "<div class='prevNavi'><a href='/rent/goBookSearch.do?reqPage="+(pageNo-1)+"'>&lt;</a></div>";
		}
		for(int i=0; i<pageNaviSize; i++) {
			if(reqPage == pageNo) {
				pageNavi += "<div style='background-color: rgb(0, 102, 179);' class='numberNavi1'><span>"+pageNo+"</span></div>";
			}else {
				pageNavi += "<div class='numberNavi2'><a href='/rent/goBookSearch.do?reqPage="+pageNo+"'>"+pageNo+"</a></div>";
			}
			pageNo++;
			if(pageNo>totalPage) {
				break;
			}
		}
		if(pageNo <= totalPage) {
			pageNavi += "<div class='nextNavi'><a href='/rent/goBookSearch.do?reqPage="+pageNo+"'>&gt;</a></div>";
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
			pageNavi += "<div class='prevNavi'><a href='/rent/searchBookDetail.do?reqPage="+(pageNo-1)+"&categorySelect="+categorySelect+"&bookAttr="+bookAttr+"&inputText="+inputText+"&sort="+sort+"'>&lt;</a></div>";
		}
		for(int i=0; i<pageNaviSize; i++) {
			if(reqPage == pageNo) {
				pageNavi += "<div style='background-color: rgb(0, 102, 179);' class='numberNavi1'><span>"+pageNo+"</span></div>";
			}else {
				pageNavi += "<div class='numberNavi2'><a href='/rent/searchBookDetail.do?reqPage="+(pageNo)+"&categorySelect="+categorySelect+"&bookAttr="+bookAttr+"&inputText="+inputText+"&sort="+sort+"'>"+pageNo+"</a></div>";
			}
			pageNo++;
			if(pageNo>totalPage) {
				break;
			}
		}
		if(pageNo <= totalPage) {
			pageNavi += "<div class='nextNavi'><a href='/rent/searchBookDetail.do?reqPage="+(pageNo)+"&categorySelect="+categorySelect+"&bookAttr="+bookAttr+"&inputText="+inputText+"&sort="+sort+"'>&gt;</a></div>";
		}
		
		BookAndReviewPageData bd = new BookAndReviewPageData((ArrayList<BookAndReview>)list, pageNavi);
		return bd;
	}

	public int insertCart(ArrayList<Cart> cartList) {
		//중복제거
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

	public ArrayList<Integer> selectBookNo(ArrayList<Cart> cartList) {
		ArrayList<Integer> list = new ArrayList<Integer>();
		for(int i=0; i<cartList.size(); i++) {
			int result = dao.selectBookNo(cartList.get(i));
			if(result>0) {
				list.add(result);
			}
		}
		return list;
	}

	public ArrayList<Review> userReviewList(Member member) {
		return (ArrayList<Review>)reviewDao.userReviewList(member);
	}

	public ArrayList<RentAndCount> userRentList(Member member) {
		return (ArrayList<RentAndCount>)dao.userRentList(member);
	}

	public ArrayList<BookAndReview> userWriterList(Member member) {
		return (ArrayList<BookAndReview>)dao.userWriterList(member);
	}

	public ArrayList<RentAndCount> userRentDateList(Member member) {
		return (ArrayList<RentAndCount>)dao.userRentDateList(member);
	}

	public PreferencePageData userPreferencePageData(Member member) {
		PreferencePageData ppd = new PreferencePageData();
		
		//review 테이블 카테고리별 리뷰 평균
		ArrayList<Review> reviewList = (ArrayList<Review>)reviewDao.userReviewList(member);
		ppd.setReviewList(reviewList);
		
		//rent 테이블 카테고리별 점수
		ArrayList<RentAndCount> rentAndCountList = (ArrayList<RentAndCount>)dao.userRentList(member);
		ppd.setRentAndCountList(rentAndCountList);
		
		//rent 테이블 작가별 빌린 횟수
		ppd.setWriterList((ArrayList<BookAndReview>)dao.userWriterList(member));
		
		//rent테이블 날짜별 빌린 책 갯수
		ArrayList<RentAndCount> rentDateList =  (ArrayList<RentAndCount>)dao.userRentDateList(member);
		ppd.setRentDateList(rentDateList);
		
		int type = 0;
		//////////
		HashMap<String, String> preferCategory = new HashMap<String, String>();
		preferCategory.put("preferCategory1", null);
		preferCategory.put("preferCategory2", null);
		preferCategory.put("preferCategory3", null);
		//////////
		if(rentDateList.size() < 10) {
			//1. 읽은 책이 10권 미만일때. 취향으로만.
			if(member.getMemberCategory3() == null) {
				if(member.getMemberCategory2() == null) {
					if(member.getMemberCategory1() == null) {
						//취향이 모두 비어있을 때. 랜덤 10권. 취향을 선택하지 않아 이용이 불가능합니다.
						type = 0;
						ppd.setBookAndReviewList((ArrayList<BookAndReview>)dao.userBookAndReviewList(preferCategory));													
					}else {
						//취향이 1개만 있을 때 
						type = 1;
						preferCategory.put("preferCategory1", member.getMemberCategory1());
						ppd.setBookAndReviewList((ArrayList<BookAndReview>)dao.userBookAndReviewList(preferCategory));						
					}
				}else {
					//취향이 2개만 있을 때
					type = 1;
					preferCategory.put("preferCategory1", member.getMemberCategory1());
					preferCategory.put("preferCategory2", member.getMemberCategory2());
					ppd.setBookAndReviewList((ArrayList<BookAndReview>)dao.userBookAndReviewList(preferCategory));												
				}
			}else {
				//취향이 3개 있을 때
				type = 1;
				preferCategory.put("preferCategory1", member.getMemberCategory1());
				preferCategory.put("preferCategory2", member.getMemberCategory2());
				preferCategory.put("preferCategory3", member.getMemberCategory3());
				ppd.setBookAndReviewList((ArrayList<BookAndReview>)dao.userBookAndReviewList(preferCategory));							
			}
		}else{
			if(reviewList.get(0).getReviewScore() > 3) {
				//3. 읽은 책이 10권 이상이고, 제일 많이 읽은 카테고리가 있지만, 리뷰를 3.0 이상 준 항목이 있다면 리뷰 3.0 이상 준 카테고리를 추천
				type = 3;
				preferCategory.put("preferCategory1", reviewList.get(0).getBookCategory());
				ppd.setBookAndReviewList((ArrayList<BookAndReview>)dao.userBookAndReviewList(preferCategory));											
			}else {
				//2. 읽은 책이 10권 이상일때. 제일 많이 읽은 카테고리를 추천
				type = 2;
				preferCategory.put("preferCategory1", rentAndCountList.get(0).getBookCategory());
				ppd.setBookAndReviewList((ArrayList<BookAndReview>)dao.userBookAndReviewList(preferCategory));											
			}
		}
		ppd.setType(type);
		ppd.setPreferCategory(preferCategory);
		return ppd;
	}

	public ArrayList<BookAndReview> refreshBookList(HashMap<String, String> preferCategory) {
		
		ArrayList<BookAndReview> list = (ArrayList<BookAndReview>)dao.refreshBookList(preferCategory);
		return list;
	}

}
