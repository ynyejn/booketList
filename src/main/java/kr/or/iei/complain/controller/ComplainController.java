package kr.or.iei.complain.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.complain.model.service.ComplainService;

@Controller
@RequestMapping("/complain")
public class ComplainController {
	@Autowired
	@Qualifier("complainService")
	private ComplainService service;

	public ComplainController() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}
