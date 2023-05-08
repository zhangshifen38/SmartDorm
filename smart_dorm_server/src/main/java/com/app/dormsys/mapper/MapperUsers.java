package com.app.dormsys.mapper;

import com.app.dormsys.entities.Users;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface MapperUsers {
    Users selUser(String uno);
    void updatePass(String uno,String newpassword);
}
