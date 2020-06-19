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
public class OpenChatting extends TextWebSocketHandler{
	
//	@Autowired
	private ArrayList<WebSocketSession> allSession;
	private HashMap<String, HashMap<String, WebSocketSession>> title;
	public OpenChatting() {		
		allSession = new  ArrayList<WebSocketSession>();
		title = new HashMap<String, HashMap<String, WebSocketSession>>();
	}
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		allSession.add(session);
	}
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception{
		JsonParser parser = new JsonParser();
		JsonElement element = parser.parse(message.getPayload());
		String type = element.getAsJsonObject().get("type").getAsString();
		HashMap<String, WebSocketSession> members;
	}
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
		HashMap<String, WebSocketSession> members;
		allSession.remove(session);
	}
}
