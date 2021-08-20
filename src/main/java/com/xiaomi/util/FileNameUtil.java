package com.xiaomi.util;

import java.util.UUID;

public class FileNameUtil {

    public static void main(String[] args) {
        System.out.println(getUUId());

    }

    public static String getUUId(){

        StringBuilder stringBuilder = new StringBuilder();
        String uuid = UUID.randomUUID().toString();
        String[] strings = uuid.split("-");
        for (String str:strings) {
            stringBuilder.append(str);
        }
        return stringBuilder.toString();
    }


    public static String getImgType(String imgName){
        String[] name = imgName.split("\\.");
        return name[1];
    }
}
