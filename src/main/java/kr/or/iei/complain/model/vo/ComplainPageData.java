package kr.or.iei.complain.model.vo;

import java.util.ArrayList;

import lombok.Data;

@Data
public class ComplainPageData {
	ArrayList<Complain> list;
	private String pageNavi;
	public ComplainPageData() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ComplainPageData(ArrayList<Complain> list, String pageNavi) {
		super();
		this.list = list;
		this.pageNavi = pageNavi;
	}
	
	
	
}
