package kr.or.iei.turn.model.vo;

import java.sql.Date;

import lombok.Data;


@Data
public class TurnApply {
	private int turnApply;
	private String memberId;
	private String bookNo;
	private String bookName;
	private String spotName;
	private Date turnapplyDate;
}
