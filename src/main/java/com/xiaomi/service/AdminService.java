package com.xiaomi.service;

import com.xiaomi.pojo.Admin;
import com.xiaomi.pojo.vo.CommonResult;



public interface AdminService {
    CommonResult<Admin> selectByPrimaryKey(Integer Id);

    CommonResult<Admin> login(Admin admin);
}
