package kr.or.iei.complain.model.vo;

import java.sql.Date;

import lombok.Data;
@Data
public class Complain {
	private int complainNo;
	private String memberId;
	private String attacker;
	private String complainCategory;
	private Date complainDate;
	private String complainContent;
	private String complainFilename;
	private int complainStauts;
}
