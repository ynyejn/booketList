package kr.or.iei.reservation.model.vo;

import java.sql.Date;

import lombok.Data;
@Data
public class Reservation {
	private int reserveNo;
	private String memberId;
	private String bookName;
	private String bookPublisher;
	private String bookWriter;
	private Date reserveDate;
	public int getReserveNo() {
		return reserveNo;
	}
	public void setReserveNo(int reserveNo) {
		this.reserveNo = reserveNo;
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
	public String getBookPublisher() {
		return bookPublisher;
	}
	public void setBookPublisher(String bookPublisher) {
		this.bookPublisher = bookPublisher;
	}
	public String getBookWriter() {
		return bookWriter;
	}
	public void setBookWriter(String bookWriter) {
		this.bookWriter = bookWriter;
	}
	public Date getReserveDate() {
		return reserveDate;
	}
	public void setReserveDate(Date reserveDate) {
		this.reserveDate = reserveDate;
	}
	public String getBookCategory() {
		return bookCategory;
	}
	public void setBookCategory(String bookCategory) {
		this.bookCategory = bookCategory;
	}
	public Reservation(int reserveNo, String memberId, String bookName, String bookPublisher, String bookWriter,
			Date reserveDate, String bookCategory) {
		super();
		this.reserveNo = reserveNo;
		this.memberId = memberId;
		this.bookName = bookName;
		this.bookPublisher = bookPublisher;
		this.bookWriter = bookWriter;
		this.reserveDate = reserveDate;
		this.bookCategory = bookCategory;
	}
	public Reservation() {
		super();
		// TODO Auto-generated constructor stub
	}
	private String bookCategory;
}
