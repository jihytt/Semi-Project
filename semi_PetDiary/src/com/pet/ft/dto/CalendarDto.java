package com.pet.ft.dto;
public class CalendarDto {

	private int calendar_no;
	private String calendar_startdate;
	private String calendar_enddate;
	private String calendar_necessity;
	private String calendar_item;
	private String calendar_title;
	private String calendar_content;
	private int member_no;
	
	public CalendarDto() {
		
	}

	public CalendarDto(int calendar_no, String calendar_startdate, String calendar_enddate, String calendar_necessity,
			String calendar_item, String calendar_title, String calendar_content, int member_no) {
		super();
		this.calendar_no = calendar_no;
		this.calendar_startdate = calendar_startdate;
		this.calendar_enddate = calendar_enddate;
		this.calendar_necessity = calendar_necessity;
		this.calendar_item = calendar_item;
		this.calendar_title = calendar_title;
		this.calendar_content = calendar_content;
		this.member_no = member_no;
	}

	public int getCalendar_no() {
		return calendar_no;
	}

	public void setCalendar_no(int calendar_no) {
		this.calendar_no = calendar_no;
	}

	public String getCalendar_startdate() {
		return calendar_startdate;
	}

	public void setCalendar_startdate(String calendar_startdate) {
		this.calendar_startdate = calendar_startdate;
	}

	public String getCalendar_enddate() {
		return calendar_enddate;
	}

	public void setCalendar_enddate(String calendar_enddate) {
		this.calendar_enddate = calendar_enddate;
	}

	public String getCalendar_necessity() {
		return calendar_necessity;
	}

	public void setCalendar_necessity(String calendar_necessity) {
		this.calendar_necessity = calendar_necessity;
	}

	public String getCalendar_item() {
		return calendar_item;
	}

	public void setCalendar_item(String calendar_item) {
		this.calendar_item = calendar_item;
	}

	public String getCalendar_title() {
		return calendar_title;
	}

	public void setCalendar_title(String calendar_title) {
		this.calendar_title = calendar_title;
	}

	public String getCalendar_content() {
		return calendar_content;
	}

	public void setCalendar_content(String calendar_content) {
		this.calendar_content = calendar_content;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

}
