package kr.or.iei.turn.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReturnDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public List selectAllRent(String memberId) {
		return sqlSession.selectList("return.selectAllRent",memberId);
	}

	public int updateBookStatus() {
		return sqlSession.update("return.updateBookStatus");
	}

	public int updateDelayStatus() {
		return sqlSession.update("return.updateDelayStatus");
	}

	public int reduceDelayStatus() {
		return sqlSession.update("return.reduceDelayStatus");
	}

}
