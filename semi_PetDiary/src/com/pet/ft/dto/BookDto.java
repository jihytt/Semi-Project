package com.pet.ft.dto;


public class BookDto {

	private int book_num;
	private String book_date;
	private String book_time;
	private String book_type;
	private int business_num;	
	private int member_no;
	private String book_price;
	private String book_state;
	private String book_hostime;
	private String book_counsel;
	
	private MemberDto memberVO;
	private BusinessDto businessVO;
	
	public BookDto() {

	}


	public BookDto(int book_num, String book_date, String book_time, String book_type, int business_num, int member_no,
			String book_price, String book_state, String book_hostime, String book_counsel) {
		super();

		this.book_num = book_num;
		this.book_date = book_date;
		this.book_time = book_time;
		this.book_type = book_type;
		this.business_num = business_num;
		this.member_no = member_no;
		this.book_price = book_price;
		this.book_state = book_state;
		this.book_hostime = book_hostime;
		this.book_counsel = book_counsel;
	}

	public BookDto(int book_num, String book_date, String book_time, String book_type, int business_num, int member_no,
			String book_price, String book_state, String book_hostime, String book_counsel, MemberDto memberVO,
			BusinessDto businessVO) {
		super();
		this.book_num = book_num;
		this.book_date = book_date;
		this.book_time = book_time;
		this.book_type = book_type;
		this.business_num = business_num;
		this.member_no = member_no;
		this.book_price = book_price;
		this.book_state = book_state;
		this.book_hostime = book_hostime;
		this.book_counsel = book_counsel;
		this.memberVO = memberVO;
		this.businessVO = businessVO;
	}

	public int getBook_num() {
		return book_num;
	}


	public void setBook_num(int book_num) {
		this.book_num = book_num;
	}


	public String getBook_date() {
		return book_date;
	}



	public void setBook_date(String book_date) {
		this.book_date = book_date;
	}


	public String getBook_time() {
		return book_time;
	}


	public void setBook_time(String book_time) {
		this.book_time = book_time;
	}


	public String getBook_type() {
		return book_type;
	}


	public void setBook_type(String book_type) {
		this.book_type = book_type;
	}


	public int getBusiness_num() {
		return business_num;
	}


	public void setBusiness_num(int business_num) {
		this.business_num = business_num;
	}


	public int getMember_no() {
		return member_no;
	}



	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public String getBook_price() {
		return book_price;
	}

	public void setBook_price(String book_price) {
		this.book_price = book_price;
	}


	public String getBook_state() {
		return book_state;
	}


	public void setBook_state(String book_state) {
		this.book_state = book_state;
	}


	public String getBook_hostime() {
		return book_hostime;
	}
	


	public void setBook_hostime(String book_hostime) {
		this.book_hostime = book_hostime;
	}

	public String getBook_counsel() {
		return book_counsel;
	}

	public void setBook_counsel(String book_counsel) {
		this.book_counsel = book_counsel;
	}

	public MemberDto getMemberVO() {
		return memberVO;
	}

	public void setMemberVO(MemberDto memberVO) {
		this.memberVO = memberVO;
	}

	public BusinessDto getBusinessVO() {
		return businessVO;
	}

	public void setBusinessVO(BusinessDto businessVO) {
		this.businessVO = businessVO;
	}
	
}
