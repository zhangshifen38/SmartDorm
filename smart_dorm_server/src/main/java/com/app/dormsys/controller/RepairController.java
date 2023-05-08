package com.app.dormsys.controller;

import com.app.dormsys.annotation.LocalLock;
import com.app.dormsys.entities.Repair;
import com.app.dormsys.entities.Student;
import com.app.dormsys.mapper.MapperRepair;
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
public class RepairController {
    private final MapperRepair mr;
    private final MapperStudents ss;
    @Autowired
    public RepairController(MapperRepair mr, MapperStudents ss) {
        this.mr = mr;
        this.ss = ss;
    }

    @GetMapping("/getRepairstoStu")
    public List<Repair> getRepairstoStu(@RequestParam(value = "sno",defaultValue = "")String sno)
    {
        return mr.selRepairstoStu(sno);
    }
    @GetMapping("/getRepairstoWno")
    public List<Repair>  getRepairstoWno(@RequestParam(value = "sno",defaultValue = "")String wno)
    {
        return mr.selRepairtoWno(wno);
    }
    private final Lock lock = new ReentrantLock();
    @Transactional
    @LocalLock(key="repair:arg[0],arg[1],arg[2],arg[3],arg[4]")
    @PostMapping("/postRepairbySno")
    public boolean postRepairbySno(@RequestParam(value ="sno" ,defaultValue ="" )String sno,
                                   @RequestParam(value ="sdate" ,defaultValue ="" )String sdate,
                                     @RequestParam(value = "itemname",defaultValue = "")String itemname,
                                     @RequestParam(value = "repairdate",defaultValue = "")String repairdate,
                                     @RequestParam(value ="reason" ,defaultValue ="" )String reason) throws ParseException
    {
        lock.lock();
        try{
            Student stutmp=ss.selStudentbySno(sno);
            String dorms_dno=stutmp.getDorms_dno();
            String buildings_bno=stutmp.getBuildings_bno();
            String state="未处理";
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
            String s = "R" + sdate.substring(0, 4) + sdate.substring(5, 7) + sdate.substring(8, 10) + "%";
            int i=mr.selRepairCount(s);
            String repairno=String.format("R%s%03d",sdate.substring(0,4)+sdate.substring(5,7)+sdate.substring(8,10),i+1);
            System.out.println(repairno+" "+itemname+" "+sdf.parse(sdate)+" "+sdf.parse(repairdate)+" "+reason+" "+state+" "+dorms_dno+" "+buildings_bno);
            Repair c=new Repair(repairno,itemname,sdf.parse(sdate),null,sdf.parse(repairdate),reason,state, dorms_dno,buildings_bno);
            mr.insRepairbySno(c);
        }finally {
            lock.unlock();
        }
        return true;
    }

    @PostMapping("/updateRepairbyWno")
    public  boolean updateRepairbyWno(@RequestParam(value = "rno")String rno,
                                        @RequestParam(value = "state")String state)
    {
        mr.updateRepairbyWno(rno,state);
        return true;
    }
}
