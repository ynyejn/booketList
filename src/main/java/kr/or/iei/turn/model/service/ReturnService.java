package kr.or.iei.turn.model.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.iei.rent.model.vo.Rent;
import kr.or.iei.spot.model.vo.Spot;
import kr.or.iei.spot.model.vo.SpotPageData;
import kr.or.iei.turn.model.dao.ReturnDao;

@Service
public class ReturnService {
	@Autowired
	private ReturnDao dao;

	public ArrayList<Rent> selectAllRent(String memberId) {
		List list = dao.selectAllRent(memberId);
		return (ArrayList<Rent>)list;
	}

	@Transactional
	public int bookDalay() {
		int[] result= new int[3];
		result[0] = dao.updateBookStatus();
		result[1] = dao.updateDelayStatus();
		result[2] = dao.reduceDelayStatus();
		int sum=0;
		for(int i=0; i<3; i++) {
			if(result[i]>0) {
				result[i]=1;
			}else {
				result[i]=0;
			}
			sum+=result[i];
		}
		return sum;
	}




}
