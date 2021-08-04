package com.pet.ft.dto;

public class BusinessDto {
	private int business_num;
	private String business_name;
	private String member_phone;
	private String menu_name;
	private String menu_price;
	private String business_addr;
	private String business_role;
	private String business_time;
	private String business_park;
	private String business_book;
	private String business_etc;
	private int business_no;
	private int member_no;
	

	
	public BusinessDto() {
		
	}

	public BusinessDto(int business_num, String business_name, String member_phone, String menu_name, String menu_price,
			String business_addr, String business_role, String business_time, String business_park,
			String business_book, String business_etc, int business_no, int member_no) {
		super();
		this.business_num = business_num;
		this.business_name = business_name;
		this.member_phone = member_phone;
		this.menu_name = menu_name;
		this.menu_price = menu_price;
		this.business_addr = business_addr;
		this.business_role = business_role;
		this.business_time = business_time;
		this.business_park = business_park;
		this.business_book = business_book;
		this.business_etc = business_etc;
		this.business_no = business_no;
		this.member_no = member_no;
	}
	

	public int getBusiness_num() {
		return business_num;
	}

	public void setBusiness_num(int business_num) {
		this.business_num = business_num;
	}

	public String getBusiness_name() {
		return business_name;
	}

	public void setBusiness_name(String business_name) {
		this.business_name = business_name;
	}

	public String getMember_phone() {
		return member_phone;
	}

	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}

	public String getMenu_name() {
		return menu_name;
	}

	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}

	public String getMenu_price() {
		return menu_price;
	}

	public void setMenu_price(String menu_price) {
		this.menu_price = menu_price;
	}

	public String getBusiness_addr() {
		return business_addr;
	}

	public void setBusiness_addr(String business_addr) {
		this.business_addr = business_addr;
	}

	public String getBusiness_role() {
		return business_role;
	}

	public void setBusiness_role(String business_role) {
		this.business_role = business_role;
	}

	public String getBusiness_time() {
		return business_time;
	}

	public void setBusiness_time(String business_time) {
		this.business_time = business_time;
	}

	public String getBusiness_park() {
		return business_park;
	}

	public void setBusiness_park(String business_park) {
		this.business_park = business_park;
	}

	public String getBusiness_book() {
		return business_book;
	}

	public void setBusiness_book(String business_book) {
		this.business_book = business_book;
	}

	public String getBusiness_etc() {
		return business_etc;
	}

	public void setBusiness_etc(String business_etc) {
		this.business_etc = business_etc;
	}

	public int getBusiness_no() {
		return business_no;
	}

	public void setBusiness_no(int business_no) {
		this.business_no = business_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	
	}
