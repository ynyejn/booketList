package kr.or.iei.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.member.model.dao.MemberDao;
import kr.or.iei.member.model.vo.Member;

@Service("memberService")
public class MemberService {
	@Autowired
	@Qualifier("memberDao")
	private MemberDao dao;
	
	public MemberService() {
		super();
	}

	public Member selectMemberOne(Member m) {
		Member member = dao.selectMemberOne(m);
		return member;
	}
}
