package kr.or.iei.admin.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.iei.apply.model.vo.Apply;
import kr.or.iei.book.model.vo.Book;
import kr.or.iei.complain.model.vo.Complain;

@Repository("adminDao")
public class AdminDao {

	@Autowired
	SqlSessionTemplate sqlSession;

	public List selectMember(HashMap<String, Integer> map) {
		System.out.println("AdminDao");
		return sqlSession.selectList("member.selectMember", map);
	}

	public int bookTotalCount() {
		return sqlSession.selectOne("book.bookTotalCount");
	}

	public List selectList1(HashMap<String, Integer> map) {
		return sqlSession.selectList("book.selectList1", map);
	}

	public int TotalCount2() {
		return sqlSession.selectOne("apply.TotalCount2");
	}

	public List selectList2(HashMap<String, Integer> map) {
		return sqlSession.selectList("apply.selectList2", map);
	}

	public int bookTotalCount3(HashMap<String, String> map2) {
		return sqlSession.selectOne("book.bookTotalCount3", map2);
	}

	public List selectList3(HashMap<String, String> map2) {
		return sqlSession.selectList("book.selectList3", map2);
	}

	public int TotalCount4(HashMap<String, String> map2) {
		return sqlSession.selectOne("apply.totalCount4", map2);
	}

	public List selectList4(HashMap<String, String> map2) {
		return sqlSession.selectList("apply.selectList4", map2);
	}

	public int memberTotalCount() {
		return sqlSession.selectOne("member.memberTotalCount");
	}

	public int deletebookList(String[] params) {
		return sqlSession.delete("book.deleteBookList", params);
	}

	public Book selectOneBookList(int bookNoo) {
		return sqlSession.selectOne("book.selectOneBookList", bookNoo);
	}

	public int detailOneBookDelete(int bookNo) {
		return sqlSession.delete("book.selectOneBookDelete", bookNo);
	}

	public Apply selectOneApplyList(int applyNoo) {
		return sqlSession.selectOne("apply.selectOneApplyList", applyNoo);
	}

	public int detailOneApplyNo(int applyNo) {
		return sqlSession.update("apply.detailOneApplyNo", applyNo);
	}

	public int detailOneApplyYes(int applyNo) {
		return sqlSession.update("apply.detailOneApplyYes", applyNo);
	}

	public Book checkBookList(String string) {
		return sqlSession.selectOne("book.checkBookList", string);
	}

	public int insertBookList(String[] insertContent) {
		return sqlSession.insert("book.insertBookList", insertContent);
	}

	public int complainTotalCount1() {
		return sqlSession.selectOne("complain.ComplainTotalCount1");
	}

	public List complainSelectList1(HashMap<String, Integer> map) {
		return sqlSession.selectList("complain.ComplainSelectList1", map);
	}

	public int complainTotalCount2() {
		return sqlSession.selectOne("complain.ComplainTotalCount2");
	}

	public List complainSelectList2(HashMap<String, Integer> map) {
		return sqlSession.selectList("complain.ComplainSelectList2", map);
	}
	
	public int complainTotalCount3(HashMap<String, String> map2) {
		return sqlSession.selectOne("complain.ComplainTotalCount3",map2);
	}

	public List complainSelectList3(HashMap<String, String> map2) {
		return sqlSession.selectList("complain.ComplainSelectList3",map2);
	}
	
	public int complainTotalCount4(HashMap<String, String> map2) {
		return sqlSession.selectOne("complain.ComplainTotalCount4",map2);
	}
	
	public List complainSelectList4(HashMap<String, String> map2) {
		return sqlSession.selectList("complain.ComplainSelectList4",map2);
	}
	
	public Complain selectOneComplainList(int complainNo) {
		return sqlSession.selectOne("complain.selectOneComplainList", complainNo);
	}

	public int detailComplainYes(int complainNo) {
		return sqlSession.update("complain.detailComplainYes",complainNo);
	}

	public int detailComplainNo(int complainNo) {
		return sqlSession.update("complain.detailComplainNo",complainNo);
	}

	

	



}
