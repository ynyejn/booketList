package kr.or.iei.review.model.vo;

import lombok.Data;

@Data
public class Review {
	private int reviewNo;
	private String memberNickName;
	private String reviewContent;
	private double reviewScore;		//리뷰 스코어 더블
	private String reviewFilename;
	private String reviewFilepath;
	private String bookName;
	private String bookPublisher;
	private String bookWriter;
	private String bookCategory;
}
