package kr.or.iei.usedBoard.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.iei.member.model.vo.Member;
import kr.or.iei.usedBoard.model.service.UsedBoardService;
import kr.or.iei.usedBoard.model.vo.UsedBoard;
import kr.or.iei.usedBoard.model.vo.UsedBoardPageData;
import kr.or.iei.usedBoard.model.vo.UsedComment;
import kr.or.iei.usedBoard.model.vo.UsedFiles;

@Controller
public class UsedBoardController {

	@Autowired
	private UsedBoardService service;

	@RequestMapping("/goUsedBoard.do")
	private String goUsedBoard(Model model, int reqPage) {
		UsedBoardPageData upd = service.selectAllUsedList(reqPage);

		model.addAttribute("list", upd.getList());
		model.addAttribute("pageNavi", upd.getPageNavi());
		return "usedBoard/usedList";
	}

	@RequestMapping("/goAdminUsedBoard.do")
	private String goAdminUsedBoard(Model model) {
		int reqPage = 1;
		UsedBoardPageData upd = service.selectAllUsedList(reqPage);

		model.addAttribute("list", upd.getList());
		model.addAttribute("pageNavi", upd.getPageNavi());

		return "usedBoard/adminUsedList";
	}

	@RequestMapping("/goBoardWrite.do")
	private String goBoardWrite() {
		return "usedBoard/boardWrite";
	}

	@RequestMapping("/insertBoard.do")
	private String insertBoard(HttpSession session, UsedBoard ub, String bank) {
		Member m = (Member) session.getAttribute("member");
		ub.setMemberId(m.getMemberId());
		if (ub.getUsedType().equals("판매")) {
			String str = "";
			str += bank + "/" + ub.getUsedInfo();
			ub.setUsedInfo(str);
		} else {
			if (ub.getUsedInfo().equals("")) {
				ub.setUsedInfo("연예진");
			}
		}
		int result = service.insertBoard(ub);
		return "redirect:/goUsedBoard.do?reqPage=1";
	}

	@ResponseBody
	@RequestMapping(value = "/checkUsedPw.do", produces = "text/html;charset=utf-8")
	public String checkUsedPw(UsedBoard usedBoard) {
		UsedBoard ub = service.checkUsedPw(usedBoard);
		if (ub == null) {
			return "0";
		} else {
			return "1";
		}
	}

	@RequestMapping("/goBoardView.do")
	private String goBoardView(Model model, int usedNo) {
		UsedBoard ub = service.selectOneBoard(usedNo);
		ArrayList<UsedComment> uc = service.selectComment(usedNo);
		model.addAttribute("ub", ub);
		model.addAttribute("ucList",uc);
		return "usedBoard/boardView";
	}

	@RequestMapping("/deleteUsedBoard.do")
	private String deleteUsedBoard(int usedNo) {
		int result = service.deleteBoard(usedNo);
		if (result > 0) {
			System.out.println("삭제성공");
		}
		return "redirect:/goUsedBoard.do?reqPage=1";
	}

	@RequestMapping("/goModifyUsedBoard.do")
	private String goModifyUsedBoard(Model model, int usedNo) {
		UsedBoard ub = service.selectOneBoard(usedNo);	
		model.addAttribute("ub", ub);		
		return "usedBoard/modifyBoard";
	}

	@RequestMapping("/usedCommentInsert.do")
	public String usedCommentInsert(HttpServletRequest request, MultipartFile files[], UsedComment uc)
			throws ServletException, IOException {
		// 업로드경로잡으려고 HttpServletRequest객체
		// 우리가올린파일 MultipartFile, 나머지 notice
		System.out.println(files.length);
		ArrayList<UsedFiles> fileList = new ArrayList<UsedFiles>();
		// 배열로 들어옴, 들어있지않으면
		for(int i=0; i<files.length;i++) {
			if (!files[i].isEmpty()) {
				String savePath = request.getSession().getServletContext().getRealPath("/resources/upload/usedBoard/");
				// 업로드된 실제 파일명 얻어옴 ->test.txt
				String originalFilename = files[i].getOriginalFilename();
				// 확장자를 제외한 파일명 ->test
				String onlyFilename = originalFilename.substring(0, originalFilename.lastIndexOf("."));
				// 확장자-> .txt
				String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
				String filepath = onlyFilename + "_" + getCurrentTime() + extension;
				String fullpath = savePath + filepath;
				UsedFiles uf = new UsedFiles();
				uf.setCommentFilename(originalFilename);
				uf.setCommentFilepath(filepath);
				fileList.add(uf);
				try {
					byte[] bytes = files[i].getBytes();
					BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(new File(fullpath)));
					bos.write(bytes);
					bos.close();
					System.out.println("파일업로드 완료");
				} catch (IOException e) {
					e.printStackTrace();
				}
			}		
		}
		int result = service.insertComment(uc,fileList);
		if (result > 1) {
			System.out.println("댓글 등록성공");
		} else {
			System.out.println("댓글 등록실패");
		}

		return "redirect:/goBoardView.do?usedNo="+uc.getUsedNo();
	}
	
	public long getCurrentTime() {
		Calendar today = Calendar.getInstance();
		return today.getTimeInMillis();
	}
}
