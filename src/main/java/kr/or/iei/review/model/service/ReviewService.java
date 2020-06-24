package kr.or.iei.review.model.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.review.model.dao.ReviewDao;
import kr.or.iei.review.model.vo.Review;

@Service("reviewService")
public class ReviewService {
	@Autowired
	@Qualifier("reviewDao")
	private ReviewDao dao;

	public ReviewService() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ArrayList<Review> selectReview() {
		List list = dao.selectReview();
		return (ArrayList<Review>)list;
	}
	
}
