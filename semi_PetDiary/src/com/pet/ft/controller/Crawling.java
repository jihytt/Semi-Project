package com.pet.ft.controller;
import java.io.BufferedReader;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.jsoup.Connection;
import org.jsoup.nodes.DataNode;

public class Crawling {

    public static void getData() {
        String url = "https://www.instagram.com/explore/tags/%EB%B0%98%EB%A0%A4%EB%8F%99%EB%AC%BC/"; //크롤링할 url지정
        Document doc = null;        //Document에는 페이지의 전체 소스가 저장된다

		try {
		    doc = Jsoup.connect(url).get();
		} catch(IOException e) {
		    e.printStackTrace();
		}

	 //select를 이용하여 원하는 태그를 선택한다. select는 원하는 값을 가져오기 위한 중요한 기능이다.
    /*    Elements element = doc.select("script[type=text/javascript]");

		System.out.println("============================================================");

		//Iterator을 사용하여 하나씩 값 가져오기
        Iterator<Element> ie = element.iterator();
		while(ie.hasNext()) {
		    System.out.println(ie.next().text());
		}
		System.out.println("============================================================");*/

        for (Element script : doc.select("script[type=text/javascript]")) {
            String data = script.data();
            if (data.contains("window._sharedData = ")) {
                System.out.println(data);
            }
        }


		/*String url ="https://www.instagram.com/explore/tags/반려동물/";  //인스타그램 url
		System.out.println(url);
		//String userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36";
		String userAgent = "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36";
		System.setProperty("sun.net.http.allowRestrictedHeaders", "false");
		try {
			Connection.Response nvDocument = Jsoup.connect(url).userAgent(userAgent).method(Connection.Method.GET).execute();

			Document doc = nvDocument.parse();

			Elements datas = doc.select("script");

			for (Element data : datas) {
				for (DataNode node : data.dataNodes()) {
					if (node.getWholeData().contains("window._sharedData =")) {

						String nodeData = node.getWholeData();
						System.out.println(nodeData);
						nodeData = nodeData.replace("window._sharedData = ", "");
						nodeData = nodeData.replace(nodeData.substring(nodeData.length() - 1), "");

						JSONParser parser = new JSONParser();
						JSONObject instaObj = (JSONObject) parser.parse(nodeData);

						JSONObject entry_data = (JSONObject) instaObj.get("entry_data");
						JSONArray profilePage = (JSONArray) entry_data.get("ProfilePage");
						JSONObject profileData = (JSONObject) profilePage.get(0);
						JSONObject graphql = (JSONObject) profileData.get("graphql");
						JSONObject user2 = (JSONObject) graphql.get("user");
						String biography = (String) user2.get("biography");
						String proFileImg = (String) user2.get("profile_pic_url");
						System.out.println("Biografia :" + biography);
						System.out.println("proFileImg :" + proFileImg);


						JSONObject edge_followed_by = (JSONObject) user2.get("edge_followed_by");

						Long count = (Long) edge_followed_by.get("count");
						System.out.println("follow --->:" + Long.toString(count));

						JSONObject edge_follow = (JSONObject) user2.get("edge_follow");
						Long count_edge_follow = (Long) edge_follow.get("count");
						System.out.println("follower --->:" + Long.toString(count_edge_follow));

						JSONObject edge_owner_to_timeline_media = (JSONObject) user2.get("edge_owner_to_timeline_media");
						Long count_edge_owner_to_timeline_media = (Long) edge_owner_to_timeline_media.get("count");
						System.out.println("게시물수 --->:" + Long.toString(count_edge_owner_to_timeline_media));

						JSONArray edges = (JSONArray) edge_owner_to_timeline_media.get("edges");

						edges.forEach(item -> {
							JSONObject edge = (JSONObject) item;
							JSONObject edgeNode = (JSONObject) edge.get("node");
							String __typename = (String) edgeNode.get("__typename");
							System.out.println("게시물 타입 --->:" + __typename);

							String contents = "";
							String contentsUrl = "";

							if (__typename.equals("GraphVideo")) {
								contents = (String) edgeNode.get("thumbnail_src");
								System.out.println("이미지 URL --->:" + contents);
							} else {
								JSONArray contentsArray = (JSONArray) edgeNode.get("thumbnail_resources");
								JSONObject contentsImg = (JSONObject) contentsArray.get(3);
								contentsUrl = (String) contentsImg.get("src");
								System.out.println("이미지 URL --->:" + contentsUrl);
							}

							JSONObject postLike = (JSONObject) edgeNode.get("edge_liked_by");
							Long postLikeCnt = (Long) postLike.get("count");

							System.out.println("좋아요 Count --->:" + postLikeCnt);

							String postUrl = "https://www.instagram.com/p/" + (String) edgeNode.get("shortcode");
							System.out.println("post 링크 --->:" + postUrl);


							JSONObject contentsTextObj = (JSONObject) edgeNode.get("edge_media_to_caption");
							JSONArray contextsTextArr = (JSONArray) contentsTextObj.get("edges");
							if (contextsTextArr.size() > 0) {
								JSONObject contentsTxtNode = (JSONObject) contextsTextArr.get(0);
								contentsTxtNode = (JSONObject) contentsTxtNode.get("node");
								String contentsStr = (String) contentsTxtNode.get("text");

								System.out.println("내용 --->:" + contentsStr);
							}

						});
						break;
					}
				}
			}
		}catch (Exception e){
			System.out.println(e.toString());
		}*/



        /*Map<String, Object> resultM = new HashMap<String, Object>();
        try {
            String apiURL = "https://www.instagram.com/explore/tags/반려동물/?__a=1&max_id=QVFDTTB6MWxMTjUzTnZ5NVdPUjNVWkpkNW1JVWszVmN5akU0Ujc1cFN1YWlMUFM3UlpJTVktTkdGWXNOZ2d4X21YUjZxNkNpN093VWk1alVDR3R6OVNYTQ==";

            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer res = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                res.append(inputLine);
            }

            JSONParser jsonParser = new JSONParser();
            JSONObject jsonObj = (JSONObject) jsonParser.parse(res.toString());
            System.out.println(jsonObj);
            jsonObj = (JSONObject) jsonObj.get("graphql");
            jsonObj = (JSONObject) jsonObj.get("hashtag");


            resultM.put("OUT_DATA", jsonObj);
            //System.out.println("인스타// "+resultM);


        } catch (Exception e) {
            System.out.println(e);
        }

        return resultM.toString();*/
    }
}