package kr.or.iei.apply.model.vo;

import java.sql.Date;


import lombok.Data;
@Data
public class Apply {
	private int applyNo;
	private String memberId;
	private Date applyDate;
	private String applyContent;
	private String bookName;
	private String bookWriter;
	private String bookPublisher;
	private int applyStatus;
	private String bookCategory;
	private String bookImg;
	private Date bookPubDate;
	private String bookContent;
}
