package com.bjpowernode.crm.base.bean;

public class ResultVo<T> {

    private boolean isOk;//用户操作是否成功
    private String message;//给客户端返回的消息
    private T t;//返回给客户端数据

    public ResultVo() {
    }

    public ResultVo(boolean isOk, String message, T t) {
        this.isOk = isOk;
        this.message = message;
        this.t = t;
    }

    public boolean isOk() {
        return isOk;
    }

    public void setOk(boolean ok) {
        isOk = ok;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public T getT() {
        return t;
    }

    public void setT(T t) {
        this.t = t;
    }
}
