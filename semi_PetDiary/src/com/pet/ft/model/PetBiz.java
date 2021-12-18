package com.pet.ft.model;

import java.util.List;

import com.pet.ft.dto.*;


public interface PetBiz {


    //병원상담
    public List<BusinessDto> hospitalList(int offset, int noOfRecords);
    public int totalHospital();

    public List<BusinessDto> bookableMap();
    public List<BusinessDto> foodMap();

    public BusinessDto hospitalSelect(int business_num);
    public int hospitalBookInsert(BookDto dto);

    public int travelInsert(TravelDto dto);
    public List<TravelDto> travelList(int member_no);
    public TravelDto travelSelect(int travel_no);
    public int travelUpdate(TravelDto dto);

    public BusinessDto businessOne(int business_num);

    public int totalMember();
    public int totalReport();
    public int totalBookHos(int member_no);
    public int totalBookSt(int member_no);

    public List<BookDto> totalDateTime();

    public List<MemberDto> memberList(int offset, int noOfRecords);
    public List<CommunityDto> reportList(int offset, int noOfRecords);
    public List<BookDto> bookListHos(int offset, int noOfRecords, int member_no);
    public List<BookDto> bookListSt(int offset, int noOfRecords, int member_no);

    public int changeRole(MemberDto dto);
    public int deleteCommnutiy(int seq);

	//pet
    public List<PetDto> selectPetList(int member_no);
    public PetDto selectPetOne(int member_no, int pet_no);
    public int updatePet(PetDto dto);
    public int insertPet(PetDto dto);
    public int deletePet(int member_no, int pet_no);
    public int getCount(int member_no);
    public PetDto selectPetOnePaging(int member_no, int count);


    //picture
    public List<PictureDto> selectPictureList(int member_no);
    public PictureDto selectPictureOne(int member_no, int picture_no);
    public int insertPicture(PictureDto dto);
    public int deletePicture(int member_no, int picture_no);
    public List<PictureDto> selectPicturePaging(int member_no, int min, int max);
    public int getPictureCount(int member_no);

    //calendar
    public List<CalendarDto> selectTripList(int member_no);
    public CalendarDto selectTripOne(int member_no, int calendar_no);
    public int insertTrip(CalendarDto dto);
    public int updateTrip(CalendarDto dto);
    public int deleteTrip(int member_no, int calendar_no);

    //calendar - 캘린더 내 clud
    public List<CalendarDto> CalViewList(int member_no, String yyyyMM);
    public List<CalendarDto> CalendarList(int member_no, String yyyyMMdd);
    public int CalendarInsert(CalendarDto CalDto);
    public CalendarDto CalendarOne(int calendar_no);
    public int CalendarDelete(int calendar_no);
    public int CalendarUpdate(CalendarDto dto);

    public MemberDto Login(String member_id, String member_pw);
    public MemberDto SocialLogin(String member_id);
    public int SocialSignUp(MemberDto dto);
    public MemberDto findId(String member_name, String member_email);
    public MemberDto findPw(String member_name, String member_email, String member_id);
    public int resetPw(String member_name, String member_email, String member_id, String member_pw);
    public int memberUpdate(MemberDto dto);
    public int memberDelete(int member_no);



    //비속어 필터링
    public List<BusinessDto> businessList();

    //식당 카페 리스트
    public List<BusinessDto> BusinessList(int offset, int noOfRecords);
    public int businessTotal();
    public List<BusinessDto> menu();




    public int bookdelete(int book_num);

    //order
    public MemberDto MemberOne(int member_no);
    public int orderInsert(OrderDto dto);
    public int bookOrderSuccess(int book_num);
    public String getMerchant_uid(int book_num);
    public int orderInsertCancel(int book_num);
    public OrderDto selectOrderOne(int book_num);	

	// profile
	public ProfileDto profile(int member_no);
	public int insertProfile(ProfileDto dto);
	public int updateProfile(ProfileDto dto);
    

}
