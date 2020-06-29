package kr.or.iei.chat.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.chat.model.service.ChatService;
import kr.or.iei.chat.model.vo.Chat;
import kr.or.iei.member.model.vo.Member;

@Controller
@RequestMapping("/chat")
public class ChatController {
	@Autowired
	@Qualifier("chatService")
	private ChatService service;

	public ChatController() {
		super();
		// TODO Auto-generated constructor stub
	}

	@RequestMapping("makingRoomFrm.do")
	public String makingRoomFrm(HttpSession session, Model model) {
		Member m = (Member) session.getAttribute("member");
		model.addAttribute("m", m);
		return "openChatting/makingRoom";
	}

	@RequestMapping(value = "/openChatting.do")
	public String openChatting(Model model) {
		ArrayList<Chat> arrChat = service.selectOpenChatting();
		model.addAttribute("openChatting", arrChat);
		return "openChatting/openChatting";
	}

	@RequestMapping("/chat.do")
	public String chat(Chat c, Model model, String memberNickname,HttpSession session) {
		System.out.println(c.getChatPeople());
		System.out.println(c.getChatTitle());
		System.out.println(memberNickname);
		int result = service.chatInsert(c);
		if(result>0) {
			model.addAttribute("title", c.getChatTitle());
			return "openChatting/chat";
		}else {
			model.addAttribute("title", c.getChatTitle());
			return "openChatting/chat";
		}
	}
	@RequestMapping("/chatRoom.do")
	public String chatRoom(String title,Model model) {
		
		model.addAttribute("title",title);
		return "openChatting/chat";
	}
}
