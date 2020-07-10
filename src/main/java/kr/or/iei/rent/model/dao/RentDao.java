package kr.or.iei.rent.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.iei.book.model.vo.Book;
import kr.or.iei.book.model.vo.BookAndRent;
import kr.or.iei.book.model.vo.BookAndReview;
import kr.or.iei.book.model.vo.BookData;
import kr.or.iei.cart.model.vo.Cart;
import kr.or.iei.member.model.vo.Member;
import kr.or.iei.rent.model.vo.Rent;
import kr.or.iei.rent.model.vo.RentAndCount;
import kr.or.iei.rent.model.vo.RentDateCount;

@Repository("rentDao")
public class RentDao {
	@Autowired
	SqlSessionTemplate sql;
	
	public RentDao() {
		super();
	}

	public int totalCount() {
		return sql.selectOne("book.totalCountBook");
	}

	public List bookAllPage(HashMap<String, Integer> map) {
		return sql.selectList("book.selectBookAllPage", map);
	}

	public List selectBookList(String bookName) {
		return sql.selectList("book.selectBookList", bookName);
	}

	public int searchBookDetailTotalCount(HashMap<String, String> map2) {
		return sql.selectOne("book.searchBookDetailTotalCount", map2);
	}

	public List searchBookDetail(HashMap<?,?> map3) {
		return sql.selectList("book.searchBookDetail", map3);
	}

	public int selectBookNo(Cart cart) {
		return sql.selectOne("book.searchBookNo", cart);
	}

	public List userRentList(Member member) {
		return sql.selectList("rent.userRentList",member);
	}

	public List userWriterList(Member member) {
		return sql.selectList("book.userWriterList", member);
	}

	public List userRentDateList(Member member) {
		return sql.selectList("rent.userRentDateList", member);
	}

	public List userBookAndReviewList(HashMap<String, String> preferCategory) {
		return sql.selectList("book.userBookAndReviewList", preferCategory);
	}

	public List refreshBookList(HashMap<String, String> preferCategory) {
		return sql.selectList("book.refreshBookList", preferCategory);
	}

	public List rentDateList() {
		return sql.selectList("rent.rentDateList");
	}

	public List rentDateCountList() {
		return sql.selectList("rent.rentDateCountList");
	}

	public List rentAndCountList() {
		return sql.selectList("rent.rentAndCountList");
	}

	public List selectUserList(Member member) {
		return sql.selectList("rent.selectUserList", member);
	}




}
