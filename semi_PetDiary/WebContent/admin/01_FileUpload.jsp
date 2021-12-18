<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.File" %>
<%@page import="java.util.Enumeration" %>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%
	String realFolder="";
	
	//업로드용 폴더 이름
	String saveFolder="upload";
	String encType="utf-8";
	int maxSize=5*1024*1024; //5MByte
	
	// jspMain2-context라고 한다. 서버에서(서블릿) 어디에 어느 폴더에서 서블릿으로 변한되니?
	ServletContext context=this.getServletContext();
	
	// 서블릿상의 upload폴더 경로를 알아온다.
	realFolder=context.getRealPath(saveFolder);
	
	// 콘솔/브라우저에 실제 경로를 출력
	System.out.println("실저 서블릿 상 경로 : " + realFolder);
	out.print("실제 서블릿 상 업로드 경로 :" + realFolder);
	
	// 파일을 받아와서 폴더에 업로드 하면 된다.
	
	MultipartRequest multi=null;
	
	String fullpath = null;
	
	try{
		multi = new MultipartRequest(
			   request,
			   realFolder,
			   maxSize,
			   encType,
			   new DefaultFileRenamePolicy()
			  );
		
		Enumeration en = multi.getParameterNames();
		while(en.hasMoreElements()){
			String name = (String) en.nextElement();
			String value = multi.getParameter(name);
			out.print("<br>"+name+":"+value);
		}
		
		out.print("<hr>");
		
		// 전송될 파일이름 fileName1, fileName2를 가져온다.
		en = multi.getFileNames();
		while(en.hasMoreElements()){
			String name=(String) en.nextElement();
			// name파라미터에는 file의 이름이 들어있다.
			// 그 이름을 주면 실제 값(업로드 "할" file)을 가져온다.
			String originFile = multi.getOriginalFileName(name);
			
			// 만약 업로드 폴더에 똑같은 파일이 있으면 현재 올리는 파일 이름은 바뀐다.(중복정책)
			// 그래서 시스템에 있는 이름을 알려준다. 
			String systemFile = multi.getFilesystemName(name);
			
			// 전송된 파일의 타입 - MIme 타입 (기계어, image, HTML, text, ...)
			String fileType = multi.getContentType(name);
			
			// 문자열 "파일 이름"이 name에 들어온 상태
			// 문자열 파일 이름을 통해 실제 파일 객체를 가져온다.
			
			File file = multi.getFile(name); // java.io
			
			out.println("파라미터 이름 : " + name + "<br>");
			out.println("원본 이름 : " + originFile + "<br>");
			out.println("시스템 이름 : " + systemFile + "<br>");
			out.println("파일 타입 : " + fileType + "<br>");
			
			if(file != null){
				out.println("크기 : " + file.length() + "byte" + "<br>");
				
				fullpath = "/semi_PetDiary/upload" + "\\" + systemFile;
				
				request.setAttribute("fullpath", fullpath);
				request.getRequestDispatcher("/admin/admin_main.jsp").forward(request, response);
			}
		}
	} catch(Exception e){
		out.println("파일 처리 간 문제 발생");
	}
	
%>  
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


	<img src=<%=fullpath%> width=512 height=384 />

</body>
</html>