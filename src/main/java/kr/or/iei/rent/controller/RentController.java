package kr.or.iei.rent.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.or.iei.book.model.vo.Book;
import kr.or.iei.book.model.vo.BookAndReviewPageData;
import kr.or.iei.book.model.vo.BookData;
import kr.or.iei.cart.model.vo.Cart;
import kr.or.iei.member.model.vo.Member;
import kr.or.iei.rent.model.service.RentService;

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
		return "book/bookSearch";
	}
	@ResponseBody
	@RequestMapping(value = "/bookListLoad.do", produces = "application/json; charset=utf-8")
	public String BookListLoad(String bookName) {
		ArrayList<Book> list = service.selectBookList(bookName);
		System.out.println("hihihi");
		return new Gson().toJson(list);
	}
	@RequestMapping(value = "/searchBookDetail.do")
	public String searchBookDetail(Model model, int reqPage, String categorySelect, String bookAttr, String inputText, String sort) {
		System.out.println(categorySelect);
		System.out.println(bookAttr);
		System.out.println(inputText);
		System.out.println(sort);
		BookAndReviewPageData bd = service.searchBookDetail(reqPage, categorySelect, bookAttr, inputText, sort);
		System.out.println(bd.getList().size());
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
		String[] param = request.getParameterValues("chkArray");
		
		//로그인 된 아이디 받기
//		Member member = session.getAttribute("member");
		
		//임시//
		Member member = new Member();
		member.setMemberId("user01");
		///////
		int result = 0;
		for(int i=0; i<param.length; i++) {
			Cart c = new Cart();
			c.setBookName(param[i].split("~구분~")[0]);
			c.setBookWriter(param[i].split("~구분~")[1]);
			c.setBookPublisher(param[i].split("~구분~")[2]);
			c.setBookImg(param[i].split("~구분~")[3]);
			c.setMemberId(member.getMemberId());
			
			result += service.insertCart(c);
		}
		System.out.println("result : "+result);
		return result;
	}
}
