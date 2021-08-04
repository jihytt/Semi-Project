<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>

<%@ page import="org.w3c.dom.*"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		//XML 데이터를 호출할 URL
	String url = "http://www.kma.go.kr/wid/queryDFSRSS.jsp?zone=4159026200";

	//서버에서리턴될 XML데이터의 엘리먼트 이름 배열
	String[] fieldNames = { "temp", "wfKor", "wfEn", "pop", "hour", "day" };

	//각 게시물하나에 해당하는 XML 노드를 담을 리스트
	ArrayList<HashMap<String, String>> pubList = new ArrayList<HashMap<String, String>>();

	String wfKor = "";
	String imgWfKor = "";
	String wfTemp = "";

	String wfKor1 = "";
	String imgWfKor1 = "";
	String wfTemp1 = "";

	String wfKor2 = "";
	String imgWfKor2 = "";
	String wfTemp2 = "";

	//오늘 내일 모레 표현을 위한 빈 변수 준비.
	String day = "";
	String day1 = "";
	String day2 = "";

	//강수확률 표현을 위한 빈 변수. 강수확률 = pop
	String pop = "";
	String pop1 = "";
	String pop2 = "";

	try {
		//XML파싱 준비
		DocumentBuilderFactory f = DocumentBuilderFactory.newInstance();
		DocumentBuilder b = f.newDocumentBuilder();

		//위에서 구성한 URL을 통해 XMl 파싱 시작
		Document doc = b.parse(url);
		doc.getDocumentElement().normalize();

		//서버에서 응답한 XML데이터를 data(발행문서 1개 해당)태그로 각각 나눔(파라미터로 요청한 size항목의 수만큼) //발표시간 기준으로 3시간 후 데이터 발표.
		NodeList items = doc.getElementsByTagName("data");

		//for 루프시작
		for (int i = 0; i < items.getLength(); i++) {
			//i번째 publication 태그를 가져와서
			Node n = items.item(i);

			Element e = (Element) n;
			HashMap<String, String> pub = new HashMap<String, String>();

			//for 루프 시작
			for (String name : fieldNames) {

		//"hour", "day", "temp", "tmx", "tmn", "sky", "pty", "wfKor"....에 해당하는 값을 XML 노드에서 가져옴		
		NodeList titleList = e.getElementsByTagName(name);
		Element titleElem = (Element) titleList.item(0);

		Node titleNode = titleElem.getChildNodes().item(0);

		// 가져온 XML 값을 맵에 엘리먼트 이름-값 쌍으로 넣음
		pub.put(name, titleNode.getNodeValue());
			}

			//데이터가 전부 들어간 맵을 리스트에 넣고 화면에 뿌릴 준비.
			pubList.add(pub);
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	for (int i = 0; i < pubList.size(); i++) {
		HashMap<String, String> pub = pubList.get(i);

		String tmpWfKor = pub.get("wfKor");
		if (tmpWfKor == null)
			tmpWfKor = "";

		String tmpWfDay = pub.get("day");
		String tmpWfHour = pub.get("hour");

		String tmpImgWfKor = "ico01";//맑을때. ""안에 이미지넣으면 되려나..
		if (tmpWfKor.equals("구름 조금"))
			tmpImgWfKor = "ico02";
		else if (tmpWfKor.equals("구름 많음"))
			tmpImgWfKor = "ico03";
		else if (tmpWfKor.equals("흐림"))
			
			tmpImgWfKor = "ico04";
		else if (tmpWfKor.equals("비"))
			tmpImgWfKor = "ico05";
		else if (tmpWfKor.equals("눈/비"))
			tmpImgWfKor = "ico06";
		else if (tmpWfKor.equals("눈"))
			tmpImgWfKor = "ico07";

		//오늘 내일 모레 if문...
		String tmpday = "오늘";
		if (tmpWfDay.equals("1"))
			tmpday = "내일";
		else if (tmpWfDay.equals("2"))
			tmpday = "모레";

		String tmpWfTemp = pub.get("temp");

		String tmppop = pub.get("pop");

		//오늘날씨
		if (i == 0) {
			day = tmpday;
			wfKor = tmpWfKor;
			imgWfKor = tmpImgWfKor;
			wfTemp = tmpWfTemp;
			pop = tmppop;
		}
		//내일날씨.
		if (tmpWfDay.equals("1") && tmpWfHour.equals("9")) {
			day1 = tmpday;
			wfKor1 = tmpWfKor;
			imgWfKor1 = tmpImgWfKor;
			wfTemp1 = tmpWfTemp;
			pop1 = tmppop;

		}
		// 모레 날씨 정보 받기
		if (!tmpWfKor.equals("") && tmpWfDay.equals("2") && tmpWfHour.equals("3")) {
			day2 = tmpday;
			wfKor2 = tmpWfKor;
			imgWfKor2 = tmpImgWfKor;
			wfTemp2 = tmpWfTemp;
			pop2 = tmppop;

		}
		if (!tmpWfKor.equals("") && tmpWfDay.equals("2") && tmpWfHour.equals("6")) {
			day2 = tmpday;
			wfKor2 = tmpWfKor;
			imgWfKor2 = tmpImgWfKor;
			wfTemp2 = tmpWfTemp;
			pop2 = tmppop;
		}
		if (!tmpWfKor.equals("") && tmpWfDay.equals("2") && tmpWfHour.equals("9")) {
			day2 = tmpday;
			wfKor2 = tmpWfKor;
			imgWfKor2 = tmpImgWfKor;
			wfTemp2 = tmpWfTemp;
			pop2 = tmppop;
		}

	}
	%>
	

	<div class="outer box">
		<div class="inner box">
			<div><p><%=day%>의 날씨</p></div>
			<div><%=wfKor%></div>
			<div>
				<img src= "/semi_PetDiary/resources/image_weather/<%=wfKor%>.png" width="150" height="150">
			</div>
		</div>
		<div class="inner box">
			<div><p><%=day1%>의 날씨</p></div>
			<div><%=wfKor1%></div>
			<div>
				<img src= "/semi_PetDiary/resources/image_weather/<%=wfKor1%>.png" width="150" height="150">
			</div>
		</div>
		<div class="inner box">
			<div><p><%=day2%>의 날씨</p></div>
			<div><%=wfKor2%></div>
			<div>
				<img src= "/semi_PetDiary/resources/image_weather/<%=wfKor2%>.png" width="150" height="150">
			</div>
		</div>
	
	</div>
	
	
	
	
	
	<p class="dateweather"><%=pop%><%=day%><%=imgWfKor%>...<%=wfKor%>...<%=wfTemp%>&deg;C
	</p>
	<p class="dateweather"><%=pop1%><%=day1%><%=imgWfKor1%>...<%=wfKor1%>...<%=wfTemp1%>&deg;C
	</p>
	<p class="dateweather"><%=pop2%><%=day2%><%=imgWfKor2%>...<%=wfKor2%>...<%=wfTemp2%>&deg;C
	</p>

</body>
</html>