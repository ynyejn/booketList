package kr.or.iei.rent.model.vo;

import java.sql.Date;

import lombok.Data;
@Data
public class Rent {
	private int rentNo;
	private String memberId;
	private int bookNo;
	private String spotName;
	private Date rentStartDate;
	private Date rentEndDate;
	private int rentReturn;
	private String bookCategory;
	public int getRentNo() {
		return rentNo;
	}
	public void setRentNo(int rentNo) {
		this.rentNo = rentNo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public int getBookNo() {
		return bookNo;
	}
	public void setBookNo(int bookNo) {
		this.bookNo = bookNo;
	}
	public String getSpotName() {
		return spotName;
	}
	public void setSpotName(String spotName) {
		this.spotName = spotName;
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
	public String getBookCategory() {
		return bookCategory;
	}
	public void setBookCategory(String bookCategory) {
		this.bookCategory = bookCategory;
	}
	public Rent(int rentNo, String memberId, int bookNo, String spotName, Date rentStartDate, Date rentEndDate,
			int rentReturn, String bookCategory) {
		super();
		this.rentNo = rentNo;
		this.memberId = memberId;
		this.bookNo = bookNo;
		this.spotName = spotName;
		this.rentStartDate = rentStartDate;
		this.rentEndDate = rentEndDate;
		this.rentReturn = rentReturn;
		this.bookCategory = bookCategory;
	}
	public Rent() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
}
