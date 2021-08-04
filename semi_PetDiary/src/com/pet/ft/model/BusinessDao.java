package com.pet.ft.model;

import java.util.List;

import com.pet.ft.dto.BookDto;
import com.pet.ft.dto.BusinessDto;

public interface BusinessDao {
	String namespace1 = "com.pet.ft.mapper.";

	List<BusinessDto> BusinessList();
	public List<BusinessDto> BusinessList(int offset, int noOfRecords);
	
	public int businessTotal();
	
	BusinessDto businessOne(int business_num);//mapper id = businessOne
	
	int bookInsert(BookDto bookDto);//bookInsert: mapper에서 쓰는 아이디

	int BusinessInsert(BusinessDto bdto);
	
	public List<BusinessDto> menu();
}
