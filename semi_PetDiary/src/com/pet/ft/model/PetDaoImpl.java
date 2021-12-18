package com.pet.ft.model;

import com.pet.ft.dto.*;

import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

public class PetDaoImpl extends SqlMapConfig implements PetDao {


	int noOfRecords;
	
	public int getNoOfRecords() {
		return noOfRecords;
	}
	@Override
	public MemberDto SocialLogin(String member_id) {
		MemberDto dto = null;

		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			dto = session.selectOne(namespace+"SocialLogin", member_id);
		}
		return dto;
	}


	@Override
	public MemberDto findId(String member_name, String member_email) {
		MemberDto dto = null;
		Map<String, String> map = new HashMap<String, String>();
		map.put("member_name", member_name);
		map.put("member_email", member_email);
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			dto = session.selectOne(namespace+"findId", map);
		}
		return dto;
	}

	@Override
	public MemberDto findPw(String member_name, String member_email, String member_id) {
		MemberDto dto = null;
		Map<String, String> map = new HashMap<String, String>();
		map.put("member_name", member_name);
		map.put("member_email", member_email);
		map.put("member_id", member_id);
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			dto = session.selectOne(namespace+"findPw", map);
		}
		return dto;
	}

	@Override
	public int resetPw(String member_name, String member_email, String member_id, String member_pw) {
		int res=0;
		Map<String, String> map = new HashMap<String, String>();
		map.put("member_name", member_name);
		map.put("member_email", member_email);
		map.put("member_id", member_id);
		map.put("member_pw", member_pw);
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			res = session.update(namespace+"resetPw", map);
		}
		return res;
	}

	@Override
	public int memberDelete(int member_no) {
		int res = 0;
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			res = session.delete(namespace+"memberDelete", member_no);
		}
		return res;
	}

	@Override
	public int totalBookHos(int member_no) {

		int res = 0;
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			res = session.selectOne(namespace + "totalBookHos", member_no);
		}
		return res;
	}

	@Override
	public int totalBookSt(int member_no) {
		int res = 0;
		try (SqlSession session = getSqlSessionFactory().openSession(true)) {
			res = session.selectOne(namespace + "totalBookSt", member_no);
		}
		return res;
	}

	@Override
	public List<BookDto> totalDateTime() {
		SqlSession session = getSqlSessionFactory().openSession();
		List<BookDto> list = session.selectList(namespace + "totalDateTime");
		session.close();
		return list;
	}

	@Override
	public List<CommunityDto> reportList(int offset, int noOfRecords) {

		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("offset", offset);
		params.put("noOfRecords", noOfRecords);
		SqlSession session = getSqlSessionFactory().openSession();
		List<CommunityDto> list = session.selectList(namespace + "reportListPaging", params);	// �������� �� record����
		session.close();

		return list;
	}

	@Override
	public List<BookDto> bookListHos(int offset, int noOfRecords, int member_no) {
		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("offset", offset);
		params.put("noOfRecords", noOfRecords);
		params.put("member_no", member_no);

		SqlSession session = getSqlSessionFactory().openSession();
		List<BookDto> list = session.selectList(namespace + "bookListHosPaging", params);
		session.close();

		return list;
	}

	@Override
	public List<BookDto> bookListSt(int offset, int noOfRecords, int member_no) {
		HashMap<String, Object> params = new HashMap<String, Object>();

		System.out.println("of :" + offset + "no : " + noOfRecords + "no :" + member_no);

		params.put("offset", offset);
		params.put("noOfRecords", noOfRecords);
		params.put("member_no", member_no);

		SqlSession session = getSqlSessionFactory().openSession();
		List<BookDto> list = session.selectList(namespace + "bookListStPaging", params);
		session.close();

		return list;
	}

	@Override
	public MemberDto MemberOne(int member_no) {
		MemberDto mdto = null;
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			mdto = session.selectOne(namespace+"MemberOne", member_no);
		}		
		return mdto;
	}
	

	
	@Override
	public int totalReport() {
		int res = 0;
		try (SqlSession session = getSqlSessionFactory().openSession(true)){
			res  = session.selectOne(namespace + "totalReport");
		}
		return res;
	}
	

	@Override
	public List<CommunityDto> CommunityPageList(int page) {
		List<CommunityDto> list = new ArrayList<CommunityDto>();
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			list = session.selectList(namespace+"CommunityPageList", page);
		}
		return list;
	}

	@Override
	public List<CommunityDto> MyCommunityList(int member_no) {
		List<CommunityDto> list = new ArrayList<CommunityDto>();
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			list = session.selectList(namespace+"MyCommunityList",member_no);
		}
		return list;
	}

	@Override
	public int CommunityPageMax() {
		int res  = 0;
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			if(session.selectOne(namespace+"CommunityPageMax")!=null) {
				res = session.selectOne(namespace+"CommunityPageMax");
			}
		}
		return res;
	}

	@Override
	public List<CommunityDto> CommunityList() {
		List<CommunityDto> list = new ArrayList<CommunityDto>();
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			list = session.selectList(namespace+"CommunityList");
		}
		return list;
	}

	@Override
	public List<CommunityDto> CommunityList(int member_no) {
		List<CommunityDto> list = new ArrayList<CommunityDto>();
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			list = session.selectList(namespace+"MyCommunityList", member_no);
		}
		return list;
	}

	@Override
	public int totalMember() {
		
		int res = 0;
		try (SqlSession session = getSqlSessionFactory().openSession(true)){
			res  = session.selectOne(namespace + "totalMember");
		}
		return res;
		
	}
	
	@Override
	public List<MemberDto> memberList(int offset, int noOfRecords) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("offset", offset);
		params.put("noOfRecords", noOfRecords);
		SqlSession session = getSqlSessionFactory().openSession();
		List<MemberDto> list = session.selectList(namespace + "memberListPaging", params);	// �������� �� record����
		session.close();

		return list;
	}


	//병원상담
	@Override
	public List<BusinessDto> hospitalList(int offset, int noOfRecords) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("offset", offset);
		params.put("noOfRecords", noOfRecords);
	    SqlSession session = getSqlSessionFactory().openSession();
		List<BusinessDto> list = session.selectList(namespace+"hospitalList",params);
		session.close();
		
		return list;
	}
	
	
	public int totalHospital() {

		int res = 0;
		try (SqlSession session = getSqlSessionFactory().openSession(true)){
			res  = session.selectOne(namespace + "totalHospital");
		}
		return res;

	}
	

	
	// 내가 작성

	@Override
	public int MemberInsert(MemberDto dto) {
		int res = 0;
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			res = session.insert(namespace+"MemberInsert", dto);
		}
		return res;
	}

	@Override
	public BusinessDto hospitalSelect(int business_num) {
		SqlSession session = null;
		BusinessDto dto = null;

		try {
			session = getSqlSessionFactory().openSession();
			dto = session.selectOne(namespace + "hospitalOne", business_num);
		} catch (Exception e) {

			e.printStackTrace();
		}finally {
			session.close();
		}
		return dto;
	}

	public MemberDto SignUpIdChk(String member_id) {
		MemberDto dto = null;
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			dto = session.selectOne(namespace+"SignUpIdChk", member_id);
		}
		return dto;
	}


	@Override
	public List<TravelDto> travelList(int member_no) {
		SqlSession session = getSqlSessionFactory().openSession();
		List<TravelDto> list = session.selectList(namespace + "travelList",member_no);
		session.close();

		return list;
	}

	@Override
	public TravelDto travelSelect(int travel_no) {
		TravelDto dto = null;
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			dto = session.selectOne(namespace+"travelSelect", travel_no);
		}
		return dto;

	}


	@Override
	public int CalendarInsert(CalendarDto CalDto) {
		int res = 0;
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			res = session.insert(namespace+"CalendarInsert", CalDto);
		}
		return res;
	}






	@Override
	public int changeRole(MemberDto dto) {
		
		int res = 0;
		
		try (SqlSession session = getSqlSessionFactory().openSession(true)){
			res = session.update(namespace + "changeRole", dto);
		}
		
		return res;
	}
	
	@Override
	public int deleteCommnutiy(int seq) {
		int res = 0;
		try(SqlSession session = getSqlSessionFactory().openSession(true)) {
			res = session.update(namespace + "deleteCommunity" , seq);
		}
		return res;
	}
	@Override
	public List<CalendarDto> CalViewList(int member_no, String yyyyMM) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<CalendarDto> list = new ArrayList<CalendarDto>();
		map.put("member_no", member_no);
		map.put("calendar_startdate", yyyyMM);
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			list = session.selectList(namespace+"CalViewList",map);
		}
		return list;
	}
	@Override
	public boolean nextPage(String pageNumber) {
		boolean res = false;
		try(SqlSession session = getSqlSessionFactory().openSession(true)) {
			res = session.selectOne(namespace + "nextPage" , pageNumber);
		}
		return res;
	}

	  @Override
	    public List<PetDto> selectPetList(int member_no) {

	        SqlSession session = getSqlSessionFactory().openSession();
	        List<PetDto> list = session.selectList(namespace + "selectPetList", member_no);
	        session.close();
	        return list;
	    }

	    @Override
	    public PetDto selectPetOne(int member_no, int pet_no) {

	        SqlSession session = getSqlSessionFactory().openSession();
	        Map<String, Integer> map = new HashMap<String, Integer>();
	        map.put("member_no", member_no);
	        map.put("pet_no", pet_no);
	        PetDto dto = session.selectOne(namespace + "selectPetOne", map);
	        session.close();

	        return dto;
	    }

	    @Override
	    public int getCount(int member_no) {

	        int res = 0;
	        SqlSession session = getSqlSessionFactory().openSession();
	        res = session.selectOne(namespace + "getCount", member_no);
	        session.close();
	        return res;
	    }
	    @Override
	    public int insertPet(PetDto dto) {
	        int res = 0;

	        try (SqlSession session = getSqlSessionFactory().openSession(true)) {
	            res = session.insert(namespace + "insertPet", dto);
	        }
	        return res;
	    }

	    @Override
	    public int updatePet(PetDto dto) {

	        int res = 0;
	        try (SqlSession session = getSqlSessionFactory().openSession(true)){
	            res = session.update(namespace + "updatePet", dto);
	        }
	        return res;
	    }

	    @Override
	    public int deletePet(int member_no, int pet_no) {
	        int res = 0;
	        Map<String, Integer> map = new HashMap<String, Integer>();
	        map.put("member_no", member_no);
	        map.put("pet_no", pet_no);
	        try (SqlSession session = getSqlSessionFactory().openSession(true)){
	            res = session.delete(namespace + "deletePet", map);
	        }
	        return res;
	    }

	    @Override
	    public List<PictureDto> selectPictureList(int member_no) {

	        SqlSession session = getSqlSessionFactory().openSession();
	        List<PictureDto> list = session.selectList(namespace + "selectPictureList",  member_no);
	        session.close();
	        return list;
	    }

	    @Override
	    public PictureDto selectPictureOne(int member_no, int picture_no) {
	        SqlSession session = getSqlSessionFactory().openSession();
	        Map<String, Integer> map = new HashMap<String , Integer>();
	        map.put("member_no", member_no);
	        map.put("picture_no", picture_no);
	        PictureDto dto = session.selectOne(namespace + "selectPictureOne", map);
	        session.close();
	        return dto;
	    }

	    @Override
	    public int insertPicture(PictureDto dto) {
	        int res = 0;
	        try(SqlSession session = getSqlSessionFactory().openSession(true)) {
	            res = session.insert(namespace + "insertPicture", dto);
	        }
	        return res;
	    }

	    @Override
	    public int deletePicture(int member_no, int picture_no) {

	        int res = 0;
	        Map<String, Integer> map = new HashMap<String , Integer>();
	        map.put("member_no", member_no);
	        map.put("picture_no", picture_no);

	        try(SqlSession session = getSqlSessionFactory().openSession(true)) {
	            res = session.insert(namespace + "deletePicture", map);
	        }

	        return res;
	    }

	@Override
	public List<PictureDto> selectPicturePaging(int member_no, int min, int max) {

		SqlSession session = getSqlSessionFactory().openSession();
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("member_no", member_no);
		map.put("min", min);
		map.put("max", max);

		List<PictureDto> list = session.selectList(namespace + "selectPicturePaging", map);

		return list;
	}

	@Override
	public int getPictureCount(int member_no) {
		int res = 0;
		SqlSession session = getSqlSessionFactory().openSession();
		res = session.selectOne(namespace + "getPictureCount", member_no);

		return res;
	}

	@Override
	    public PetDto selectPetOnePaging(int member_no, int count) {


	        SqlSession session = getSqlSessionFactory().openSession();

	        Map<String, Integer> map = new HashMap<String , Integer>();
	        map.put("member_no", member_no);
	        map.put("count", count);

	        PetDto dto = session.selectOne(namespace + "selectPetOnePaging", map);
	        return dto;
	    }

	    @Override
	    public List<CalendarDto> selectTripList(int member_no) {

	        SqlSession session = getSqlSessionFactory().openSession();
	        List<CalendarDto> list = session.selectList(namespace + "selectTripList", member_no);
	        session.close();

	        return list;
	    }

	    @Override
	    public CalendarDto selectTripOne(int member_no, int calendar_no) {

	        SqlSession session = getSqlSessionFactory().openSession();
	        Map<String, Integer> map = new HashMap<String, Integer>();
	        map.put("member_no", member_no);
	        map.put("calendar_no", calendar_no);
	        CalendarDto dto = session.selectOne(namespace + "selectTripOne", map);

	        return dto;
	    }

	    @Override
	    public int insertTrip(CalendarDto dto) {

	        int res = 0;
	        try (SqlSession session = getSqlSessionFactory().openSession(true)){
	            res = session.insert(namespace + "insertTrip", dto);
	        }
	        return res;
	    }

	    @Override
	    public int updateTrip(CalendarDto dto) {

	        int res = 0;
	        try (SqlSession session = getSqlSessionFactory().openSession(true)){
	            res = session.update(namespace + "updateTrip", dto);
	        }
	        return res;
	    }

	    @Override
	    public int deleteTrip(int member_no, int calendar_no) {
	        int res = 0;
	        Map<String, Integer> map = new HashMap<String, Integer>();
	        map.put("member_no", member_no);
	        map.put("calendar_no", calendar_no);

	        try (SqlSession session = getSqlSessionFactory().openSession(true)) {
	            res = session.delete(namespace + "deleteTrip", map);
	        }
	        return res;
	    }
	    
	    @Override
	    public HashMap<String, Integer> SelectMyinfoCount(int member_no) {
	    	HashMap<String, Integer> map = new HashMap<String, Integer>();
	        try (SqlSession session = getSqlSessionFactory().openSession(true)) {
	        	
	            int CountMyinfoPet = session.selectOne(namespace + "CountMyinfoPet", member_no);
	            int CountMyinfoCalendar = session.selectOne(namespace + "CountMyinfoCalendar", member_no);
	            int CountMyinfoCommunity = session.selectOne(namespace + "CountMyinfoCommunity", member_no);
	            int CountMyinfoComment = session.selectOne(namespace + "CountMyinfoComment", member_no);
	            int CountMyinfoBook = session.selectOne(namespace + "CountMyinfoBook", member_no);
	            int CountMyinfoOrder = session.selectOne(namespace+ "CountMyinfoOrder",member_no);
	            int CountPicture = session.selectOne(namespace+ "getPictureCount",member_no);

	            map.put("CountMyinfoPet", CountMyinfoPet);
	            map.put("CountMyinfoCalendar", CountMyinfoCalendar);
	            map.put("CountMyinfoCommunity", CountMyinfoCommunity);
	            map.put("CountMyinfoComment", CountMyinfoComment);
	            map.put("CountMyinfoBook", CountMyinfoBook);
	            map.put("CountMyinfoOrder", CountMyinfoOrder);
	            map.put("CountPicture", CountPicture);
	        }
	        return map;
	    }

	
	
		@Override
		public int SocialSignUp(MemberDto dto) {
			int res = 0;
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				res = session.delete(namespace+"SocialSignUp", dto);
			}
			return res;
		}


		@Override
		public int memberUpdate(MemberDto dto) {
			int res = 0;
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				res = session.update(namespace+"memberUpdate", dto);
			}
			return res;
		}


		@Override
		public int CommunityInsert(CommunityDto CDto) {
			int res = 0;
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				res = session.insert(namespace+"CommunityInsert", CDto);
			}
			return res;
		}


		@Override
		public CommunityDto CommunityOne(int seq) {
			CommunityDto cdto = null;
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				cdto = session.selectOne(namespace+"CommunityOne", seq);
			}
			return cdto;
		}

		
		@Override
		public int CommentInsert(CommunityDto cdto) {
			int res = 0;
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				res = session.insert(namespace+"CommentInsert", cdto);
			}
			return res;
		}

		

		@Override
		public List<CommunityDto> CommunitySearchList(String filter, String community_search){
			List<CommunityDto> list = new ArrayList<CommunityDto>();		
			switch (filter) {
			case "title":
				try(SqlSession session = getSqlSessionFactory().openSession(true)){
					list = session.selectList(namespace+"CommunitySearchTitle", community_search);
				}		
				break;

			case "content":
				try(SqlSession session = getSqlSessionFactory().openSession(true)){
					list = session.selectList(namespace+"CommunitySearchContent", community_search);
				}		
				
				break;
			case "comment_content" :
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				list = session.selectList(namespace+"CommunitySearchCommentContent", community_search);
				}				
			}
			return list;
		}
	
		@Override
		public int CommunityReport(CommunityDto dto) {
			int res = 0;
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				res = session.update(namespace+"CommunityReport", dto);
			}		
			return res;
		}
		
		@Override
		public int CommunityUpdate(CommunityDto cdto) {
			int res = 0;
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				res = session.update(namespace+"CommunityUpdate", cdto);
			}		
			return res;
		}


		@Override
		public MemberDto SignUpEmailChk(String member_email) {
			MemberDto dto = null;
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				dto = session.selectOne(namespace+"SignUpEmailChk", member_email);
			}
			return dto;
		}

		

		@Override
		public List<CalendarDto> CalendarList(int member_no, String yyyyMMdd) {
			Map<String, Object> map = new HashMap<String, Object>();
			List<CalendarDto> list = new ArrayList<CalendarDto>();
			map.put("member_no", member_no);
			map.put("calendar_startdate", yyyyMMdd);
			System.out.println(map);
			
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				list = session.selectList(namespace+"CalendarList",map);
			}
			return list;
		}

		@Override
		public CalendarDto CalendarOne(int carlendar_no) {
			CalendarDto CalDto = null;
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				CalDto = session.selectOne(namespace+"CalendarOne", carlendar_no);
			}
			return CalDto;
		}
		
		@Override
		public int CalendarDelete(int calendar_no) {
			int res = 0;
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				res = session.delete(namespace+"CalendarDelete", calendar_no);
			}
			return res;
		}
		@Override
		
		public int CalendarUpdate(CalendarDto dto) {
			int res = 0;
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				res = session.delete(namespace+"CalendarUpdate", dto);
			}
			return res;
		}


	@Override
		public MemberDto Login(String member_id, String member_pw) {
			MemberDto dto = null;
			Map<String, Object> map = new HashMap<>();
			map.put("member_id", member_id);
			map.put("member_pw", member_pw);
			
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				dto = session.selectOne(namespace+"Login", map);
				
			}
			return dto;
		}

		@Override
		public int insertRTC(PetRTCDto dto) {
			int res = 0;
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				res = session.insert(namespace+"InsertRTC", dto);
			}
			return res;
		}

		@Override
		public PetRTCDto SelectRTCOne(int business_num) {
			PetRTCDto dto = null;
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				dto = session.selectOne(namespace+"SelectRTCOne", business_num);
			}			
			return dto;
		}

		@Override
		public PetRTCDto SelectRTCRoom (String room_id) {
			PetRTCDto dto = null;
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				dto = session.selectOne(namespace+"SelectRTCRoom", room_id);
			}			
			return dto;
		}

		@Override
		public int updateRTC(PetRTCDto dto) {
			int res = 0;
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				res = session.insert(namespace+"UpdateRTC", dto);
			}
			return res;
		}

		@Override
		public int DeleteRTC(int business) {
			int res  = 0 ;
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				res = session.insert(namespace+"DeleteRTC", business);
			}	
			return res;
	}

	@Override
	public BookDto SelectBookRTC(HashMap<String, String> map) {
		BookDto dto = null;
		System.out.println(map.get("member_no"));
		System.out.println(map.get("book_date"));
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			dto = session.selectOne(namespace+"SelectBookRTC", map);
		}	
		
		return dto;
	}

		@Override
		public int UseRTC(String room_id) {
			int res  = 0;
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				res = session.update(namespace+"UseRTC",room_id);
			}	
			return res;
		}

		@Override
		public int NUseRTC(String room_id) {
			int res  = 0;
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				res = session.update(namespace+"NUseRTC",room_id);
			}	
			return res;
		}

		@Override
		public int SelectLikeCount(int community_seq) {
			int res = 0;
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				res = session.selectOne(namespace+"SelectLikeCount",community_seq);
			}	
			return res;
		}

		@Override
		public LikesDto SelectLikeOne(LikesDto likedto) {
			LikesDto dto = null;
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				dto = session.selectOne(namespace+"SelectLikeOne",likedto);
				}
			return dto;
		}

		@Override
		public int InsertLikes(LikesDto dto) {
			int res = 0;
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				res = session.insert(namespace+"InsertLikes",dto);
			}	
			return res;
		}

		@Override
		public int DeleteLikes(LikesDto dto) {
			int res = 0;
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				res = session.delete(namespace+"DeleteLikes",dto);
			}	
			return res;
		}
		
		
		@Override
		public List<BusinessDto> businessList() {
		    SqlSession session = getSqlSessionFactory().openSession();
		    List<BusinessDto> list = session.selectList(namespace + "BusinessListAll");
		    session.close();

		    return list;
		}

		
		
		@Override
		public int bookdelete(int book_num) {
			
			int res = 0;
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				res = session.delete(namespace+"bookDelete", book_num);
			}
			return res;
			
		}



		//등록된 병원만 뜨도록
		@Override
		public List<BusinessDto> bookableMap() {
			SqlSession session = getSqlSessionFactory().openSession();
		
			List<BusinessDto> list = session.selectList(namespace+"bookableMap");
			session.close();

			return list;
		}
		//음식점지도
		@Override
		public List<BusinessDto> foodMap() {
			SqlSession session = getSqlSessionFactory().openSession();
			
			List<BusinessDto> list = session.selectList(namespace+"foodMap");
			session.close();

			return list;
		}
		
		//여행일정
		@Override
		public int travelInsert(TravelDto dto) {
			int res = 0;
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				res = session.insert(namespace+"travelInsert", dto);
			}
			return res;

		}


		@Override
		public int travelUpdate(TravelDto dto) {
			int res = 0;
			try(SqlSession session = getSqlSessionFactory().openSession(true)){
				res = session.insert(namespace+"travelupdate", dto);
			}
			return res;

		}	


	@Override
	public int orderInsert(OrderDto dto) {

		int res = 0;
		try (SqlSession session = getSqlSessionFactory().openSession(true)){
			res = session.insert(namespace + "orderInsert", dto);
		}
		return res;
	}


	@Override
	public int bookOrderSuccess(int book_num) {

		int res = 0;
		try (SqlSession session = getSqlSessionFactory().openSession(true)){
			res = session.update(namespace + "bookOrderSuccess", book_num);
		}
		return res;
	}

	@Override
	public String getMerchant_uid(int book_num) {

		String res = "";

		try {
			SqlSession session = getSqlSessionFactory().openSession();
			res = session.selectOne(namespace + "getMerchantUid", book_num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int orderInsertCancel(int book_num) {
		int res = 0;

		try (SqlSession session = getSqlSessionFactory().openSession(true)){
			res = session.update(namespace + "orderInsertCancel", book_num);
		}
		return res;
	}

	@Override
	public OrderDto selectOrderOne(int book_num) {

		OrderDto dto = null;
		try {
			SqlSession session = getSqlSessionFactory().openSession();
			dto = session.selectOne(namespace + "selectOrderOne", book_num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int hospitalBookInsert(BookDto dto) {
		int res = 0;
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			res = session.insert(namespace+"counselInsert", dto);
		}
		return res;

	}

	
	@Override
	public List<CommunityDto> CommentList(int community_no) {
		List<CommunityDto> list = new ArrayList<CommunityDto>();
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			list = session.selectList(namespace+"CommentList", community_no);
		}
		for(CommunityDto dto : list) {
		}
		
		return list;

	}
	@Override
	public int CommunityDelete(int seq) {
		int res = 0;
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			res = session.update(namespace+"CommunityDelete", seq);
		}		
		return res;
	}

	@Override
	public int CommunityViews(int seq) {
		int res = 0;
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			res = session.update(namespace+"CommunityViews", seq);
		}		
		return res;
	}
	@Override
	public int CommunityCommentCount(int seq) {
		int res = 0;
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			res = session.selectOne(namespace+"CommunityCommentCount", seq);
		}		
		return res;
	}

	// profile
	
	@Override
	public ProfileDto profile(int member_no) {
		
		ProfileDto dto = null;
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			dto = session.selectOne(namespace+"profile", member_no);
		}
		
		return dto;
		
	}

	@Override
	public int insertProfile(ProfileDto dto) {
		int res = 0;
		
		try(SqlSession session = getSqlSessionFactory().openSession(true)){
			res = session.insert(namespace + "insertProfile", dto);
		}
		
		return res;
	}

	@Override
	public int updateProfile(ProfileDto dto) {
		int res = 0;
		
		try (SqlSession session = getSqlSessionFactory().openSession(true)){
			res = session.update(namespace + "updateProfile", dto);
		}
		
		return res;
	}	
	
	
}
