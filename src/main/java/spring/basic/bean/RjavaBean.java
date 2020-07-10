package spring.basic.bean;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import kr.or.iei.book.model.vo.BookAndRent;
import kr.or.iei.member.model.vo.Member;
import kr.or.iei.rent.model.service.RentService;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.rosuda.REngine.REXP;
import org.rosuda.REngine.RList;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RFileInputStream;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;




@Controller
@RequestMapping("/rjava")
public class RjavaBean {
	
	@Autowired
	@Qualifier("rentService")
	private RentService rentService;
	
	@RequestMapping(value="/connection.do")
	public String connection(Model model, HttpSession session) throws Exception { //예외 처리
		Member member = (Member)session.getAttribute("member");
		ArrayList<BookAndRent> userRentList = rentService.selectUserList(member);
		if(userRentList.size()>0) {
			RConnection conn = new RConnection();    //RConnection 객체 선언

			conn.eval("library('tidyverse')");
			conn.eval("library('KoNLP')");
			conn.eval("useNIADic()");
			conn.eval("library('reshape2')");
			conn.eval("library('wordcloud2')");
			conn.eval("library(htmlwidgets)");
			conn.eval("library('rvest')");
			conn.eval("library('R6')");
			conn.eval("library(htmltools)");

			String bookName = "bookName <- ";
			String bookCategory = "bookCateogry <- ";
			String bookWriter = "bookWriter <- ";
			String bookPublisher = "bookPublisher <- ";
			String bookContent = "bookContent <- ";
			for(int i=0; i<userRentList.size(); i++) {
				bookName += userRentList.get(i).getBookName() + " ";
				bookCategory += userRentList.get(i).getBookName()+ " ";
				bookWriter += userRentList.get(i).getBookName()+ " ";
				bookPublisher += userRentList.get(i).getBookName()+ " ";
				bookContent += userRentList.get(i).getBookContent()+ " ";
			}
			conn.assign("b1", bookName);
			conn.assign("b2", bookCategory);
			conn.assign("b3", bookWriter);
			conn.assign("b4", bookPublisher);
			conn.assign("b5", bookContent);
//			REXP b11 = conn.eval(bookName);
//			REXP b12 = conn.eval(bookCategory);
//			REXP b13 = conn.eval(bookWriter);
//			REXP b14 = conn.eval(bookPublisher);
			REXP b4 = conn.eval("b11 <- c(b1, b2, b3, b4, b5)");
			REXP b5 = conn.eval("b011 <- SimplePos09(b11)");
			REXP b6 = conn.eval("b0111 <- b011 %>% melt %>% as_tibble");
			REXP b7 = conn.eval("b0111 <- b0111[, c(3, 1)]");
			REXP b8 = conn.eval("b1111 <- b0111 %>% mutate(noun=str_match(value, '([가-힣]+)/N')[,2]) %>% na.omit %>% filter(str_length(noun)>=2) %>% count(noun, sort=TRUE) %>% wordcloud2(fontFamily='Noto Sans CJK KR Bold', color='random-light')");
			REXP b91 = conn.eval("ren <- renderTags(b1111)");
			String result = conn.eval("ren$html").asString();
			model.addAttribute("result",result);

			
			
//			REXP b91 = conn.eval("setwd('C:/tempTest')");
//			REXP b10 = conn.parseAndEval("saveWidget(b1111, '12344321.html',selfcontained = F)");
//			REXP b11 = conn.eval("htxt <- read_html(\"C:/tempTest/12344321.html\")");
//			REXP b20 = conn.eval("tt <- coerce(htxt, 'character', strict = TRUE)");
//			REXP b12 = conn.eval("tt");
//			System.out.println(b20.asString());
//			String style = "<style>" + b20.asString().split("<style>")[1].split("</style>")[0] + "</style>";
//			String script = b20.asString().split("</style>")[1].split("</title>")[0];
//			script += b20.asString().split("</div>")[2].split("</body>")[0];
//			String body = b20.asString().split("<body>")[1].split("</div>")[0]+ "</div>\n</div>";
//			
//			System.out.println(style);
//			System.out.println(script);
//			System.out.println(body);
//			model.addAttribute("scriptTag", script);
//			conn.close();   //필수요소. 다시 실행될 때 리로딩 됨 (끊고-실행을 반복해야 함)
//			String styleScriptBody = style + "~구분~" + script + "~구분~" + body;
//			return new Gson().toJson(b9);
//			System.out.println(b12.asString());
			return "rjava/wcloud2";
		}else {
			return "none";
		}
	}
	
	@RequestMapping("/word.do")
	public void WordCloud(HttpServletResponse response, String htmlText) throws IOException{
		response.getWriter().print(htmlText);
	}
	
}
