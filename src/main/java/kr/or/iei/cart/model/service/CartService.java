package kr.or.iei.cart.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.book.model.vo.BookAndReview;
import kr.or.iei.book.model.vo.BookAndReviewPageData;
import kr.or.iei.cart.model.dao.CartDao;
import kr.or.iei.cart.model.vo.Cart;
import kr.or.iei.cart.model.vo.CartPageData;
import kr.or.iei.member.model.vo.Member;

@Service("cartService")
public class CartService {

	@Autowired
	@Qualifier("cartDao")
	private CartDao dao;

	public CartPageData selectCartList(int reqPage, Member member) {
		HashMap<String, String> map2 = new HashMap<String, String>();
		map2.put("memberId", member.getMemberId());

		int totalCount = dao.totalCount(map2);
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
		HashMap<String, HashMap<?,?>> map3 = new HashMap<String, HashMap<?,?>>();
		map3.put("map", map);
		map3.put("map2", map2);		
		
		List list = dao.selectCartList(map3);
		
		String pageNavi ="";
		int pageNaviSize = 5;
		int pageNo = ((reqPage-1)/pageNaviSize)*pageNaviSize+1;
		//페이지 네비 [이전] [현재] [다음]
		if(pageNo != 1) {
			pageNavi += "<a href='/cart/goMyCart.do?reqPage="+(pageNo-1)+"'>[이전]</a>";
		}
		for(int i=0; i<pageNaviSize; i++) {
			if(reqPage == pageNo) {
				pageNavi += "<span>"+pageNo+"</span>";
			}else {
				pageNavi += "<a href='/cart/goMyCart.do?reqPage="+pageNo+"'>"+pageNo+"</a>";
			}
			pageNo++;
			if(pageNo>totalPage) {
				break;
			}
		}
		if(pageNo <= totalPage) {
			pageNavi += "<a href='/cart/goMyCart.do?reqPage="+pageNo+"'>[다음]</a>";
		}
		
		CartPageData cartPageData = new CartPageData((ArrayList<Cart>)list, pageNavi);
		return cartPageData;
	}

	public int delSelect(ArrayList<Cart> cartList) {
		return dao.delSelect(cartList);
	}
}
