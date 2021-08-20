package com.xiaomi.controller;

import com.alibaba.druid.support.json.JSONUtils;
import com.xiaomi.pojo.Product;
import com.xiaomi.pojo.vo.CommonResult;
import com.xiaomi.pojo.vo.Page;
import com.xiaomi.service.ProductService;
import com.xiaomi.util.FileNameUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ProductController {

    @Autowired
    private ProductService productService;



    @GetMapping(value = "/admin/product/list")
    @ResponseBody
    public CommonResult<List<Product>> getProInfo(){
       List<Product> productList = productService.selectAll();
       return new CommonResult<>(200,productList);
    }

    @GetMapping(value = "/admin/product/pageList")
    @ResponseBody
    public Page<Product> pageList(Page<Product> page,Product product,HttpServletRequest request){
        Page<Product> pageList = productService.pageList(page,product);

        request.getSession().setAttribute("page",pageList);

        return pageList;
    }
    @ResponseBody
    @PostMapping(value = "/admin/product/choiceImg")
    public String choiceImg(MultipartFile pimage, HttpServletRequest request){
        String imgName = null;
        String path = request.getServletContext().getRealPath("/image_big");
        String originalFilename = pimage.getOriginalFilename();
        if (originalFilename != null) {
            imgName = FileNameUtil.getUUId() +"."+FileNameUtil.getImgType(originalFilename);
        }
        try {
            pimage.transferTo(new File(path + "/" + imgName));
        } catch (IOException e) {
            e.printStackTrace();
        }

        Map<String,Object> map = new HashMap<>();
        map.put("imgName",imgName);
        String jsonString = JSONUtils.toJSONString(map);
        return jsonString;
    }

    @ResponseBody
    @PostMapping(value = "/admin/product/addProduct")
    public CommonResult addProduct(Product product){

        return productService.insertProduct(product);

    }
    @GetMapping(value = "/admin/product/goUpdate")
    public String getProductById(Integer pId,Integer pageNo,HttpServletRequest request){

       Product product = productService.getProductById(pId);

       request.setAttribute("product",product);
       request.setAttribute("pageNo",pageNo);
       return "/admin/update.jsp";

    }
    @ResponseBody
    @PostMapping(value = "/admin/product/updateProduct")
    public CommonResult updateProductById(Product product){

        return productService.updateProductById(product);

    }
    @ResponseBody
    @PostMapping(value = "/admin/product/delProduct")
    public CommonResult delProductById(Integer pId){

        return productService.delProductById(pId);

    }
}
