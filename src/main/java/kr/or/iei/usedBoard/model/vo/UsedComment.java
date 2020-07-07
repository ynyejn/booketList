package kr.or.iei.usedBoard.model.vo;

import lombok.Data;

@Data
public class UsedComment {
	private int commentNo;
	private int usedNo;
	private String commentContent;
	private String commentWriter;
	private String commentDate;
}
