package kr.or.iei.reservation.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.iei.reservation.model.vo.Reservation;

@Repository("reservationDao")
public class ReservationDao {
	@Autowired
	SqlSessionTemplate sql;
	
	public ReservationDao() {
		super();
	}

	public int insertReservation(Reservation r) {
		return sql.insert("reservation.insertReservation", r);
	}

	public Reservation searchReservation(Reservation r) {
		Reservation r2 = sql.selectOne("reservation.searchReservation", r);
		System.out.println(r2);
		return r2;
	}
}
