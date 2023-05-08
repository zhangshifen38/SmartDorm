package com.app.dormsys.controller;

import com.app.dormsys.annotation.LocalLock;
import com.app.dormsys.entities.ChangeDorm;
import com.app.dormsys.entities.Student;
import com.app.dormsys.mapper.MapperChangeDorm;
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
public class ChangeDormController {
    private final MapperStudents ss;
    private final MapperChangeDorm ml;
    @Autowired
    public ChangeDormController(MapperChangeDorm ml,
                                MapperStudents ss)
    {
        this.ml = ml;
        this.ss=ss;
    }

    @GetMapping("/getStuChangeDorm")
    public List<ChangeDorm> getStuChangeDorm(@RequestParam(value = "sno",defaultValue = "")String sno)
    {
        return ml.selChangeDorm(sno);
    }

    private final Lock lock = new ReentrantLock();
    @Transactional
    @LocalLock(key="changeDorm:arg[0],arg[1],arg[2],arg[3]")
    @PostMapping("/postStuChangeDorm")
    public boolean postStuChangeDorm(@RequestParam(value = "sno",defaultValue ="" )String sno,
                             @RequestParam(value = "changedormdate",defaultValue ="")String changedormdate,
                             @RequestParam(value = "reason",defaultValue ="")String reason,
                             @RequestParam(value = "sdate",defaultValue ="")String sdate) throws ParseException
    {
        lock.lock();
        try {
            Student stutmp = ss.selStudentbySno(sno);
            String dorms_dno = stutmp.getDorms_dno();
            String buildings_bno = stutmp.getBuildings_bno();
            String state = "未处理";
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            String s = "D" + sdate.substring(0, 4) + sdate.substring(5, 7) + sdate.substring(8, 10) + "%";
            int i = ml.selChangeDormCount(s);
            System.out.println("申请日期: " + sdate + " 换宿舍日期: " + changedormdate);
            String changedormno = String.format("D%s%03d", sdate.substring(0, 4) + sdate.substring(5, 7) + sdate.substring(8, 10), i + 1);
            ChangeDorm d = new ChangeDorm(changedormno, sdf.parse(sdate), null, sdf.parse(changedormdate), state, reason, sno, dorms_dno, buildings_bno);
            ml.insChangeDorm(d);
        }finally {
            lock.unlock();
        }
        return true;
    }
}
