package com.pet.ft.dto;

public class ProfileDto {

	private String profile_src;
	private String profile_state;
	private int member_no;
	
	public ProfileDto() {
		super();
	}

	public ProfileDto(String profile_src, String profile_state, int member_no) {
		super();
		this.profile_src = profile_src;
		this.profile_state = profile_state;
		this.member_no = member_no;
	}

	public String getProfile_src() {
		return profile_src;
	}

	public void setProfile_src(String profile_src) {
		this.profile_src = profile_src;
	}

	public String getProfile_state() {
		return profile_state;
	}

	public void setProfile_state(String profile_state) {
		this.profile_state = profile_state;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	
}
