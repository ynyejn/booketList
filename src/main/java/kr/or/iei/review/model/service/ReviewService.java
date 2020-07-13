package kr.or.iei.review.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.book.model.vo.Book;
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

	public ArrayList<Book> reviewSelectBook(String memberId) {
		List list = dao.reviewSelectBook(memberId);
		return (ArrayList<Book>)list;
	}

	public int reviewInsert(Review review) {
		Review r = dao.selectOneReviews(review);
		if(r==null) {
			
			int result = dao.reviewInsert(review);
			return result;
		}else {
			return 0;
		}
		
	}

	public Review selectOneReview(String string, String memberNickName) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("bookName", string);
		map.put("memberNickName", memberNickName);
		Review r = dao.selectOneReview(map);
		return r;
	}

	public int reviewDelete(int reviewNo) {
		// TODO Auto-generated method stub
		return dao.reviewDelete(reviewNo);
	}

	public ArrayList<Review> reviewList(String memberNickname) {
		List reviewList = dao.reviewList(memberNickname);
		return (ArrayList<Review>)reviewList;
		
	}

	public Review selectOneReviews(int reviewNo) {
		// TODO Auto-generated method stub
		return dao.selectOnReview(reviewNo);
	}

	public int reviewUpdate(Review r) {
		
		return dao.reviewUpdate(r);
	}

}
