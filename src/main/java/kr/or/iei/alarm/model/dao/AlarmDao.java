package kr.or.iei.alarm.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("alarmDao")
public class AlarmDao {
	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	public int updateAlarm() {
		return sqlSession.update("alarm.updateAlarm");
	}
}
