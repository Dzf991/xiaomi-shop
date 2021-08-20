package com.xiaomi.pojo.vo;

import java.util.List;

public class Page<T> {

    private Integer pageNo;
    private Integer pageSize = 5;
    private Integer pageCount;
    private Integer total;
    private List<T> pageList;

    public Page() {

    }

    public Page(Integer pageNo, Integer pageSize, Integer pageCount, List<T> pageList, Integer total) {
        this.pageNo = pageNo;
        this.pageSize = pageSize;
        this.pageCount = pageCount;
        this.pageList = pageList;
        this.total = total;
    }

    public Integer getPageNo() {
        return pageNo;
    }

    public void setPageNo(Integer pageNo) {
        this.pageNo = pageNo;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getPageCount() {
        return pageCount;
    }

    public void setPageCount(Integer pageCount) {
        this.pageCount = pageCount;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public List<T> getPageList() {
        return pageList;
    }

    public void setPageList(List<T> pageList) {
        this.pageList = pageList;
    }
}
