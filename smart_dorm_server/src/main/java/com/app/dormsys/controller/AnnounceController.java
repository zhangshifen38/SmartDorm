package com.app.dormsys.controller;

import com.app.dormsys.annotation.LocalLock;
import com.app.dormsys.entities.Announces;
import com.app.dormsys.mapper.MapperAnnounce;
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
public class AnnounceController {
    private final MapperAnnounce ma;
    @Autowired
    public AnnounceController(MapperAnnounce ma) {
        this.ma = ma;
    }

    @GetMapping("/getAnnouncestoStu")
    public List<Announces>  getAnnouncestoStu(@RequestParam(value = "sno",defaultValue = "")String sno)
    {
        return ma.selAnnouncestoStu(sno);
    }
    @GetMapping("/getAnnouncestoWno")
    public List<Announces>  getAnnouncestoWno(@RequestParam(value = "wno",defaultValue = "")String wno)
    {
        return ma.selAnnouncestoWno(wno);
    }

    private final Lock lock = new ReentrantLock();
    @Transactional
    @LocalLock(key="announce:arg[0],arg[1],arg[2],arg[3]")
    @PostMapping("/postAnnouncebyWno")
    public boolean postAnnouncebyWno(@RequestParam(value ="wno" ,defaultValue ="" )String wno,
                                     @RequestParam(value ="sdate" ,defaultValue ="" )String sdate,
                                     @RequestParam(value ="title" ,defaultValue ="" )String title,
                                     @RequestParam(value ="text" ,defaultValue ="" )String text) throws ParseException
    {
        lock.lock();
        try {
            String buildings_bno=ma.selAdminshasBuilding(wno);
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
            String s = "A" + sdate.substring(0, 4) + sdate.substring(5, 7) + sdate.substring(8, 10) + "%";

            String cnt=ma.selAnnounceCount(s);
            int i=0;
            if(cnt!=null)
                i=Integer.parseInt(cnt.substring(9,12));

            String ano=String.format("A%s%03d",sdate.substring(0,4)+sdate.substring(5,7)+sdate.substring(8,10),i+1);
            System.out.println(ano+" "+sdate+" "+title+" "+text+" "+buildings_bno+" "+wno);
//            try {
//                Thread.sleep(3000);
//            } catch (InterruptedException e) {
//                e.printStackTrace();
//            }
            Announces anc=new Announces(ano,sdf.parse(sdate),title,text,buildings_bno,wno);
            ma.insAnnouncebyWno(anc);
        } finally {
            lock.unlock();
        }
        return true;
    }

    @PostMapping("/updateAnnouncebyWno")
    public  boolean updateAnnouncebyWno(@RequestParam(value = "ano")String ano,
                                        @RequestParam(value = "title")String title,
                                        @RequestParam(value = "text")String text)
    {
        ma.updateAnnouncebyWno(ano,title,text);
        return true;
    }
    @PostMapping("/delAnnouncebyWno")
    public  boolean delAnnouncebyWno(@RequestParam(value = "ano")String ano)
    {
        ma.delAnnouncebyWno(ano);
        return true;
    }
}
