package kr.or.iei.reservation.model.vo;

import java.util.ArrayList;




public class ReservationPage {
	private ArrayList<Reservation> list;
	private String pageNavi;
	public ReservationPage() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ReservationPage(ArrayList<Reservation> list, String pageNavi) {
		super();
		this.list = list;
		this.pageNavi = pageNavi;
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
	
	
}
