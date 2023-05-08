package com.app.dormsys.mapper;

import com.app.dormsys.entities.ChangeDorm;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface MapperChangeDorm {
    void insChangeDorm(ChangeDorm cd);
    List<ChangeDorm> selChangeDorm(String sno);
    Integer selChangeDormCount(String cdno);
}
