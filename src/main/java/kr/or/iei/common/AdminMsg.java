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
		System.out.println("제발ㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹ!");
		
	}
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		JsonParser parser = new JsonParser();
		JsonElement element = parser.parse(message.getPayload());
		String type = element.getAsJsonObject().get("type").getAsString();
		System.out.println("타입입니다. :");
		if(type.equals("lostbookAlarmCount")) {
			System.out.println("2222222222s");
			/* int data = element.getAsJsonObject().get("data").getAsInt() */;
			System.out.println("왜 안되지 : ");
			dao.lostUpdateAlarm(); //책 분실신고 들어오면 lostbook_count + data, total_count + data
			Alarm total = dao.selectTotalCount();  
			String a = new Gson().toJson(total);
			System.out.println(a);
			if(!admin.isEmpty()) {
				for(int i=0;i<admin.size();i++) {
					admin.get(i).sendMessage(new TextMessage(new Gson().toJson(total)));
				}
			}
			

		}else if(type.equals("complainAlarmCount")) {
			System.out.println("11111111111s");
			int result = dao.updateComplainAlarm(); // alarm 테이블 complain_count +1
			Alarm total = dao.selectTotalCount(); //모든 컬럼들 select 
			String a = new Gson().toJson(total);
			System.out.println(a);
			for(int i=0;i<admin.size();i++) {
				admin.get(i).sendMessage(new TextMessage(new Gson().toJson(total)));
			}
			
		}else if(type.equals("lostbookClick")) {
			System.out.println("3333333333333s");
			int data = element.getAsJsonObject().get("data").getAsInt(); 
			int result = dao.updateLostBookAlarm(data); // lostbookAlarmClick을 하면 lostbook_count 0, lostbook_count 만큼 total_count 삭제
			Alarm total = dao.selectTotalCount();
			String a = new Gson().toJson(total);
			System.out.println(a);
			for(int i=0;i<admin.size();i++) {
				admin.get(i).sendMessage(new TextMessage(new Gson().toJson(total)));
			}
			
		}else if(type.equals("complainAlarmClick")) {
			System.out.println("555555555555s");
			int data = element.getAsJsonObject().get("data").getAsInt();
			int result = dao.updatecomplainAlarmClick(data); // complainAlarmClick을 하면 complain_count 0, lostbook_count 만큼 total_count 삭제
			Alarm total = dao.selectTotalCount();
			String a = new Gson().toJson(total);
			System.out.println(a);
			for(int i=0;i<admin.size();i++) {
				admin.get(i).sendMessage(new TextMessage(new Gson().toJson(total)));
			}
			
		}else if(type.equals("output")){
			System.out.println("666666666666s");
			admin.add(session);
			Alarm total = dao.selectTotalCount(); //전체출력
			System.out.println("totalCount : "+ total);
			session.sendMessage(new TextMessage(new Gson().toJson(total))); //보내줌
		}
		
	}
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("연결이 종료되었습니다!!!!!!");
	}
}
