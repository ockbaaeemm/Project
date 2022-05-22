package com.teamb.shareoffice.guest.controller;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.teamb.shareoffice.guest.service.GuestServiceB;
import com.teamb.shareoffice.guest.service.GuestServiceRN;
import com.teamb.shareoffice.vo.BusinessDayVo;
import com.teamb.shareoffice.vo.MemberVo;
import com.teamb.shareoffice.vo.OrderVo;
import com.teamb.shareoffice.vo.RentalVo;
import com.teamb.shareoffice.vo.ReviewVo;

@Controller
@RequestMapping("/guest/*")
public class GuestControllerB {
	
	@Autowired
	private GuestServiceB guestServiceB;
	
	@Autowired
	private GuestServiceRN guestServiceRN;
	
	private final String uploadFolder = "/shareOffice/reviewImage/";
	//private final String uploadFolder = "C:\shareOffice\licenseImg";
	
	@RequestMapping("orderPage")
	public String orderPage(int office_no, Model model) {
		
		//int office_no = 3; //파라미터값 임의 정의 추후 파라미터 추가(officeDetailPage에서 받아와야함)
		
		HashMap<String, Object> officeInfo = guestServiceB.getOfficeInfo(office_no);
		ArrayList<HashMap<String, Object>> officeBusinessDayInfo = guestServiceB.getBusinessDayInfo(office_no);
		ArrayList<RentalVo> officeRentalList = guestServiceB.getOfficeRentalList(office_no);
		
		model.addAttribute("officeInfo", officeInfo);
		model.addAttribute("officeBusinessDayInfo", officeBusinessDayInfo);
		model.addAttribute("officeRentalList", officeRentalList);
		
		
		return "guest/orderPage";
	}	
	
	@RequestMapping("paymentPage")
	public String paymentPage(Model model, HttpSession session, int officeNo, OrderVo ovo, BusinessDayVo bdvo, Date [] rental_date) {
		
		if(rental_date != null) {
			for(int i=0; i<rental_date.length; i++) {
				int rentalWhether = guestServiceB.officeRentalWhetherCheck(officeNo, rental_date[i]);
				
				System.out.println("렌탈 날짜 : " + rental_date[i] + " -> 렌탈여부 (" + rentalWhether + ")");
				
				if(rentalWhether > 0) {
					return "guest/orderFail";
				}
			}
		}
		
		//orderPage view쪽엔 hidden으로 미리 넘기는 코드 작성
		HashMap<String, Object> officeInfo = guestServiceB.getOfficeInfo(officeNo);
		
		//예약날짜 형식 변경(DateFormat)
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy년 MM월 dd일, E");
		ArrayList<String> formatRentalDateList = new ArrayList<String>();
		
		//해당 오피스의 businessDayVo 리스트 (OrderAndPaymentProcess로 넘기기 위한)
		ArrayList<BusinessDayVo> businessDayVoList = new ArrayList<BusinessDayVo>();
		
		int totalPayment = 0;
		
		bdvo.setOffice_no(officeNo); //임의 set
		
		// for mobile
		HashMap<String, String> weekMap = new HashMap<>();
		weekMap.put("Mon", "월");
		weekMap.put("Tue", "화");
		weekMap.put("Wed", "수");
		weekMap.put("Thu", "목");
		weekMap.put("Fri", "금");
		weekMap.put("Sat", "토");
		weekMap.put("Sun", "일");
		
		if(rental_date != null) {
			for(int i=0; i<rental_date.length; i++) {
				String formatDate = simpleDateFormat.format(rental_date[i]);

				formatRentalDateList.add(formatDate);
				
				String businessDay = formatDate.substring(15);
				
				if(weekMap.containsKey(businessDay)) {
					businessDay = weekMap.get(businessDay);
				}				
				
				bdvo.setBusiness_day(businessDay);
				
				BusinessDayVo businessDayVo = guestServiceB.getPriceAndBusiunessTime(bdvo);
				
				businessDayVoList.add(businessDayVo);
				
				totalPayment += businessDayVo.getBusiness_day_price();
			}
		}
		
		formatRentalDateList.sort(null);
		
		model.addAttribute("officeInfo", officeInfo); // 오피스정보
		model.addAttribute("ovo", ovo); 
		model.addAttribute("rental_date", rental_date); //예약 날짜리스트
		model.addAttribute("formatRentalDateList", formatRentalDateList); //포맷된 예약날짜 리스트
		model.addAttribute("totalPayment", totalPayment); // 총결제금액(출력용도)
		model.addAttribute("businessDayVoList", businessDayVoList);  // businessDayVo 리스트 (OrderAndPaymentProcess로 값 넘기기 위한)
		model.addAttribute("memberCouponList", guestServiceRN.getMemberCoupon(((MemberVo) session.getAttribute("sessionUser")).getMember_no()));	// 멤버가 발급받은 쿠폰리스트
		
		return "guest/paymentPage";
	}
	
	/*
	@RequestMapping("officeRentalWhetherCheck")
	public String officeRentalWhetherCheck(int office_no, String [] rental_date) throws Exception {
		
		//예약날짜 타입 변경(Parse : String -> Date)
		SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy", Locale.US);
		
		if(rental_date != null) {
			for(int i=0; i<rental_date.length; i++) {
				int rentalWhether = guestServiceB.officeRentalWhetherCheck(office_no, sdf.parse(rental_date[i]));
				
				System.out.println("렌탈 날짜 : " + rental_date[i] + " -> 렌탈여부 (" + rentalWhether + ")");
				
				if(rentalWhether > 0) {
					return "guest/rentalFail";
				} 
			}
		}
		
		
		return "redirect:./paymentPage";
		
		
	}
	*/
	
	@RequestMapping("orderAndPaymentProcess")
	public String orderAndPaymentProcess(HttpSession session, OrderVo ovo, String [] rental_date, int [] rental_price) {
		
		MemberVo sessionUser = (MemberVo) session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		
		ovo.setMember_no(member_no);
		
		guestServiceB.guestOrderAndOfficeRental(ovo, rental_date, rental_price);
		
		return "guest/rentalCompletePage";
	}
	
	
	@RequestMapping("officeRentalListPage")
	public String officeRentalListPage(HttpSession session, Model model) {
	
		MemberVo sessionUser = (MemberVo) session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		
		ArrayList<HashMap<String, Object>> rentalList = guestServiceB.getGuestRentalList(member_no);
		
		model.addAttribute("rentalList", rentalList);
		
		
		return "guest/officeRentalListPage";
	}
	
	
	@RequestMapping("writeReviewPage")
	public String writeReviewPage(HttpSession session, Model model, int order_no, int office_no) {

			HashMap<String, Object> officeInfo = guestServiceB.getOfficeInfo(office_no);

			model.addAttribute("officeInfo", officeInfo);
			model.addAttribute("order_no", order_no);

			return "guest/writeReviewPage";
	}

	@RequestMapping("writeReviewProcess")
	public String writeReviewProcess(ReviewVo rvo, MultipartFile uploadReviewImage) {

		System.out.println("uploadReviewImage : " + uploadReviewImage);

	    if(uploadReviewImage.isEmpty()) {
	    	rvo.setReview_image("imageNone");
	    } else if(uploadReviewImage != null) {	    	

			//날짜별 폴더 생성
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/");
			String folderPath = sdf.format(today);

			File todayFolder = new File(uploadFolder + folderPath);

			if(!todayFolder.exists()) {
				todayFolder.mkdirs();
			}

			// 중복되지않게 저장
			String fileName = "";
			UUID uuid = UUID.randomUUID();
			fileName += uuid.toString();

			long currentTime = System.currentTimeMillis();
			fileName += "_" + currentTime;

			//확장자 추가
			String originalFileName = uploadReviewImage.getOriginalFilename();
			String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
			fileName += ext;

			try {
				uploadReviewImage.transferTo(new File(uploadFolder + folderPath + fileName));
			} catch(Exception e) {
				e.printStackTrace();
			}

			rvo.setReview_image(folderPath + fileName);
	    } else {
			rvo.setReview_image("imageNone");
		}

		guestServiceB.writeReview(rvo);

		return "redirect:./officeRentalListPage";
	}
	
	
	

}
