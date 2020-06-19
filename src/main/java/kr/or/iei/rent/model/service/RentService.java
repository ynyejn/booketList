package kr.or.iei.rent.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.rent.model.dao.RentDao;

@Service("rentService")
public class RentService {
	@Autowired
	@Qualifier("rentDao")
	private RentDao dao;

}
