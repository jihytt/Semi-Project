package com.pet.ft.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pet.ft.dto.BookDto;
import com.pet.ft.dto.BusinessDto;
import com.pet.ft.dto.CommunityDto;
import com.pet.ft.dto.MemberDto;
import com.pet.ft.model.BusinessDao;
import com.pet.ft.model.BusinessDaoImpl;
import com.pet.ft.model.PetBiz;
import com.pet.ft.model.PetBizImpl;
import com.pet.ft.paging.Paging;

@WebServlet("/paging.do")
public class PagingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String command = request.getParameter("command");
		
		int currentPageNo = 1;
		int recordsPerPage = 0;
		String url = null;
		PetBiz biz = new PetBizImpl();
		
		HttpSession session = request.getSession();
		
		if("member".equals(command)) {
			
			if(request.getParameter("pages") != null)
				currentPageNo = Integer.parseInt(request.getParameter("pages"));
			
			if(request.getParameter("lines") != null)
				recordsPerPage = Integer.parseInt(request.getParameter("lines"));
			
			Paging paging = new Paging(currentPageNo, recordsPerPage);
			
			int offset = (paging.getCurrentPageNo() -1) * paging.getRecordsPerPage();
			
			List<MemberDto> list = biz.memberList(offset, paging.getRecordsPerPage() * currentPageNo);
			
			paging.setNumberOfRecords(biz.totalMember());
			
			paging.makePaging();
			
			if(list != null) {
				request.setAttribute("key", "member");
				request.setAttribute("list", list);
				request.setAttribute("paging", paging);
				request.setAttribute("servletPath", "paging.do");
				
				url = "admin/admin_member.jsp";
			} else {
				request.setAttribute("msg", "Error가 발생했습니다.");
				
				url = "admin/admin_member.jsp";
			}
			
			request.getRequestDispatcher(url).forward(request, response);
		} else if("report".equals(command)) {
			
			if(request.getParameter("pages") != null)
				currentPageNo = Integer.parseInt(request.getParameter("pages"));
			
			if(request.getParameter("lines") != null)
				recordsPerPage = Integer.parseInt(request.getParameter("lines"));
			
			Paging paging = new Paging(currentPageNo, recordsPerPage);
			
			int offset = (paging.getCurrentPageNo() -1) * paging.getRecordsPerPage();
			
			List<CommunityDto> list = biz.reportList(offset, paging.getRecordsPerPage() * currentPageNo);
			
			paging.setNumberOfRecords(biz.totalReport());
			
			paging.makePaging();
			
			if(list != null) {
				request.setAttribute("key", "report");
				request.setAttribute("list", list);
				request.setAttribute("paging", paging);
				request.setAttribute("servletPath", "paging.do");
				
				url = "admin/admin_report.jsp";
			} else {
				
				request.setAttribute("msg", "Error가 발생했습니다.");
				
				url = "admin/admin_report.jsp";
			}
			
			request.getRequestDispatcher(url).forward(request, response);
			
		} else if("book".equals(command)) {
			
			if(request.getParameter("pages") != null)
				currentPageNo = Integer.parseInt(request.getParameter("pages"));
			
			if(request.getParameter("lines") != null)
				recordsPerPage = Integer.parseInt(request.getParameter("lines"));
			
			Paging paging = new Paging(currentPageNo, recordsPerPage);
			
			int offset = (paging.getCurrentPageNo() -1) * paging.getRecordsPerPage();
			
			int member_no = (int) session.getAttribute("member_no");
			
			List<BookDto> list = biz.bookListHos(offset, paging.getRecordsPerPage() * currentPageNo, member_no);
			
			paging.setNumberOfRecords(biz.totalBookHos(member_no));
			
			paging.makePaging();
			
			if(list != null) {
				request.setAttribute("key", "book");
				request.setAttribute("list", list);
				request.setAttribute("paging", paging);
				request.setAttribute("servletPath", "paging.do");
				
				url = "business/booklist_main.jsp";
			} else {
				
				request.setAttribute("msg", "Error가 발생했습니다.");
				
				url = "business/booklist_main.jsp";
			}
			
			request.getRequestDispatcher(url).forward(request, response);
		} else if("bookst".equals(command)) {
			
			if(request.getParameter("pages") != null)
				currentPageNo = Integer.parseInt(request.getParameter("pages"));
			
			if(request.getParameter("lines") != null)
				recordsPerPage = Integer.parseInt(request.getParameter("lines"));
			
			Paging paging = new Paging(currentPageNo, recordsPerPage);
			
			int offset = (paging.getCurrentPageNo() -1) * paging.getRecordsPerPage();
			
			int member_no = (int) session.getAttribute("member_no");
			
			List<BookDto> list = biz.bookListSt(offset, paging.getRecordsPerPage() * currentPageNo, member_no);
			
			paging.setNumberOfRecords(biz.totalBookSt(member_no));
			
			paging.makePaging();
			
			if(list != null) {
				request.setAttribute("key", "bookst");
				request.setAttribute("list", list);
				request.setAttribute("paging", paging);
				request.setAttribute("servletPath", "paging.do");
				
				url = "business/booklist_st.jsp";
			} else {
				
				request.setAttribute("msg", "Error가 발생했습니다.");
				
				url = "business/booklist_st.jsp";
			}
			
			request.getRequestDispatcher(url).forward(request, response);
		}
		if("foodlist".equals(command)) {
			
			List<BusinessDto> list1 = biz.menu();
			request.setAttribute("list1", list1);
			request.getRequestDispatcher("/food/food_list1.jsp");
			
			
			if(request.getParameter("pages") != null)
				currentPageNo = Integer.parseInt(request.getParameter("pages"));
			
			if(request.getParameter("lines") != null)
				recordsPerPage = Integer.parseInt(request.getParameter("lines"));
			
			Paging paging = new Paging(currentPageNo, recordsPerPage);
			
			int offset = (paging.getCurrentPageNo() -1) * paging.getRecordsPerPage();
			
			System.out.println("offset : " +offset);
			System.out.println("리스트 : "+list1);
			
			List<BusinessDto> list = biz.BusinessList(offset, paging.getRecordsPerPage() * currentPageNo);
			
			paging.setNumberOfRecords(biz.businessTotal());
			
			paging.makePaging();
			System.out.println("recordsPerPage *currentpage : " +paging.getRecordsPerPage()*currentPageNo);
			System.out.println("currentpage : " +paging.getCurrentPageNo());
			System.out.println("recordsPerpage : " +paging.getRecordsPerPage());
			
			if(list != null) {
				request.setAttribute("key", "foodlist");
				request.setAttribute("list", list);
				request.setAttribute("paging", paging);
				request.setAttribute("servletPath", "paging.do");
				
				url = "/food/food_list1.jsp";
			} else {
				request.setAttribute("msg", "Error가 발생했습니다.");
				
				url = "/food/food_list1.jsp";
			}
			
			request.getRequestDispatcher(url).forward(request, response);
		
		
	}
	}

}