package kr.or.iei.cart.model.vo;

import java.util.ArrayList;


import lombok.Data;

@Data
public class CartPageData {
	ArrayList<Cart> list;
	private String pageNavi;
	public CartPageData(ArrayList<Cart> list, String pageNavi) {
		super();
		this.list = list;
		this.pageNavi = pageNavi;
	}
	public CartPageData() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	
}
