package com.pet.ft.dto;

public class TravelDto {
	private int travel_no;
	private String travel_date;
	private String travel_name;
	private String travel_spot1;
	private String travel_spot2;
	private String travel_spot3;
	private int travel_time1;
	private int travel_time2;
	private int travel_stay1;
	private int travel_stay2;
	private int member_no;
	
	public TravelDto() {
	
	}

	public TravelDto(int travel_no, String travel_date, String travel_name, String travel_spot1, String travel_spot2,
			String travel_spot3, int travel_time1, int travel_time2, int travel_stay1, int travel_stay2,
			int member_no) {
		
		this.travel_no = travel_no;
		this.travel_date = travel_date;
		this.travel_name = travel_name;
		this.travel_spot1 = travel_spot1;
		this.travel_spot2 = travel_spot2;
		this.travel_spot3 = travel_spot3;
		this.travel_time1 = travel_time1;
		this.travel_time2 = travel_time2;
		this.travel_stay1 = travel_stay1;
		this.travel_stay2 = travel_stay2;
		this.member_no = member_no;
	}

	public int getTravel_no() {
		return travel_no;
	}

	public void setTravel_no(int travel_no) {
		this.travel_no = travel_no;
	}

	public String getTravel_date() {
		return travel_date;
	}

	public void setTravel_date(String travel_date) {
		this.travel_date = travel_date;
	}

	public String getTravel_name() {
		return travel_name;
	}

	public void setTravel_name(String travel_name) {
		this.travel_name = travel_name;
	}

	public String getTravel_spot1() {
		return travel_spot1;
	}

	public void setTravel_spot1(String travel_spot1) {
		this.travel_spot1 = travel_spot1;
	}

	public String getTravel_spot2() {
		return travel_spot2;
	}

	public void setTravel_spot2(String travel_spot2) {
		this.travel_spot2 = travel_spot2;
	}

	public String getTravel_spot3() {
		return travel_spot3;
	}

	public void setTravel_spot3(String travel_spot3) {
		this.travel_spot3 = travel_spot3;
	}

	public int getTravel_time1() {
		return travel_time1;
	}

	public void setTravel_time1(int travel_time1) {
		this.travel_time1 = travel_time1;
	}

	public int getTravel_time2() {
		return travel_time2;
	}

	public void setTravel_time2(int travel_time2) {
		this.travel_time2 = travel_time2;
	}

	public int getTravel_stay1() {
		return travel_stay1;
	}

	public void setTravel_stay1(int travel_stay1) {
		this.travel_stay1 = travel_stay1;
	}

	public int getTravel_stay2() {
		return travel_stay2;
	}

	public void setTravel_stay2(int travel_stay2) {
		this.travel_stay2 = travel_stay2;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	
	
	
	
	
	


}
