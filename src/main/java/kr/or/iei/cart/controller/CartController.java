package kr.or.iei.cart.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.iei.cart.model.service.CartService;
import kr.or.iei.cart.model.vo.Cart;
import kr.or.iei.cart.model.vo.CartPageData;
import kr.or.iei.member.model.vo.Member;

@Controller
@RequestMapping("/cart")
public class CartController {
	
	@Autowired
	@Qualifier("cartService")
	private CartService service;
	
	@RequestMapping("/goMyCart.do")
	public String GoMyCart(int reqPage, Model model, HttpSession session) {
		
		Member member = (Member)session.getAttribute("member");
		if(member == null) {
			return "redirect:/member/loginFrm.do";
		}else {
			CartPageData cartPageData = service.selectCartList(reqPage, member);
			model.addAttribute("list", cartPageData.getList());
			model.addAttribute("pageNavi", cartPageData.getPageNavi());
			return "book/myCart";						
		}
	}
	
	@ResponseBody
	@RequestMapping(value= "/delSelect.do", method = RequestMethod.GET)
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
				c.setMemberId(member.getMemberId());
				cartList.add(c);
			}
			result = service.delSelect(cartList);
			return result;
		}else {
			return -1;			
		}
	}

}
