package kr.or.iei.turn.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.iei.rent.model.vo.Rent;
import kr.or.iei.turn.model.dao.ReturnDao;
import kr.or.iei.turn.model.vo.TurnApply;

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
		System.out.println(result[0]);
		result[1] = dao.updateDelayStatus();
		System.out.println(result[1]);
		result[2] = dao.reduceDelayStatus();
		System.out.println(result[2]);
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
	@Transactional
	public int insertTurnApply(TurnApply turn) {
		int result = 0;
		StringTokenizer st = new StringTokenizer(turn.getBookNo(),",");
		while(st.hasMoreTokens()) {
			turn.setBookNo(st.nextToken());
			System.out.println(turn.getBookNo());
			result += dao.insertTurnApply(turn);
			dao.updateBookStatusTo3(turn.getBookNo());
		}
		return result;
	}




}
