package kr.or.iei.book.model.vo;

import java.util.ArrayList;
import java.util.HashMap;

import lombok.Data;

@Data
public class BookAndReviewPageData {
	ArrayList<BookAndReview> list;
	private String pageNavi;
	public BookAndReviewPageData(ArrayList<BookAndReview> list, String pageNavi) {
		super();
		this.list = list;
		this.pageNavi = pageNavi;
	}
	public BookAndReviewPageData() {
		super();
	}

	

}
