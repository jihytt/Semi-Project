package com.pet.ft.dto;

public class PictureDto {
    private int picture_no;
    private String picture_name;
    private String picture_directory;
    private int member_no;

    public PictureDto() {
    }

    public PictureDto(int picture_no, String picture_name, String picture_directory, int member_no) {
        this.picture_no = picture_no;
        this.picture_name = picture_name;
        this.picture_directory = picture_directory;
        this.member_no = member_no;
    }

    public int getPicture_no() {
        return picture_no;
    }

    public void setPicture_no(int picture_no) {
        this.picture_no = picture_no;
    }

    public String getPicture_name() {
        return picture_name;
    }

    public void setPicture_name(String picture_name) {
        this.picture_name = picture_name;
    }

    public String getPicture_directory() {
        return picture_directory;
    }

    public void setPicture_directory(String picture_directory) {
        this.picture_directory = picture_directory;
    }

    public int getMember_no() {
        return member_no;
    }

    public void setMember_no(int member_no) {
        this.member_no = member_no;
    }
}
