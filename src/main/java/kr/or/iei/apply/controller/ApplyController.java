package kr.or.iei.apply.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.apply.model.service.ApplyService;

@Controller
@RequestMapping("/apply")
public class ApplyController {
	@Autowired
	@Qualifier("applyService")
	private ApplyService service;

	public ApplyController() {
		super();
		// TODO Auto-generated constructor stub
	}
	@RequestMapping("/applyApplication.do")
	public String applyApplication() {
		return "apply/applyApplication";
	}
	
}
