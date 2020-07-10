package kr.or.iei.usedBoard.model.vo;

import java.util.ArrayList;

import lombok.Data;

@Data
public class UsedComment {
	private int commentNo;
	private int usedNo;
	private String commentContent;
	private String commentWriter;
	private String commentDate;
	private ArrayList<UsedFiles> usedFiles;

	public UsedComment() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}
