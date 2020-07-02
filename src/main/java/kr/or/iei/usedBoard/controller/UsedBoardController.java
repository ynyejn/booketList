package kr.or.iei.usedBoard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.usedBoard.model.service.UsedBoardService;
import kr.or.iei.usedBoard.model.vo.UsedBoardPageData;
@Controller
public class UsedBoardController {
	
	@Autowired
	private UsedBoardService service;
	
	@RequestMapping("/goUsedBoard.do")
	private String goUsedBoard() {
		return "usedBoard/usedList";
	}

	@RequestMapping("/goAdminUsedBoard.do")
	private String goAdminUsedBoard(Model model) {
		int reqPage = 1;
		UsedBoardPageData upd= service.selectAllUsedList(reqPage);
		
		
		model.addAttribute("list",upd.getList());
		model.addAttribute("pageNavi", upd.getPageNavi());
		
		return "usedBoard/adminUsedList";
	}
	
	@RequestMapping("/goBoardWrite.do")
	private String goBoardWrite() {
		return "usedBoard/boardWrite";
	}
}
