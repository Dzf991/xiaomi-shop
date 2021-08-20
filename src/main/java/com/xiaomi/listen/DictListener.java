package com.xiaomi.listen;

import com.xiaomi.mapper.ProductMapper;
import com.xiaomi.pojo.ProductType;
import com.xiaomi.service.ProductService;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DictListener implements ServletContextListener {




    @Override
    public void contextInitialized(ServletContextEvent sce) {

        ServletContext servletContext = sce.getServletContext();

        WebApplicationContext webApplicationContext = WebApplicationContextUtils.getWebApplicationContext(sce.getServletContext());

        ProductService productService = (ProductService) webApplicationContext.getBean("productServiceImpl");

        List<ProductType> productTypeList = productService.getProductType();

        servletContext.setAttribute("productType",productTypeList);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

    }
}
