package kr.or.iei.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.iei.common.SHA256Util;
import kr.or.iei.member.model.dao.MemberDao;
import kr.or.iei.member.model.vo.Member;

@Service("memberService")
public class MemberService {
	@Autowired
	@Qualifier("memberDao")
	private MemberDao dao;
	
	@Autowired
	private SHA256Util enc;
	
	public MemberService() {
		super();
	}
	
	@Transactional
	public int joinSuccess(Member member) {
		try {
			System.out.println(member.getMemberId());
			member.setMemberPw(enc.encData(member.getMemberPw()));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		return dao.joinSuccess(member);
	}
	

	public Member checkId(String memberId) {
		
		return dao.checkId(memberId);
	}

	public Member checkNickname(String memberNickname) {
		
		return dao.checkNickname(memberNickname);
	}

	public Member selectOneMember(Member m) throws IllegalArgumentException{
		
		return dao.selectOneMember(m);
	}
	
	@Transactional
	public int update(Member m) {
		
		return dao.update(m);
	}
	@Transactional
	public int delete(String memberId) {
		
		return dao.delete(memberId);
	}

	
}
