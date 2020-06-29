package kr.or.iei.chat.model.service;



import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.chat.model.dao.ChatDao;
import kr.or.iei.chat.model.vo.Chat;

@Service("chatService")
public class ChatService {
@Autowired
@Qualifier("chatDao")
private ChatDao dao;

public ChatService() {
	super();
	// TODO Auto-generated constructor stub
}

public ArrayList<Chat> selectOpenChatting() {
	List list = dao.selectOpenChatting();
	return (ArrayList<Chat>)list;
}

public int chatInsert(Chat c) {
	String title = dao.selectOnetitle(c.getChatTitle());
	if(title==null) {
		int result = dao.chatInsert(c);
		return result;
	}else {
		return 0;
	}
}
}
