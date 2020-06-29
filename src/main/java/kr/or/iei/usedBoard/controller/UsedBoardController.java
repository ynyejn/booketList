package kr.or.iei.usedBoard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.usedBoard.model.service.UsedBoardService;
@Controller
public class UsedBoardController {
	
	@Autowired
	private UsedBoardService service;
	
	@RequestMapping("/goUsedBoard.do")
	private String goUsedBoard() {
		return "usedBoard/usedList";
	}
}
