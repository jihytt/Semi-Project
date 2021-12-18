package com.pet.ft.dto;

import java.util.Date;

public class CommunityDto {
	
	private int community_seq;
	private String community_title;
	private String community_content;
	private Date community_regdate;
	private String community_report;
	private int community_reportcount;
	private String community_reportcontent;
	private int community_no;
	private int community_comment;
	private int community_like;
	private int community_views;	
	private int member_no;
	private MemberDto memberVO;
	
	public CommunityDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	

	public CommunityDto(int community_seq, String community_title, String community_content, Date community_regdate,
			String community_report, int community_reportcount, int community_no, int comment_no, int member_no) {
		super();
		this.community_seq = community_seq;
		this.community_title = community_title;
		this.community_content = community_content;
		this.community_regdate = community_regdate;
		this.community_report = community_report;
		this.community_reportcount = community_reportcount;
		this.community_no = community_no;
		this.community_comment = community_comment;
		this.member_no = member_no;
	}

	public CommunityDto(int community_seq, String community_title, String community_content, Date community_regdate,
			String community_report, int community_reportcount, String community_reportcontent, int community_no,
			int comment_no, int community_like, int community_views, int member_no) {
		super();
		this.community_seq = community_seq;
		this.community_title = community_title;
		this.community_content = community_content;
		this.community_regdate = community_regdate;
		this.community_report = community_report;
		this.community_reportcount = community_reportcount;
		this.community_reportcontent = community_reportcontent;
		this.community_no = community_no;
		this.community_comment = community_comment;
		this.community_like = community_like;
		this.community_views = community_views;
		this.member_no = member_no;
	}

	public int getCommunity_seq() {
		return community_seq;
	}

	public void setCommunity_seq(int community_seq) {
		this.community_seq = community_seq;
	}

	public String getCommunity_title() {
		return community_title;
	}

	public void setCommunity_title(String community_title) {
		this.community_title = community_title;
	}

	public String getCommunity_content() {
		return community_content;
	}

	public void setCommunity_content(String community_content) {
		this.community_content = community_content;
	}

	public Date getCommunity_regdate() {
		return community_regdate;
	}

	public void setCommunity_regdate(Date community_regdate) {
		this.community_regdate = community_regdate;
	}

	public String getCommunity_report() {
		return community_report;
	}

	public void setCommunity_report(String community_report) {
		this.community_report = community_report;
	}

	public int getCommunity_reportcount() {
		return community_reportcount;
	}

	public void setCommunity_reportcount(int community_reportcount) {
		this.community_reportcount = community_reportcount;
	}

	public String getCommunity_reportcontent() {
		return community_reportcontent;
	}

	public void setCommunity_reportcontent(String community_reportcontent) {
		this.community_reportcontent = community_reportcontent;
	}

	public int getCommunity_no() {
		return community_no;
	}

	public void setCommunity_no(int community_no) {
		this.community_no = community_no;
	}

	public int getComment_no() {
		return community_comment;
	}

	public void setComment_no(int comment_no) {
		this.community_comment = community_comment;
	}

	public int getCommunity_like() {
		return community_like;
	}

	public void setCommunity_like(int community_like) {
		this.community_like = community_like;
	}

	public int getCommunity_views() {
		return community_views;
	}

	public void setCommunity_views(int community_views) {
		this.community_views = community_views;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	

	public MemberDto getMemberVO() {
		return memberVO;
	}

	public void setMemberVO(MemberDto memberVO) {
		this.memberVO = memberVO;
	}
}
