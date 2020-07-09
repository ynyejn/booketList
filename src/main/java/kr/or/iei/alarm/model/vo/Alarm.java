package kr.or.iei.alarm.model.vo;

public class Alarm {
	private int alarmNo;
	private int lostbookCount;
	private int totalCount;

	public Alarm() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Alarm(int alarmNo, int lostbookCount, int totalCount) {
		super();
		this.alarmNo = alarmNo;
		this.lostbookCount = lostbookCount;
		this.totalCount = totalCount;
	}

	public int getAlarmNo() {
		return alarmNo;
	}

	public void setAlarmNo(int alarmNo) {
		this.alarmNo = alarmNo;
	}

	public int getLostbookCount() {
		return lostbookCount;
	}

	public void setLostbookCount(int lostbookCount) {
		this.lostbookCount = lostbookCount;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	
	
}
