package kr.or.iei.alarm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.alarm.model.service.AlarmService;


@Controller
public class AlarmController {
	@Autowired
	@Qualifier("alarmService")
	private AlarmService service;
	
	/*
	 * @RequestMapping(value="/updateAlarm.do") public String updateAlarm() { int
	 * result = service.updateAlarm(); if(result>0) {
	 * System.out.println("alarm : 11"); } return "redirect:/userLostBook.do"; }
	 */
}
