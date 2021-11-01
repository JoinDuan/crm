package com.bjpowernode.crm.base.utils;

import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

public class FileUploadUtil {

    public static ResultVo fileUpload(MultipartFile img, HttpServletRequest request){
        ResultVo resultVo = new ResultVo();
        try {
            String realPath = request.getSession().getServletContext().getRealPath("/upload");
            //file:文件 文件夹:能够存放其它文件的文件
            File file = new File(realPath);
            if(!file.exists()){
                file.mkdirs();
            }
            //上传文件名
            String fileName = img.getOriginalFilename();
            //防止文件重名 ../upload/121348921038210938美女.jpg
            fileName = System.currentTimeMillis() + fileName;

            //上传文件大小<=2M
            veiryfyMaxSize(img.getSize());

            //文件的后缀名是否符合要求
            verifySuffix(img.getOriginalFilename());
            img.transferTo(new File(realPath + File.separator +fileName));
            resultVo.setOk(true);
            resultVo.setMessage("上传头像成功");
            //获取项目根路径 /crm /crm/upload/1625534907489美女.jpg
            String path = request.getContextPath() + File.separator + "upload" + File.separator + fileName;
            resultVo.setT(path);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        } catch (IOException e) {
            resultVo.setMessage("未知异常");
        }
        return resultVo;
    }


    //判断文件后缀名
    private static void verifySuffix(String originalFilename) {
        String suffix = originalFilename.substring(originalFilename.lastIndexOf(".")+1);
        String suffixs = "png,jpg,bmp,gif";
        if(!suffixs.contains(suffix)){
            throw new CrmException(CrmEnum.USER_UPLOAD_SUFFIX);
        }
    }

    //校验文件大小 <=2M
    private static void veiryfyMaxSize(long size) {
        long maxSize = 2 * 1024 * 1024;
        if(size > maxSize){
            throw new CrmException(CrmEnum.USER_UPLOAD_MAXSIZE);
        }
    }


}
