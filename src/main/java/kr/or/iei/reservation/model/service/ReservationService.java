package kr.or.iei.reservation.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.reservation.model.dao.ReservationDao;
import kr.or.iei.reservation.model.vo.Reservation;

@Service("reservationService")
public class ReservationService {
	@Autowired
	@Qualifier("reservationDao")
	private ReservationDao dao;

	public int insertReservation(Reservation r) {
		return dao.insertReservation(r);
	}

	public Reservation searchReservation(Reservation r) {
		return dao.searchReservation(r);
	}
}
