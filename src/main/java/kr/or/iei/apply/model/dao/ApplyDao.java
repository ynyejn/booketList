package kr.or.iei.apply.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("applyDao")
public class ApplyDao {
	@Autowired
	SqlSessionTemplate sql;

	public ApplyDao() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}
