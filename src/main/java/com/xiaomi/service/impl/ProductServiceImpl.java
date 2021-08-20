package com.xiaomi.service.impl;

import com.xiaomi.mapper.ProductMapper;
import com.xiaomi.pojo.Product;
import com.xiaomi.pojo.ProductType;
import com.xiaomi.pojo.vo.CommonResult;
import com.xiaomi.pojo.vo.Page;
import com.xiaomi.service.ProductService;
import com.xiaomi.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductMapper productMapper;

    @Override
    public List<Product> selectAll() {

        List<Product> productList = productMapper.selectAll();
        return productList;
    }

    @Override
    public Page<Product> pageList(Page<Product> page,Product product) {

            if (product == null){
                product = new Product();
            }

            int productCount = productMapper.selectCount(product);
            int pageNo = page.getPageNo();
            int beginNo = (page.getPageNo() - 1) * page.getPageSize();

            page.setTotal(productCount);


            page.setPageCount(productCount % page.getPageSize() != 0 ? (productCount / page.getPageSize()) + 1 : productCount / page.getPageSize());
            page.setPageNo(beginNo);

            List<Product> productList = productMapper.pageList(page, product);

            return new Page<>(pageNo, page.getPageSize(), page.getPageCount(), productList, productCount);


    }

    @Override
    public List<ProductType> getProductType() {
        return productMapper.getProductType();
    }

    @Override
    public CommonResult insertProduct(Product product) {
        product.setpDate(DateUtil.getDate());
        int result = productMapper.insert(product);
        if (result == 1){
            return new CommonResult(200,null);
        }else{
            return new CommonResult(404,null);
        }
    }

    @Override
    public Product getProductById(Integer pId) {
        Product product = productMapper.selectByPrimaryKey(pId);

        return product;
    }

    @Override
    public CommonResult updateProductById(Product product) {
        product.setpDate(DateUtil.getDate());
        int result = productMapper.updateByPrimaryKey(product);
        if (result == 1){
            return new CommonResult(200,null);
        }else{
            return new CommonResult(404,null);
        }
    }

    @Override
    public CommonResult delProductById(Integer pId) {

        int result = productMapper.deleteByPrimaryKey(pId);

        if (result == 1){
            return new CommonResult(200,null);
        }else{
            return new CommonResult(404,null);
        }
    }
}
