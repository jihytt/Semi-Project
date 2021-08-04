package com.pet.ft.dto;

public class LikesDto {

	private int member_no;
	private int community_seq;
	public LikesDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public LikesDto(int member_no, int community_seq) {
		super();
		this.member_no = member_no;
		this.community_seq = community_seq;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public int getCommunity_seq() {
		return community_seq;
	}
	public void setCommunity_seq(int community_seq) {
		this.community_seq = community_seq;
	}
	
	
	
}
