package kr.or.iei.member.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.iei.apply.model.vo.Apply;
import kr.or.iei.mail.util.MailSend;
import kr.or.iei.member.model.service.MemberService;
import kr.or.iei.member.model.vo.Member;
import kr.or.iei.rent.model.vo.Rent;
import kr.or.iei.reservation.model.vo.Reservation;
import kr.or.iei.review.model.vo.Review;
import kr.or.iei.usedBoard.model.vo.UsedComment;

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
	@RequestMapping(value="/joinSuccess.do")
	public String joinSuccess(@RequestBody Member member) {
		int result = service.joinSuccess(member);
		
		if(result>0) {
			System.out.println("회원가입성공");
			return "redirect:/";
		}else {
			System.out.println("회원가입 실패");
			return "member/join";
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
	public String loginMember(HttpSession session, Member m) {
		System.out.println(m.getMemberId());
		System.out.println(m.getMemberPw());
		Member member = service.selectOneMember(m);
		
		if (member != null) {
			System.out.println();
			session.setAttribute("member", member);
			return "member/mypage";
		} else {
			return "member/loginFailed";
		}
	}
	@RequestMapping(value="/mUpdate.do",method = RequestMethod.POST)
	public String update(HttpSession session,Member m) {
		int result = service.update(m);
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
	
	@RequestMapping(value="/mypage.do")
	public String mypage(HttpSession session, Model model) {
		Member m = (Member) session.getAttribute("model");
		model.addAttribute("m",m);
		return "member/mypage";
	}
	@RequestMapping(value="/delete.do", method = RequestMethod.POST)
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
	@RequestMapping("/usedCommentInsert.do")
	public String usedCommentInsert(UsedComment uc) {
		return null;
	}
	
}

