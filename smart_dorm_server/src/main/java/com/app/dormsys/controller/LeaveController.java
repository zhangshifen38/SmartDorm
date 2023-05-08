package com.app.dormsys.controller;

import com.app.dormsys.annotation.LocalLock;
import com.app.dormsys.entities.Leave;
import com.app.dormsys.entities.Student;
import com.app.dormsys.mapper.MapperLeave;
import com.app.dormsys.mapper.MapperStudents;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

@CrossOrigin
@RestController
public class LeaveController {
    private final MapperLeave ml;
    private final MapperStudents ss;
    @Autowired
    public LeaveController(MapperLeave ml,
                           MapperStudents ss)
    {
        this.ml = ml;
        this.ss = ss;
    }

    @GetMapping("/getStuLeave")
    public List<Leave> getStuLeave(@RequestParam(value = "sno",defaultValue = "")String sno)
    {
        System.out.println("debug le"+sno);
        return ml.selLeave(sno);
    }
    private final Lock lock = new ReentrantLock();
    @Transactional
    @LocalLock(key="leave:arg[0],arg[1],arg[2],arg[3],arg[4]")
    @PostMapping("/postStuLeave")
    public boolean postStuLeave(@RequestParam(value = "sno",defaultValue ="" )String sno,
                             @RequestParam(value = "leavedate",defaultValue ="")String leavedate,
                             @RequestParam(value = "backdate",defaultValue ="")String backdate,
                             @RequestParam(value = "reason",defaultValue ="")String reason,
                             @RequestParam(value = "sdate",defaultValue ="")String sdate) throws ParseException
    {
        lock.lock();
        try{
            System.out.println(sno+leavedate+backdate+reason+sdate);
            Student stutmp=ss.selStudentbySno(sno);
            String dorms_dno=stutmp.getDorms_dno();
            String buildings_bno=stutmp.getBuildings_bno();
            String state="未处理";
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
            String s = "L" + sdate.substring(0, 4) + sdate.substring(5, 7) + sdate.substring(8, 10) + "%";
            int i=ml.selLeaveCount(s);
            String leaveno=String.format("L%s%03d",sdate.substring(0,4)+sdate.substring(5,7)+sdate.substring(8,10),i+1);
            Leave l=new Leave(leaveno,sdf.parse(sdate), null,sdf.parse(leavedate),sdf.parse(backdate),state,reason,sno,dorms_dno,buildings_bno);
            ml.insLeave(l);
        }finally {
            lock.unlock();
        }
        return true;
    }

    @GetMapping("/getStuLeaveforWno")
    public List<Leave> getStuLeaveforWno(@RequestParam(value = "wno",defaultValue = "")String wno)
    {
        return ml.selLeaveforWno(wno);
    }

    @PostMapping("/updateStuLeavebyWno")
    public boolean updateStuLeavebyWno(@RequestParam(value = "leaveno",defaultValue = "")String lno,
                                       @RequestParam(value = "state")boolean state)
    {

        String state_str;
        SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date(System.currentTimeMillis());
        String edate=formatter.format(date);

        if(state)
            state_str="宿舍管理员批准";
        else
            state_str="宿舍管理员不批准";
        ml.updateLeavebyWno(lno,state_str,edate);
        return true;
    }
}
