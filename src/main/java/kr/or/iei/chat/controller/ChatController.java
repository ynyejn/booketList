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
		System.out.println(m.getMemberNickname());
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
		System.out.println(c.getMemberNickname());
		int result = service.chatInsert(c);
		if(result>0) {
			model.addAttribute("c", c);
			return "openChatting/chat";
		}else {
			return "redirect:/chat/chatRoom.do?title="+c.getChatTitle();
		}
	}
	@RequestMapping("/chatRoom.do")
	public String chatRoom(String title,Model model) {
		int result = service.chatUpdate(title);
		System.out.println("gdgd");
		if(result>0) {
			model.addAttribute("title",title);
			System.out.println("gdgd");
			return "openChatting/chat";	
		}else {
			System.out.println("gdgd");
			return "openChatting/chatFull";
		}
	}
}
