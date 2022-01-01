package com.pet.ft.controller;

import java.awt.image.BufferedImage;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.activation.CommandMap;
import javax.activation.CommandObject;
import javax.activation.MailcapCommandMap;
import javax.imageio.ImageIO;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.oreilly.servlet.Base64Decoder;
import com.pet.ft.dto.*;
import com.pet.ft.model.PetBiz;
import com.pet.ft.model.PetBizImpl;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.Base64Decoder;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.pet.ft.model.BusinessDao;
import com.pet.ft.model.BusinessDaoImpl;

import com.pet.ft.model.PetDao;
import com.pet.ft.model.PetDaoImpl;
import com.pet.ft.paging.HospitalPaging;
import com.pet.ft.paging.Paging;

import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.simple.parser.JSONParser;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

@WebServlet("/pet_servlet")
public class pet_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String command = request.getParameter("command");
		System.out.println(command);

		HttpSession session = request.getSession();

		PetDao dao = new PetDaoImpl();
		String communityDirectory = "community/community_";
		String CalendarDirectory = "calendar/calendar_";
		String loginDirectory = "login/login_";
		PetBiz biz = new PetBizImpl();
		
		if("change".equals(command)) {
			
			int no = Integer.parseInt(request.getParameter("no"));
			String role = request.getParameter("role");

			MemberDto dto = new MemberDto();
			dto.setMember_no(no);
			dto.setMember_role(role);

			int res = biz.changeRole(dto);

			if(res > 0) {
				jsResponse(response, role + "등급 변경", "/semi_PetDiary/paging.do?command=member"); 
			} else {
				jsResponse(response, "변경 실패", "/semi_PetDiary/paging.do?command=member");
			}
			
		} else if("delete".equals(command)) {

			int seq = Integer.parseInt(request.getParameter("seq"));

			int res = biz.deleteCommnutiy(seq);

			if(res > 0) {
				jsResponse(response, "삭제 성공", "/semi_PetDiary/paging.do?command=report");
			} else {
				jsResponse(response, "삭제 실패", "/semi_PetDiary/paging.do?command=report");
			}		
		} 
			
		
		if("community".equals(command)) {	
			int MaxPage = dao.CommunityPageMax();
			request.setAttribute("maxpage", MaxPage);
			if(request.getParameter("paging")==null){
				List<CommunityDto> list = dao.CommunityPageList(1);	
				request.setAttribute("list", list);
				request.getRequestDispatcher(communityDirectory+"main.jsp?paging="+1).forward(request, response);
			}else {
				List<CommunityDto> list = dao.CommunityPageList(Integer.parseInt(request.getParameter("paging")));			
				request.setAttribute("list", list);
				request.getRequestDispatcher(communityDirectory+"main.jsp?paging="+request.getParameter("paging")).forward(request, response);
			}
		}

		
		if("community_like".equals(command)) {
			int seq = Integer.parseInt(request.getParameter("seq"));
			int no = (int)session.getAttribute("member_no");
			LikesDto dto = new LikesDto(no, seq);
			if(dao.SelectLikeOne(dto) !=null) {
				dao.DeleteLikes(dto);
			}else {
				dao.InsertLikes(dto);
			}			
		}

		
		if("listmycommnunity".equals(command)) {	
			List<CommunityDto> mList = dao.CommunityList((int)session.getAttribute("member_no"));			
			request.setAttribute("mList", mList);
			List<Integer> commentcount = new ArrayList<Integer>();
			for(CommunityDto cdto : mList) {
				commentcount.add(dao.CommunityCommentCount(cdto.getCommunity_no())-1);
			}
			request.setAttribute("commentcount", commentcount);
			if(request.getParameter("paging")==null){
				request.getRequestDispatcher("myinfo/myinfo_community.jsp?paging="+1).forward(request, response);
			}else {
				request.getRequestDispatcher("myinfo/myinfo_community.jsp?paging="+request.getParameter("paging")).forward(request, response);
			}
		}

		
		if("community_search".equals(command)) {
			String filter = request.getParameter("filter");
			String search_content = request.getParameter("search_content");
			System.out.println(search_content+filter);

			List<CommunityDto> list = dao.CommunitySearchList(filter, search_content);
			request.setAttribute("list", list);
			
			if(request.getParameter("paging")==null){
				request.getRequestDispatcher(communityDirectory+"search.jsp?&filter="+filter+"&search_content="+search_content+"&paging="+1).forward(request, response);
			}else {
				request.getRequestDispatcher(communityDirectory+"search.jsp?&filter="+filter+"&search_content="+search_content+"&paging="+request.getParameter("paging")).forward(request, response);
			}
		}
		if("community_reportform".equals(command)) {
			int seq = Integer.parseInt(request.getParameter("seq"));
			request.setAttribute("seq", seq);
			request.getRequestDispatcher(communityDirectory+"report.jsp").forward(request, response);;
			
		}
		
		if("community_reportinsert".equals(command)) {
			int seq = Integer.parseInt(request.getParameter("seq"));
			int member_no = (int)session.getAttribute("member_no");
			String content = request.getParameter("content")+"(신고자 No : "+member_no+")";
			CommunityDto dto = new CommunityDto(seq, null, null, null, null, 0, content, 0, 0, 0, 0, member_no);
			int res = dao.CommunityReport(dto);
			
			if(res>0) {
				jsResponseClose(response, "신고가 정상 접수되었습니다..");
			}else {
				jsResponseClose(response, "신고가 실패했습니다.");
				
			}
		}

		if("community_updateform".equals(command)) {
			int seq = Integer.parseInt(request.getParameter("seq"));
			request.setAttribute("cdto", dao.CommunityOne(seq));
			request.getRequestDispatcher(communityDirectory+"update.jsp").forward(request, response);
		}
		
		if("community_insert_form".equals(command)) {	
			if(session.getAttribute("member_no")==null) {
				jsResponse(response, "로그인 해주세요", loginDirectory+"login.jsp");
			}else{
				response.sendRedirect(communityDirectory+"insert.jsp");
			}
		
		}
		
		if("community_detail".equals(command)) {
			int seq = Integer.parseInt(request.getParameter("seq"));
			if(session.getAttribute("member_no")!=null) {
				LikesDto dto = new LikesDto((int)session.getAttribute("member_no"), seq);
				if(dao.SelectLikeOne(dto) !=null) {
					request.setAttribute("likes", "like");
				}							
			}
			dao.CommunityViews(seq);
			CommunityDto cdto = dao.CommunityOne(seq);
			List<CommunityDto> CommentList= dao.CommentList(cdto.getCommunity_no());
			request.setAttribute("cdto", cdto);
			request.setAttribute("commentList", CommentList);
			if(request.getParameter("filter")!= null) {
				request.getRequestDispatcher(communityDirectory+"detail_filter.jsp").forward(request, response);				

			}else {
				request.getRequestDispatcher(communityDirectory+"detail.jsp").forward(request, response);				

			}
		}
		
		if("community_insert".equals(command)){
			String title = request.getParameter("title");
			System.out.println(title);
			String content = request.getParameter("content");

			while(content.indexOf("<img src=\"data")>=0) { 
				String picture = "<img src=\"data"+content.split("<img src=\"data")[1].split(">")[0]+">";
				System.out.println(picture);
				String filenamme= picture.split("data-filename=\"")[1].split("\"")[0];
				System.out.println(filenamme);
				UUID id = UUID.randomUUID();
				String pictureAcc = "style="+picture.split("\" style=")[1].split("data-filename")[0]+">";
				String data = picture.split(",")[1].split("\" style=")[0];
				String path = request.getSession().getServletContext().getRealPath("/");
				byte[] imageBytes = Base64Decoder.decodeToBytes(data);				
				BufferedImage bufimg = ImageIO.read(new ByteArrayInputStream(imageBytes));
				ImageIO.write(bufimg, filenamme.split("\\.")[1], new File(path+"resources/community_img/"+id.toString()+"."+filenamme.split("\\.")[1]));
				content =content.replace("<img src=\"data"+content.split("<img src=\"data")[1].split(">")[0]+">","<img src='/semi_PetDiary/resources/community_img/"+id.toString()+"."+filenamme.split("\\.")[1]+"'"+pictureAcc);
			}
			 
			System.out.println(content);
			System.out.println("내부");
			//-----------------------------id 로그인 생기면 마지막파라미터(회원번호)바꾸기
			CommunityDto CDto = new CommunityDto(0, title, content, null, "N", 0, 0, 0, (int)session.getAttribute("member_no"));
			int res = dao.CommunityInsert(CDto);
			int MaxPage = dao.CommunityPageMax();
			request.setAttribute("maxpage", MaxPage);
			if(res>0) {
				request.getRequestDispatcher("pet.do?command=community").forward(request, response);

			}else{
				jsResponse(response, "작성 실패", communityDirectory+"insert.jsp");
			}
		}
		if("community_comment".equals(command)) {
			String content = request.getParameter("comment");
			int community_no = Integer.parseInt(request.getParameter("community_no"));
			CommunityDto CDto = new CommunityDto(0, " ", content, null, "N", 0, community_no, 0, Integer.parseInt(request.getParameter("member_no")));
			int res = dao.CommentInsert(CDto);
			if(res>0) {
				//해당 유저가 가장 최근에 작성한 번호 가져와서 해당 게시글로 이동
				jsResponse(response, "작성 성공", "pet.do?command=community_detail&seq="+request.getParameter("seq")+"&community_no="+request.getParameter("community_no"));
			}else{
				jsResponse(response, "작성 실패", "pet.do?command=community_detail&seq="+request.getParameter("seq")+"&community_no="+request.getParameter("community_no"));
			}

		}

		if("community_update".equals(command)) {
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			while(content.indexOf("<img src=\"data")>=0) { 
				String picture = "<img src=\"data"+content.split("<img src=\"data")[1].split(">")[0]+">";
				System.out.println(picture);
				String filenamme= picture.split("data-filename=\"")[1].split("\"")[0];
				System.out.println(filenamme);
				UUID id = UUID.randomUUID();
				String pictureAcc = "style="+picture.split("\" style=")[1].split("data-filename")[0]+">";
				String data = picture.split(",")[1].split("\" style=")[0];
				String path = request.getSession().getServletContext().getRealPath("/");
				byte[] imageBytes = Base64Decoder.decodeToBytes(data);				
				BufferedImage bufimg = ImageIO.read(new ByteArrayInputStream(imageBytes));
				ImageIO.write(bufimg, filenamme.split("\\.")[1], new File(path+"resources/community_img/"+id.toString()+"."+filenamme.split("\\.")[1]));
				content =content.replace("<img src=\"data"+content.split("<img src=\"data")[1].split(">")[0]+">","<img src='/semi_PetDiary/resources/community_img/"+id.toString()+"."+filenamme.split("\\.")[1]+"'"+pictureAcc);
			}
			int seq = Integer.parseInt(request.getParameter("seq"));
			int community_no = Integer.parseInt(request.getParameter("community_no"));
			CommunityDto CDto = new CommunityDto(seq, title, content, null, "N", 0, community_no, 0, 1);
			int res = dao.CommunityUpdate(CDto);
			if(res>0) {
				//해당 유저가 가장 최근에 작성한 번호 가져와서 해당 게시글로 이동
				jsResponse(response, "수정 성공", "pet.do?command=community_detail&seq="+seq+"&community_no="+community_no);
			}else{
				jsResponse(response, "수정 실패", "pet.do?command=community_detail&seq="+seq+"&community_no="+community_no);
			}

		}

		if("community_delete".equals(command)) {
			int seq = Integer.parseInt(request.getParameter("seq"));
			int res = dao.CommunityDelete(seq);

			if(res>0) {
				//해당 유저가 가장 최근에 작성한 번호 가져와서 해당 게시글로 이동
				jsResponse(response, "삭제 성공", "pet.do?command=community");
			}else{
				jsResponse(response, "삭제 실패", "pet.do?command=community");
			}

		}

		if("community_comment_delete".equals(command)) {
			int seq = Integer.parseInt(request.getParameter("seq"));
			int community_seq = Integer.parseInt(request.getParameter("community_seq"));
			int res = dao.CommunityDelete(seq);
			if(res>0) {
				//해당 유저가 가장 최근에 작성한 번호 가져와서 해당 게시글로 이동
				jsResponse(response, "삭제 성공", "pet.do?command=community_detail&seq="+community_seq);
			}else{
				jsResponse(response, "삭제 실패", "pet.do?command=community_detail&seq="+community_seq);
			}

		}
		if("community_comment_update".equals(command)) {
			String content = request.getParameter("content");
			int seq = Integer.parseInt(request.getParameter("seq"));
			int community_no = Integer.parseInt(request.getParameter("community_no"));
			CommunityDto CDto = new CommunityDto(seq, "댓글", content, null, "N", 0, community_no, 0, 1);
			int res = dao.CommunityUpdate(CDto);
			if(res>0) {
				//해당 유저가 가장 최근에 작성한 번호 가져와서 해당 게시글로 이동
				jsResponse(response, "수정 성공", "pet.do?command=community_detail&seq="+request.getParameter("community_seq")+"&community_no="+community_no);
			}else{
				jsResponse(response, "수정 실패", "pet.do?command=community_detail&seq="+request.getParameter("community_seq")+"&community_no="+community_no);
			}
		}
		
		//병원상담
		int currentPageNo = 1;
		int recordsPerPage = 0;
		String url = null;
		if(command.equals("hospitalmain")) {

			if(request.getParameter("pages") != null)
				currentPageNo = Integer.parseInt(request.getParameter("pages"));

			if(request.getParameter("lines") != null)
				recordsPerPage = Integer.parseInt(request.getParameter("lines"));
				HospitalPaging paging = new HospitalPaging(currentPageNo, recordsPerPage);
				int offset = (paging.getCurrentPageNo()-1)*paging.getRecordsPerPage();
				
				System.out.println("offset : " +offset);
				
				List<BusinessDto> list = biz.hospitalList(offset, paging.getRecordsPerPage()*currentPageNo);
				paging.setNumberOfRecords(biz.totalHospital());
				paging.makePaging();
				
				System.out.println("recordsPerPage *currentpage : " +paging.getRecordsPerPage()*currentPageNo);
				System.out.println("currentpage : " +paging.getCurrentPageNo());
				System.out.println("recordsPerpage : " +paging.getRecordsPerPage());
		
				if(list != null) {
				
				request.setAttribute("list", list);
				request.setAttribute("paging", paging);
				request.setAttribute("servletPath", "pet.do");
				request.setAttribute("key", "hospitalmain");
								
				url = "/hospital/hospital_main.jsp";
			}else {
				request.setAttribute("msg", "에러");
				
				url = "/hospital/hospital_main.jsp";
			}
			request.getRequestDispatcher(url).forward(request, response);


		}else if(command.equals("hospitalselect")) {
			int business_num = Integer.parseInt(request.getParameter("business_num"));
			BusinessDto dto = biz.hospitalSelect(business_num);
			request.setAttribute("dto", dto);
			String room_id = null;
			if(dao.SelectRTCOne(business_num) !=null) {
				room_id = dao.SelectRTCOne(business_num).getRtc_room();
			}
			if(dao.SelectRTCOne(business_num)!=null) {
				room_id = dao.SelectRTCOne(business_num).getRtc_room();
			}
			request.setAttribute("dto", dto);
			request.setAttribute("room_id", room_id);
			
			dispatch(request,response,"./hospital/hospital_select.jsp");



		}else if(command.equals("counselInsert")) {
			String book_date = request.getParameter("book_date");
			String book_counsel = request.getParameter("book_counsel");
			int business_num = Integer.parseInt(request.getParameter("business_num"));
			
			if(session.getAttribute("member_no")!= null) {
				int member_no = (int)session.getAttribute("member_no");
				BookDto dto = new BookDto();
				dto.setBook_date(book_date);
				dto.setBook_counsel(book_counsel);
				dto.setBusiness_num(business_num);
				dto.setMember_no(member_no);
				dto.setBook_state("N");
				dto.setBook_price("0");
				int res = biz.hospitalBookInsert(dto);
				if(res>0) {
			        pet_sms.SendSMS(book_date, null, business_num, (int)session.getAttribute("member_no"));
					jsResponse(response, "예약성공", "pet.do?command=hospitalmain");
				}else {
					jsResponse(response, "예약실패", "./hospital/hospital_select.jsp");

				}
			}else {
				jsResponse(response, "로그인 해주세요", loginDirectory+"login.jsp");        		

			}
			
		//병원지도
		}else if(command.equals("bookableMap")) {
			PrintWriter out = response.getWriter();
			
			List<BusinessDto> list = biz.bookableMap();
			JSONObject obj = new JSONObject();
			JSONArray jsonArray = new JSONArray();
			for(int i = 0; i<list.size(); i++) {
				
				
				obj.put("business_addr",list.get(i).getBusiness_addr());
			    obj.put("business_name", list.get(i).getBusiness_name());
				
				jsonArray.add(obj);
			
			}
						
			out.print(jsonArray);
			out.flush();
		
			//음식점지도
		}else if(command.equals("foodMap")) {
			PrintWriter out = response.getWriter();
			
			List<BusinessDto> list = biz.foodMap();
			JSONObject obj = new JSONObject();
			JSONArray jsonArray = new JSONArray();
			for(int i = 0; i<list.size(); i++) {
				
				
				obj.put("business_addr",list.get(i).getBusiness_addr());
			    obj.put("business_name", list.get(i).getBusiness_name());
				
				jsonArray.add(obj);
			}		
			out.print(jsonArray);
			out.flush();
			
		//여행일정	
		}else if(command.equals("travelmain")) {
			if(session.getAttribute("member_no")!= null) {
				int member_no = (int)session.getAttribute("member_no");
				
				List<TravelDto> list = biz.travelList(member_no);
				request.setAttribute("list", list);
				dispatch(request,response,"./travel/travel_main.jsp");
			}else {
				jsResponse(response, "로그인 해주세요", loginDirectory+"login.jsp");        		

			}
			
		}else if(command.equals("travelselect")) {
			int travel_no = Integer.parseInt(request.getParameter("travel_no"));
			TravelDto dto = biz.travelSelect(travel_no);
			request.setAttribute("dto", dto);
			dispatch(request,response,"./travel/travel_select.jsp");

		}else if(command.equals("insertform")) {
			dispatch(request,response,"./travel/travel_insert.jsp");
			
		}else if(command.equals("travelInsert")) {
			String travel_name = request.getParameter("travel_name");
			String travel_date = request.getParameter("travel_date");
			String travel_spot1 = request.getParameter("travel_spot1");
			String travel_spot2 = request.getParameter("travel_spot2");
			String travel_spot3 = request.getParameter("travel_spot3");
			int travel_time1 = Integer.parseInt(request.getParameter("travel_time1"));
			int travel_time2 = Integer.parseInt(request.getParameter("travel_time2"));
			int travel_stay1 = Integer.parseInt(request.getParameter("travel_stay1"));
			int travel_stay2 = Integer.parseInt(request.getParameter("travel_stay2"));
			
			if(session.getAttribute("member_no")!= null) {
				int member_no = (int)session.getAttribute("member_no");
			
				TravelDto dto = new TravelDto();
				dto.setTravel_name(travel_name);
				dto.setTravel_date(travel_date);
				dto.setTravel_spot1(travel_spot1);
				dto.setTravel_spot2(travel_spot2);
				dto.setTravel_spot3(travel_spot3);
				dto.setTravel_stay1(travel_stay1);
				dto.setTravel_stay2(travel_stay2);
				dto.setTravel_time1(travel_time1);
				dto.setTravel_time2(travel_time2);
				dto.setMember_no(member_no);
			
				int res = biz.travelInsert(dto);
				if(res>0) {
					jsResponse(response, "일정저장성공", "pet.do?command=travelmain");
				}else {
					jsResponse(response, "저장실패", "pet.do?command=travelmain");

				}
			}else {
				jsResponse(response, "로그인 해주세요", loginDirectory+"login.jsp");   
			}

		}else if(command.equals("updateform")) {
			int travel_no = Integer.parseInt(request.getParameter("travel_no"));
			TravelDto dto = biz.travelSelect(travel_no);
			request.setAttribute("dto", dto);
			dispatch(request,response,"./travel/travel_update.jsp");
		
		}else if(command.equals("travelupdate")) {
			int travel_no = Integer.parseInt(request.getParameter("travel_no"));
			String travel_name = request.getParameter("travel_name");
			String travel_date = request.getParameter("travel_date");
			String travel_spot1 = request.getParameter("travel_spot1");
			String travel_spot2 = request.getParameter("travel_spot2");
			String travel_spot3 = request.getParameter("travel_spot3");
			int travel_time1 = Integer.parseInt(request.getParameter("travel_time1"));
			int travel_time2 = Integer.parseInt(request.getParameter("travel_time2"));
			int travel_stay1 = Integer.parseInt(request.getParameter("travel_stay1"));
			int travel_stay2 = Integer.parseInt(request.getParameter("travel_stay2"));
			int member_no = 1;
							//Integer.parseInt(request.getParameter("member_no"));

			TravelDto dto = new TravelDto();
			dto.setTravel_no(travel_no);
			dto.setTravel_name(travel_name);
			dto.setTravel_date(travel_date);
			dto.setTravel_spot1(travel_spot1);
			dto.setTravel_spot2(travel_spot2);
			dto.setTravel_spot3(travel_spot3);
			dto.setTravel_stay1(travel_stay1);
			dto.setTravel_stay2(travel_stay2);
			dto.setTravel_time1(travel_time1);
			dto.setTravel_time2(travel_time2);
			dto.setMember_no(member_no);
			
			int res = biz.travelUpdate(dto);
			if(res>0) {
				jsResponse(response, "수정성공", "pet.do?command=travelmain");
			}else {
				jsResponse(response, "수정실패", "pet.do?command=travelselect&travel_no="+travel_no);

			}
		}
		
		if (command.equals("picture_delete")) {
			int member_no = (int) session.getAttribute("member_no");
			int picture_no = Integer.parseInt(request.getParameter("picture_no"));
			PictureDto dto = biz.selectPictureOne(member_no, picture_no);

			int res = biz.deletePicture(member_no, picture_no);
			if (res > 0) {
				System.out.println("삭제 성공");
				dispatch(request, response, "pet.do?command=picture_main");
			} else {
				System.out.println("삭제 실패");
				dispatch(request, response, "pet.do?command=picture_main");
			}

		}
		
		if (command.equals("weather_main")) {
			response.sendRedirect("weather/weather_view.jsp");
		}
		
		if(command.equals("weather_view")) {
        	String where = request.getParameter("where");
        	System.out.println("where: "+where);
        	request.setAttribute("where", where);
        	dispatch(request, response, "weather/weather_view.jsp");
        	response.sendRedirect("weather/weather_view.jsp");
        
        } else if (command.equals("pet_Paging")) {

			int member_no = (int) session.getAttribute("member_no");
            int count = Integer.parseInt(request.getParameter("count"));
            PrintWriter out = response.getWriter();
            JSONArray jsonArray = new JSONArray();
            PetDto dto = biz.selectPetOnePaging(member_no, count);

            JSONObject jObj = new JSONObject();
            jObj.put("pet_no", dto.getPet_no());
            jObj.put("pet_name", dto.getPet_name());
            jObj.put("pet_species", dto.getPet_species());
            jObj.put("pet_breed", dto.getPet_breed());
            jObj.put("pet_birthday", dto.getPet_birthday().substring(0, 10));
            jObj.put("pet_gender", dto.getPet_gender());
            jObj.put("pet_path", dto.getPet_path());
            jObj.put("pet_vaccination", dto.getPet_vaccination());

            jsonArray.add(jObj);
            out.print(jsonArray);
            out.flush();
        }

        if(command.equals("myinfo")) {
        	if(session.getAttribute("member_no")==null) {
				jsResponse(response, "로그인 해주세요", loginDirectory+"login.jsp");        		
        	}else {
            	int member_no = (int)session.getAttribute("member_no");
        		if(member_no == 1) {
        			String fullpath = null;
        			System.out.println(fullpath);  
        			if(biz.profile((int)session.getAttribute("member_no")) !=null) {
        				ProfileDto dto = biz.profile((int)session.getAttribute("member_no"));
        				System.out.println("번호 : " + dto.getMember_no() + dto.getProfile_src() + dto.getProfile_state());
        				
        				request.setAttribute("fullpath", fullpath);
        			}else {
        				System.out.println("정보를 추가합니다.");
        				ProfileDto dto = new ProfileDto("NotYet", "N", (int)session.getAttribute("member_no"));
        				biz.insertProfile(dto);
        			}
        			request.getRequestDispatcher("admin/admin_main.jsp").forward(request, response);
        			
    		}else {
                	HashMap<String, Integer> map = dao.SelectMyinfoCount(member_no);
                	MemberDto dto = dao.MemberOne(member_no);        	
                	request.setAttribute("map", map);
                	request.setAttribute("dto", dto);
                	
                	dispatch(request, response, "myinfo/myinfo_main.jsp");      
        			
        		}  		
        	}
        }  

		if("adminSend".equals(command)) {
			
			request.getRequestDispatcher("admin/01_FileUpload.jsp").forward(request, response);
		}

        if(command.equals("MyCommunityList")) {
        	if(session.getAttribute("member_no")==null) {
				jsResponse(response, "로그인 해주세요", loginDirectory+"login.jsp");        		
        	}else {
            	int member_no = (int)session.getAttribute("member_no");
            	List<CommunityDto> list = dao.MyCommunityList(member_no);
            	request.setAttribute("list", list); 	       	
            	request.getRequestDispatcher("myinfo/myinfo_communitylist.jsp").forward(request, response);  		
        	}
        }    


        if(command.equals("myinfobusup")) {
        	int member_no = Integer.parseInt(request.getParameter("member_no"));
        	dispatch(request, response, "myinfo/myinfo_businessup.jsp?member_no="+member_no);
        }
        

		if("myinfo_update".equals(command)) {
    		response.sendRedirect("myinfo/myinfo_update.jsp");
    	}
    	
		
    	if("myinfo_updateform".equals(command)) {
    		int member_no = Integer.parseInt(request.getParameter("member_no"));
			String member_pw = request.getParameter("member_pw");
			String member_email = request.getParameter("member_email");
			String member_phone = request.getParameter("member_phone");
			String member_addr = request.getParameter("member_addr");
			String member_addr_detail = request.getParameter("member_addr_detail");
		
			String memberaddress = member_addr + " " + member_addr_detail;
			
			MemberDto dto = new MemberDto();
			dto.setMember_no(member_no);
			dto.setMember_pw(member_pw);
			dto.setMember_email(member_email);
			dto.setMember_phone(member_phone);
			dto.setMember_address(memberaddress);
			
			int res = biz.memberUpdate(dto);
			
			if (res > 0) {
				jsResponse(response, "회원 정보가 수정되었습니다.", "myinfo/myinfo_update.jsp");
			} else {
				jsResponse(response, "회원 정보가 수정되지 않았습니다.", "myinfo/myinfo_update.jsp");
			}
    	}
			
		if("myinfo_delete".equals(command)) {
			int member_no = Integer.parseInt(request.getParameter("member_no"));
			
			int res = biz.memberDelete(member_no);
			
			if(res > 0) {
				session.invalidate();
				jsResponse(response, "탈퇴가 완료되었습니다.", "main/main.jsp");
			} else {
				jsResponse(response, "회원 탈퇴가 이루어지지 않았습니다.", "myinfo/myinfo_update.jsp");
			}
		}
		
		//식당,카페 리스트
		BusinessDao bdao = new BusinessDaoImpl();
		if(command.equals("foodlist")) {
			List<BusinessDto> list = bdao.BusinessList();
			request.setAttribute("list", list);
			request.getRequestDispatcher("food/food_list.jsp").forward(request, response);
		}
		if(command.equals("bookform")) {//-------------------------------------------------------
			int business_num = Integer.parseInt(request.getParameter("business_num"));
			if(session.getAttribute("member_no")!=null) {
				System.out.println(business_num);
				BusinessDto bdto = bdao.businessOne(business_num);
				request.setAttribute("bdto", bdto);
				System.out.println(bdto.getBusiness_name());
				dispatch(request, response,"./food/food_book.jsp");
			}else {
				jsResponse(response, "로그인 해주세요", loginDirectory+"login.jsp");
			}
		}
		
		if(command.equals("bookinsert")) {
	         String book_date = request.getParameter("book_date").replaceAll("-", "");//예약날짜.
	         System.out.println("1. book_date : "+book_date);      //출력구문 1. 예약날짜
	         String book_time = request.getParameter("book_time");//.replaceAll(":", "");
	         System.out.println("2. book_time : "+book_time);

			 String merchant_uid = request.getParameter("merchant_uid");

			 int member_no = (int) session.getAttribute("member_no");

	         int business_num = Integer.parseInt(request.getParameter("business_num"));
	         // business_num: 회사번호
	         System.out.println("3. business_num : "+business_num);//출력구문 2. 예약업체 번호.
	         String book_type = request.getParameter("book_type"); //book_type, business_role 둘다 올수 있는 값이 h,s
	         System.out.println(book_type);
	         BookDto bokdto = new BookDto(0, book_date, book_time, book_type, business_num, member_no, null, null, null, null);
	         int res = bdao.bookInsert(bokdto); 
	         System.out.println(res);
	         
	         if(res>0) {
	            //해당 유저가 가장 최근에 작성한 번호 가져와서 해당 게시글로 이동
		        pet_sms.SendSMS(book_date, book_time, business_num, (int)session.getAttribute("member_no"));
	            jsResponse(response, "작성 성공", "paging.do?command=foodlist");
	         
	         }else{
	            jsResponse(response, "작성 실패", "paging.do?command=foodlist");
	         }

	      }
		
		if(command.equals("booklistview")) { // 예약버튼을 누른 조회하는 view
			String book_date = request.getParameter("book_date");
			String book_time = request.getParameter("book_time");
			int business_num = Integer.parseInt(request.getParameter("business_num"));
			String book_type = request.getParameter("book_type");
			 
			
			String date = book_date.replaceAll("[^0-9]", "");
			String time = book_time.replaceAll("[^0-9]", "");
			
			List<BookDto> list = biz.totalDateTime();
			String msg = "없음";
			int pe = 0;
			
			for(BookDto dto : list) {
				
				if(business_num == dto.getBusiness_num()) {
				
					if(date.equals(dto.getBook_date())) {	
						
						int timecheck = Integer.parseInt(dto.getBook_time().replaceAll("[^0-9]", ""));
						int timeall = Integer.parseInt(time);
						int x = 0;
						
						if((timecheck/100) == (timeall/100)) {
							x = timeall - timecheck;
							
						} else {
							x = (timeall - timecheck) - 40;
						}
						
						if(x <= 60 && x >= 10) {
							pe = (60 - x)/10;
							
							msg = "예상 대기시간은 " + 5 * pe + " ~ " + (5 * pe + 5) + "분 입니다.";
							
							jsResponse(response, msg, "pet.do?command=selectBook&booknum="+dto.getBook_num());
						}
					}
				}
			}
			
			System.out.println("pe : " +pe);
			
			 request.setAttribute("msg", msg);
			 request.setAttribute("pe", pe);
			 
			 dispatch(request, response, "business/booklist_view.jsp");
		}
		
		if(command.equals("bookview")) {// 예약 조회
			int book_num = Integer.parseInt(request.getParameter("book_num"));
			String date = request.getParameter("date");
			String time = request.getParameter("time");
			
			String dateTime = date.substring(0, 4) + "-" + date.substring(4, 6) + "-" + date.substring(6, 8) + " " + time;
			
			request.setAttribute("date", date);
			request.setAttribute("time", time);
			request.setAttribute("dateTime", dateTime);
			
			dispatch(request, response, "business/business_bookview.jsp");
			
		}
		
		if(command.equals("myinfo_business")) {
			int member_no = (int)session.getAttribute("member_no"); //나중에 session에서 받아오기
			String Business_name = request.getParameter("Business_name");
			String Business_role = request.getParameter("Business_role");
			String Business_time = request.getParameter("Business_time1")+":"+request.getParameter("Business_time1")+"~"+request.getParameter("Business_time1")+":"+request.getParameter("Business_time4");
			String Business__park = request.getParameter("Business__park");
			String Business_addr = request.getParameter("Business_addr")+request.getParameter("Business_addr_detail");
			int Business_no = Integer.parseInt(request.getParameter("Business_no"));

			BusinessDto dto = new BusinessDto(0, Business_name, null, null, null, Business_addr, Business_role, Business_time, Business__park, "N", "N", Business_no, member_no);

			int res = bdao.BusinessInsert(dto);
			if(res>0) {
				jsResponse(response, "신청 성공", "main/main.jsp");
			}else {
				jsResponse(response, "신청 실패", "main/main.jsp");
			}

		}
		if (command.equals("pet_main")) {
			if(session.getAttribute("member_no") !=null) {
				int member_no = (int) session.getAttribute("member_no");
	            List<PetDto> petlist = biz.selectPetList(member_no);
	            request.setAttribute("petlist", petlist);
	            dispatch(request, response, "pet/pet_main.jsp");
			}else {
				jsResponse(response, "로그인 해주세요", loginDirectory+"login.jsp");

			}
  
		} else if (command.equals("picture_insert_select")) {

			int member_no = (int) session.getAttribute("member_no");
            List<PictureDto> list = biz.selectPictureList(member_no);
            request.setAttribute("list", list);
            dispatch(request, response, "pet/pet_insert_select.jsp");
            
        } else if (command.equals("picture_update_select")) {
            int member_no = (int) session.getAttribute("member_no");
            List<PictureDto> list = biz.selectPictureList(member_no);
            request.setAttribute("list", list);
            dispatch(request, response, "pet/pet_update_select.jsp");

        } else if (command.equals("pet_update_form")) {

			int member_no = (int) session.getAttribute("member_no");
            int pet_no = Integer.parseInt(request.getParameter("pet_no"));
            PetDto dto = biz.selectPetOne(member_no, pet_no);
			request.setAttribute("pet_no", pet_no);
            request.setAttribute("dto", dto);
            dispatch(request, response, "pet/pet_update.jsp");

        } else if (command.equals("pet_update_res")) {
			int member_no = (int) session.getAttribute("member_no");
			PrintWriter out = response.getWriter();
            int pet_no = Integer.parseInt(request.getParameter("pet_no"));
            String path = request.getParameter("path");
            String vaccination = request.getParameter("vaccination");
            PetDto dto = new PetDto();

            dto.setPet_no(pet_no);
            dto.setPet_path(path);
            dto.setPet_vaccination(vaccination);

			String str="";
			str = "<script language='javascript'>";
			str += "opener.window.location.reload();";  //오프너 새로고침
			str += "self.close();";   // 창닫기
			str += "</script>";

            int res = biz.updatePet(dto);
            if (res > 0) {
                System.out.println("수정 성공");
				out.print(str);
            } else {
                System.out.println("수정 실패");
				out.print(str);
            }

        } else if (command.equals("pet_insert")) {

			int member_no = (int) session.getAttribute("member_no");
			PrintWriter out = response.getWriter();
            String name = request.getParameter("name");
            String species = request.getParameter("species");
            String breed = request.getParameter("breed");
            String birthday = request.getParameter("birthday");
            String gender = request.getParameter("gender");
            String path = request.getParameter("path");
            String vaccination = request.getParameter("vaccination");

			String str="";
			str = "<script language='javascript'>";
			str += "opener.window.location.reload();";  //오프너 새로고침
			str += "self.close();";   // 창닫기
			str += "</script>";

            PetDto dto = new PetDto(0, species, breed, name, birthday, gender, member_no, path, vaccination);
            int res = biz.insertPet(dto);
            if (res > 0) {
                System.out.println("추가 성공");
				out.print(str);
            } else {
                System.out.println("추가 실패");
				out.print(str);
            }

      } else if (command.equals("pet_delete")) {
            int member_no = (int) session.getAttribute("member_no");
            int pet_no = Integer.parseInt(request.getParameter("pet_no"));
            int res = biz.deletePet(member_no, pet_no);
            if (res > 0) {
                System.out.println("삭제 성공");
                dispatch(request, response, "pet/pet_main.jsp?member_no=1");
            } else {
                System.out.println("삭제 실패");
                dispatch(request, response, "pet/pet_main.jsp?member_no=1");
            }
     
        } else if (command.equals("picture_main")) {
			int member_no = (int) session.getAttribute("member_no");
			int min = 0;
			int max = 0;

			if (request.getParameter("max") == null) {
				min = max-5;
				max = 6;
			} else {
				max = Integer.parseInt(request.getParameter("max"));
				min = max - 5;
			}

			List<PictureDto> list = biz.selectPicturePaging(member_no, min, max);

			request.setAttribute("list", list);
			dispatch(request, response, "picture/picture_main.jsp");
	
        } else if (command.equals("picture_upload")) {

			Map<String, String> user = new HashMap<String, String>();

			String fileSeperator = File.separator;
			int member_no = (int) session.getAttribute("member_no");
            String path = request.getSession().getServletContext().getRealPath("resources" + fileSeperator + "Upload" + fileSeperator + member_no);
			Util.MakeFolder(path);

            int size = 1024 * 1024 * 10;
            String fileName = "";
            String originalFile = "";

            boolean isMultipart = FileUpload.isMultipartContent(request);

			try {
				if (isMultipart) {
					DiskFileItemFactory factory = new DiskFileItemFactory();

					ServletFileUpload upload = new ServletFileUpload(factory);

					upload.setHeaderEncoding("UTF-8");

					List<FileItem> items = upload.parseRequest(request);
					Iterator<FileItem> iter = items.iterator();

					while (iter.hasNext()) {
						FileItem item = iter.next();

						item.getString("UTF-8");

						if (item.isFormField()) {

							String name = item.getFieldName();
							String value = new String((item.getString()).getBytes("8859_1"), "UTF-8");
							user.put(name, value);

						} else {
							fileName = new File(item.getName()).getName();
							String eFilename = URLEncoder.encode(fileName, "UTF-8");
							PictureDto dto = new PictureDto();
							dto.setPicture_directory(".." + fileSeperator + "resources" + fileSeperator + "Upload" + fileSeperator + member_no);
							dto.setPicture_name(fileName);
							dto.setMember_no(member_no);
							int res = biz.insertPicture(dto);

							File storeFile = new File(path + fileSeperator + eFilename);
							user.put("user_img", eFilename);
							item.write(storeFile);
						}
					}

				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			dispatch(request, response, "pet.do?command=picture_main");

		} else if (command.equals("picture_delete")) {

			String fileSeperator = File.separator;
			int member_no = (int) session.getAttribute("member_no");
			int picture_no = Integer.parseInt(request.getParameter("picture_no"));
			PictureDto dto = biz.selectPictureOne(member_no, picture_no);
			String path = request.getSession().getServletContext().getRealPath("resources" + fileSeperator + "Upload" + fileSeperator + member_no + fileSeperator + dto.getPicture_name());
			System.out.println(path);
			Util.deleteFile(path);

			int res = biz.deletePicture(member_no, picture_no);
			if (res > 0) {
				System.out.println("삭제 성공");
				dispatch(request, response, "pet.do?command=picture_main");
			} else {
				System.out.println("삭제 실패");
				dispatch(request, response, "pet.do?command=picture_main");
			}  
		
		} else if (command.equals("trip_main")) {
			int member_no = (int) session.getAttribute("member_no");
			List<CalendarDto> list = biz.selectTripList(1);
			request.setAttribute("list", list);
			dispatch(request, response, "trip/trip_main.jsp");

		} else if (command.equals("trip_insert_form")) {
			response.sendRedirect("trip/trip_insert.jsp");

		} else if (command.equals("trip_insert_res")) {

			String calendar_startdate = request.getParameter("calendar_startdate");
			String calendar_enddate = request.getParameter("calendar_enddate");
			String calendar_necessity = request.getParameter("calendar_necessity");
			String calendar_item = request.getParameter("calendar_item");
			String calendar_title = request.getParameter("calendar_title");
			String calendar_content = request.getParameter("calendar_content");
			int member_no = Integer.parseInt(request.getParameter("member_no"));

			CalendarDto dto = new CalendarDto(0, calendar_startdate, calendar_enddate, calendar_necessity, calendar_item, calendar_title, calendar_content, member_no);
			int res = biz.insertTrip(dto);
			if (res > 0) {
				System.out.println("여행 일정 작성 성공");
				dispatch(request, response, "index.html");
			} else {
				System.out.println("여행 일정 작성 실패");
				dispatch(request, response, "index.html");
			}
	
		} else if (command.equals("trip_detail")) {
			int member_no = (int) session.getAttribute("member_no");
			int calendar_no = Integer.parseInt(request.getParameter("calendar_no"));

			CalendarDto dto = biz.selectTripOne(member_no, calendar_no);
			request.setAttribute("dto", dto);
			dispatch(request, response, "trip/trip_detail.jsp");

		} else if (command.equals("trip_update_form")) {

			int member_no = (int) session.getAttribute("member_no");
			int calendar_no = Integer.parseInt(request.getParameter("calendar_no"));
			CalendarDto dto = biz.selectTripOne(member_no, calendar_no);
			request.setAttribute("dto", dto);
			dispatch(request, response, "trip/trip_update.jsp");

		} else if (command.equals("trip_update_res")) {

			int member_no = (int) session.getAttribute("member_no");
			int calendar_no = Integer.parseInt(request.getParameter("calendar_no"));
			String start_date = request.getParameter("start_date");
			String end_date = request.getParameter("end_date");
			String necessity = request.getParameter("necessity");
			String item = request.getParameter("item");
			String title = request.getParameter("title");
			String content = request.getParameter("content");

			CalendarDto dto = new CalendarDto(calendar_no, start_date, end_date, necessity, item, title, content, member_no);
			int res = biz.updateTrip(dto);
			if (res > 0) {
				System.out.println("수정 성공");
			} else {
				System.out.println("수정 실패");
			}
			
		} else if (command.equals("trip_delete")) {

			int member_no = (int) session.getAttribute("member_no");
			int calendar_no = Integer.parseInt(request.getParameter("calendar_no"));
			System.out.println(calendar_no);

			int res = biz.deleteTrip(1, calendar_no);

			if (res > 0) {
				System.out.println("삭제 성공");
				dispatch(request, response, "index.html");
			} else {
				System.out.println("삭제 실패");
				dispatch(request, response, "index.html");
			}
		}        

		// Calendar - 지현
		// Calendar 메인으로 이동
        if (command.equals("calendar_main")) {
        	dispatch(request, response, CalendarDirectory + "main.jsp");
        }
    
        // 일정 작성 페이지로 이동
     	if("calendar_insertform".equals(command)) {
     		String year = request.getParameter("year");
     		String month = request.getParameter("month");
     		String date = request.getParameter("date");
     		
   			request.setAttribute("year", year);
     		request.setAttribute("month", month);
     		request.setAttribute("date", date);
     		dispatch(request, response, CalendarDirectory + "insert.jsp");
     		
     	}
     	
        // 일정 등록
		if("calendar_insertres".equals(command)) {
			
			String calendar_title = request.getParameter("calendar_title");
			String s_year = request.getParameter("s_year");
			String s_month = request.getParameter("s_month");
			String s_date = request.getParameter("s_date");
			String s_hour = request.getParameter("s_hour");
			String s_min = request.getParameter("s_min");
			String e_year = request.getParameter("e_year");
			String e_month = request.getParameter("e_month");
			String e_date = request.getParameter("e_date");
			String e_hour = request.getParameter("e_hour");
			String e_min = request.getParameter("e_min");
			String calendar_necessity = request.getParameter("calendar_necessity");
			String calendar_item = request.getParameter("calendar_item");
			String calendar_content = request.getParameter("calendar_content");
			int member_no = (int) session.getAttribute("member_no");

			String calendar_startdate = s_year + pet_util.isTwo(s_month) + pet_util.isTwo(s_date) + pet_util.isTwo(s_hour) + pet_util.isTwo(s_min);
			String calendar_enddate = e_year + pet_util.isTwo(e_month) + pet_util.isTwo(e_date) + pet_util.isTwo(e_hour) + pet_util.isTwo(e_min);

			CalendarDto CalDto = new CalendarDto(0, calendar_startdate, calendar_enddate, calendar_necessity, calendar_item, calendar_title, calendar_content, member_no);
		
			int res = dao.CalendarInsert(CalDto);

			if (res > 0) {
				jsResponse(response, "일정이 등록되었습니다.", CalendarDirectory + "main.jsp");
			} else {
				jsResponse(response, "일정이 등록되지 않았습니다.", CalendarDirectory + "main.jsp");
			}

		}
	
		// 일정 리스트
     	if ("calendar_list".equals(command)) {
     		String year = request.getParameter("year");
     		String month = request.getParameter("month");
     		String date = request.getParameter("date");
   			String yyyyMMdd = year + pet_util.isTwo(month) + pet_util.isTwo(date);
   			int member_no = (int) session.getAttribute("member_no");
    			
   			List<CalendarDto> list = biz.CalendarList(member_no, yyyyMMdd);
     			
   			request.setAttribute("year", year);
     		request.setAttribute("month", month);
     		request.setAttribute("date", date);
     		request.setAttribute("list", list);
     		dispatch(request, response, CalendarDirectory + "list.jsp");
     	}
     		
     	// 일정 상세페이지
     	if("calendar_detail".equals(command)) {
     		String year = request.getParameter("year");
     		String month = request.getParameter("month");
     		String date = request.getParameter("date");
     		int calendar_no = Integer.parseInt(request.getParameter("calendar_no"));
     			
     		CalendarDto dto = biz.CalendarOne(calendar_no);
     			
     		request.setAttribute("year", year);
     		request.setAttribute("month", month);
     		request.setAttribute("date", date);
     		request.setAttribute("dto", dto);
     		dispatch(request, response, CalendarDirectory + "detail.jsp");
     		}
     	
     	
     	// 일정 삭제
     	if("calendar_delete".equals(command)) {
     		String year = request.getParameter("year");
     		String month = request.getParameter("month");
     		String date = request.getParameter("date");
     		int member_no = (int) session.getAttribute("member_no");
     		int calendar_no = Integer.parseInt(request.getParameter("calendar_no"));
     		
     		int res = biz.CalendarDelete(calendar_no);
     		if (res > 0) {
     			jsResponse(response, "삭제가 완료되었습니다.", "/semi_PetDiary/pet.do?command=calendar_list&year="+year+"&month="+month+"&date="+date+"&member_no="+member_no);
     		} else {
     			jsResponse(response, "오류가 발생했습니다.", "/semi_PetDiary/pet.do?command=calendar_list&year="+year+"&month="+month+"&date="+date+"&member_no="+member_no);
     		}
     	}
     		
     	// 일정 수정페이지로 이동
   		if("calendar_updateform".equals(command)) {
   			String year = request.getParameter("year");
     		String month = request.getParameter("month");
     		String date = request.getParameter("date");
     		int calendar_no = Integer.parseInt(request.getParameter("calendar_no"));
     			
     			
     		CalendarDto dto = biz.CalendarOne(calendar_no);
     		request.setAttribute("year", year);
     		request.setAttribute("month", month);
     		request.setAttribute("date", date);
     		request.setAttribute("dto", dto);
     		dispatch(request, response, CalendarDirectory + "update.jsp");
     	}
     		
   		// 일정 수정
     	if("calendar_updateres".equals(command)) {
     		String year = request.getParameter("year");
     		String month = request.getParameter("month");
     		String date = request.getParameter("date");
     			
     		int calendar_no = Integer.parseInt(request.getParameter("calendar_no"));
     		String calendar_title = request.getParameter("calendar_title");
     		String calendar_necessity = request.getParameter("calendar_necessity");
     		String calendar_item = request.getParameter("calendar_item");
     		String calendar_content = request.getParameter("calendar_content");
     		int member_no = (int) session.getAttribute("member_no");
     		CalendarDto dto = new CalendarDto();
     		dto.setCalendar_no(calendar_no);
     		dto.setCalendar_title(calendar_title);
     		dto.setCalendar_necessity(calendar_necessity);
     		dto.setCalendar_item(calendar_item);
     		dto.setCalendar_content(calendar_content);
     			
     		int res = biz.CalendarUpdate(dto);
     			
     		if (res > 0) {
     			jsResponse(response, "수정이 완료되었습니다.", "/semi_PetDiary/pet.do?command="+"calendar_list&year="+year+"&month="+month+"&date="+date+"&member_no="+member_no);
     		} else {
     			jsResponse(response, "오류가 발생했습니다.", "/semi_PetDiary/pet.do?command=calendar_list&year="+year+"&month="+month+"&date="+date+"&member_no="+member_no);
     		}
     	}
     	
     	// Calendar 끝
     	
    	
    	if("StartRTC".equals(command)) {
			System.out.println("성공");
			//String business_num = request.getParameter("business_num")
			String ROOM_ID=request.getParameter("ROOM_ID");
			int member=Integer.parseInt(request.getParameter("member"));
			int business=Integer.parseInt(request.getParameter("business"));
			System.out.println("R:"+ROOM_ID);
			System.out.println("M:"+member);
			System.out.println("B:"+business);
			PetRTCDto dto = new PetRTCDto(ROOM_ID,"N", member, business);
			if(dao.SelectRTCOne(business)!=null) {
				if(dao.updateRTC(dto)>0) {
					System.out.println("DB수정 성공");		
					String responseText = "<script type='text/javascript'>"
						    + "alert('성공');"
						    + "</script>";
					response.getWriter().print(responseText);
				}
			}else {
				if(dao.insertRTC(dto)>0) {
					System.out.println("DB작성 성공");		
				}
			}		
		}

		if("EndRTC".equals(command)) {
			System.out.println("성공");
			String ROOM_ID=request.getParameter("ROOM_ID");
			int member=Integer.parseInt(request.getParameter("member"));
			int business=Integer.parseInt(request.getParameter("business"));
			System.out.println("R:"+ROOM_ID);
			System.out.println("M:"+member);
			System.out.println("B:"+business);
			if(dao.SelectRTCOne(business)!=null) {
				if(dao.DeleteRTC(business)>0) {
					System.out.println("DB삭제 성공");
					
				}
			}else {
				System.out.println("DB삭제 실패");		

			}
			String responseText = "<script type='text/javascript'>"
				    + "window.close()"
				    + "</script>";
			response.getWriter().print(responseText);
			
		}

		if("OpenRTC".equals(command)) {
			int member=Integer.parseInt(request.getParameter("member"));
			int business=Integer.parseInt(request.getParameter("business"));
			if(dao.SelectRTCOne(business)==null) {
				request.setAttribute("member", member);
				request.setAttribute("business", business);
				request.getRequestDispatcher("rtc/openrtc.jsp").forward(request, response);
			}else {
				jsResponseClose(response, "열려있는 상담실이 있습니다.");
			}
			
		}

		if("ConnectRTC".equals(command)) {
			int member=Integer.parseInt(request.getParameter("member"));
			int business=Integer.parseInt(request.getParameter("business"));
			String room_id = dao.SelectRTCOne(business).getRtc_room();
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("member_no", Integer.toString(member));
			Calendar cal = Calendar.getInstance();			
			String book_date = Integer.toString(cal.get(Calendar.YEAR))+pet_util.isTwo(Integer.toString(cal.get(Calendar.MONTH)+1))+pet_util.isTwo(Integer.toString(cal.get(Calendar.DATE)));
			System.out.println(book_date);
			map.put("book_date", book_date);
			if(dao.SelectBookRTC(map)!=null) {
				System.out.println(dao.SelectRTCOne(business).getRtc_use());
				if(dao.SelectRTCOne(business).getRtc_use().equals("N")) {
					response.sendRedirect("https://152.70.250.165:3000/"+room_id	);		
				}else {
					jsResponseClose(response, "먼저 상담중인 사람이 있습니다. 잠시 기다려 주세요");
					
				}
			}else {
				jsResponseClose(response, "상담 전 예약을 진행해 주세요");
			}
			
		}

		
		if("UseRTC".equals(command)) {
			String room_id = request.getParameter("ROOM_ID");
			System.out.println(room_id);
			if(dao.SelectRTCRoom(room_id)!=null) {
				if(dao.UseRTC(room_id)>0) {
					System.out.println("성공");
				}				
			}
		}
		
		if("NUseRTC".equals(command)) {
			String room_id = request.getParameter("ROOM_ID");
			System.out.println(room_id);

			if(dao.SelectRTCRoom(room_id)!=null) {
				if(dao.NUseRTC(room_id)>0) {
					System.out.println("성공");
				}			
			}
			
		} else if (command.equals("picture_insert_upload")) {

			Map<String, String> user = new HashMap<String, String>();

			String fileSeperator = File.separator;
			int member_no = (int) session.getAttribute("member_no");
			String path = request.getSession().getServletContext().getRealPath("resources" + fileSeperator + "Upload" + fileSeperator + member_no);
			Util.MakeFolder(path);

			int size = 1024 * 1024 * 10;
			String fileName = "";
			String originalFile = "";
			request.setCharacterEncoding("UTF-8");
			boolean isMultipart = FileUpload.isMultipartContent(request);

			try {
				if (isMultipart) {
					DiskFileItemFactory factory = new DiskFileItemFactory();

					ServletFileUpload upload = new ServletFileUpload(factory);

					upload.setHeaderEncoding("UTF-8");

					List<FileItem> items = upload.parseRequest(request);
					Iterator<FileItem> iter = items.iterator();

					while (iter.hasNext()) {
						FileItem item = iter.next();

						item.getString("UTF-8");

						if (item.isFormField()) {

							String name = item.getFieldName();
							String value = new String((item.getString()).getBytes("8859_1"), "UTF-8");
							user.put(name, value);

						} else {
							fileName = new File(item.getName()).getName();
							String eFilename = URLEncoder.encode(fileName, "UTF-8");

							PictureDto dto = new PictureDto();
							dto.setPicture_directory(".." + fileSeperator + "resources" + fileSeperator + "Upload" + fileSeperator + member_no);							dto.setPicture_name(fileName);
							dto.setMember_no(member_no);
							int res = biz.insertPicture(dto);

							File storeFile = new File(path + fileSeperator + eFilename);
							user.put("user_img", eFilename);
							item.write(storeFile);
						}
					}

				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			dispatch(request, response, "pet.do?command=picture_insert_select");	
			
		} else if (command.equals("iSelPic")) {
			String src = request.getParameter("src");
			request.setAttribute("src", src);
			dispatch(request, response, "pet/pet_insert.jsp");
			
		} else if (command.equals("uSelPic")) {
			int member_no = (int) session.getAttribute("member_no");
			int pet_no = Integer.parseInt(request.getParameter("pet_no"));
			String src = request.getParameter("src");
			System.out.println(src);
			System.out.println(pet_no);
			PetDto dto = biz.selectPetOne(member_no, pet_no);
			request.setAttribute("dto",dto);
			request.setAttribute("src", src);
			dispatch(request, response, "pet/pet_update.jsp");
			
		}else if (command.equals("memberInfo")) {
			int member_no = (int) session.getAttribute("member_no");
			PrintWriter out = response.getWriter();
			MemberDto dto = biz.MemberOne(member_no);
			JSONObject jObj = new JSONObject();
			JSONArray jarr = new JSONArray();
			jObj.put("member_email", dto.getMember_email());
			jObj.put("member_name", dto.getMember_name());
			jObj.put("member_phone", dto.getMember_phone());
			jObj.put("member_address", dto.getMember_address());
			jarr.add(jObj);
			out.print(jarr);
			out.flush();
			
		} else if (command.equals("payCancel")) {
			Pay_function pay = new Pay_function();
			int book_num = Integer.parseInt(request.getParameter("book_num"));

			String token = pay.getImportToken();
			String merchant_uid = biz.getMerchant_uid(book_num);
			System.out.println(pay.cancelPayment(token, merchant_uid));

			OrderDto s_dto = biz.selectOrderOne(book_num);
			OrderDto c_dto = new OrderDto();
			c_dto.setMerchant_uid(s_dto.getMerchant_uid());
			c_dto.setOrder_state("예약취소");
			c_dto.setOrder_information("예약금 결제 취소");
			c_dto.setOrder_amount(s_dto.getOrder_amount());
			c_dto.setMember_no(s_dto.getMember_no());
			c_dto.setMember_name(s_dto.getMember_name());

			int insert_order = biz.orderInsert(c_dto);
			int book_res = biz.bookdelete(book_num);
			int order_res = biz.orderInsertCancel(book_num);

			if (insert_order > 0) {
				System.out.println("예약 취소 insert 성공");
			}
			
			if(book_res > 0 ) {
				System.out.println("예약 내용 삭제 성공!");
			}
			if (order_res > 0) {
				System.out.println("결제 취소 성공!");
			}
			dispatch(request, response, "pet.do?command=myinfo");
		
			
		} else if (command.equals("orderSuccess")) {

			int member_no = (int) session.getAttribute("member_no");
			String order_data = request.getParameter("order_data");
			JSONObject json = JSONObject.fromObject(order_data);

			OrderDto dto = new OrderDto();
			System.out.println((String) json.get("book_num"));
			dto.setBook_num(Integer.parseInt((String) json.get("book_num")));
			dto.setMerchant_uid((String) json.get("merchant_uid"));
			dto.setOrder_amount((Integer) json.get("order_amount"));
			dto.setMember_name((String) json.get("order_name"));
			dto.setOrder_information((String) json.get("order_info"));
			dto.setMember_no(member_no);
			dto.setOrder_state("예약 완료");

			int order_res = biz.orderInsert(dto);

			if (order_res > 0) {
				int res = biz.bookOrderSuccess(Integer.parseInt((String) json.get("book_num")));
				if (res > 0) {
					System.out.println("수정 성공");
					dispatch(request, response, "pet.do?command=business");
				} else {
					System.out.println("수정 실패");
				}
			}
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	protected void dispatch(HttpServletRequest request, HttpServletResponse response, String path) throws ServletException, IOException{
		RequestDispatcher dispatch = request.getRequestDispatcher(path);
		dispatch.forward(request, response);
	}

	private void jsResponse(HttpServletResponse response, String msg, String url) throws IOException {
		String responseText = "<script type='text/javascript'>"
						    + "alert('" + msg + "');"
						    + "location.href='" + url + "';"
						    + "</script>";
		response.getWriter().print(responseText);
	}

	private void jsResponseClose(HttpServletResponse response, String msg) throws IOException {
		String responseText = "<script type='text/javascript'>"
						    + "alert('" + msg + "');"
						    + "window.close()"
						    + "</script>";
		response.getWriter().print(responseText);
	}
}
