package kr.or.iei.chat.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;



import kr.or.iei.chat.model.service.ChatService;
import kr.or.iei.chat.model.vo.Chat;


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

	@RequestMapping(value="openChatting.do")
	public String openChatting(Model model) {
		ArrayList<Chat> arrChat = service.selectOpenChatting();
		model.addAttribute("openChatting",arrChat);
		return "openChatting/openChatting";
	}
}
