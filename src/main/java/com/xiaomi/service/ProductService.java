package com.xiaomi.service;

import com.xiaomi.pojo.Product;
import com.xiaomi.pojo.ProductType;
import com.xiaomi.pojo.vo.CommonResult;
import com.xiaomi.pojo.vo.Page;

import java.util.List;

public interface ProductService {
    List<Product> selectAll();

    Page<Product> pageList(Page<Product> page,Product product);

    List<ProductType> getProductType();

    CommonResult insertProduct(Product product);

    Product getProductById(Integer pId);

    CommonResult updateProductById(Product product);

    CommonResult delProductById(Integer pId);

    CommonResult delProductByIds(Integer[] id);
}
