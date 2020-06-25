package kr.or.iei.apply.controller;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

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
	public String applyInsert(Apply a, String bookPubDates) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		java.util.Date date = null;

		try {
			date = sdf.parse(bookPubDates);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String transDate = sdf.format(date);
		Date d = Date.valueOf(transDate);

		System.out.println(d);
		a.setBookPubDate(d);
		System.out.println(a.getBookPubDate());

		int result = service.applyInsert(a);
		if (result > 0) {
			return "redirect:/";
		} else {
			return "apply/applyApplication";
		}
	}
}
