package kr.or.iei.review.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import javax.naming.spi.DirStateFactory.Result;
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
		model.addAttribute("r", list);
		return "review/reviewList";
	}

	@RequestMapping("/reviewWriting.do")
	public String reviewWriting(HttpSession session, Model model) {
		Member m = (Member) session.getAttribute("member");
		model.addAttribute("m", m);
		return "review/reviewWriting";
	}

	@RequestMapping("/reviewInsert.do")
	public String reviewInster(HttpSession session, HttpServletRequest request, MultipartFile file, String type,
			Review review, Model model) {
		Member m = (Member) session.getAttribute("member");

		if (!file.isEmpty()) {
			System.out.println(review.getReviewScore() + "점수");
			String savePath = request.getSession().getServletContext().getRealPath("resources/review/");
			String originalFileName = file.getOriginalFilename();
			String onlyFilename = originalFileName.substring(0, originalFileName.lastIndexOf("."));
			String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
			String filepath = onlyFilename + "_" + getCurrentTime() + extension;
			String fullpath = savePath + filepath;
			review.setReviewFilename(onlyFilename);
			review.setReviewFilepath("/resources/review/" + filepath);
			review.setBookName(type);
			ArrayList<Book> list = service.reviewSelectBook(m.getMemberId());
			for (Book b : list) {
				if (b.getBookName().equals(review.getBookName())) {
					System.out.println(b.getBookCategory());
					System.out.println(b.getBookPublisher());
					System.out.println(b.getBookWriter());
					review.setBookCategory(b.getBookCategory());
					review.setBookPublisher(b.getBookPublisher());
					review.setBookWriter(b.getBookWriter());
				}
			}
			System.out.println(review.getBookPublisher());
			System.out.println(review.getBookWriter());
			int result = service.reviewInsert(review);
			if (result > 0) {
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
				ArrayList<Review> list2 = service.selectReview();
				model.addAttribute("r", list2);
				return "review/reviewList";
			}else {
				ArrayList<Review> list2 = service.selectReview();
				model.addAttribute("r", list2);
				return "review/reviewList";
			}
		} else {
			System.out.println(review.getReviewScore() + "점수");
			review.setBookName(type);
			ArrayList<Book> list = service.reviewSelectBook(m.getMemberId());
			
			for (Book b : list) {
				
				if (b.getBookName().equals(review.getBookName())) {
					System.out.println(b.getBookCategory());
					System.out.println(b.getBookPublisher());
					System.out.println(b.getBookWriter());
					review.setBookCategory(b.getBookCategory());
					review.setBookPublisher(b.getBookPublisher());
					review.setBookWriter(b.getBookWriter());
				}
			}
		
			int result = service.reviewInsert(review);
			if (result > 0) {
				ArrayList<Review> list2 = service.selectReview();
				model.addAttribute("r", list2);
				return "review/reviewList";
			}else {
				ArrayList<Review> list2 = service.selectReview();
				model.addAttribute("r", list2);
				return "review/reviewList";
			}
		}
	

	}

	public long getCurrentTime() {
		Calendar today = Calendar.getInstance();

		return today.getTimeInMillis();
	}
	@ResponseBody
	@RequestMapping(value = "/rentBook.do", produces = "application/json; charset=utf-8")
	public String rentBook(String memberId,String memberNickname) {
		ArrayList<Book> list = service.reviewSelectBook(memberId);
		HashMap<String,Object> map = new HashMap<String, Object>();
		for(int i=0;i<list.size();i++) {
			System.out.println(list.get(i).getBookName());
		
				Review review = service.selectOneReview(list.get(i).getBookName(),memberNickname);
				System.out.println(review);
				if(review!=null) {
					
					map.put(list.get(i).getBookName(), list.get(i));
				}
				
			}
			for(String s : map.keySet()) {
				for(int i=0;i<list.size();i++) {
					if(list.get(i).getBookName().equals(s)) {
						System.out.println(s);
						list.remove(i);
					}
					
				}
				
			}
			
			if(list.size()!=0) {
				System.out.println("dd");
				return new Gson().toJson("1");
			}else {
				System.out.println("re");
				return new Gson().toJson("0");
			}
	}
	@ResponseBody
	@RequestMapping(value = "/reviewSelectBook.do", produces = "application/json; charset=utf-8")
	public String reviewSelectBook(String memberId, String memberNickName) {
		ArrayList<Book> list = service.reviewSelectBook(memberId);
		System.out.println(list.size());
		HashMap<String,Object> map = new HashMap<String, Object>();
			for(int i=0;i<list.size();i++) {
				System.out.println(list.get(i).getBookName());
			
					Review review = service.selectOneReview(list.get(i).getBookName(), memberNickName);
					System.out.println(review);
					if(review!=null) {
						
						map.put(list.get(i).getBookName(), list.get(i));
					}
					
				}
				for(String s : map.keySet()) {
					for(int i=0;i<list.size();i++) {
						if(list.get(i).getBookName().equals(s)) {
							System.out.println(s);
							list.remove(i);
						}
						
					}
				}
			System.out.println(map);
		
		return new Gson().toJson(list);
	}
	@RequestMapping("/reviewDelete.do")
	public String reviewDelete(HttpSession session,int reviewNo,Model model) {
		int result = service.reviewDelete(reviewNo);
		if(result>0) {
			Member m = (Member)session.getAttribute("member");
			ArrayList<Review> reviewList = service.reviewList(m.getMemberNickname());
			System.out.println(reviewList.size());
			model.addAttribute("list", reviewList);
			return "member/mypageReview";
		}else {
			Member m = (Member)session.getAttribute("member");
			ArrayList<Review> reviewList = service.reviewList(m.getMemberNickname());
			System.out.println(reviewList.size());
			model.addAttribute("list", reviewList);
			return "member/mypageReview";
		}
		
	}
	@RequestMapping("/reviewUpdateFrm.do")
	public String reviewUpdateFrm(int reviewNo,Model model) {
		System.out.println(reviewNo);
		Review r =  service.selectOneReviews(reviewNo);
		System.out.println(r.getMemberNickName());
		model.addAttribute("r", r);
		return "review/reviewUpdate";
	}
	@RequestMapping(value = "/reviewUpdate.do")
	public String noticeUpdate(HttpSession session,String status, Review r,Model model,HttpServletRequest request, MultipartFile file,String filepath1) {
		String res = "";
		
		String savePath = request.getSession().getServletContext().getRealPath("resources/review/");
		if(!file.isEmpty()) {
			if(status.equals("stay")&& file.isEmpty()) {
				
				r.setReviewFilepath(filepath1);
				int result = service.reviewUpdate(r);
				if(result>0) {
					Member m = (Member)session.getAttribute("member");
					ArrayList<Review> reviewList = service.reviewList(m.getMemberNickname());
					System.out.println(reviewList.size());
					model.addAttribute("list", reviewList);
					return "member/mypageReview";
					
				}else {
					Member m = (Member)session.getAttribute("member");
					ArrayList<Review> reviewList = service.reviewList(m.getMemberNickname());
					System.out.println(reviewList.size());
					model.addAttribute("list", reviewList);
					return "member/mypageReview";
				}
			}else {
				
				
				String originalFileName = file.getOriginalFilename();
				String onlyFilename = originalFileName.substring(0, originalFileName.lastIndexOf("."));
				String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
				String filepath = onlyFilename + "_" + getCurrentTime() + extension;
				String fullpath = savePath + filepath;
				r.setReviewFilename(onlyFilename);
				r.setReviewFilepath("/resources/review/" + filepath);
				
				
				int result = service.reviewUpdate(r);
				if(result>0) {
					if(status.equals("delete")) {
						String[] fileName = filepath1.split("/");
						File delFile = new File(savePath+fileName[3]);
						delFile.delete();
					}
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
					Member m = (Member)session.getAttribute("member");
					ArrayList<Review> reviewList = service.reviewList(m.getMemberNickname());
					System.out.println(reviewList.size());
					model.addAttribute("list", reviewList);
					return "member/mypageReview";
					
			}
			}
		}else {
			if(status.equals("delete")) {
				String[] fileName = filepath1.split("/");
				File delFile = new File(savePath+fileName[3]);
				delFile.delete();
				r.setReviewFilename("");
			}
			System.out.println("여기탄다");
			System.out.println(r.getReviewNo());
			System.out.println(r.getReviewContent());
			int result = service.reviewUpdate(r);
			if(result>0) {
				Member m = (Member)session.getAttribute("member");
				ArrayList<Review> reviewList = service.reviewList(m.getMemberNickname());
				System.out.println(reviewList.size());
				model.addAttribute("list", reviewList);
				return "member/mypageReview";
			}else {
				Member m = (Member)session.getAttribute("member");
				ArrayList<Review> reviewList = service.reviewList(m.getMemberNickname());
				System.out.println(reviewList.size());
				model.addAttribute("list", reviewList);
				return "member/mypageReview";
			}
		}
	
		return "member/mypageReview";
		
	
	}
}
