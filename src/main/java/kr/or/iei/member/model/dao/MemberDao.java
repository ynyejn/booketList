package kr.or.iei.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.iei.member.model.vo.Member;

@Repository("memberDao")
public class MemberDao {
	@Autowired
	SqlSessionTemplate sql;
	
	public MemberDao() {
		super();
	}

	public Member selectMemberOne(Member m) {
		
		return sql.selectOne("member.selectMemberOne",m);
	}
}
