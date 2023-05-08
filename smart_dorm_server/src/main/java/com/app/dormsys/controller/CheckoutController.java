package com.app.dormsys.controller;

import com.app.dormsys.annotation.LocalLock;
import com.app.dormsys.entities.Checkout;
import com.app.dormsys.entities.Student;
import com.app.dormsys.mapper.MapperCheckout;
import com.app.dormsys.mapper.MapperStudents;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

@CrossOrigin
@RestController
public class CheckoutController {

    private final MapperCheckout ml;
    private final MapperStudents ss;
    @Autowired
    public CheckoutController(MapperCheckout ml,
                              MapperStudents ss )
    {
        this.ml = ml;
        this.ss=ss;
    }

    @GetMapping("/getStuCheckout")
    public List<Checkout> getStuCheckout(@RequestParam(value = "sno",defaultValue = "")String sno)
    {
        return ml.selCheckout(sno);
    }
    private final Lock lock = new ReentrantLock();
    @Transactional
    @LocalLock(key="checkout:arg[0],arg[1],arg[2],arg[3]")
    @PostMapping("/postStuCheckout")
    public boolean postStuCheckout(@RequestParam(value = "sno",defaultValue ="" )String sno,
                             @RequestParam(value = "checkoutdate",defaultValue ="")String checkoutdate,
                             @RequestParam(value = "reason",defaultValue ="")String reason,
                             @RequestParam(value = "sdate",defaultValue ="")String sdate) throws ParseException
    {
        lock.lock();
        try {
            Student stutmp=ss.selStudentbySno(sno);
            if(stutmp==null)
                return false;
            String dorms_dno=stutmp.getDorms_dno();
            String buildings_bno=stutmp.getBuildings_bno();
            String state="未处理";
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
            String s = "C" + sdate.substring(0, 4) + sdate.substring(5, 7) + sdate.substring(8, 10) + "%";
            int i=ml.selCheckoutCount(s);
            System.out.println("申请日期: "+sdate+" 退宿日期"+sdf.parse(checkoutdate));
            String checkoutno=String.format("C%s%03d",sdate.substring(0,4)+sdate.substring(5,7)+sdate.substring(8,10),i+1);
            Checkout c=new Checkout(checkoutno,sdf.parse(sdate), null,sdf.parse(checkoutdate),state,reason,sno,dorms_dno,buildings_bno);
            ml.insCheckout(c);
        }finally {
            lock.unlock();
        }
        return true;
    }
}
