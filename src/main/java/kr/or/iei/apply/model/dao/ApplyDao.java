package kr.or.iei.apply.model.dao;




import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.iei.apply.model.vo.Apply;
import kr.or.iei.book.model.vo.Book;

@Repository("applyDao")
public class ApplyDao {
	@Autowired
	SqlSessionTemplate sql;

	public ApplyDao() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int applyInsert(Apply a){
		return sql.insert("apply.appltInsert",a);
	}
	public int selectCheck(Book b) {
		System.out.println(b.getBookName());
		List<Book> bookNames = sql.selectList("apply.selectCheck",b);
		
		if(!bookNames.isEmpty()) {
			int result = 1;
			return result;
		}else {
			int result = 0;
			return result;
		}
	
		
	}
	
}
