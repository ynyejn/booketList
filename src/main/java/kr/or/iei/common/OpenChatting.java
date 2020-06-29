package kr.or.iei.common;

import java.util.ArrayList;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import kr.or.iei.chat.model.dao.ChatDao;
import kr.or.iei.chat.model.vo.Chat;

@Component("openChatting")
public class OpenChatting extends TextWebSocketHandler {
	@Autowired
	@Qualifier("chatDao")
	private ChatDao dao;
	private ArrayList<WebSocketSession> allSession;
	private HashMap<String, HashMap<String, WebSocketSession>> map;

	public OpenChatting() {
		allSession = new ArrayList<WebSocketSession>();
		map = new HashMap<String, HashMap<String, WebSocketSession>>();
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		allSession.add(session);
	}

	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println(message);
		JsonParser parser = new JsonParser();
		JsonElement element = parser.parse(message.getPayload());
		String type = element.getAsJsonObject().get("type").getAsString();
		HashMap<String, WebSocketSession> members;
			if(type.equals("register")){
			String memberNickname = element.getAsJsonObject().get("memberNickname").getAsString();
			String title = element.getAsJsonObject().get("title").getAsString();
			members = map.get(title);
			
			if(members == null) {//대화방이 방제목에 해당하는 방이 없을 경우
				members= new HashMap<String, WebSocketSession>();
				map.put(title, members);
				members.put(memberNickname, session);
				System.out.println(memberNickname);
				System.out.println(title);
				for(String key : members.keySet()){
					System.out.println(key);
					System.out.println(memberNickname);
					System.out.println(title);
				WebSocketSession ws = members.get(key);
				ws.sendMessage(new TextMessage(memberNickname+"님이"+title+"방을 생성 하였습니다."));
				}
				
			}
				System.out.println(memberNickname);
				members.put(memberNickname, session);
				
			
						
				int result = dao.chatUpdate(title);
				if(result>0) {
			for(String key : members.keySet()){//리절트에 해당하는 대화방의 저장되어있는 세션을 모두 순회
					
					WebSocketSession ws = members.get(key);
					ws.sendMessage(new TextMessage(memberNickname+"님이 입장하셧습니다."));
				}
	        }

		}else {
			String memberNickname = element.getAsJsonObject().get("memberNickname").getAsString();
			String msg = element.getAsJsonObject().get("msg").getAsString();
			String title = element.getAsJsonObject().get("title").getAsString();
			System.out.println(memberNickname);
			members = map.get(title);
			for(String key : members.keySet()){
	            System.out.println("키 : " + key);
	            if(!key.equals(memberNickname)) {
	            	WebSocketSession ws = members.get(key);
					ws.sendMessage(new TextMessage(msg));
	            }
	        }
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		HashMap<String, WebSocketSession> members;
		if(session.getUri().getQuery()!=null) {
			String array = session.getUri().getQuery();
			String[] memberNickname = array.split("=");
			String[] title = memberNickname[1].split(" ");
			members = map.get(title[1]);
		for(String key : members.keySet()){  
            if(key.equals(title[0])) {
            	members.remove(title[0]);
            	for(String key1 : map.keySet()) {
            		members = map.get(title[1]);
            		if(members.isEmpty()) {
            			System.out.println(title[1]+"대화방 삭제");
            			int result = dao.titleDlelte(title[1]);
            			if(result>0) {
            				map.remove(title[1]);
            			}
            		}
            	}
            	
            	break;
            }
        }
		for(String key : members.keySet()){
			int result = dao.chatUpdatedelete(title[1]);
            WebSocketSession ws = members.get(key);
			ws.sendMessage(new TextMessage(title[0]+"님이 퇴장 하였습니다."));
        }
		
		}else {
			
			System.out.println("연결 종료");
			allSession.remove(session);
		}
	}
}
