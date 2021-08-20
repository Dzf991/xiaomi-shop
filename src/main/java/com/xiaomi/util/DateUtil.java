package com.xiaomi.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {


    public static void main(String[] args) {
        System.out.println(getDate());
    }

    public static String getDate(){

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String nowDate = simpleDateFormat.format(new Date());
        return nowDate;
    }
}
