package kr.or.iei.usedBoard.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.iei.usedBoard.model.dao.UsedBoardDao;

@Service
public class UsedBoardService {
	@Autowired
	private UsedBoardDao dao;
}
