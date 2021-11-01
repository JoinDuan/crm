package com.bjpowernode.crm.base.utils;

/**
 * @author Dxt
 * @date 2021/6/30 - 16:34
 * 线程睡眠工具类
 */
public class SleepUtils {
    public static void sleep(int second){
        try {
            Thread.sleep(1000*second);
        } catch (InterruptedException _ignored) {
            Thread.currentThread().interrupt();
        }
    }
}
