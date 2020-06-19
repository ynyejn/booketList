package kr.or.iei.reservation.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.reservation.model.dao.ReservationDao;

@Service("reservationService")
public class ReservationService {
	@Autowired
	@Qualifier("reservationDao")
	private ReservationDao dao;
}
