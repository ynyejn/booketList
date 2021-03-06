package kr.or.iei.member.model.vo;

import java.sql.Date;


import lombok.Data;

@Data
public class Member {
	private int memberNo;
	private String memberId;
	private String memberPw;
	private String memberName;
	private String memberEmail;
	private String memberPhone;
	private String memberCategory1;
	private String memberCategory2;
	private String memberCategory3;
	private int delayStatus;
	private int compainStatus;
	private Date enrollDate;
	private String memberNickname;
	
}
