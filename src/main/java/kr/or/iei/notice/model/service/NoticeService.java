package kr.or.iei.notice.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.notice.model.dao.NoticeDao;

@Service("noticeService")
public class NoticeService {
	@Autowired
	@Qualifier("noticeDao")
	private NoticeDao dao;

}
