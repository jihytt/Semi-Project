package com.pet.ft.dto;

import java.util.Date;

public class PetDto {
    private int pet_no;
    private String pet_species;
    private String pet_breed;
    private String pet_name;
    private String pet_birthday;
    private String pet_gender;
    private int member_no;
    private String pet_path;
    private String pet_vaccination;

    public PetDto() {
    }

    public PetDto(int pet_no, String pet_species, String pet_breed, String pet_name, String pet_birthday, String pet_gender, int member_no, String pet_path, String pet_vaccination) {
        this.pet_no = pet_no;
        this.pet_species = pet_species;
        this.pet_breed = pet_breed;
        this.pet_name = pet_name;
        this.pet_birthday = pet_birthday;
        this.pet_gender = pet_gender;
        this.member_no = member_no;
        this.pet_path = pet_path;
        this.pet_vaccination = pet_vaccination;
    }

    public int getPet_no() {
        return pet_no;
    }

    public void setPet_no(int pet_no) {
        this.pet_no = pet_no;
    }

    public String getPet_species() {
        return pet_species;
    }

    public void setPet_species(String pet_species) {
        this.pet_species = pet_species;
    }

    public String getPet_breed() {
        return pet_breed;
    }

    public void setPet_breed(String pet_breed) {
        this.pet_breed = pet_breed;
    }

    public String getPet_name() {
        return pet_name;
    }

    public void setPet_name(String pet_name) {
        this.pet_name = pet_name;
    }

    public String getPet_birthday() {
        return pet_birthday;
    }

    public void setPet_birthday(String pet_birthday) {
        this.pet_birthday = pet_birthday;
    }

    public String getPet_gender() {
        return pet_gender;
    }

    public void setPet_gender(String pet_gender) {
        this.pet_gender = pet_gender;
    }

    public int getMember_no() {
        return member_no;
    }

    public void setMember_no(int member_no) {
        this.member_no = member_no;
    }

    public String getPet_path() {
        return pet_path;
    }

    public void setPet_path(String pet_path) {
        this.pet_path = pet_path;
    }

    public String getPet_vaccination() {
        return pet_vaccination;
    }

    public void setPet_vaccination(String pet_vaccination) {
        this.pet_vaccination = pet_vaccination;
    }
}
