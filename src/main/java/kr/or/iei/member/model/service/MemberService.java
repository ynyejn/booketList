package kr.or.iei.member.model.service;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.iei.apply.model.vo.Apply;
import kr.or.iei.book.model.vo.BookAndRent;
import kr.or.iei.common.SHA256Util;
import kr.or.iei.member.model.dao.MemberDao;
import kr.or.iei.member.model.vo.Member;
import kr.or.iei.rent.model.vo.Rent;
import kr.or.iei.reservation.model.vo.Reservation;
import kr.or.iei.review.model.vo.Review;

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
	public int update(Member m) {
		return dao.update(m);
	}
	
	@Transactional
	public int updatePw(Member m) throws Exception {
		try {
			System.out.println(m.getMemberId());
			m.setMemberPw(enc.encData(m.getMemberPw()));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dao.updatePw(m);
	}
	@Transactional
	public int delete(String memberId) {
		
		return dao.delete(memberId);
	}

	public ArrayList<Review> reviewList(String memberNickname) {
		List reviewList = dao.reviewList(memberNickname);
		return (ArrayList<Review>)reviewList;
		
	}

	public ArrayList<Apply> applyList(String memberId) {
		List applyList = dao.applyList(memberId);
		return (ArrayList<Apply>)applyList;
		
	}

	public ArrayList<Reservation> reservationList(String memberId) {
		List reservationList = dao.reservationList(memberId);
		return (ArrayList<Reservation>)reservationList;
	}

	public ArrayList<Rent> rentList(String memberId) {
		List rentList = dao.rentList(memberId);
		return (ArrayList<Rent>)rentList;
	}
	
	public Member selectIdMember(Member m) {
		System.out.println(m.getMemberId());
		System.out.println(m.getMemberPhone());
		System.out.println(m.getMemberEmail());
		Member memberId = dao.selectIdMember(m);
		System.out.println(m.getMemberId());
		return memberId;
	}

	public Member selectId(Member m) {
		System.out.println(m.getMemberId());
		System.out.println(m.getMemberPhone());
		System.out.println(m.getMemberEmail());
		System.out.println("서비스");
		Member memberId = dao.selectId(m);
		System.out.println(m.getMemberId());
		System.out.println("서비스갔다옴");
		return memberId;
	}

	public int rentUpdate(int rentNo) {
		
		return dao.rentUpdate(rentNo);
	}

	public List userLostBook(Member m) {
		return dao.userLostBook(m);
	}
	
}
