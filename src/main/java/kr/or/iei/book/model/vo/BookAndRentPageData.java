package kr.or.iei.book.model.vo;

import java.util.ArrayList;

import lombok.Data;

@Data
public class BookAndRentPageData {
	private ArrayList<BookAndRent> list;
	private String pageNavi;
	public BookAndRentPageData(ArrayList<BookAndRent> list, String pageNavi) {
		super();
		this.list = list;
		this.pageNavi = pageNavi;
	}
	public BookAndRentPageData() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}
