package kr.or.iei.complain.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("complainDao")
public class ComplainDao {
	@Autowired
	SqlSessionTemplate sql;

	public ComplainDao() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}
