package kr.or.iei.apply.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.iei.apply.model.vo.Apply;

@Repository("applyDao")
public class ApplyDao {
	@Autowired
	SqlSessionTemplate sql;

	public ApplyDao() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int applyInsert(Apply a) {
		
		return sql.insert("apply.appltInsert",a);
	}
	
}
