package kr.or.iei.complain.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;

import kr.or.iei.complain.model.service.ComplainService;
import kr.or.iei.complain.model.vo.Complain;

@Controller
@RequestMapping("/complain")
public class ComplainController {
	@Autowired
	@Qualifier("complainService")
	private ComplainService service;

	public ComplainController() {
		super();
		// TODO Auto-generated constructor stub
	}
	@RequestMapping("/complain.do")
	public String complain(String memberIds,String fileName,String complainContent,Model model) {
		System.out.println(memberIds);
		System.out.println(fileName);
		System.out.println(complainContent);
		model.addAttribute("memberIds",memberIds);
		model.addAttribute("fileName",fileName);
		model.addAttribute("complainContent",complainContent);
		return "complain/complain";
	}
	@RequestMapping("/complainInsert.do")
	public String complainInsert(HttpServletRequest request,String fileName,Complain c,HttpServletResponse response) {
		if(!fileName.equals(null)) {
				try {
					System.out.println("/"+fileName);
					String[] filepame = fileName.split("/");
					System.out.println("/"+fileName);
					//1)결로 설정
					String root1 = request.getSession().getServletContext().getRealPath("resources/complain/");
					String root = request.getSession().getServletContext().getRealPath("resources/chat/");
					FileInputStream fis;
					System.out.println("/"+fileName);
					System.out.println("/"+fileName);
					fis = new FileInputStream(root+filepame[3]);
					FileOutputStream fos = new FileOutputStream(root1+filepame[3]);
					int data;
					byte[] readBy = new byte[200];
					while ((data=fis.read(readBy))!=-1) {
						fos.write(readBy,0,data);
						
					}
					fos.flush();
					fos.close();
					fis.close();
					c.setComplainContent("/resources/complain/"+filepame[3]);
					System.out.println(c.getAttacker());
					System.out.println(c.getComplainCategory());
					System.out.println(c.getComplainContent());
					System.out.println(c.getMemberId());
					System.out.println("파일 업로드 완료");
					int result = service.complainInsert(c);
					if(result>0) {
						return "complain/complainSuccess";
					}else {
						return "complain/complainFull";
					}
				} catch (FileNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}else {
			int result = service.complainInsert(c);
			if(result>0) {
				return "complain/complainSuccess";
			}else {
				return "complain/complainFull";
			}
		}
	
		return null;
	}
}
