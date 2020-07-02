package kr.or.iei.rent.model.vo;

import java.sql.Date;

import lombok.Data;
@Data
public class Rent {
	private int rentNo;
	private String memberId;
	private int bookNo;
	private String spotName;
	private Date rentStartDate;
	private Date rentEndDate;
	private int rentReturn;
	private String bookCategory;
	private String bookName;
	private String bookWriter;
	private int bookStatus;
	
	
}
