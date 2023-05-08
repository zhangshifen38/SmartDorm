package com.app.dormsys.mapper;

import com.app.dormsys.entities.Dorm;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface MapperDorm {
    Dorm selDormbyDno(String dno,String wno);
    List<Dorm> selDormsbyWno(String wno);
    Dorm selDormbySno(String sno);
}
