package kr.or.iei.complain.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.complain.model.dao.ComplainDao;
import kr.or.iei.complain.model.vo.Complain;

@Service("complainService")
public class ComplainService {
	@Autowired
	@Qualifier("complainDao")
	private ComplainDao dao;

	public ComplainService() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int complainInsert(Complain c) {
		// TODO Auto-generated method stub
		return dao.complainInsert(c);
	}

	public int complainInsertFile(Complain c) {
		// TODO Auto-generated method stub
		return dao.complainInsertFile(c);
	}
	
}
