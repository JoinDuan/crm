package com.bjpowernode.crm.base.exception;

/**
 * @author Dxt
 * @date 2021/7/5 - 14:26
 */
public enum CrmEnum {

    USER_LOGIN_ACCOUNT("001-001","用户名或密码错误"),
    USER_LOGIN_EXPIRE("001-002","账号失效，请联系管理员"),
    USER_LOGIN_LOCKED("001-003","账号已被锁定，请联系管理员"),
    USER_LOGIN_ALLOWIP("001-004","不允许登录的ip，请联系管理员"),
    USER_UPLOAD_MAXSIZE("001-005","上传文件不能超过2M"),
    USER_UPLOAD_SUFFIX("001-006","只能上传png,jpg,bmp,gif图片"),
    USER_UPLOAD_UPDATEPWD("001-007","更新用户信息失败"),
    ACTIVITY_ADD("002-001","新增市场活动失败"),
    ACTIVITY_EDIT("002-001","修改市场活动失败"),
    ACTIVITY_DEL("002-003","删除市场活动失败"),
    ACTIVITY_REMARK_ADD("003-001","市场活动备注添加失败"),
    ACTIVITY_REMARK_EDIT("003-002","市场活动备注修改失败"),
    ACTIVITY_REMARK_DEL("003-003","市场活动备注删除失败"),
    CUSTOMER_ADD("004-001","客户添加失败"),
    CUSTOMER_EDIT("004-002","客户修改失败"),
    CUSTOMER_DEL("004-003","客户删除失败"),
    CUSTOMER_REMARK_EDIT("005-001","客户备注修改失败"),
    CUSTOMER_REMARK_ADD("005-002","客户备注添加失败"),
    CUSTOMER_REMARK_DEL("005-003","客户备注删除失败"),
    CONTACTS_DEL("006-001","联系人删除失败"),
    CLUE_ADD("007-001","线索添加失败"),
    CLUE_EDIT("007-002","线索修改失败"),
    CLUE_DEL("007-003","线索删除失败"),
    CLUE_ACTIVITY_ADD("008-001","线索与市场活动关联失败"),
    CLUE_ACTIVITY_DEL("008-002","线索与市场活动解除关联失败"),
    DICTYPE_ADD("009-001","保存字典类型失败"),
    DICTYPE_DEL("009-002","删除字典类型失败"),
    DICTYPE_EDIT("009-003","修改字典类型失败"),
    DICVALUE_ADD("010-001","新增字典值失败"),
    DICVALUE_DEL("010-002","删除字典值失败"),
    DICVALUE_EDIT("010-003","修改字典值失败"),
    CLUE_REMARK_ADD("011-001","添加线索备注失败"),
    CLUE_REMARK_DEL("011-002","删除线索备注失败"),
    CLUE_REMARK_EDIT("011-003","修改线索备注失败"),
    CLUE_TRANSFORM("012-001","线索转换失败"),
    TRAN_ADD("013-001","交易添加失败"),
    TRAN_DEL("013-002","交易删除失败"),
    TRAN_EDIT("013-002","交易修改失败"),
    CONTACTS_EDIT("014-001","联系人修改失败"),
    CONTACTS_ADD("014-002","联系添加失败"),
    CONTACTS_ACTIVITY_DEL("015-001","联系人与市场活动解除关联失败"),
    CONTACTS_ACTIVITY_ADD("015-002","联系人与市场活动关联失败"),
    CONTACTS_REMARK_ADD("015-003","联系人备注添加失败"),
    CONTACTS_REMARK_DEL("015-004","联系人备注删除失败");


    private String type;
    private String message;

    CrmEnum() {
    }

    CrmEnum(String type, String message) {
        this.type = type;
        this.message = message;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
