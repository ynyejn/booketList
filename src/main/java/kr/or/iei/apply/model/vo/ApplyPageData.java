package kr.or.iei.apply.model.vo;

import java.util.ArrayList;

public class ApplyPageData {
	private ArrayList<Apply> list;
	private String pageNavi;
	public ApplyPageData() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ApplyPageData(ArrayList<Apply> list, String pageNavi) {
		super();
		this.list = list;
		this.pageNavi = pageNavi;
	}
	public ArrayList<Apply> getList() {
		return list;
	}
	public void setList(ArrayList<Apply> list) {
		this.list = list;
	}
	public String getPageNavi() {
		return pageNavi;
	}
	public void setPageNavi(String pageNavi) {
		this.pageNavi = pageNavi;
	}
	
	
}
