package kr.or.iei.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.apache.ibatis.session.SqlSession;
import kr.or.iei.member.model.vo.Member;

@Repository("memberDao")
public class MemberDao {
	@Autowired
	SqlSessionTemplate sql;
	
	public MemberDao() {
		super();
	}

	
	public int joinSuccess(Member member) {
		
		return sql.insert("member.joinSuccess",member);
	}


	public Member checkId(String memberId) {
		
		return sql.selectOne("member.checkId",memberId);
	}


	public Member checkNickname(String memberNickname) {
		
		return sql.selectOne("member.checkNickname",memberNickname);
	}


	public Member selectOne(Member m) {
		
		return sql.selectOne("member.selectOneMember",m);
	}
}
