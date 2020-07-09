package kr.or.iei.rent.model.vo;

import lombok.Data;

@Data
public class RentDateCount {
	private String rentDate;
	private int cnt;
	public RentDateCount(String rentDate, int cnt) {
		super();
		this.rentDate = rentDate;
		this.cnt = cnt;
	}
	public RentDateCount() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
}
