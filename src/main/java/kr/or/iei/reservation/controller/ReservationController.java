package kr.or.iei.reservation.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.iei.member.model.vo.Member;
import kr.or.iei.reservation.model.service.ReservationService;
import kr.or.iei.reservation.model.vo.Reservation;

@Controller
@RequestMapping("/reservation")
public class ReservationController {
	
	
	@Autowired
	@Qualifier("reservationService")
	private ReservationService service;
	
	@ResponseBody
	@RequestMapping(value="/insertReservation.do", method = RequestMethod.GET)
	public int insertReservation (String resVal) {
		//로그인 된 아이디 받기
		//Member member = session.getAttribute("member");
		
		//임시//
		Member member = new Member();
		member.setMemberId("user01");
		///////
		Reservation r = new Reservation();
		r.setMemberId(member.getMemberId());
		r.setBookName(resVal.split("~구분~")[0]);
		r.setBookWriter(resVal.split("~구분~")[1]);
		r.setBookPublisher(resVal.split("~구분~")[2]);
		r.setBookCategory(resVal.split("~구분~")[3]);
		
		Reservation resultR = service.searchReservation(r);
//		int result1 = service.searchReservation(r);
		System.out.println(resultR);
		if(resultR == null) {
			System.out.println("인서트하자");
			int result2 = service.insertReservation(r);			
			System.out.println("인서트했어");
			return result2;
		}else {
			return -1;
		}
	}
	

}
