package kr.or.iei.mail.util;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;

import kr.or.iei.member.model.service.MemberService;
import kr.or.iei.member.model.vo.Member;

public class MailSendPw {
	
	public String mailSendPw(Member m) {
		// 1.랜덤코드 생성
		Random r = new Random();
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < 6; i++) {
			sb.append(r.nextInt(10));
		}
		System.out.println(sb.toString());
		System.out.println(m.getMemberId());
		System.out.println(m.getMemberEmail());
		// 2. 메일 설정(사용할 메일 서버 설정)
		Properties prop = System.getProperties();
		prop.put("mail.smtp.host", "smtp.gmail.com");
		prop.put("mail.smtp.port", 465);
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.ssl.enable", "true");
		prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		
		
			// 3. 메일 계정 정보 설정
			Session session = Session.getDefaultInstance(prop, new Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication("booketlistmaster@gmail.com", "book1234**");
				}
			});
			MimeMessage msg = new MimeMessage(session);
			try {
				msg.setSentDate(new Date());
				msg.setFrom(new InternetAddress("booktetlistmaster@gmail.com", "북킷리스트"));
				InternetAddress to = new InternetAddress(m.getMemberEmail());
				msg.setRecipient(Message.RecipientType.TO, to);

				msg.setSubject("북킷리스트 임시비밀번호입니다.", "UTF-8");
				msg.setContent("<h1>북킷리스트 임시비밀번호입니다.</h1><h3>임시비밀번호[" + sb.toString() + "]입니다.</h3>",
						"text/html;charset=UTF-8");
				Transport.send(msg);
			} catch (MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return sb.toString();
		}
		
	}

	
		
	

