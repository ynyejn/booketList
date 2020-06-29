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
	public String goSpotPage(HttpServletRequest request,Model model,int reqPage,String localName,String keyword) {
		//책번호넘기기
		String[] bookNo=request.getParameterValues("bookNo");
		model.addAttribute("bookNo",bookNo);
		//spot정보들
		SpotPageData spd = service.selectAllSpot(reqPage,localName,keyword,bookNo);
		model.addAttribute("list",spd.getList());
		model.addAttribute("pageNavi",spd.getPageNavi());
		//lacalName list
		ArrayList<String> localList = service.selectAllLocalName();
		model.addAttribute("localList",localList);
		
		//검색
		model.addAttribute("localName",localName);
		model.addAttribute("keyword",keyword);
		return "book/spotPage";
	}
}
