package kr.or.iei.common;

import java.io.FileOutputStream;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kr.or.iei.book.model.vo.Book;

//import kr.or.iei.member.model.vo.Book;

@Controller("/aladdin")
public class AladdinAPI {
	@ResponseBody
	@RequestMapping(value="/aladdin.do", produces = "application/json; charset=utf-8")
	public String aladdin(String title, HttpServletRequest request) {

		System.out.println("title:"+title);
		String BASE_URL ="";
		//20070901 20131101
		//베스트셀러
		BASE_URL = "http://www.aladin.co.kr/ttb/api/ItemSearch.aspx?ttbkey=ttbbang82550812001&Query="+title+"&QueryType=Bestseller&MaxResults=100&start=1&SearchTarget=Book&output=js&Version=20070901";
		//편집자 추천
//		BASE_URL = "http://www.aladin.co.kr/ttb/api/ItemSearch.aspx?ttbkey=ttbbang82550812001&Query="+title+"&QueryType=ItemEditorChoice&MaxResults=100&start=1&SearchTarget=Book&output=js&Version=20070901";
		//인기 신간
//		BASE_URL = "http://www.aladin.co.kr/ttb/api/ItemSearch.aspx?ttbkey=ttbbang82550812001&Query="+title+"&QueryType=ItemNewSpecial&MaxResults=100&start=1&SearchTarget=Book&output=js&Version=20070901";

		try {
			HttpClient client = HttpClientBuilder.create().build(); // HttpClient 생성
			HttpGet getRequest = new HttpGet(BASE_URL); //GET 메소드 URL 생성
			getRequest.addHeader("ttbkey", "ttbbang82550812001"); //KEY 입력

			HttpResponse response = client.execute(getRequest);

			//Response 출력
			if (response.getStatusLine().getStatusCode() == 200) {
				ResponseHandler<String> handler = new BasicResponseHandler();
				String body = handler.handleResponse(response);
				body = body.replaceAll(";", "");
				System.out.println(body);
				JsonParser parser = new JsonParser();
				JsonObject resultJson = (JsonObject)parser.parse(body);
				JsonArray resultJson2 = (JsonArray)resultJson.get("item");				
				System.out.println("resultJson : "+resultJson);
				System.out.println("resultJson2 : "+resultJson2);
				
				
//				String from = "2013-04-08 10:10:10";
//				SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//				Date to = transFormat.parse(from);

//				java.sql.Timestamp t = java.sql.Timestamp.valueOf("2020-06-01");
				System.out.println(resultJson2.get(0).getAsJsonObject().get("pubDate").getAsString());
				System.out.println(resultJson2.get(0).getAsJsonObject().get("pubDate").getClass().getName());
				System.out.println(resultJson2.get(0).getAsJsonObject().get("pubDate").getAsString().getClass().getName());

				ArrayList<Book> list = new ArrayList<Book>();
				for(int i=0; i<resultJson2.size(); i++) {
					Book b = new Book();
					b.setBookName(resultJson2.get(i).getAsJsonObject().get("title").getAsString());
					b.setBookContent(resultJson2.get(i).getAsJsonObject().get("description").getAsString());
					b.setBookImg(resultJson2.get(i).getAsJsonObject().get("cover").getAsString());
					b.setBookWriter(resultJson2.get(i).getAsJsonObject().get("author").getAsString());
					b.setBookPublisher(resultJson2.get(i).getAsJsonObject().get("publisher").getAsString());
					b.setBookCategory(resultJson2.get(i).getAsJsonObject().get("categoryName").getAsString().split(">")[1]);
					java.sql.Date d = java.sql.Date.valueOf(resultJson2.get(i).getAsJsonObject().get("pubDate").getAsString());
					b.setBookPubDate(d);
					list.add(b);
				}
				System.out.println("listSize : "+list.size());
				////////////////////////
				////////엑셀파일로 빼기//////
				////////////////////////
				XSSFRow row;
				XSSFCell cell;
				int countRow = 0;
				int countCell = 0;
				XSSFWorkbook workbook = new XSSFWorkbook();
				
				//Sheet명 설정
				XSSFSheet sheet = workbook.createSheet("mySheet");
				
				for(int i=0; i<list.size(); i++) {
					//출력 row 생성
					row = sheet.createRow(i);
					//출력 cell 생성
					row.createCell(0).setCellValue(i);
					row.createCell(1).setCellValue(list.get(i).getBookName());
					row.createCell(2).setCellValue(list.get(i).getBookWriter());
					row.createCell(3).setCellValue(list.get(i).getBookPublisher());
					row.createCell(4).setCellValue(list.get(i).getBookCategory());
					row.createCell(5).setCellValue(list.get(i).getBookImg());
					row.createCell(6).setCellValue(list.get(i).getBookPubDate());
					row.createCell(7).setCellValue(list.get(i).getBookStatus());
					row.createCell(8).setCellValue(list.get(i).getBookContent());
				}

				// 출력 파일 위치및 파일명 설정

				FileOutputStream outFile;
				try {
					outFile = new FileOutputStream("인기신간 다.xlsx");
					workbook.write(outFile);
					outFile.close();		
					System.out.println("파일생성 완료");
					return new Gson().toJson(resultJson2);
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {
				System.out.println("response is error : " + response.getStatusLine().getStatusCode());
			}
		} catch (Exception e){
			System.err.println(e.toString());
		}
		return "fail";
	}
}
