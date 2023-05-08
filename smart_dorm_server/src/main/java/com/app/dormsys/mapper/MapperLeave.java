package com.app.dormsys.mapper;

import com.app.dormsys.entities.Leave;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface MapperLeave {
    void insLeave(Leave lv);
    List<Leave> selLeave(String sno);

    List<Leave> selLeaveforWno(String wno);

    void updateLeavebyWno(String lno,String state,String edate);
    Integer selLeaveCount(String lno);
}
