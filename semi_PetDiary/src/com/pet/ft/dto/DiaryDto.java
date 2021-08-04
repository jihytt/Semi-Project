package com.pet.ft.dto;

import java.util.Date;

public class DiaryDto {

    private int diary_no;
    private String diary_title;
    private String diary_content;
    private Date diary_regdate;
    private int member_no;

    public DiaryDto() {
    }

    public DiaryDto(int diary_no, String diary_title, String diary_content, Date diary_regdate, int member_no) {
        this.diary_no = diary_no;
        this.diary_title = diary_title;
        this.diary_content = diary_content;
        this.diary_regdate = diary_regdate;
        this.member_no = member_no;
    }

    public int getDiary_no() {
        return diary_no;
    }

    public void setDiary_no(int diary_no) {
        this.diary_no = diary_no;
    }

    public String getDiary_title() {
        return diary_title;
    }

    public void setDiary_title(String diary_title) {
        this.diary_title = diary_title;
    }

    public String getDiary_content() {
        return diary_content;
    }

    public void setDiary_content(String diary_content) {
        this.diary_content = diary_content;
    }

    public Date getDiary_regdate() {
        return diary_regdate;
    }

    public void setDiary_regdate(Date diary_regdate) {
        this.diary_regdate = diary_regdate;
    }

    public int getMember_no() {
        return member_no;
    }

    public void setMember_no(int member_no) {
        this.member_no = member_no;
    }
}
