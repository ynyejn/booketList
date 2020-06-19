package kr.or.iei.cart.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.cart.model.dao.CartDao;

@Service("cartService")
public class CartService {

	@Autowired
	@Qualifier("cartDao")
	private CartDao dao;
}
