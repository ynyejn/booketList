package kr.or.iei.turn.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReturnDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
}
