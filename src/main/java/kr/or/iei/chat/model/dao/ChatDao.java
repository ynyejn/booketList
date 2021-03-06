package kr.or.iei.chat.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.iei.chat.model.vo.Chat;
import kr.or.iei.chat.model.vo.ChatFile;

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

	public int chatInsert(Chat c) {
		// TODO Auto-generated method stub
		return sql.insert("chat.chatInsert",c);
	}


	public int chatUpdate(String title) {
		return sql.update("chat.chatUpdate",title);
	}

	public int chatUpdatedelete(String title) {
		
		return sql.update("chat.chatUpdatedelete",title);
	}

	public int titleDlelte(String title) {
		return sql.delete("chat.titleDlelte",title);
	}

	public String selectOnetitle(String chatTitle) {
		
		return sql.selectOne("chat.selectOnetitle",chatTitle);
	}

	public int chatFileInsert(ChatFile c) {
		// TODO Auto-generated method stub
		return sql.insert("chat.chatFileInsert",c);
	}

	public ArrayList<ChatFile> chatFileSelect(String title) {
		List list = sql.selectList("chat.chatFileSelect",title);
		return (ArrayList<ChatFile>)list;
	}

}
