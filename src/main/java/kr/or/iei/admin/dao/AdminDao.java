package kr.or.iei.admin.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.iei.book.model.vo.Book;


@Repository("adminDao")
public class AdminDao {
	
	@Autowired
	SqlSessionTemplate sqlSession;

	public List selectMember(HashMap<String, Integer> map) {
		System.out.println("AdminDao");
		return sqlSession.selectList("member.selectMember",map);
	}

	public int bookTotalCount() {		
		return sqlSession.selectOne("book.bookTotalCount");
	}

	public List selectList1(HashMap<String, Integer> map) {
		return sqlSession.selectList("book.selectList1",map);
	}

	public int bookTotalCount2() {
		return sqlSession.selectOne("book.bookTotalCount2");
	}

	public List selectList2(HashMap<String, Integer> map) {
		return sqlSession.selectList("book.selectList2",map);
	}

	public int bookTotalCount3(HashMap<String, String> map2) {
		return sqlSession.selectOne("book.bookTotalCount3",map2);
	}

	public List selectList3(HashMap<String, String> map2) {
		return sqlSession.selectList("book.selectList3",map2);
	}
	
	public int memberTotalCount() {
		return sqlSession.selectOne("member.memberTotalCount");

	}

	public int deletebookList(String[] params) {
		return sqlSession.delete("book.deleteBookList", params);
	}
}
