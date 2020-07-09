package kr.or.iei.rent.controller;

import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonArray;

//import javafx.application.Application;
import kr.or.iei.book.model.vo.Book;
import kr.or.iei.book.model.vo.BookAndReview;
import kr.or.iei.book.model.vo.BookAndReviewPageData;
import kr.or.iei.book.model.vo.BookData;
import kr.or.iei.book.model.vo.PreferencePageData;
import kr.or.iei.cart.model.vo.Cart;
import kr.or.iei.member.model.vo.Member;
import kr.or.iei.rent.model.service.RentService;
import kr.or.iei.rent.model.vo.RentAndCount;
import kr.or.iei.review.model.vo.Review;
import net.sf.json.JSONArray;

@Controller
@RequestMapping("/rent")
public class RentController {
	
	@Autowired
	@Qualifier("rentService")
	private RentService service;
	
	@RequestMapping("/goBookSearch.do")
	public String GoBookSearch(int reqPage, Model model) {
		BookAndReviewPageData bd = service.selectBookPage(reqPage);
		HashMap<String, Integer> bookNum = new HashMap<String, Integer>();
		model.addAttribute("list", bd.getList());
		model.addAttribute("pageNavi", bd.getPageNavi());
		model.addAttribute("bookAttr", "");
		model.addAttribute("sort", "book_name");
		model.addAttribute("categorySelect", "");
		return "book/bookSearch";
	}
	@ResponseBody
	@RequestMapping(value = "/bookListLoad.do", produces = "application/json; charset=utf-8")
	public String BookListLoad(String bookName) {
		ArrayList<Book> list = service.selectBookList(bookName);
		return new Gson().toJson(list);
	}
	@RequestMapping(value = "/searchBookDetail.do")
	public String searchBookDetail(Model model, int reqPage, String categorySelect, String bookAttr, String inputText, String sort) {
		BookAndReviewPageData bd = service.searchBookDetail(reqPage, categorySelect, bookAttr, inputText, sort);
		HashMap<String, Integer> bookNum = new HashMap<String, Integer>();
		model.addAttribute("list", bd.getList());
		model.addAttribute("pageNavi", bd.getPageNavi());	
		model.addAttribute("categorySelect", categorySelect);
		model.addAttribute("bookAttr", bookAttr);
		model.addAttribute("inputText", inputText);
		model.addAttribute("sort", sort);
		return "book/bookSearch";
	}
	@ResponseBody
	@RequestMapping(value= "/insertCart.do", method = RequestMethod.GET)
	public int insertCart(HttpServletRequest request, HttpSession session) {
		if(request.getParameter("chkArray") != null) {			
			String[] param = request.getParameterValues("chkArray");
			Member member = (Member)session.getAttribute("member");

			int result = 0;
			ArrayList<Cart> cartList = new ArrayList<Cart>();
			for(int i=0; i<param.length; i++) {
				Cart c = new Cart();
				c.setBookName(param[i].split("~구분~")[0]);
				c.setBookWriter(param[i].split("~구분~")[1]);
				c.setBookPublisher(param[i].split("~구분~")[2]);
				c.setBookImg(param[i].split("~구분~")[3]);
				c.setMemberId(member.getMemberId());
				cartList.add(c);
			}
			result = service.insertCart(cartList);
			return result;
		}else {
			return -1;
		}
	}
	
	/////////////////////////////////////////////
	//////////////// 장바구니 선택한 책 빌리기 //////////
	@ResponseBody
	@RequestMapping(value= "/selectedCart.do", method = RequestMethod.GET)
	public ArrayList<Integer> selectedCart(HttpServletRequest request, HttpSession session, Model model) {
		if(request.getParameter("chkArray") != null) {			
			String[] param = request.getParameterValues("chkArray");
			//로그인 된 아이디 받기
			Member member = (Member)session.getAttribute("member");
			ArrayList<Cart> cartList = new ArrayList<Cart>();
			for(int i=0; i<param.length; i++) {
				Cart c = new Cart();
				c.setBookName(param[i].split("~구분~")[0]);
				c.setBookWriter(param[i].split("~구분~")[1]);
				c.setBookPublisher(param[i].split("~구분~")[2]);
				System.out.println();
				cartList.add(c);
			}
			ArrayList<Integer> bookNoList = new ArrayList<Integer>();
			bookNoList = service.selectBookNo(cartList);
			model.addAttribute("bookNo", new Gson().toJson(bookNoList));
			return bookNoList;
		}else {
			return null;			
		}
	}

	@RequestMapping(value="/goPreference.do")
	public String GoPreference(Model model, HttpSession session) {
		//review엔 member_nickname 조회
		//rent엔 member_id 조회
		Member member = (Member)session.getAttribute("member");
		if(member == null) {
			return "redirect:/member/loginFrm.do";
		}else {
			PreferencePageData ppd = service.userPreferencePageData(member);
			
			ArrayList<Review> reviewList = ppd.getReviewList();
			ArrayList<RentAndCount> rentList = ppd.getRentAndCountList();
			ArrayList<BookAndReview> writerList = ppd.getWriterList();
			ArrayList<RentAndCount> rentDateList = ppd.getRentDateList();
			ArrayList<BookAndReview> bookAndReviewList = ppd.getBookAndReviewList();
			session.setAttribute("reviewList", reviewList);
			session.setAttribute("rentList", rentList);
			session.setAttribute("writerList", writerList);
			session.setAttribute("rentDateList", rentDateList);
			session.setAttribute("bookAndReviewList", bookAndReviewList);
			
			//유저 카테고리는 유형에 따라 다르게 보여진다.
			//1 : 기본 취향 세 개, 2 : 가장많이 읽은 카테고리, 3: 좋은 후기를 남긴 카테고리
			
			model.addAttribute("preferCategory", ppd.getPreferCategory());
			model.addAttribute("type", ppd.getType());
			
			if(ppd.getPreferCategory().get("preferCategory3") == null) {
				if(ppd.getPreferCategory().get("preferCategory2") == null) {
					if(ppd.getPreferCategory().get("preferCategory1") == null) {
						model.addAttribute("userCategory", "알 수 없음");					
					}else {
						model.addAttribute("userCategory", ppd.getPreferCategory().get("preferCategory1"));										
					}
				}else {
					model.addAttribute("userCategory", ppd.getPreferCategory().get("preferCategory1")+"/"+ppd.getPreferCategory().get("preferCategory2"));									
				}
			}else {
				model.addAttribute("userCategory", ppd.getPreferCategory().get("preferCategory1")+"/"+ppd.getPreferCategory().get("preferCategory2")+"/"+ppd.getPreferCategory().get("preferCategory3"));								
			}
			
			model.addAttribute("reviewList", new Gson().toJson(reviewList));
			model.addAttribute("rentList", new Gson().toJson(rentList));
			model.addAttribute("writerList", new Gson().toJson(writerList));
			model.addAttribute("rentDateList", new Gson().toJson(rentDateList));
			model.addAttribute("bookAndReviewList", bookAndReviewList);
			model.addAttribute("rentListSize", rentList.size());
			model.addAttribute("reviewListSize", reviewList.size());
			session.setAttribute("preferCategory", ppd.getPreferCategory());
			session.setAttribute("type", ppd.getType());
			
			return "/book/preference";
			
		}
	}
	@ResponseBody
	@RequestMapping(value="/refresh.do" , produces = "application/json; charset=utf-8")
	public String Refresh (HttpSession session) {	
		HashMap<String, String> preferCategory = (HashMap<String, String>)session.getAttribute("preferCategory");
		
		//취향과 같은 책리스트 전체 뽑기
		ArrayList<BookAndReview> refreshBookList = service.refreshBookList(preferCategory);

		int count = refreshBookList.size();
		Random r = new Random();
//		System.out.println("random : "+r.nextInt(count)+1);	//1과 2출력
		
		//새로운 10권 짜리 책 리스트 만들기.
		ArrayList<BookAndReview> list = new ArrayList<BookAndReview>();
		for(int i=0; i<5; i++) {
			int ranCount = r.nextInt(count);
			list.add(refreshBookList.get(ranCount));
		}		
		return new Gson().toJson(list);
	}
	
}
