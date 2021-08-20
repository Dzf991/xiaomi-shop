package com.xiaomi.service.impl;

import com.xiaomi.mapper.AdminMapper;
import com.xiaomi.pojo.Admin;
import com.xiaomi.pojo.vo.CommonResult;
import com.xiaomi.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;


    @Override
    public CommonResult<Admin> selectByPrimaryKey(Integer id) {
       Admin admin = adminMapper.selectByPrimaryKey(id);
        if (admin != null) {
           return new CommonResult<Admin>(200,admin);
        }else {
            return new CommonResult<Admin>(404,null);
        }
    }

    @Override
    public CommonResult<Admin> login(Admin admin) {
        Admin admin1 = adminMapper.login(admin);
        if (admin1 != null) {
            return new CommonResult<Admin>(200,admin1);
        }else {
            return new CommonResult<Admin>(404,null);
        }
    }
}
