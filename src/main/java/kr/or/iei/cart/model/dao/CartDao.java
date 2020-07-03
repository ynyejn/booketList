package kr.or.iei.cart.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import kr.or.iei.cart.model.vo.Cart;

@Repository("cartDao")
public class CartDao {
	@Autowired
	SqlSessionTemplate sql;
	
	public CartDao() {
		super();
	}

	public int dupChk(Cart cart) {
		return sql.selectOne("cart.dupChk", cart);
	}

	public int insertCart(Cart cart) {
		return sql.insert("cart.insertCart", cart);
	}

	public int totalCount(HashMap<String, String> map2) {
		return sql.selectOne("cart.totalCount", map2);
	}

	public List selectCartList(HashMap<String, HashMap<?, ?>> map3) {
		return sql.selectList("cart.selectCartList", map3);
	}

	public int delSelect(ArrayList<Cart> cartList) {
		return sql.delete("cart.delSelect", cartList);
	}



}
