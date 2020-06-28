package kr.or.iei.spot.model.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SpotDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int totalCount() {
		return sqlSession.selectOne("spot.selectSpotCount");
	}
	
	public List selectAllSpot(HashMap<String, String> map) {
		return sqlSession.selectList("spot.selectAllSpot",map);
	}

	public List selectAllLocalName() {
		return sqlSession.selectList("spot.selectAllLocalName");
	}

}
