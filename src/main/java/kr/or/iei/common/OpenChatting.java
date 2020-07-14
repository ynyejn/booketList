package kr.or.iei.common;

import java.io.File;
import java.util.ArrayList;


import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import kr.or.iei.chat.controller.ChatController;
import kr.or.iei.chat.model.dao.ChatDao;
import kr.or.iei.chat.model.service.ChatService;
import kr.or.iei.chat.model.vo.Chat;
import kr.or.iei.chat.model.vo.ChatFile;


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
			String chatPeople = element.getAsJsonObject().get("chatPeople").getAsString();
			members = map.get(title);
			
			if(members == null) {//대화방이 방제목에 해당하는 방이 없을 경우
				Chat c = new Chat();
				c.setMemberNickname(memberNickname);
				c.setChatTitle(title);
				c.setChatPeople(Integer.parseInt(chatPeople));
				System.out.println(c.getChatPeople());
				System.out.println(c.getChatTitle());
				System.out.println(c.getMemberNickname());
				int result = dao.chatInsert(c);
				if(result>0) {
					
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
				
			}
				System.out.println(memberNickname);
				members.put(memberNickname, session);
				
			
						
				
				
			for(String key : members.keySet()){//리절트에 해당하는 대화방의 저장되어있는 세션을 모두 순회
					
					WebSocketSession ws = members.get(key);
					ws.sendMessage(new TextMessage(memberNickname+"님이 입장하셨습니다."));
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
			System.out.println(title[1]);
			System.out.println(map.size());
			members = map.get(title[1]);
		for(String key : members.keySet()){  
            if(key.equals(title[0])) {
            	members.remove(title[0]);
            	System.out.println(title[0]);
            	int result = dao.chatUpdatedelete(title[1]);
            	for(String key2 : members.keySet()){
        			
                    WebSocketSession ws = members.get(key2);
        			ws.sendMessage(new TextMessage(title[0]+"님이 퇴장 하였습니다."));
                }
            	if(!map.isEmpty()) {
            		
            		for(String key1 : map.keySet()) {
            			members = map.get(title[1]);
            			if(members.isEmpty()) {
            				System.out.println(title[1]+"대화방 삭제");
            				int result2 = dao.titleDlelte(title[1]);
            				if(result2>0) {
            					
            					ArrayList<ChatFile> chatFile = dao.chatFileSelect(title[1]);
            					
            					
            					String saveDirectory = "C:/Users/SEC/spring-book/booketList/src/main/webapp/resources/chat/";
            					for(ChatFile c : chatFile) {
            						String[] fileName = c.getChatFilepath().split("/");
            						File delFile = new File(saveDirectory+fileName[3]);
            						delFile.delete();
            					}
            				}
            				map.remove(title[1]);
            				break;
            			}
            		}
            	}
            	
            	
            }
        }
		
		
		}else {
			
			System.out.println("연결 종료");
			allSession.remove(session);
		}
	}
}
