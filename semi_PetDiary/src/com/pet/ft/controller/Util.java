package com.pet.ft.controller;

import java.io.File;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.Year;
import java.util.Calendar;
import java.util.Date;

public class Util {

    public static void MakeFolder(String path) {
        File isDir = new File(path);
        if (!isDir.isDirectory()) {
            try {
                if (isDir.mkdir()) {
                    System.out.println("폴더 생성");
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("이미 폴더가 생성되어 있습니다");
        }

    }

    public static void deleteFile(String path) {

        File file = new File(path);
        if (file.exists()) {
            file.delete();
        }
    }

    public static String today() {
        Calendar cal = Calendar.getInstance();
        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH) + 1;
        int day = cal.get(Calendar.DATE);


        return year + "-" + month + "-" + day;
    }
    
    public static String isTwo(String booktime) {
        if(booktime.length() < 2) {
            booktime = "0" + booktime;
        }

        return booktime;
    }
}
