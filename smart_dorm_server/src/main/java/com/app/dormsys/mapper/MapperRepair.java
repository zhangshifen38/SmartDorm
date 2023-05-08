package com.app.dormsys.mapper;

import com.app.dormsys.entities.Repair;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface MapperRepair {
    List<Repair> selRepairstoStu(String sno);
    List<Repair> selRepairtoWno(String wno);
    void insRepairbySno(Repair rp);
    //boolean delAnnoucebySno(String ano);
    void updateRepairbyWno(String rno, String state);

    Integer selRepairCount(String rno);
}
