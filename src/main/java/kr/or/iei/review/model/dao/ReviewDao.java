package kr.or.iei.review.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.iei.member.model.vo.Member;
import kr.or.iei.rent.model.vo.Rent;
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


	
}
