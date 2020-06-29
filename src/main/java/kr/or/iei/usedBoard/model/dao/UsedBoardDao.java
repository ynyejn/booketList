package kr.or.iei.usedBoard.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UsedBoardDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
}
