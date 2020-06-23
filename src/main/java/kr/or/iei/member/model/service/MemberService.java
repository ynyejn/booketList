package kr.or.iei.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	@Transactional
	public int join(Member m) {
		
		return dao.join(m);
	}
}
