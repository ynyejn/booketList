package kr.or.iei.turn.model.vo;

import java.util.ArrayList;

public class BookTurnApplyPage {
	private ArrayList<TurnApply> list;
	private String pageNavi;
	public BookTurnApplyPage() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BookTurnApplyPage(ArrayList<TurnApply> list, String pageNavi) {
		super();
		this.list = list;
		this.pageNavi = pageNavi;
	}
	public ArrayList<TurnApply> getList() {
		return list;
	}
	public void setList(ArrayList<TurnApply> list) {
		this.list = list;
	}
	public String getPageNavi() {
		return pageNavi;
	}
	public void setPageNavi(String pageNavi) {
		this.pageNavi = pageNavi;
	}
	
	
}
