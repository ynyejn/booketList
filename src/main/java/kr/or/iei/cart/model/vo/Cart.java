package kr.or.iei.cart.model.vo;

import lombok.Data;

@Data
public class Cart {
	private int cartNo;
	private String memberId;
	private String bookName;
	private String bookWriter;
	private String bookPublisher;
	private String bookCategory;
	public int getCartNo() {
		return cartNo;
	}
	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	public String getBookWriter() {
		return bookWriter;
	}
	public void setBookWriter(String bookWriter) {
		this.bookWriter = bookWriter;
	}
	public String getBookPublisher() {
		return bookPublisher;
	}
	public void setBookPublisher(String bookPublisher) {
		this.bookPublisher = bookPublisher;
	}
	public String getBookCategory() {
		return bookCategory;
	}
	public void setBookCategory(String bookCategory) {
		this.bookCategory = bookCategory;
	}
	public Cart(int cartNo, String memberId, String bookName, String bookWriter, String bookPublisher,
			String bookCategory) {
		super();
		this.cartNo = cartNo;
		this.memberId = memberId;
		this.bookName = bookName;
		this.bookWriter = bookWriter;
		this.bookPublisher = bookPublisher;
		this.bookCategory = bookCategory;
	}
	public Cart() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
}
