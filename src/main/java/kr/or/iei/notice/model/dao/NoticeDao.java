package kr.or.iei.notice.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("noticeDao")
public class NoticeDao {
	@Autowired
	SqlSessionTemplate sql;
	
	public NoticeDao() {
		
	}
}
