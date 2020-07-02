package kr.or.iei.usedBoard.model.vo;

import lombok.Data;

@Data
public class UsedBoard {
	private int usedNo;
	private String memberId;
	private String usedType;
	private String usedTitle;
	private String usedContent;
	private String usedDate;
	private int usedStatus;
}
