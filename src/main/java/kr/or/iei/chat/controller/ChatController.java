package kr.or.iei.chat.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.ServletOutputStream;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import kr.or.iei.chat.model.service.ChatService;
import kr.or.iei.chat.model.vo.Chat;
import kr.or.iei.member.model.vo.Member;

@Controller
@RequestMapping("/chat")
public class ChatController {
	@Autowired
	@Qualifier("chatService")
	private ChatService service;

	public ChatController() {
		super();
		// TODO Auto-generated constructor stub
	}

	@RequestMapping("makingRoomFrm.do")
	public String makingRoomFrm(HttpSession session, Model model) {
		Member m = (Member) session.getAttribute("member");
		model.addAttribute("m", m);
		return "openChatting/makingRoom";
	}

	@RequestMapping(value = "/openChatting.do")
	public String openChatting(Model model) {
		ArrayList<Chat> arrChat = service.selectOpenChatting();
		model.addAttribute("openChatting", arrChat);
		return "openChatting/openChatting";
	}

	@RequestMapping("/chat.do")
	public String chat(Chat c, Model model, String memberNickname,HttpSession session) {
			model.addAttribute("c", c);
			return "openChatting/chat";
		
	}
	@RequestMapping("/chatRoom.do")
	public String chatRoom(String title,Model model) {
		String chatTitle=service.selectOpenTitle(title);
		if(chatTitle==null) {
			return "openChatting/chatTitleFull";
		}else {
			
			int result = service.chatUpdate(title);
			Chat c = new Chat();
			c.setChatTitle(title);
			System.out.println("gdgd");
			if(result>0) {
				model.addAttribute("c",c);
				System.out.println("gdgd");
				return "openChatting/chat";	
			}else {
				System.out.println("gdgd");
				return "openChatting/chatFull";
			}
		}
	}
	@ResponseBody
	@RequestMapping(value = "/ajaxFormReceive.do",produces = "application/json; charset=utf-8")
	public String fileInsert(HttpServletRequest request,MultipartFile file) {
		if(!file.isEmpty()) {
			String savePath = request.getSession().getServletContext().getRealPath("resources/chat/");
			String originalFileName = file.getOriginalFilename();
			String onlyFilename = originalFileName.substring(0, originalFileName.lastIndexOf("."));
			String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
			String filepath =  onlyFilename+"_"+extension;
			String fullpath = savePath+filepath;
			String fileName = "/resources/chat/"+filepath;
			System.out.println(fileName);
			System.out.println(savePath);
			System.out.println(originalFileName);
			System.out.println(onlyFilename);
			System.out.println(extension);
			System.out.println(filepath);
			System.out.println(fullpath);
			byte[] bytes;
			try {
				bytes = file.getBytes();
				BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(new File(fullpath)));
				bos.write(bytes);
				bos.close();
				System.out.println("파일 업로드 완료");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return new Gson().toJson(fileName);
		}else {
			return new Gson().toJson("0");
		}
		
	}
	@RequestMapping("/fileDownload.do")
	public String fileDownload(HttpServletRequest request,HttpServletResponse response,String filepath){
		//1.인코딩
				try {
					
					System.out.println("/"+filepath);
					String[] fileName = filepath.split("/");
					
					//1)결로 설정
					String root = request.getSession().getServletContext().getRealPath("resources/");
					String saveDirectory = root+"chat/";
					//파일이랑 서블릿연결
					FileInputStream fis = new FileInputStream(saveDirectory+fileName[3]);
					//속도를 위한 보조 스트림 생성
					BufferedInputStream bis = new BufferedInputStream(fis);
					//파일을 내보내기 위한 스트림 생성
					ServletOutputStream sos = response.getOutputStream();
					BufferedOutputStream bos = new BufferedOutputStream(sos);
					String resFilename = "";
					//브라우저가 IE인지 확인
					boolean bool = request.getHeader("user-agent").indexOf("MSIE") != -1 || request.getHeader("user-agent").indexOf("Trident") != -1;
					System.out.println("ie여부 :"+bool);
					if(bool){
						//ie인경우
						resFilename = URLEncoder.encode(fileName[3], "UTF-8");
						resFilename = resFilename.replaceAll("\\\\", "%20");
					}else {
						resFilename = new String(fileName[3].getBytes("UTF-8"),"ISO-8859-1");
					}
					//파일 다운로드 위한 HTTP Header설정
					response.setContentType("application/octet-stream");
					response.setHeader("Content-Disposition", "attachment;filename="+resFilename);
					int read = -1;
					while((read = bis.read())!= -1) {
						bos.write(read);
					}
					bos.close();
					bis.close();
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				return null;
				
	}
}
