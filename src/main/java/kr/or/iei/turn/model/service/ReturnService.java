package kr.or.iei.turn.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.iei.turn.model.dao.ReturnDao;

@Service
public class ReturnService {
	@Autowired
	private ReturnDao dao;
}
