package com.xiaomi.mapper;

import com.xiaomi.pojo.Product;
import com.xiaomi.pojo.ProductType;
import com.xiaomi.pojo.vo.Page;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductMapper {
    int deleteByPrimaryKey(Integer pId);

    int insert(Product record);

    int insertSelective(Product record);

    Product selectByPrimaryKey(Integer pId);

    int updateByPrimaryKeySelective(Product record);

    int updateByPrimaryKey(Product record);

    List<Product> selectAll();

    int selectCount(Product product);

    List<Product> pageList(@Param(value = "page") Page<Product> page,
                           @Param(value = "product") Product product);

    List<ProductType> getProductType();
}