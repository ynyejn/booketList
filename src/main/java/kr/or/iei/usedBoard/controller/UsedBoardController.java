package kr.or.iei.usedBoard.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.member.model.vo.Member;
import kr.or.iei.usedBoard.model.service.UsedBoardService;
import kr.or.iei.usedBoard.model.vo.UsedBoard;
import kr.or.iei.usedBoard.model.vo.UsedBoardPageData;
@Controller
public class UsedBoardController {
	
	@Autowired
	private UsedBoardService service;
	
	@RequestMapping("/goUsedBoard.do")
	private String goUsedBoard(Model model) {
		int reqPage = 1;
		UsedBoardPageData upd= service.selectAllUsedList(reqPage);
		
		
		model.addAttribute("list",upd.getList());
		model.addAttribute("pageNavi", upd.getPageNavi());
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
	
	@RequestMapping("/insertBoard.do")
	private String insertBoard(HttpSession session,UsedBoard ub, String bank) {
		Member m = (Member)session.getAttribute("member");
		//ub.setMemberId(m.getMemberId());
		ub.setMemberId("user01");
		if(ub.getUsedType().equals("판매")) {
			String str="";
			str+=bank+"/"+ub.getUsedInfo();
			ub.setUsedInfo(str);
		}else {
			if(ub.getUsedInfo().equals("")) {
				//ub.setUsedInfo(m.getMemberName());
				ub.setUsedInfo("연예진");
			}
		}
		int result = service.insertBoard(ub);
		return "redirect:/goUsedBoard.do";
	}
	
	@RequestMapping("/goBoardView.do")
	private String goBoardView(int usedNo) {
		return "usedBoard/boardView";
	}
}
