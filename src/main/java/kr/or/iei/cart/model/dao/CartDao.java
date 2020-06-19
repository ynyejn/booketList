package kr.or.iei.cart.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("cartDao")
public class CartDao {
	@Autowired
	SqlSessionTemplate sql;
	
	public CartDao() {
		super();
	}

}
