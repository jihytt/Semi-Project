package com.pet.ft.controller;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.snu.ids.kkma.ma.Eojeol;
import org.snu.ids.kkma.ma.MExpression;
import org.snu.ids.kkma.ma.MorphemeAnalyzer;
import org.snu.ids.kkma.ma.Sentence;
import org.snu.ids.kkma.util.Timer;

import com.google.gson.JsonObject;
import com.pet.ft.model.PetBiz;
import com.pet.ft.model.PetBizImpl;


public class pet_filter {

	public String filtering(String str) {
	
		
		return maTest(str);
	}
	
	public static String maTest(String string){
		int space = 0;
		List<String> badW1 = badwords.badword1();
		HashMap<String, String> badP2 = badwords.badmorpheme1();
		List<String> badW3 = badwords.badword2();
		HashMap<String, String> badP4 = badwords.badmorpheme2();
		List<String> keymap = badwords.Keymap();
		List<String> keymap2 = badwords.Keymap2();

		int count = 0;
		
		for(String word :badW1) {
			while(string.indexOf(word)>=0) {
				string = string.replace(word, "**");	
				count++;
			}		
		}
		if(count==0) {
			String match = "[^\uAC00-\uD7A3xfea-zA-Z]";
	        String string2 =string.replaceAll(match, "");
			for(String word :badW1) {
				while(string2.indexOf(word)>=0) {
					string2 = string2.replace(word, "**");
					count++;
				}		
			}
			System.out.println("1단계 체크/공백 및 특수문자 :"+count);
		}
		

		
		
		try {
			MorphemeAnalyzer ma = new MorphemeAnalyzer();
			ma.createLogger(null);		
			List<MExpression> ret = ma.analyze(string);
			ret = ma.postProcess(ret);
			ret = ma.leaveJustBest(ret);
			List<Sentence> stl = ma.divideToSentences(ret);	
			for(Sentence word : stl) {
				for(Eojeol res : word) {
						for(String K :keymap) {
							if(count==0) {
								if(res.toString().split("=>")[1].split("/")[1].trim().equals(K)) {
									space = 0;
										if(res.toString().split("=>")[1].trim().split("/")[2].indexOf(badP2.get(K))>=0) {
											String builder = string;
											int place = Integer.parseInt(res.toString().split("=>")[1].trim().split("/")[0].replace("[", ""));
											while(!builder.substring(place, place+K.length()).equals(K)) {
												if(builder.substring(place, place+K.length()).equals("존")) {
													break;
												}
												builder = builder.replaceFirst(" ", "");
												space++;
											}					
												
											string = string.substring(0, place+space)+"*"+string.substring(place+space+K.length(), string.length());
											count++;
										}
										
								}
								
							}
						}		
						
				}			
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println("2단계 체크 :"+count);
		if(count>0) {
			for(String word :badW3) {
				while(string.indexOf(word)>=0) {
					string = string.replace(word, "**");	
					count++;
				}		
			}
			System.out.println("3단계 체크 :"+count);
		}
		
		

		if(count>0) {
			try {
				MorphemeAnalyzer ma = new MorphemeAnalyzer();
				ma.createLogger(null);		
				List<MExpression> ret = ma.analyze(string);
				ret = ma.postProcess(ret);
				ret = ma.leaveJustBest(ret);
				List<Sentence> stl = ma.divideToSentences(ret);	
				for(Sentence word : stl) {
					for(Eojeol res : word) {
						for(String K :keymap2) {
								if(res.toString().split("=>")[1].trim().split("/")[1].equals(K)) {
									space = 0;
									if(res.toString().split("=>")[1].trim().split("/")[2].indexOf(badP4.get(K))>=0) {
										String builder = string;
										int place = Integer.parseInt(res.toString().split("=>")[1].trim().split("/")[0].replace("[", ""));
										while(!builder.substring(place, place+K.length()).equals(K)) {
											if(builder.substring(place, place+K.length()).equals("존")) {
												break;
											}
											builder = builder.replaceFirst(" ", "");
											space++;

										}			
										string = string.substring(0, place+space)+"*"+string.substring(place+space+K.length(), string.length());
										count++;
									}
								}
										
							}
						}		
						
					}			 
				}catch (Exception e) {
				// TODO: handle exception
			}
		}

		System.out.println("4단계 체크:"+count);
		
		return string;	
		}
}
