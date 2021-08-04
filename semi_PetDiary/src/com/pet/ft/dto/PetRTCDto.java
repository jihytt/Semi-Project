package com.pet.ft.dto;

public class PetRTCDto {
	private String rtc_room;
	private String rtc_use;
	private int member_no;
	private int business_num;
	public PetRTCDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public PetRTCDto(String rtc_room, String rtc_use, int member_no, int business_num) {
		super();
		this.rtc_room = rtc_room;
		this.rtc_use = rtc_use;
		this.member_no = member_no;
		this.business_num = business_num;
	}
	public String getRtc_room() {
		return rtc_room;
	}
	public void setRtc_room(String rtc_room) {
		this.rtc_room = rtc_room;
	}
	public String getRtc_use() {
		return rtc_use;
	}
	public void setRtc_use(String rtc_use) {
		this.rtc_use = rtc_use;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public int getBusiness_num() {
		return business_num;
	}
	public void setBusiness_num(int business_num) {
		this.business_num = business_num;
	}
	
	
}
