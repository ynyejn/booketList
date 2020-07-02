package kr.or.iei.member.controller;

import java.io.UnsupportedEncodingException;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.iei.mail.util.MailSend;
import kr.or.iei.member.model.service.MemberService;
import kr.or.iei.member.model.vo.Member;

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
		Member member = service.selectOne(m);
		if (member != null) {
			session.setAttribute("member", member);
			return "redirect:/";
		} else {
			return "member/loginFailed";
		}
	}
		@RequestMapping(value = "/loginFrm.do")
		public String loginMember() {
			
				return "member/login";
			
	}
	
	
	

}
