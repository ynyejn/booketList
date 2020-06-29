package kr.or.iei.spot.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.spot.model.service.SpotService;
import kr.or.iei.spot.model.vo.Spot;
import kr.or.iei.spot.model.vo.SpotPageData;

@Controller
public class SpotController {
	@Autowired
	private SpotService service;
	
	@RequestMapping("/goSpotPage.do")
	public String goSpotPage(HttpServletRequest request,Model model) {
		//책번호넘기기
		String[] numbers=request.getParameterValues("bookNo");
		model.addAttribute("numbers",numbers);
		//spot정보들
		int reqPage = Integer.parseInt(request.getParameter("reqPage"));
		SpotPageData spd = service.selectAllSpot(reqPage);
		model.addAttribute("list",spd.getList());
		model.addAttribute("pageNavi",spd.getPageNavi());
		
		//lacalName
		//ArrayList<String> localName = service.selectAllLocalName();
		return "book/spotPage";
	}
}
