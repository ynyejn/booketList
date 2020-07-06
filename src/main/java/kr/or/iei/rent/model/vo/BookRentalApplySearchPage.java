package kr.or.iei.rent.model.vo;

import java.util.ArrayList;

public class BookRentalApplySearchPage {
	private ArrayList<RentApply> list;
	private String pageNavi;
	private String[] arrRentApplyDate;
	private int reqPage;
	private int selectCount;
	public BookRentalApplySearchPage() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BookRentalApplySearchPage(ArrayList<RentApply> list, String pageNavi, String[] arrRentApplyDate, int reqPage,
			int selectCount) {
		super();
		this.list = list;
		this.pageNavi = pageNavi;
		this.arrRentApplyDate = arrRentApplyDate;
		this.reqPage = reqPage;
		this.selectCount = selectCount;
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
	public String[] getArrRentApplyDate() {
		return arrRentApplyDate;
	}
	public void setArrRentApplyDate(String[] arrRentApplyDate) {
		this.arrRentApplyDate = arrRentApplyDate;
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
