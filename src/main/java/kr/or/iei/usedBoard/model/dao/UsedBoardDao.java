package kr.or.iei.usedBoard.model.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.iei.usedBoard.model.vo.UsedBoard;

@Repository
public class UsedBoardDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int totalCount() {
		return sqlSession.selectOne("usedBoard.selectListCount");
	}

	public List selectAllList(HashMap<String, String> map) {
		return sqlSession.selectList("usedBoard.selectAllList", map);
	}

	public int insertBoard(UsedBoard ub) {
		return sqlSession.insert("usedBoard.insertBoard",ub);
	}
}