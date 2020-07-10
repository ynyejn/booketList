package kr.or.iei.admin.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.iei.apply.model.vo.Apply;
import kr.or.iei.book.model.vo.Book;

import kr.or.iei.book.model.vo.BookRentalStatus;

import kr.or.iei.book.model.vo.BookAndRent;

import kr.or.iei.member.model.vo.Member;
import kr.or.iei.rent.model.vo.RentApply;
import kr.or.iei.reservation.model.vo.Reservation;
import kr.or.iei.spot.model.vo.Spot;
import kr.or.iei.turn.model.vo.TurnApply;
import kr.or.iei.complain.model.vo.Complain;

@Repository("adminDao")
public class AdminDao {

	@Autowired
	SqlSessionTemplate sqlSession;

	public List selectMember(HashMap<String, Integer> map) {
		System.out.println("AdminDao");
		return sqlSession.selectList("member.selectMember", map);
	}

	public int bookTotalCount() {
		return sqlSession.selectOne("book.bookTotalCount");
	}

	public List selectList1(HashMap<String, Integer> map) {
		return sqlSession.selectList("book.selectList1", map);
	}

	public int TotalCount2() {
		return sqlSession.selectOne("apply.TotalCount2");
	}

	public List selectList2(HashMap<String, Integer> map) {
		return sqlSession.selectList("apply.selectList2", map);
	}

	public int bookTotalCount3(HashMap<String, String> map2) {
		return sqlSession.selectOne("book.bookTotalCount3", map2);
	}

	public List selectList3(HashMap<String, String> map2) {
		return sqlSession.selectList("book.selectList3", map2);
	}

	public int TotalCount4(HashMap<String, String> map2) {
		return sqlSession.selectOne("apply.totalCount4", map2);
	}

	public List selectList4(HashMap<String, String> map2) {
		return sqlSession.selectList("apply.selectList4", map2);
	}

	public int memberTotalCount() {
		return sqlSession.selectOne("member.memberTotalCount");
	}

	public int deletebookList(String[] params) {
		return sqlSession.delete("book.deleteBookList", params);
	}

	public Book selectOneBookList(int bookNoo) {
		System.out.println(bookNoo);
		return sqlSession.selectOne("book.selectOneBookList", bookNoo);
	}

	public int detailOneBookDelete(int bookNo) {
		return sqlSession.delete("book.selectOneBookDelete", bookNo);
	}

	public Apply selectOneApplyList(int applyNoo) {
		return sqlSession.selectOne("apply.selectOneApplyList", applyNoo);
	}

	public int selectMemberTotalCount(HashMap<String, Object> map) {
		return sqlSession.selectOne("member.selectMemberTotalCount",map);
	}

	public List selectMemberList(HashMap<String, Object> map) {
		return sqlSession.selectList("member.selectMemberList",map);
	}


	public int detailOneApplyNo(int applyNo) {
		return sqlSession.update("apply.detailOneApplyNo", applyNo);
	}

	public int detailOneApplyYes(int applyNo) {
		return sqlSession.update("apply.detailOneApplyYes", applyNo);
	}

	public Book checkBookList(String string) {
		return sqlSession.selectOne("book.checkBookList", string);
	}

	public int insertBookList(String[] insertContent) {
		return sqlSession.insert("book.insertBookList", insertContent);
	}

	public int complainTotalCount1() {
		return sqlSession.selectOne("complain.ComplainTotalCount1");
	}

	public List complainSelectList1(HashMap<String, Integer> map) {
		return sqlSession.selectList("complain.ComplainSelectList1", map);
	}

	public int complainTotalCount2() {
		return sqlSession.selectOne("complain.ComplainTotalCount2");
	}

	public List complainSelectList2(HashMap<String, Integer> map) {
		return sqlSession.selectList("complain.ComplainSelectList2", map);
	}
	
	public int complainTotalCount3(HashMap<String, String> map2) {
		return sqlSession.selectOne("complain.ComplainTotalCount3",map2);
	}

	public List complainSelectList3(HashMap<String, String> map2) {
		return sqlSession.selectList("complain.ComplainSelectList3",map2);
	}
	
	public int complainTotalCount4(HashMap<String, String> map2) {
		return sqlSession.selectOne("complain.ComplainTotalCount4",map2);
	}
	
	public List complainSelectList4(HashMap<String, String> map2) {
		return sqlSession.selectList("complain.ComplainSelectList4",map2);
	}
	
	public Complain selectOneComplainList(int complainNo) {
		return sqlSession.selectOne("complain.selectOneComplainList", complainNo);
	}

	public int detailComplainYes(int complainNo) {
		return sqlSession.update("complain.detailComplainYes",complainNo);
	}

	public int detailComplainNo(int complainNo) {
		return sqlSession.update("complain.detailComplainNo",complainNo);
	}

	public int LostbookTotalCount() {
		return sqlSession.selectOne("book.LostBookTotalCount1");
	}

	public List LostBookselectList1(HashMap<String, Integer> map) {
		return sqlSession.selectList("book.LostBookSelectList",map);
	}

	public int LostbookTotalCount3(HashMap<String, String> map2) {
		return sqlSession.selectOne("book.LostBookTotalCount3",map2);
	}

	public List LostBookselectList3(HashMap<String, String> map2) {
		return sqlSession.selectList("book.LostBookSelectList3",map2);
	}

	public int cancelLostbookList(String[] params) {
		return sqlSession.update("book.cancelLostbookList",params);
	}

	/*
	 * public int complainTotalCount1() { return
	 * sqlSession.selectOne("complain.ComplainTotalCount1"); }
	 * 
	 * public List complainSelectList1(HashMap<String, Integer> map) { return
	 * sqlSession.selectList("complain.ComplainSelectList1",map); }
	 * 
	 * public int complainTotalCount2() { return
	 * sqlSession.selectOne("complain.ComplainTotalCount2"); }
	 * 
	 * public List complainSelectList2(HashMap<String, Integer> map) { return
	 * sqlSession.selectList("complain.ComplainSelectList2",map); }
	 */
	public List selectExcelList(String memberId) {
		return sqlSession.selectList("member.selectExcelList",memberId);
	}

	public int adminDeleteMember(String memberId) {
		return sqlSession.delete("member.adminDeleteMember",memberId);
	}


	public List bookRentalStatusList(HashMap<String, Integer> map) {
		return sqlSession.selectList("book.bookRentalStatusList",map);
	}

	public List bookSearchRentalStatusList(HashMap<String, Object> map) {
		return sqlSession.selectList("book.bookSearchRentalStatusList",map);
	}

	public int selectRentTotalCount(HashMap<String, Object> map) {
		return sqlSession.selectOne("book.selectRentTotalCount",map);
	}

	public int rentTotalCount() {
		return sqlSession.selectOne("book.rentTotalCount");
	}

	public List selectExcelRentList(int rentNo) {
		return sqlSession.selectList("book.selectExcelRentList",rentNo);
	}

	public List userLostBook(Member m) {
		return sqlSession.selectList("book.userLostBook",m);
	}

	public int userLostBookUpdate(String[] params) {
		return sqlSession.update("book.userLostBookUpdate", params);
	}

	public int userLostRentUpdate(String[] params) {
		return sqlSession.update("rent.userLostRentUpdate",params);
	}

	public int cancelLostbookList2(String[] params) {
		return sqlSession.update("rent.cancelLostbookList2",params);
	}
	public int rentApplyTotalCount() {
			return sqlSession.selectOne("rent.rentApplyTotalCount");
	}

	public List bookRentalApplyList(HashMap<String, Integer> map) {
		return sqlSession.selectList("rent.bookRentalApplyList",map);
	}

	public int selectRentApplyTotalCount(HashMap<String, Object> map) {
		return sqlSession.selectOne("rent.selectRentApplyTotalCount",map);
	}

	public List bookSearchRentalApplyList(HashMap<String, Object> map) {
		return sqlSession.selectList("rent.bookSearchRentalApplyList",map);
	}

	public RentApply selectOneRentApply(int rentApply) {
		return sqlSession.selectOne("rent.selectOneRentApply",rentApply);
	}

	public int insertAgreeRentApply(RentApply selectRentApply) {
		return sqlSession.insert("rent.insertAgreeRentApply",selectRentApply);
	}

	public int deleteAgreeRentApply(int rentApply) {
		return sqlSession.delete("rent.deleteAgreeRentApply",rentApply);
	}

	public int turnApplyTotalCount() {
		return sqlSession.selectOne("return.turnApplyTotalCount");
	}

	public List bookTurnApplyList(HashMap<String, Integer> map) {
		return sqlSession.selectList("return.bookTurnApplyList",map);
	}

	public int selectTurnApplyTotalCount(HashMap<String, Object> map) {
		return sqlSession.selectOne("return.selectTurnApplyTotalCount",map);
	}

	public List bookSearchTurnApplyList(HashMap<String, Object> map) {
		return sqlSession.selectList("return.bookSearchTurnApplyList",map);
	}

	public TurnApply selectTurnApplyOneList(int turnApply) {
		return sqlSession.selectOne("return.selectTurnApplyOneList",turnApply);
	}

	public Book selectBookListTurnApply(String bookNo) {
		return sqlSession.selectOne("return.selectBookListTurnApply",bookNo);
	}

	public List selectReservationListTurnApply(HashMap<String, String> map) {
		return sqlSession.selectList("return.selectReservationListTurnApply",map);
	}

	public String selectMemberEmailTurnApply(String memberId) {
		return sqlSession.selectOne("return.selectMemberEmailTurnApply",memberId);
	}

	public int deleteTurnApply(int turnApply) {
		return sqlSession.delete("return.deleteTurnApply",turnApply);
	}

	public int deleteReservationTurnApply(HashMap<String, String> map) {
		return sqlSession.delete("return.deleteReservationTurnApply",map);
	}

	public int updateBookTurnApply(String bookNo) {
		return sqlSession.update("return.updateBookTurnApply",bookNo);
	}

	public BookAndRent selectOneLostBook(int bookNo) {
		return sqlSession.selectOne("book.selectOneLostBook", bookNo);
	}

	public List bookStatusList() {
		return sqlSession.selectList("book.bookStatusList");
	}
	public int updateBookRentApply(int bookNo) {
		return sqlSession.update("rent.updateBookRentApply",bookNo);
	}

	public int updateRentReturnTurnApply(String bookNo) {
		return sqlSession.update("return.updateRentReturnTurnApply",bookNo);
	}

	public List selectExcelRentApplyList(int rentApply) {
		return sqlSession.selectList("rent.selectExcelRentApplyList",rentApply);
	}

	public List selectExcelTurnApplyList(int turnApply) {
		return sqlSession.selectList("return.selectExcelTurnApplyList",turnApply);
	}

	public List excelTurnApplyListTotal() {
		return sqlSession.selectList("return.excelTurnApplyListTotal");
	}

	public List excelRentApplyListTotal() {
		return sqlSession.selectList("rent.excelRentApplyListTotal");
	}

	public List excelRentListTotal() {
		return sqlSession.selectList("book.excelRentListTotal");
	}

	public List excelMemberListTotal() {
		return sqlSession.selectList("member.excelMemberListTotal");
	}

	public int reservationTotalCount() {
		return sqlSession.selectOne("reservation.reservationTotalCount");
	}

	public List bookReservationList(HashMap<String, Integer> map) {
		return sqlSession.selectList("reservation.bookReservationList",map);
	}

	public int selectReservationTotalCount(HashMap<String, Object> map) {
		return sqlSession.selectOne("reservation.selectReservationTotalCount",map);
	}

	public List bookSearchReservationList(HashMap<String, Object> map) {
		return sqlSession.selectList("reservation.bookSearchReservationList",map);

	}

	public List selectExcelReservationList(int reserveNo) {
		return sqlSession.selectList("reservation.selectExcelReservationList",reserveNo);
	}

	public List excelReservationListTotal() {
		return sqlSession.selectList("reservation.excelReservationListTotal");
	}

	public Spot spotNameChecked(String spotName) {
		return sqlSession.selectOne("spot.spotNameChecked",spotName);
	}

	public int insertSpot(HashMap<String, String> map) {
		return sqlSession.insert("spot.insertSpot",map);
	}

	public int adminSpotListTotalCount() {
		return sqlSession.selectOne("spot.adminSpotListTotalCount");
	}

	public List adminSpotList(HashMap<String, Integer> map) {
		return sqlSession.selectList("spot.adminSpotList",map);
	}

	public int selectSpotListTotalCount(HashMap<String, Object> map) {
		return sqlSession.selectOne("spot.selectSpotListTotalCount",map);
	}

	public List bookSearchSpotList(HashMap<String, Object> map) {
		return sqlSession.selectList("spot.bookSearchSpotList",map);
	}

	public List excelSpotListDown(int spotNo) {
		return sqlSession.selectList("spot.excelSpotListDown",spotNo);
	}

	public List excelSpotListTotal() {
		return sqlSession.selectList("spot.excelSpotListTotal");
	}

	public Spot selectOneSpot(int spotNo) {
		return sqlSession.selectOne("spot.selectOneSpot",spotNo);
	}

	public int deleteSpot(int spotNo) {
		return sqlSession.delete("spot.deleteSpot",spotNo);
	}

	public int updateSpot(HashMap<String, Object> map) {
		return sqlSession.update("spot.updateSpot",map);
	}

	 





	}
