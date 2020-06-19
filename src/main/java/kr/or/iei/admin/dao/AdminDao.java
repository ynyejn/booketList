package kr.or.iei.admin.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.or.iei.member.model.vo.Member;

@Repository("adminDao")
public class AdminDao {
	private SqlSession sqlSession;

	public List<Object> selectMember() {
		return sqlSession.selectList("member.selectMember");
	}
}
