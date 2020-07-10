package kr.or.iei.alarm.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.alarm.model.dao.AlarmDao;

@Service("alarmService")
public class AlarmService {
	@Autowired
	@Qualifier("alarmDao")
	private AlarmDao dao;
	
	
}
