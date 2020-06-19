package kr.or.iei.reservation.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("reservationDao")
public class ReservationDao {
	@Autowired
	SqlSessionTemplate sql;
	
	public ReservationDao() {
		super();
	}
}
