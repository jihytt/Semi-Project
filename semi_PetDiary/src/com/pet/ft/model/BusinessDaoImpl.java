package com.pet.ft.model;

import com.pet.ft.dto.BookDto;

import com.pet.ft.dto.BusinessDto;
import com.pet.ft.dto.CommunityDto;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;


public class BusinessDaoImpl extends SqlMapConfig implements BusinessDao {
	
	int noOfRecords;
	
	public int getNoOfRecords() {
		return noOfRecords;
	}
	

	@Override
	public List<BusinessDto> BusinessList(int offset, int noOfRecords) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("offset", offset);
		params.put("noOfRecords", noOfRecords);
		
		SqlSession session = getSqlSessionFactory().openSession();
		List<BusinessDto> list = session.selectList(namespace1+"BusinessList", params);
		session.close();
		
		return list;
	}
	
	@Override
	public BusinessDto businessOne(int business_num) {
		BusinessDto bdto = null;
		SqlSession session = null;
		
		try {
			session = getSqlSessionFactory().openSession();
			bdto = session.selectOne(namespace1+"BusinessOne", business_num);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return bdto;
	
	}

	@Override
	public int BusinessInsert(BusinessDto bdto) {
		int res = 0;
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			res = session.insert(namespace1+"BusinessInsert", bdto);
		}
		return res;
	}
	

	@Override
	public int bookInsert(BookDto bookDto) {
		int res = 0;
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			res = session.insert(namespace1+"BookInsert", bookDto);
		}
		return res;
	}


	@Override
	public int businessTotal() {
		int res = 0;
		try (SqlSession session = getSqlSessionFactory().openSession(true)){
			res  = session.selectOne(namespace1 + "BusinessTotal");
		}
		return res;
	}


	@Override
	public List<BusinessDto> menu() {
		SqlSession session = getSqlSessionFactory().openSession();
		List<BusinessDto> list = session.selectList(namespace1+"menu");
		session.close();
		return list;
	}


	@Override
	public List<BusinessDto> BusinessList() {

		List<BusinessDto> list = new ArrayList<BusinessDto>();
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			list = session.selectList(namespace1+"BusinessList");
		}
		return list;
	}



}
