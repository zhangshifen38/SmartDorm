package com.app.dormsys.mapper;

import com.app.dormsys.entities.Checkout;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface MapperCheckout {
    void insCheckout(Checkout co);
    List<Checkout> selCheckout(String sno);

    Integer selCheckoutCount(String cno);
}
