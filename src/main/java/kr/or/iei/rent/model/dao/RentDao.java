package kr.or.iei.rent.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("rentDao")
public class RentDao {
	@Autowired
	SqlSessionTemplate sql;
	
	public RentDao() {
		super();
	}
}
