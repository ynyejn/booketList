package kr.or.iei.book.model.vo;

import java.util.ArrayList;


import lombok.Data;

@Data
public class BookData {
	ArrayList<Book> book;
	private String pageNavi;
	public BookData(ArrayList<Book> book, String pageNavi) {
		super();
		this.book = book;
		this.pageNavi = pageNavi;
	}
	public BookData() {
		super();
		// TODO Auto-generated constructor stub
	}
}
