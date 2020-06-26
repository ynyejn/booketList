package kr.or.iei.common;

import java.util.ArrayList;

import java.util.HashMap;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import kr.or.iei.chat.model.vo.Chat;

@Component("openChatting")
public class OpenChatting extends TextWebSocketHandler {

//	@Autowired
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
		if (type.equals("type")) {
			String memberId = element.getAsJsonObject().get("memberId").getAsString();
			String title = element.getAsJsonObject().get("title").getAsString();
			System.out.println(title);
			members = map.get(title);
			int result = members.size();
			String result2 = Integer.toString(result);
			WebSocketSession ws = members.get(memberId);
			ws.sendMessage(new TextMessage(result2));
		}else if(type.equals("register")){
			String memberId = element.getAsJsonObject().get("memberId").getAsString();
			String title = element.getAsJsonObject().get("title").getAsString();
			members = map.get(title);
			
			if(members == null) {//대화방이 방제목에 해당하는 방이 없을 경우
				members= new HashMap<String, WebSocketSession>();
				map.put(title, members);
				members.put(memberId, session);
				for(String key : map.keySet()){
				WebSocketSession ws = members.get(key);
				ws.sendMessage(new TextMessage(memberId+"님이"+title+"방을 생성 하였습니다."));
				}
				
			}
				System.out.println(memberId);
				members.put(memberId, session);
			
						
			for(String key : members.keySet()){//리절트에 해당하는 대화방의 저장되어있는 세션을 모두 순회
				System.out.println("키 : "+key);
				WebSocketSession ws = members.get(key);
				ws.sendMessage(new TextMessage(memberId+"님이 입장하셧습니다."));
	        }

		}else {
			String memberId = element.getAsJsonObject().get("memberId").getAsString();
			String msg = element.getAsJsonObject().get("msg").getAsString();
			String title = element.getAsJsonObject().get("result").getAsString();
			System.out.println(memberId);
			members = map.get(title);
			for(String key : map.keySet()){
	            System.out.println("키 : " + key);
	            if(!key.equals(memberId)) {
	            	WebSocketSession ws = members.get(key);
					ws.sendMessage(new TextMessage(msg));
	            }
	        }
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		HashMap<String, WebSocketSession> members;
		System.out.println(session);
		System.out.println(session.getUri().getQuery());
		String array = session.getUri().getQuery();
		String[] memberId = array.split("=");
		String[] title = memberId[1].split(" ");
		System.out.println(title[0]);
		System.out.println(title[1]);
		System.out.println(title.length);
		members = map.get(title[1]);
		for(String key : members.keySet()){
            System.out.println("키 : " + key);
            
            if(key.equals(title[0])) {
            	System.out.println("ddddd");
            	members.remove(title[0]);
            	System.out.println(map.size()+"ddddd");
            	
            	for(String key1 : map.keySet()) {
            		System.out.println(key1+"대화방 삭제"+map.get(title[1]));
            		members = map.get(title[1]);
            		if(map.isEmpty()) {
            			System.out.println(title[1]+"대화방 삭제");
            			map.remove(title[1]);
            			
            		}
            	}
            	
            	break;
            }
        }
		for(String key : map.keySet()){
            System.out.println("키 : " + key);
            WebSocketSession ws = members.get(key);
			ws.sendMessage(new TextMessage(title[0]+"님이 퇴장 하였습니다."));
        }
		
		
		System.out.println("연결 종료");
		allSession.remove(session);
	}
}
