package com.pet.ft.dto;

public class MemberDto {
	
	private int member_no;
	private String member_name;
	private String member_id;
	private String member_pw;
	private String member_email;
	private String member_phone;
	private String member_role;
	private String member_address;
	
	public MemberDto() {
		
	}

	public MemberDto(int member_no, String member_name, String member_id, String member_pw, String member_email,
			String member_phone, String member_role, String member_address) {
		super();
		this.member_no = member_no;
		this.member_name = member_name;
		this.member_id = member_id;
		this.member_pw = member_pw;
		this.member_email = member_email;
		this.member_phone = member_phone;
		this.member_role = member_role;
		this.member_address = member_address;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_pw() {
		return member_pw;
	}

	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}

	public String getMember_email() {
		return member_email;
	}

	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}

	public String getMember_phone() {
		return member_phone;
	}

	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}

	public String getMember_role() {
		return member_role;
	}

	public void setMember_role(String member_role) {
		this.member_role = member_role;
	}

	public String getMember_address() {
		return member_address;
	}

	public void setMember_address(String member_address) {
		this.member_address = member_address;
	}

	

}
