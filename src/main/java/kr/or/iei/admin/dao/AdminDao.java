package kr.or.iei.admin.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository("adminDao")
public class AdminDao {
	
	@Autowired
	SqlSessionTemplate sqlSession;

	public List selectMember() {
		System.out.println("AdminDao");
		return sqlSession.selectList("member.selectMember");
	}
}
