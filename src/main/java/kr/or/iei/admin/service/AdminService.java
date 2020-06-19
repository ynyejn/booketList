package kr.or.iei.admin.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.admin.dao.AdminDao;
import kr.or.iei.member.model.vo.Member;

@Service("adminService")
public class AdminService {
	
	@Autowired
	@Qualifier("adminDao")
	private AdminDao dao;

	public ArrayList<Member> selectMember() {
		List list = dao.selectMember();
		return (ArrayList<Member>)list;
	}
}
