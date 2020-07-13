package kr.or.iei.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.iei.member.model.vo.Member;
import kr.or.iei.review.model.vo.Review;

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
	public Member selectOneMember(Member m) {
		return sql.selectOne("member.selectOneMember",m);
	}
	public int update(Member m) {	
		return sql.update("member.update", m);
	}

	public int delete(String memberId) {
		return sql.delete("member.delete", memberId);
	}


	public List reviewList(String memberNickname) {
		
		return sql.selectList("review.reviewList", memberNickname);
	
	}
	public List applyList(String memberId) {
		
		return sql.selectList("apply.applyList", memberId);
	}
	public List reservationList(String memberId) {
		
		return sql.selectList("reservation.reservationList", memberId);
	}

	public List rentList(String memberId) {
		return sql.selectList("rent.rentList", memberId);
	}
	@Transactional
	public int updatePw(Member member) throws Exception{
		return sql.update("member.updatePw",member);
	}


	public Member selectIdMember(Member m) {
		System.out.println("dao");
		return  sql.selectOne("member.selectIdMember",m);
	}


	public Member selectId(Member m) {
		
		return sql.selectOne("member.selectId",m);
	}


	public int rentUpdate(int rentNo) {
		
		return sql.update("rent.rentUpdate",rentNo);
	}


	public List userLostBook(Member m) {
		
		return sql.selectList("book.userLostBook",m);
	}
	
}
