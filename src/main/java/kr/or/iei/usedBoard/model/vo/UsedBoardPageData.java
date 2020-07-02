package kr.or.iei.usedBoard.model.vo;

import java.util.ArrayList;

import lombok.Data;
@Data
public class UsedBoardPageData {
	private ArrayList<UsedBoard> list;
	private String pageNavi;
	public UsedBoardPageData(ArrayList<UsedBoard> list, String pageNavi) {
		super();
		this.list = list;
		this.pageNavi = pageNavi;
	}
	
	
}
