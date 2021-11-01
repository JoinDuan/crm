package com.bjpowernode.crm.base.exception;

/**
 * @author Dxt
 * @date 2021/7/5 - 14:26
 */
public class CrmException extends RuntimeException{

    private CrmEnum crmEnum;

    public CrmException(CrmEnum crmEnum) {
        super(crmEnum.getMessage());
        this.crmEnum = crmEnum;
    }
}
