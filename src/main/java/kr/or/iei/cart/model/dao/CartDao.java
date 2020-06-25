package kr.or.iei.cart.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.iei.book.model.vo.Book;
import kr.or.iei.cart.model.vo.Cart;

@Repository("cartDao")
public class CartDao {
	@Autowired
	SqlSessionTemplate sql;
	
	public CartDao() {
		super();
	}

	public int dupChk(Book book) {
		return sql.selectOne("cart.dupChk", book);
	}

//	public int insertCart(Book book) {
//		return sql.insert("cart.insertCart", book);
//	}

	public int insertCart(Cart c) {
		return sql.insert("cart.insertCart", c);
	}

}
