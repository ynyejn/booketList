package kr.or.iei.book.model.vo;

import java.util.ArrayList;
import java.util.HashMap;

import kr.or.iei.rent.model.vo.RentAndCount;
import kr.or.iei.review.model.vo.Review;
import lombok.Data;

@Data
public class PreferencePageData {
	ArrayList<BookAndReview> bookAndReviewList;
	ArrayList<Review> ReviewList;
	ArrayList<RentAndCount> rentAndCountList;
	ArrayList<RentAndCount> rentDateList;
	ArrayList<BookAndReview> writerList;
	private int type;
	HashMap<String, String> preferCategory;

	public PreferencePageData(ArrayList<BookAndReview> bookAndReviewList, ArrayList<Review> reviewList,
			ArrayList<RentAndCount> rentAndCountList, ArrayList<RentAndCount> rentDateList,
			ArrayList<BookAndReview> writerList, int type) {
		super();
		this.bookAndReviewList = bookAndReviewList;
		ReviewList = reviewList;
		this.rentAndCountList = rentAndCountList;
		this.rentDateList = rentDateList;
		this.writerList = writerList;
		this.type = type;
	}
	public PreferencePageData() {
		super();
		// TODO Auto-generated constructor stub
	}
	public PreferencePageData(ArrayList<BookAndReview> bookAndReviewList, ArrayList<Review> reviewList,
			ArrayList<RentAndCount> rentAndCountList, ArrayList<RentAndCount> rentDateList,
			ArrayList<BookAndReview> writerList, int type, HashMap<String, String> preferCategory) {
		super();
		this.bookAndReviewList = bookAndReviewList;
		ReviewList = reviewList;
		this.rentAndCountList = rentAndCountList;
		this.rentDateList = rentDateList;
		this.writerList = writerList;
		this.type = type;
		this.preferCategory = preferCategory;
	}
	
	
}
