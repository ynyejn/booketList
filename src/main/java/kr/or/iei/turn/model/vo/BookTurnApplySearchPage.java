package kr.or.iei.turn.model.vo;

import java.util.ArrayList;

import lombok.Data;

public class BookTurnApplySearchPage {
	private ArrayList<TurnApply> list;
	private String pageNavi;
	private String[] arrTurnApplyDate;
	private int reqPage;
	private int selectCount;
	public BookTurnApplySearchPage() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BookTurnApplySearchPage(ArrayList<TurnApply> list, String pageNavi, String[] arrTurnApplyDate, int reqPage,
			int selectCount) {
		super();
		this.list = list;
		this.pageNavi = pageNavi;
		this.arrTurnApplyDate = arrTurnApplyDate;
		this.reqPage = reqPage;
		this.selectCount = selectCount;
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
	public String[] getArrTurnApplyDate() {
		return arrTurnApplyDate;
	}
	public void setArrTurnApplyDate(String[] arrTurnApplyDate) {
		this.arrTurnApplyDate = arrTurnApplyDate;
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
