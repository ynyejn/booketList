package kr.or.iei.common;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import kr.or.iei.alarm.model.dao.AlarmDao;
import kr.or.iei.alarm.model.vo.Alarm;

@Component("adminMsg")
public class AdminMsg extends TextWebSocketHandler{
	@Autowired
	@Qualifier("alarmDao")
	private AlarmDao dao;
	private ArrayList<WebSocketSession> admin;
	
	public AdminMsg() {
		admin = new ArrayList<WebSocketSession>();
	}
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("연결 성공!");
		
	}
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		JsonParser parser = new JsonParser();
		JsonElement element = parser.parse(message.getPayload());
		String type = element.getAsJsonObject().get("type").getAsString();
		
		if(type.equals("lostBookAlarmCount")) {
			int result = dao.updateAlarm();
			
			Alarm total = dao.selectTotalCount();
			System.out.println("totalCount : "+ total);
			String a = new Gson().toJson(total);
			System.out.println(a);
			for(int i=0;i<admin.size();i++) {
				admin.get(i).sendMessage(new TextMessage(new Gson().toJson(total)));
			}

		}else if(type.equals("output")){
			System.out.println(session);
			admin.add(session);	
			
			Alarm total = dao.selectTotalCount();
			
			System.out.println("totalCount : "+ total);
			session.sendMessage(new TextMessage(new Gson().toJson(total)));
		}else if(type.equals("lostbookClick")) {
			int data = element.getAsJsonObject().get("data").getAsInt();
			int result = dao.updateLostBookAlarm(data);
			
			
			Alarm total = dao.selectTotalCount();
			String a = new Gson().toJson(total);
			System.out.println(a);
			for(int i=0;i<admin.size();i++) {
				admin.get(i).sendMessage(new TextMessage(new Gson().toJson(total)));
			}
		}
	}
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
	}
}
