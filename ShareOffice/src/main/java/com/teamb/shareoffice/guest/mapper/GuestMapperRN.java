package com.teamb.shareoffice.guest.mapper;

import java.util.*;

import org.apache.ibatis.annotations.Param;

import com.teamb.shareoffice.vo.OrderVo;

public interface GuestMapperRN {
	public ArrayList<HashMap<String, Object>> selectMemberCoupon(int member_no);
	public void useCoupon(int allot_no);
	public OrderVo selectOrderByOrderNo (int order_no);
	public int selectBusinessDayPrice(@Param("office_no") int office_no, @Param("business_day") String business_day);
}
