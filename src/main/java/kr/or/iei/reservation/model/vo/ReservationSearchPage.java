package kr.or.iei.reservation.model.vo;

import java.util.ArrayList;


public class ReservationSearchPage {
	private ArrayList<Reservation> list;
	private String pageNavi;
	private String[] arrReserveDate;
	private int reqPage;
	private int selectCount;
	public ReservationSearchPage() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ReservationSearchPage(ArrayList<Reservation> list, String pageNavi, String[] arrReserveDate, int reqPage,
			int selectCount) {
		super();
		this.list = list;
		this.pageNavi = pageNavi;
		this.arrReserveDate = arrReserveDate;
		this.reqPage = reqPage;
		this.selectCount = selectCount;
	}
	public ArrayList<Reservation> getList() {
		return list;
	}
	public void setList(ArrayList<Reservation> list) {
		this.list = list;
	}
	public String getPageNavi() {
		return pageNavi;
	}
	public void setPageNavi(String pageNavi) {
		this.pageNavi = pageNavi;
	}
	public String[] getArrReserveDate() {
		return arrReserveDate;
	}
	public void setArrReserveDate(String[] arrReserveDate) {
		this.arrReserveDate = arrReserveDate;
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
