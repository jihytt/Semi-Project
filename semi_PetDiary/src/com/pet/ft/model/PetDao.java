package com.pet.ft.model;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import com.pet.ft.dto.*;
import org.apache.ibatis.annotations.Param;
public interface PetDao {
	String namespace = "com.pet.ft.mapper.";

	int CommunityInsert(CommunityDto CDto);

	List<CommunityDto> CommunityList();
	
	List<CommunityDto> CommunityList(int member_no);

	CommunityDto CommunityOne(int seq);

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


	public List<CommunityDto> CommentList(int community_no);
	public List<CommunityDto> CommunitySearchList(String filter, String community_search);
	public int CommunityReport(CommunityDto dto);
	public int CommunityUpdate(CommunityDto cdto);
	public int CommunityDelete(int seq);
	public int CommentInsert(CommunityDto cdto);
	public int CommunityViews(int seq);
	public int CommunityCommentCount(int seq);
	public List<CommunityDto> CommunityPageList(int page);
	public List<CommunityDto> MyCommunityList(int member_no);
	public int CommunityPageMax();

	// member
	public MemberDto MemberOne(int member_no);
	public int MemberInsert(MemberDto dto);
	public MemberDto SignUpIdChk(String member_id);
	public MemberDto SignUpEmailChk(String member_email);
	public MemberDto Login(String member_id, String member_pw);
	public MemberDto SocialLogin(String member_id);
	public int SocialSignUp(MemberDto dto);
	public MemberDto findId(String member_name, String member_email);
	public MemberDto findPw(String member_name, String member_email, String member_id);
	public int resetPw(String member_name, String member_email, String member_id, String member_pw);
	public int memberUpdate(MemberDto dto);
	public int memberDelete(int member_no);

	public int totalMember();
	public int totalReport();
	public int totalBookHos(int member_no);
	public int totalBookSt(int member_no);
	public List<BookDto> totalDateTime();



	// ����¡ o
	public List<MemberDto> memberList(int offset, int noOfRecords);
	public List<CommunityDto> reportList(int offset, int noOfRecords);
	public List<BookDto> bookListHos(int offset, int noOfRecords, int member_no);
	public List<BookDto> bookListSt(int offset, int noOfRecords, int member_no);

	// pet
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

	public int updateTrip(CalendarDto dto);
	public int insertTrip(CalendarDto dto);
	public int deleteTrip(int member_no, int calendar_no);

	// member
	public int changeRole(MemberDto dto);
	public int deleteCommnutiy(int seq);
	public boolean nextPage(String pageNumber);
	HashMap<String, Integer> SelectMyinfoCount(int member_no);

    //calendar - 캘린더 내 clud
	//calendar - 캘린더 내 clud
	public List<CalendarDto> CalViewList(int member_no, String yyyyMM);
	public List<CalendarDto> CalendarList(int member_no, String yyyyMMdd);
	public int CalendarInsert(CalendarDto CalDto);
	public CalendarDto CalendarOne(int calendar_no);
	public int CalendarDelete(int calendar_no);
	public int CalendarUpdate(CalendarDto dto);

	public int insertRTC(PetRTCDto dto);

	public PetRTCDto SelectRTCOne(int business_num);

	public int updateRTC(PetRTCDto dto);

	public int DeleteRTC(int business);

	public BookDto SelectBookRTC(HashMap<String, String> map);

	public int UseRTC(String room_id);

	public int NUseRTC(String room_id);

	public PetRTCDto SelectRTCRoom(String room_id);

	public int SelectLikeCount(int community_seq);
	public LikesDto SelectLikeOne(LikesDto dto);
	public int InsertLikes(LikesDto dto);
	public int DeleteLikes(LikesDto dto);
	public int bookdelete(int book_num);
	public List<BusinessDto> businessList();

	//Order
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
