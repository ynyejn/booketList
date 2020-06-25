package kr.or.iei.cart.model.vo;

import lombok.Data;

@Data
public class Cart {
	private int cartNo;
	private String memberId;
	private String bookName;
	private String bookWriter;
	private String bookPublisher;
	private String bookImg;

	
	
}
