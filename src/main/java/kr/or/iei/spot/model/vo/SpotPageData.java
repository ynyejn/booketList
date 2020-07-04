package kr.or.iei.spot.model.vo;

import java.util.ArrayList;


import lombok.Data;
@Data
public class SpotPageData {
	private ArrayList<Spot> list;
	private String pageNavi;
	public SpotPageData(ArrayList<Spot> list, String pageNavi) {
		super();
		this.list = list;
		this.pageNavi = pageNavi;
	}
	
	
}
