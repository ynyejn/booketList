package kr.or.iei.rent.model.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.iei.book.model.vo.BookData;

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
}
