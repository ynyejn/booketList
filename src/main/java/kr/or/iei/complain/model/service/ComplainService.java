package kr.or.iei.complain.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.complain.model.dao.ComplainDao;

@Service("complainService")
public class ComplainService {
	@Autowired
	@Qualifier("complainDao")
	private ComplainDao dao;

	public ComplainService() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}
