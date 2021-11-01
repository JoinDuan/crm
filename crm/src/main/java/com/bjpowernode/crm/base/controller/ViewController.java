package com.bjpowernode.crm.base.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Enumeration;

/**
 * @author Dxt
 * @date 2021/7/5 - 15:00
 */
@Controller
public class ViewController {

    @RequestMapping({"/toView/{firstView}/{secondView}", "/toView/{firstView}/{secondView}/{thirdView}",
            "/toView/{firstView}/{secondView}/{thirdView}/{fourView}"})
    public String toView(@PathVariable(value = "firstView", required = false) String firstView,
                         @PathVariable(value = "secondView", required = false) String secondView,
                         @PathVariable(value = "thirdView", required = false) String thirdView,
                         @PathVariable(value = "fourView", required = false) String fourView,
                         HttpServletRequest request) {

        Enumeration<String> parameterNames = request.getParameterNames();
        while (parameterNames.hasMoreElements()) {
            String name = parameterNames.nextElement();
            String value = request.getParameter(name);
            request.setAttribute(name, value);
        }

        if (thirdView == null) {
            //2级目录
            return firstView + File.separator + secondView;

        }
        if (fourView == null) {
            //3级目录
            return firstView + File.separator + secondView + File.separator + thirdView;
        }
       //四级目录
        return firstView + File.separator + secondView + File.separator + thirdView+File.separator+fourView;
    }

}

