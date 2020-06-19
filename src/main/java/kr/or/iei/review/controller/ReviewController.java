package kr.or.iei.review.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.review.model.service.ReviewService;

@Controller
@RequestMapping("/review")
public class ReviewController {
	@Autowired
	@Qualifier("reviewService")
	private ReviewService service;
	public ReviewController() {
		super();
		// TODO Auto-generated constructor stub
	}
	@RequestMapping("/reviewList.do")
	public String reviewList() {
		return "review/reviewList";
	}
}
