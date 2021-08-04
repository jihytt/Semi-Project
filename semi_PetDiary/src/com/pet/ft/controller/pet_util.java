package com.pet.ft.controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

import com.pet.ft.dto.CalendarDto;
import com.pet.ft.model.PetDao;
import com.pet.ft.model.PetDaoImpl;

public class pet_util {

	static PetDao dao = new PetDaoImpl();
	
	public static String FromMemberNoTogetName(int member_no) {
		return dao.MemberOne(member_no).getMember_name();
	}
	public static String FromMemberNoTogetPhone(int member_no) {
		return dao.MemberOne(member_no).getMember_phone();
	}
	public static String FromMemberNoTogetEmail(int member_no) {
		return dao.MemberOne(member_no).getMember_email();
	}
	public static String FromMemberNoTogetAddress(int member_no) {
		return dao.MemberOne(member_no).getMember_address();
	}
	public static String FromMemberNoTogetId(int member_no) {
		return dao.MemberOne(member_no).getMember_id();
	}	


	public static int CommunityCommentCount(int seq) {
		
		int res = dao.CommunityCommentCount(seq)-1;
		if(res ==-1) {
			res = 0;
		}
		return res;
	}
	public static int LikesCount(int seq) {
		return dao.SelectLikeCount(seq);
	}
	

	public static String fontColor(int date, int dayOfWeek) {
		String color = "";
		
		if ((dayOfWeek-1+date) % 7 == 0) {
			color= "blue";
		} else if ((dayOfWeek-1+date)%7 == 1) {
			color = "red";
		} else {
			color = "black";
		}
		
		return color;
	}
	
	public static String isTwo(String msg) {
		return (msg.length() < 2)? "0"+msg : msg;
	}
	
	public static String getCalView(int i, List<CalendarDto> list) {
		String d = isTwo(i+"");
		String res = "";
		
		for (CalendarDto dto : list) {
			if (dto.getCalendar_startdate().substring(6, 8).equals(d)) {
				res += "<p name=\"view\" id=\"view\">"
						+ ((dto.getCalendar_title().length() > 5)? dto.getCalendar_title().substring(0,5) : dto.getCalendar_title())
						+ "</p>";
			}
		}
		return res;
	}
}
