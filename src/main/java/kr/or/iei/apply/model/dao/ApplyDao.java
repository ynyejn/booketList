package kr.or.iei.apply.model.dao;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.iei.apply.model.vo.Apply;

@Repository("applyDao")
public class ApplyDao {
	@Autowired
	SqlSessionTemplate sql;

	public ApplyDao() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int applyInsert(Apply a, String bookPubDates){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		java.util.Date date = null;
				
			try {
				date = sdf.parse(bookPubDates);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			 String transDate = sdf.format(date);
			 Date d = Date.valueOf(transDate);
			
		System.out.println(d);
		a.setBookPubDate(d);
		System.out.println(a.getBookPubDate());
		return sql.insert("apply.appltInsert",a);
	}
	
}
