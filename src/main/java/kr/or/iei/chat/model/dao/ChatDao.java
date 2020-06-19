package kr.or.iei.chat.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("chatDao")
public class ChatDao {
	@Autowired
	SqlSessionTemplate sql;
	
	public ChatDao() {
		super();
	}

	public List selectOpenChatting() {
		return sql.selectList("chat.selectOpenChatting");
	}

}
