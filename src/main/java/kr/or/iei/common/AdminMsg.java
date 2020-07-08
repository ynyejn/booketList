package kr.or.iei.common;

import java.util.ArrayList;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import kr.or.iei.alarm.model.dao.AlarmDao;

@Component("adminMsg")
public class AdminMsg extends TextWebSocketHandler{
	@Autowired
	@Qualifier("alarmDao")
	private AlarmDao dao;
	
	private ArrayList<WebSocketSession> adminSession;

	public AdminMsg() {
		adminSession = new ArrayList<WebSocketSession>();
	}
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println(session);
		adminSession.add(session);
	}
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println(message);
		JsonParser parser = new JsonParser();
		JsonElement element = parser.parse(message.getPayload());
		String type = element.getAsJsonObject().get("type").getAsString();
		if(type.equals("lostBookAlarmCount")) {
			
		}
	}
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		adminSession.remove(session);
	}
}
