package kr.or.iei.apply.model.service;

import java.text.ParseException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.apply.model.dao.ApplyDao;
import kr.or.iei.apply.model.vo.Apply;

@Service("applyService")
public class ApplyService {
	@Autowired
	@Qualifier("applyDao")
	private ApplyDao dao;

	public ApplyService() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int applyInsert(Apply a, String bookPubDates){
		int result =  dao.applyInsert(a,bookPubDates);
		return result;
	}
	
}
