package com.app.dormsys.mapper;

import com.app.dormsys.entities.Announces;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface MapperAnnounce {
    List<Announces> selAnnouncestoStu(String sno);
    List<Announces> selAnnouncestoWno(String wno);
    String selAdminshasBuilding(String wno);
    String selAnnounceCount(String ano);
    void insAnnouncebyWno(Announces anc);
    void delAnnouncebyWno(String ano);
    void updateAnnouncebyWno(String ano,String title,String text);
}
