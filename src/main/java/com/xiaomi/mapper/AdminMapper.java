package com.xiaomi.mapper;

import com.xiaomi.pojo.Admin;


public interface AdminMapper {
    int insert(Admin record);

    int insertSelective(Admin record);

    Admin selectByPrimaryKey(Integer id);

    Admin login(Admin admin);
}