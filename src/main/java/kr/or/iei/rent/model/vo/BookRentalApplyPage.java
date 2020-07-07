package kr.or.iei.rent.model.vo;

import java.util.ArrayList;

public class BookRentalApplyPage {
	private ArrayList<RentApply> list;
	private String pageNavi;
	public BookRentalApplyPage() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BookRentalApplyPage(ArrayList<RentApply> list, String pageNavi) {
		super();
		this.list = list;
		this.pageNavi = pageNavi;
	}
	public ArrayList<RentApply> getList() {
		return list;
	}
	public void setList(ArrayList<RentApply> list) {
		this.list = list;
	}
	public String getPageNavi() {
		return pageNavi;
	}
	public void setPageNavi(String pageNavi) {
		this.pageNavi = pageNavi;
	}
	
	
}
