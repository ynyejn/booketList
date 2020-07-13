package kr.or.iei.review.model.dao;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.iei.rent.model.vo.Rent;
import kr.or.iei.book.model.vo.Book;
import kr.or.iei.member.model.vo.Member;
import kr.or.iei.review.model.vo.Review;

@Repository("reviewDao")
public class ReviewDao {
	@Autowired
	SqlSessionTemplate sql;

	public ReviewDao() {
		super();
		// TODO Auto-generated constructor stub
	}

	public List userReviewList(Member member) {
		return sql.selectList("review.userReviewList", member);
	}

	public List selectReview() {
		
		return sql.selectList("review.selectReview");
	}

	public List reviewSelectBook(String memberId) {
		return sql.selectList("review.reviewSelectBook",memberId);
	}

	public int reviewInsert(Review review) {	
		return sql.insert("review.reviewInsert",review);
	}

	public Review selectOneReview(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return sql.selectOne("review.selectOneReview",map);
	}

	public Review selectOneReviews(Review review) {
		// TODO Auto-generated method stub
		return sql.selectOne("review.selectOneReviews",review);
	}

	public int reviewDelete(int reviewNo) {
		// TODO Auto-generated method stub
		return sql.delete("review.reviewDelete",reviewNo);
	}

	public List reviewList(String memberNickname) {
		// TODO Auto-generated method stub
		return sql.selectList("review.reviewList", memberNickname);
	}

	

}
