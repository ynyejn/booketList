package kr.or.iei.rent.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class RentApply {
	private int rentApply;
	private String memberId;
	private int bookNo;
	private String bookName;
	private String spotName;
	private Date rentApplyDate; 
}
