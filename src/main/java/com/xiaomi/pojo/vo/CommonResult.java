package com.xiaomi.pojo.vo;

/**
 * @author feng
 *
 * 存放业务方法执行结果
 */
public class CommonResult<T> {

    private Integer code;
    private T data;

    public CommonResult() {
    }

    public CommonResult(Integer code, T data) {
        this.code = code;
        this.data = data;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
