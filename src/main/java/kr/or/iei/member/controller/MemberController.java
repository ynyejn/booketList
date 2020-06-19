package kr.or.iei.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.member.model.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	@Qualifier("memberSerivce")
	private MemberService service;
	
	public MemberController() {
		super();
	}
}
