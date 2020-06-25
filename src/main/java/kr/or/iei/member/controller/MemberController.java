package kr.or.iei.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.member.model.service.MemberService;
import kr.or.iei.member.model.vo.Member;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	@Qualifier("memberService")
	private MemberService service;
	
	public MemberController() {
		super();
	}
	@RequestMapping("/selectMember.do")
	public String selectMember(HttpSession session,Member m) {
		Member member = service.selectMemberOne(m);
		if(member!=null) {
			session.setAttribute("member", member);
			return "redirect:/";
		}else {
			
			return "redirect:/";
		}
	}
	@RequestMapping("/login.do")
	public String login() {
		return "member/login";
	}
}
