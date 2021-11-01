package com.bjpowernode.crm.settings.controller;

import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.utils.FileUploadUtil;
import com.bjpowernode.crm.base.utils.MD5Util;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * @author Dxt
 * @date 2021/7/3 - 14:46
 */
@Controller
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * 登录
     * @return  结果集
     */
    @ResponseBody
    @RequestMapping("/settings/user/login")
    public ResultVo getUsers(User user, HttpServletRequest request, HttpSession session) {
        ResultVo resultVo = new ResultVo();
        try {
            //获取登录ip
            String userIp = request.getRemoteAddr();
            user.setAllowIps(userIp);
            user = userService.login(user);
            //将账户信息存入session中
            session.setAttribute("user", user);
            resultVo.setOk(true);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    /**
     * 登出
     * @param session 会话对象
     * @return 重定向到 登录页
     */
    @RequestMapping("/loginOut")
    public String loginOut(HttpSession session){
        session.removeAttribute("user");
        return "redirect: /crm/login.jsp";
    }

    //验证老密码
    @ResponseBody
    @RequestMapping("/settings/user/oldPwd")
    public ResultVo oldPwd(User user,HttpSession session) {
        ResultVo resultVo = new ResultVo();
        //获取session域中user的密码
        User sessionUser = (User) session.getAttribute("user");
        if(!sessionUser.getLoginPwd().equals(MD5Util.getMD5(user.getLoginPwd()))){
            resultVo.setMessage("密码不正确");
            return resultVo;
        }else {
            resultVo.setOk(true);
            return resultVo;
        }
    }

    //文件上传/settings/user/fileUpload
    @ResponseBody
    @RequestMapping("/settings/user/fileUpload")
    public ResultVo fileUpload(MultipartFile img, HttpServletRequest request) {
        ResultVo resultVo = FileUploadUtil.fileUpload(img, request);
        return resultVo;
    }

    /**
     * 更新密码与图片
     * @param user 密码与图片
     * @return resultVo
     */
    @ResponseBody
    @RequestMapping("/settings/user/updatePwdAndImg")
    public ResultVo updatePwdAndImg(User user) {
        ResultVo resultVo = new ResultVo();
        try {
            userService.updatePwdAndImg(user);
            resultVo.setOk(true);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

}
