package kr.or.iei.review.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import kr.or.iei.book.model.vo.Book;
import kr.or.iei.member.model.vo.Member;
import kr.or.iei.review.model.service.ReviewService;
import kr.or.iei.review.model.vo.Review;

@Controller
@RequestMapping("/review")
public class ReviewController {
	@Autowired
	@Qualifier("reviewService")
	private ReviewService service;
	public ReviewController() {
		super();
		// TODO Auto-generated constructor stub
	}
	@RequestMapping("/reviewList.do")
	public String reviewList(Model model) {
		ArrayList<Review> list = service.selectReview();
		model.addAttribute("r",list);
		return "review/reviewList";
	}
	@RequestMapping("/reviewWriting.do")
	public String reviewWriting(HttpSession session,Model model) {
		Member m = (Member)session.getAttribute("member");
		model.addAttribute("m",m);
		return "review/reviewWriting";
	}
	@RequestMapping("/reviewInsert.do")
	public String reviewInster(HttpServletRequest request,MultipartFile file,String type,Review review) {
		String memberId = "user01";
		if(!file.isEmpty()) {
			String savePath = request.getSession().getServletContext().getRealPath("resources/review/");
			String originalFileName = file.getOriginalFilename();
			String onlyFilename = originalFileName.substring(0, originalFileName.lastIndexOf("."));
			String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
			String filepath =  onlyFilename+"_"+getCurrentTime()+extension;
			String fullpath = savePath+filepath;
			review.setReviewFilename(onlyFilename);
			review.setReviewFilepath(filepath);
			review.setBookName(type);
			ArrayList<Book> list = service.reviewSelectBook(memberId);
			for(Book b : list) {
				if(b.getBookName()==type) {
					System.out.println(b.getBookCategory());
					System.out.println(b.getBookPublisher());
					System.out.println(b.getBookWriter());
					review.setBookCategory(b.getBookCategory());
					review.setBookPublisher(b.getBookPublisher());
					review.setBookWriter(b.getBookWriter());
				}
			}
			int result = service.reviewInsert(review);
			if(result>0) {
				try {
					byte[] bytes = file.getBytes();
					BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(new File(fullpath)));
					bos.write(bytes);
					bos.close();
					System.out.println("파일 업로드 완료");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}	
			}
		}else {
			review.setBookName(type);
			ArrayList<Book> list = service.reviewSelectBook(memberId);
			for(Book b : list) {
				if(b.getBookName()==type) {
					System.out.println(b.getBookCategory());
					System.out.println(b.getBookPublisher());
					System.out.println(b.getBookWriter());
					review.setBookCategory(b.getBookCategory());
					review.setBookPublisher(b.getBookPublisher());
					review.setBookWriter(b.getBookWriter());
				}
			}
			int result = service.reviewInsert(review);
			if(result>0) {
				return "review/reviewList";
			}
		}
		return "review/reviewList";
	}
	public long getCurrentTime() {
		Calendar today = Calendar.getInstance();
		
		return today.getTimeInMillis();
	}
	@ResponseBody
	@RequestMapping(value = "/reviewSelectBook.do",produces = "application/json; charset=utf-8")
	public String reviewSelectBook(String memberId) {
		ArrayList<Book> list = service.reviewSelectBook(memberId);
		System.out.println(list.size());
		return new Gson().toJson(list);
	}
}
