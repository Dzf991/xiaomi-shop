package com.xiaomi.controller;

import com.xiaomi.pojo.Admin;
import com.xiaomi.pojo.vo.CommonResult;
import com.xiaomi.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
public class AdminController {
    @Autowired
    private AdminService adminService;

    @PostMapping(value = "/admin/login")
    public String login(Model model, Admin admin, HttpServletRequest request) {
        CommonResult<Admin> admin1 = adminService.login(admin);
        if (admin1 != null && admin1.getCode() == 200){
            request.getSession().setAttribute("admin", admin1.getData());
            return "redirect:/admin/main.jsp";
        }else {
            model.addAttribute("errmsg","用户名或密码错误！请重新输入");
            return "/admin/login.jsp";
        }
    }
}
