package kr.or.iei.spot.model.vo;

import java.util.ArrayList;


public class SpotSearchPage {
	
	private ArrayList<Spot> list;
	private String pageNavi;
	private int reqPage;
	private int selectCount;
	public SpotSearchPage() {
		super();
		// TODO Auto-generated constructor stub
	}
	public SpotSearchPage(ArrayList<Spot> list, String pageNavi, int reqPage, int selectCount) {
		super();
		this.list = list;
		this.pageNavi = pageNavi;
		this.reqPage = reqPage;
		this.selectCount = selectCount;
	}
	public ArrayList<Spot> getList() {
		return list;
	}
	public void setList(ArrayList<Spot> list) {
		this.list = list;
	}
	public String getPageNavi() {
		return pageNavi;
	}
	public void setPageNavi(String pageNavi) {
		this.pageNavi = pageNavi;
	}
	public int getReqPage() {
		return reqPage;
	}
	public void setReqPage(int reqPage) {
		this.reqPage = reqPage;
	}
	public int getSelectCount() {
		return selectCount;
	}
	public void setSelectCount(int selectCount) {
		this.selectCount = selectCount;
	}
	
	
}
