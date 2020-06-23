package kr.or.iei.apply.controller;

import java.sql.Date;
import java.text.ParseException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.apply.model.service.ApplyService;
import kr.or.iei.apply.model.vo.Apply;

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
	@RequestMapping("/applySearch.do")
	public String applySearch() {
		return "apply/applySearch";
	}
	@RequestMapping("/applyInsert.do")
	public String applyInsert(Apply a,String bookPubDates) throws ParseException {
		
//		String[] arr = a.getBookPubDate().split("/");
//		Date d = new Date(Integer.parseInt(arr[0]), Integer.parseInt(arr[1]), Integer.parseInt(arr[2]));
		
		int result = service.applyInsert(a,bookPubDates);
		if(result>0) {
			return "redirect:/";			
		}else {
			return "apply/applyApplication";			
		}
	}
}
