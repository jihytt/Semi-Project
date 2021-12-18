package com.pet.ft.dto;

public class OrderDto {

    private int order_no;
    private String merchant_uid;
    private String order_date;
    private String order_state;
    private String order_information;
    private int order_amount;
    private int member_no;
    private String member_name;
    private int book_num;

    public OrderDto() {
    }

    public OrderDto(int order_no, String merchant_uid, String order_date, String order_state, String order_information, int order_amount, int member_no, String member_name, int book_num) {
        this.order_no = order_no;
        this.merchant_uid = merchant_uid;
        this.order_date = order_date;
        this.order_state = order_state;
        this.order_information = order_information;
        this.order_amount = order_amount;
        this.member_no = member_no;
        this.member_name = member_name;
        this.book_num = book_num;
    }

    public String getMerchant_uid() {
        return merchant_uid;
    }

    public void setMerchant_uid(String merchant_uid) {
        this.merchant_uid = merchant_uid;
    }

    public int getOrder_no() {
        return order_no;
    }

    public void setOrder_no(int order_no) {
        this.order_no = order_no;
    }

    public String getOrder_date() {
        return order_date;
    }

    public void setOrder_date(String order_date) {
        this.order_date = order_date;
    }

    public String getOrder_state() {
        return order_state;
    }

    public void setOrder_state(String order_state) {
        this.order_state = order_state;
    }

    public String getOrder_information() {
        return order_information;
    }

    public void setOrder_information(String order_information) {
        this.order_information = order_information;
    }

    public String getMember_name() {
        return member_name;
    }

    public void setMember_name(String member_name) {
        this.member_name = member_name;
    }

    public int getOrder_amount() {
        return order_amount;
    }

    public void setOrder_amount(int order_amount) {
        this.order_amount = order_amount;
    }

    public int getMember_no() {
        return member_no;
    }

    public void setMember_no(int member_no) {
        this.member_no = member_no;
    }

    public int getBook_num() {
        return book_num;
    }

    public void setBook_num(int book_num) {
        this.book_num = book_num;
    }
}
