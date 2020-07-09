package kr.or.iei.review.model.vo;

import lombok.Data;

@Data
public class Review {
	private int reviewNo;
	private String memberNickName;
	private String reviewContent;
	private double reviewScore;	
	private String reviewFilename;
	private String reviewFilepath;
	private String bookName;
	private String bookPublisher;
	private String bookWriter;
	private String bookCategory;
	private String reviewDate;
}
