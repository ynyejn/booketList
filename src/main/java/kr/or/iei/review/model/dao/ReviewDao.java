package kr.or.iei.review.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	
}
