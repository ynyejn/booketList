package kr.or.iei.usedBoard.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.iei.usedBoard.model.vo.UsedBoard;
import kr.or.iei.usedBoard.model.vo.UsedComment;
import kr.or.iei.usedBoard.model.vo.UsedFiles;

@Repository
public class UsedBoardDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int totalCount(String usedStatus) {
		return sqlSession.selectOne("usedBoard.selectListCount",usedStatus);
	}

	public List selectAllList(HashMap<String, String> map) {
		return sqlSession.selectList("usedBoard.selectAllList", map);
	}

	public int insertBoard(UsedBoard ub) {
		return sqlSession.insert("usedBoard.insertBoard",ub);
	}

	public UsedBoard checkUsedPw(UsedBoard ub) {
		return sqlSession.selectOne("usedBoard.checkUsedPw", ub);
	}

	public UsedBoard selectOneBoard(int usedNo) {
		return sqlSession.selectOne("usedBoard.selectOneBoard", usedNo);
	}

	public void updateReadCount(int usedNo) {
		sqlSession.update("usedBoard.updateReadCount",usedNo);
		
	}

	public int deleteBoard(int usedNo) {
		return sqlSession.delete("usedBoard.deleteBoard",usedNo);
	}

	public int insertComment(UsedComment uc) {
		return sqlSession.insert("usedBoard.insertComment",uc);
	}

	public int insertFiles(ArrayList<UsedFiles> fileList) {
		int result=0;
		for(int i=0; i<fileList.size();i++) {
		UsedFiles uf = fileList.get(i);
		result +=sqlSession.insert("usedBoard.insertFiles",uf);
		}
		return result;
	}

	public List selectComment(int usedNo) {
		return sqlSession.selectList("usedBoard.selectComment",usedNo);
	}

	public List selectFiles(int commentNo) {
		return sqlSession.selectList("usedBoard.selectFiles",commentNo);
	}

	public int updateUsedStatus(UsedBoard ub) {
		return sqlSession.update("usedBoard.updateUsedStatus",ub);
		
	}
}
