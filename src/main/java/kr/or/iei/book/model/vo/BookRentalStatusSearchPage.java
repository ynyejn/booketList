package kr.or.iei.book.model.vo;

import java.util.ArrayList;

public class BookRentalStatusSearchPage {
	private ArrayList<BookRentalStatus> list;
	private String pageNavi;
	private String[] arrRentStartDate;
	private String[] arrRentEndDate;
	private int reqPage;
	private int selectCount;
	private String[] compareStatus;
	public BookRentalStatusSearchPage() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BookRentalStatusSearchPage(ArrayList<BookRentalStatus> list, String pageNavi, String[] arrRentStartDate,
			String[] arrRentEndDate, int reqPage, int selectCount, String[] compareStatus) {
		super();
		this.list = list;
		this.pageNavi = pageNavi;
		this.arrRentStartDate = arrRentStartDate;
		this.arrRentEndDate = arrRentEndDate;
		this.reqPage = reqPage;
		this.selectCount = selectCount;
		this.compareStatus = compareStatus;
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
	public String[] getArrRentStartDate() {
		return arrRentStartDate;
	}
	public void setArrRentStartDate(String[] arrRentStartDate) {
		this.arrRentStartDate = arrRentStartDate;
	}
	public String[] getArrRentEndDate() {
		return arrRentEndDate;
	}
	public void setArrRentEndDate(String[] arrRentEndDate) {
		this.arrRentEndDate = arrRentEndDate;
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
	public String[] getCompareStatus() {
		return compareStatus;
	}
	public void setCompareStatus(String[] compareStatus) {
		this.compareStatus = compareStatus;
	}
 	
}
