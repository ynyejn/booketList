package kr.or.iei.review.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.review.model.service.ReviewService;
import kr.or.iei.review.model.vo.Review;

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
	public String reviewList(Model model) {
		ArrayList<Review> list = service.selectReview();
		model.addAttribute("r",list);
		return "review/reviewList";
	}
	@RequestMapping("/reviewWriting.do")
	public String reviewWriting() {
		return "review/reviewWriting";
	}
}
