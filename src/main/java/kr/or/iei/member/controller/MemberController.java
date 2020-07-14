package kr.or.iei.member.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.iei.apply.model.vo.Apply;
import kr.or.iei.book.model.vo.BookAndRent;
import kr.or.iei.mail.util.MailSend;
import kr.or.iei.mail.util.MailSendId;
import kr.or.iei.mail.util.MailSendPw;
import kr.or.iei.member.model.service.MemberService;
import kr.or.iei.member.model.vo.Member;
import kr.or.iei.rent.model.vo.Rent;
import kr.or.iei.reservation.model.vo.Reservation;
import kr.or.iei.review.model.vo.Review;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	@Qualifier("memberService")
	private MemberService service;
	
	public MemberController() {
		super();
	}
	@RequestMapping(value="/join.do")
	public String join(Member m) {
	
		return "member/join";
	}
	
	@RequestMapping(value="/joinSuccess.do", method = RequestMethod.POST, produces="application/json;charset=utf-8")
	@ResponseBody
	public String joinSuccess(@RequestBody Member member) {
		int result = service.joinSuccess(member);
		if(result>0) {
			System.out.println("회원가입성공");
			return "1";
		}else {
			System.out.println("회원가입 실패");
			return "0";
		}
	}
	@ResponseBody//값만 받을 때 사용
	@RequestMapping(value="checkId.do",produces ="text/html;charset=utf-8")
	public String checkId(String memberId) {
		Member member = service.checkId(memberId);
		if(member == null) {
			System.out.println("사용가능한 아이디입니다.");
			return "0";
		}else {
			System.out.println("중복된 아이디입니다.");
			return "1";
		}
	}
	@ResponseBody//값만 받을 때 사용
	@RequestMapping(value="checkNickname.do",produces ="text/html;charset=utf-8")
	public String checkNickname(String memberNickname) {
		Member m = service.checkNickname(memberNickname);
		if(m == null) {
			System.out.println("사용가능한 닉네임입니다.");
			return "0";
		}else {
			System.out.println("중복된 닉네임입니다.");
			return "1";
		}
	
	}
	@ResponseBody
	@RequestMapping(value = "sendMail.do", method = RequestMethod.POST, produces = "text/html;charset=utf-8")
	public String sendMail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String email = request.getParameter("mail");
		String mailCode = new MailSend().mailSend(email);
		return mailCode;
	}
	@RequestMapping(value = "/login.do")
	public String loginMember(HttpSession session, Member m,Model model) {
		System.out.println(m.getMemberId());
		System.out.println(m.getMemberPw());
		Member member = service.selectOneMember(m);
		
		if (member != null) {
			if(member.getMemberId().equals("admin")) {
				System.out.println("ASDfasdfasdf"+member.getMemberId());
				session.setAttribute("member", member);
				return "redirect:/adminPage.do";
			}else {
				System.out.println("ASDfasdfasdf"+member.getMemberId());
				session.setAttribute("member", member);
				return "redirect:/";
			}
			
		} else {
			model.addAttribute("fail", 5);
			return "member/login";
		}
	}
	@RequestMapping(value="/mUpdate.do",method = RequestMethod.POST)
	public String update(HttpSession session,Member m) throws Exception {
		int result = service.update(m);
		System.out.println("수정된 데이터");
		if(result>0) {
			session.setAttribute("member", m);
			System.out.println("회원정보가 수정되었습니다.");
			return "redirect:/";
			
		}else {
			System.out.println("회원정보가 수정되지 않았습니다.");
			return "member/mypage";
		}
	}
	@RequestMapping(value = "/loginFrm.do")
	public String loginMember() {
		
		return "member/login";	
	}
	@RequestMapping(value="/logout.do")
	public String logoutMember(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	@RequestMapping(value="/loginFailed.do")
	public String loginFailed() {
	
		return "member/login";
	}
	
	@RequestMapping(value="/mypage.do")
	public String mypage(HttpSession session, Model model) {
		Member m = (Member) session.getAttribute("model");
		model.addAttribute("m",m);
		return "member/mypage";
	}
	@RequestMapping("/rentUpdate.do")
	public String rentUpdate(int rentNo) {
		int result = service.rentUpdate(rentNo);
		if(result>0) {
			return "member/mypageRent";
		}else {
			return "member/mypage";
		}
	}
	@RequestMapping(value="/delete.do", method = {RequestMethod.POST,RequestMethod.GET})
	public String delete(HttpSession session) {
		Member m = (Member)session.getAttribute("member");
		int result = service.delete(m.getMemberId());
		if(result>0) {
			
			session.invalidate();
			return "redirect:/";
		}else {
			return "member/mypage";
		}
	}
	@RequestMapping(value = "/mypageReviewFrm.do")
	public String reviewList(HttpSession session, Model model) {
		Member m = (Member)session.getAttribute("member");
		ArrayList<Review> reviewList = service.reviewList(m.getMemberNickname());
		System.out.println(reviewList.size());
		model.addAttribute("list", reviewList);
		return "member/mypageReview";
	}
	@RequestMapping(value = "/mypageApplyFrm.do")
	public String applyList(HttpSession session, Model model) {
		Member m = (Member)session.getAttribute("member");
		ArrayList<Apply> applyList = service.applyList(m.getMemberId());
		System.out.println(applyList.size());
		model.addAttribute("list", applyList);
		return "member/mypageApply";
	}
	@RequestMapping(value = "/mypageReservationFrm.do")
	public String reservationList(HttpSession session, Model model) {
		Member m = (Member)session.getAttribute("member");
		ArrayList<Reservation> reservationList = service.reservationList(m.getMemberId());
		System.out.println(reservationList.size());
		model.addAttribute("list", reservationList);
		return "member/mypageReservation";
	}
	@RequestMapping(value = "/mypageRentFrm.do")
	public String rentList(HttpSession session, Model model) {
		Member m = (Member)session.getAttribute("member");
		ArrayList<Rent> rentList = service.rentList(m.getMemberId());
		System.out.println(rentList.size());
		model.addAttribute("list", rentList);
		return "member/mypageRent";
	}
	
	@RequestMapping(value="/findPwFrm.do")
	public String findPwFrm() throws Exception{
		return "/member/findPwFrm";
	}
	@ResponseBody
	@RequestMapping(value = "/findPw.do")
	public String sendMailPw(String id,String email) throws Exception {
		Member m = new Member();
		System.out.println(id);
		System.out.println(email);
		m.setMemberId(id);
		m.setMemberEmail(email);
		Member member = service.selectIdMember(m);
		if(member!=null) {
			String mailCode = new MailSendPw().mailSendPw(m);
			m.setMemberPw(mailCode);
			int result = service.updatePw(m);
			if(result>0) {
				
				return mailCode;
			}else {
				return "없어";
			}
		}else{
			return "없어";
		}
		
	}
	@RequestMapping(value="/findIdFrm.do")
	public String findIdFrm() throws Exception{
		return "/member/findIdFrm";
	}
	@ResponseBody
	@RequestMapping(value = "/findId.do")
	public String sendMailId(String email,String phone) throws Exception {
		Member m = new Member();
		
		m.setMemberEmail(email);
		m.setMemberPhone(phone);
			
		Member member = service.selectId(m);
		if(member!=null) {
			member.setMemberEmail(email);
			member.setMemberPhone(phone);
			String mailCode = new MailSendId().mailSendId(member);
			member.setMemberId(mailCode);
				return mailCode;
			}else {
				return "없어";
			}
		}
	@RequestMapping(value = "/mypageLostBookFrm.do")
	public String mypageLostBookFrm(HttpSession session,Model model) {
		Member m = (Member)session.getAttribute("member");
//		System.out.println(m.getMemberId());
		ArrayList<BookAndRent> list = (ArrayList<BookAndRent>)service.userLostBook(m);
		System.out.println(list);
		model.addAttribute("list", list);
		return "member/mypageLostBook";
	}
	}

