package kr.or.iei.complain.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.iei.complain.model.vo.Complain;

@Repository("complainDao")
public class ComplainDao {
	@Autowired
	SqlSessionTemplate sql;

	public ComplainDao() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int complainInsert(Complain c) {
		// TODO Auto-generated method stub
		return sql.insert("complain.complainInsert",c);
	}

	public int complainInsertFile(Complain c) {
		// TODO Auto-generated method stub
		return sql.insert("complain.complainInsertFile",c);
	}
	
}
