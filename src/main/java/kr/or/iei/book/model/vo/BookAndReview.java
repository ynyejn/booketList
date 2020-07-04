package kr.or.iei.book.model.vo;

import java.sql.Date;


import lombok.Data;
@Data
public class BookAndReview {
	private String bookName;
	private String bookWriter;
	private String bookPublisher;
	private String bookCategory;
	private String bookImg;
	private Date bookPubDate;
	private int bookStatus;
	private String bookContent;
	private double avgScore;
	private int cnt;
}
