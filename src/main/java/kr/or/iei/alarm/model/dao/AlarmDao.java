package kr.or.iei.alarm.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.iei.alarm.model.vo.Alarm;

@Repository("alarmDao")
public class AlarmDao {
	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	public int updateAlarm() {
		return sqlSession.update("alarm.updateAlarm");
	}

	public Alarm selectAlarmLost() {
		return sqlSession.selectOne("alarm.selectAlarmLost");
	}

	public Alarm selectTotalCount() {
		return sqlSession.selectOne("alarm.selectTotalCount");
	}

	public int updateLostBookAlarm(int data) {
		return sqlSession.update("alarm.updateLostBookAlarm",data);
	}

	public int updateComplainAlarm() {
		return sqlSession.update("alarm.updateComplainAlarm");
	}

	public int updatecomplainAlarmClick(int data) {
		return sqlSession.update("alarm.updateComplainAlarmClick",data);
	}
}
