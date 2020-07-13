package kr.or.iei.chat.model.service;



import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.chat.model.dao.ChatDao;
import kr.or.iei.chat.model.vo.Chat;
import kr.or.iei.chat.model.vo.ChatFile;

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
	System.out.println(c.getChatTitle());
	String title = dao.selectOnetitle(c.getChatTitle());
	System.out.println(c.getChatTitle());
	if(title==null) {
		int result = dao.chatInsert(c);
		return result;
	}else {
		return 0;
	}
}

public int chatUpdate(String title) {
	String titles = dao.selectOnetitle(title);
	if(titles==null) {
		System.out.println("djqtdj");
		return 0;
	}else {
		System.out.println("방있어");
		int result = dao.chatUpdate(title);
		return result;
	}
	
}

public String selectOpenTitle(String chatTitle) {
	String title = dao.selectOnetitle(chatTitle);
	return title;
}

public int chatFileInsert(ChatFile c) {
	
	return dao.chatFileInsert(c);
}




}
