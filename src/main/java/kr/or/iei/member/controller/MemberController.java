package kr.or.iei.member.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	@RequestMapping(value="/join.do")
	public String join(Member m) {
//		int result = service.join(m);
//		if(result>0) {
//			return "redirect:/";
//		}else {
//			return "member/join";
//		}
		return "member/join";
	}
	
	@RequestMapping(value="/joinSuccess.do")
	@ResponseBody
	public String joinSuccess() {
		System.out.println("hello");
		return null;
	}
	
	@RequestMapping(value="/bookcheck", method=RequestMethod.POST)
	@ResponseBody
	//String??
	public String bookcheck(@RequestParam(value="valueArr[]")List<String>valueArr) {
		return "member/join";
	}
}
