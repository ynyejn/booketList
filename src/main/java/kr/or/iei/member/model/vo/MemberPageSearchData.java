package kr.or.iei.member.model.vo;

import java.util.ArrayList;

public class MemberPageSearchData {
	private ArrayList<Member> list;
	private String pageNavi;
	private String[] arrEnrollDate;
	private int reqPage;
	private int selectCount;
	public MemberPageSearchData() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MemberPageSearchData(ArrayList<Member> list, String pageNavi, String[] arrEnrollDate, int reqPage,
			int selectCount) {
		super();
		this.list = list;
		this.pageNavi = pageNavi;
		this.arrEnrollDate = arrEnrollDate;
		this.reqPage = reqPage;
		this.selectCount = selectCount;
	}
	public ArrayList<Member> getList() {
		return list;
	}
	public void setList(ArrayList<Member> list) {
		this.list = list;
	}
	public String getPageNavi() {
		return pageNavi;
	}
	public void setPageNavi(String pageNavi) {
		this.pageNavi = pageNavi;
	}
	public String[] getArrEnrollDate() {
		return arrEnrollDate;
	}
	public void setArrEnrollDate(String[] arrEnrollDate) {
		this.arrEnrollDate = arrEnrollDate;
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