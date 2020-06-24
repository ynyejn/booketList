package kr.or.iei.review.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.iei.book.model.vo.Book;
import kr.or.iei.review.model.vo.Review;

@Repository("reviewDao")
public class ReviewDao {
	@Autowired
	SqlSessionTemplate sql;

	public ReviewDao() {
		super();
		// TODO Auto-generated constructor stub
	}

	public List selectReview() {
		
		return sql.selectList("review.selectReview");
	}

	public List reviewSelectBook(String memberId) {
		
		return sql.selectList("review.reviewSelectBook",memberId);
	}

	public int reviewInsert(Review review) {
	
		return sql.insert("review.reviewInnsert",review);
	}

	public Book selectBook(String bookName) {
		
		return sql.selectOne("review.selectBook",bookName);
	}

	public int selectBookno(Review review) {
		
		return sql.selectOne("review.selectBookno",review);
	}
	
}
