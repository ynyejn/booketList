package kr.or.iei.turn.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.member.model.vo.Member;
import kr.or.iei.rent.model.vo.Rent;
import kr.or.iei.spot.model.vo.Spot;
import kr.or.iei.spot.model.vo.SpotPageData;
import kr.or.iei.turn.model.service.ReturnService;
import kr.or.iei.turn.model.vo.TurnApply;

@Controller
public class ReturnController {
	@Autowired
	private ReturnService service;
	
	//@Scheduled(cron = "0 0 12 * * *")
	@RequestMapping("/bookDelay.do")
	public void bookDalay() {
		System.out.println("연체로직 gogo");
		int result = service.bookDalay();
		if(result>0) {
			System.out.println("성공");
		}else {
			System.out.println("실패");
		}
	}
	
	
	@RequestMapping("/goBookReturn.do")
	public String goBookReturn(HttpSession session,Model model,String msg) {
		Member m = (Member)session.getAttribute("member");
		ArrayList<Rent> list = service.selectAllRent(m.getMemberId());
		model.addAttribute("list",list);
		if(msg!=null) {
			model.addAttribute("msg",msg);
		}
		return "book/returnBook";
	}
	
	@RequestMapping("/returnBook.do")
	public String goBookReturn(HttpSession session, TurnApply turn) {
		Member m = (Member)session.getAttribute("member");
		String memberId = m.getMemberId();
		turn.setMemberId(memberId);
		System.out.println(turn.getBookNo()+"/"+turn.getSpotName());
		int result = service.insertTurnApply(turn);
		if(result>0) {
			return "redirect:/goBookReturn.do?msg=0";
		}else {
			return "redirect:/goBookReturn.do?msg=1";
		}
	}

}
