package kr.or.iei.book.model.vo;

import java.util.ArrayList;

public class BookRentalStatusPage {
	private ArrayList<BookRentalStatus> list;
	private String pageNavi;
	public BookRentalStatusPage() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BookRentalStatusPage(ArrayList<BookRentalStatus> list, String pageNavi) {
		super();
		this.list = list;
		this.pageNavi = pageNavi;
	}
	public ArrayList<BookRentalStatus> getList() {
		return list;
	}
	public void setList(ArrayList<BookRentalStatus> list) {
		this.list = list;
	}
	public String getPageNavi() {
		return pageNavi;
	}
	public void setPageNavi(String pageNavi) {
		this.pageNavi = pageNavi;
	}
	
	
}
