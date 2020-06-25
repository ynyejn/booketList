package kr.or.iei.chat.model.vo;

import java.sql.Date;

import lombok.Data;
@Data
public class Chat {
	private int chatNo;
	private String chatTitle;
	private int chatPeople;
	private String chatPw;
	private Date chatEnrollDate;
	private String memberNickname;
}
