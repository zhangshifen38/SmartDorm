package com.app.dormsys.controller;

import com.app.dormsys.entities.Users;
import com.app.dormsys.mapper.MapperUsers;
import com.app.dormsys.tools.MD5;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin
@RestController
public class UserController {
    private final MapperUsers tm;
    @Autowired
    public UserController(MapperUsers tm) {
        this.tm = tm;
    }

    //处理用户登录的请求，返回值为bool类型
    @GetMapping("/login")
    public boolean doLogin(@RequestParam(value = "uno",defaultValue = "")String username,
                           @RequestParam(value = "upass",defaultValue = "")String password,
                           @RequestParam(value = "utype",defaultValue = "")String userclas)
    {
        if(username.equals(""))return false;
        Users ad=tm.selUser(username);
        if(ad==null) return false;
        String uno=ad.getUsername();
        if(uno==null)return false;
        String upa=ad.getPassword();
        String uty=ad.getUserclas();
        System.out.println("用户传进的参数："+username+" "+password+" "+userclas);
        System.out.println("数据库获取的参数："+uno+" "+upa+" "+uty);
        return uno.equals(username) && upa.equals(password)&&uty.equals(userclas);
    }

    @PostMapping("/updatePassword")
    public  boolean updatePassword(@RequestParam(value = "uno",defaultValue = "")String uno,
                                   @RequestParam(value = "oldpass",defaultValue = "")String oldpass,
                                   @RequestParam(value = "newpass",defaultValue = "")String newpass)
    {
        System.out.println("用户传进的参数："+uno+" "+oldpass+" "+newpass);
        if(uno.equals(""))
            return false;
        Users u=tm.selUser(uno);
        if(u==null){
            return false;
        }
        if(u.getUsername()==null||u.getUsername().equals(""))
            return false;
        if(MD5.MD5EncodeUtf8(oldpass).equals(u.getPassword())){
            tm.updatePass(uno,MD5.MD5EncodeUtf8(newpass));
            return true;
        }
        return false;
    }
}
