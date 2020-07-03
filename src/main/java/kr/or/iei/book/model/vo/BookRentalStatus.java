package kr.or.iei.book.model.vo;

import java.sql.Date;

public class BookRentalStatus {
	private int rentNo;
	private int bookNo;
	private String memberId;
	private String bookName;
	private Date rentStartDate;
	private Date rentEndDate;
	private int rentReturn;
	public BookRentalStatus() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BookRentalStatus(int rentNo, int bookNo, String memberId, String bookName, Date rentStartDate,
			Date rentEndDate, int rentReturn) {
		super();
		this.rentNo = rentNo;
		this.bookNo = bookNo;
		this.memberId = memberId;
		this.bookName = bookName;
		this.rentStartDate = rentStartDate;
		this.rentEndDate = rentEndDate;
		this.rentReturn = rentReturn;
	}
	public int getRentNo() {
		return rentNo;
	}
	public void setRentNo(int rentNo) {
		this.rentNo = rentNo;
	}
	public int getBookNo() {
		return bookNo;
	}
	public void setBookNo(int bookNo) {
		this.bookNo = bookNo;
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
	public Date getRentStartDate() {
		return rentStartDate;
	}
	public void setRentStartDate(Date rentStartDate) {
		this.rentStartDate = rentStartDate;
	}
	public Date getRentEndDate() {
		return rentEndDate;
	}
	public void setRentEndDate(Date rentEndDate) {
		this.rentEndDate = rentEndDate;
	}
	public int getRentReturn() {
		return rentReturn;
	}
	public void setRentReturn(int rentReturn) {
		this.rentReturn = rentReturn;
	}

	
}
