package com.app.dormsys.controller;

import com.app.dormsys.entities.Student;
import com.app.dormsys.mapper.MapperStudents;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
public class StudentsController {
    private final MapperStudents ss;

    @Autowired
    public StudentsController(MapperStudents ss){
        this.ss=ss;
    }

    @GetMapping("/StudentUserInfo")
    public Student getStudent(@RequestParam(value = "sno",defaultValue = "")String sno)
    {
        return ss.selStudentbySno(sno);
    }
    @GetMapping("/StudentInfotoWno")
    public Student getStudentoWno(@RequestParam(value = "sno",defaultValue = "")String sno,
                                  @RequestParam(value = "wno",defaultValue = "")String wno)
    {
        return ss.selStudentbyWno(wno,sno);
    }
    @GetMapping("/StudentsUserInfo")
    public List<Student> getStudentstoWno(@RequestParam(value = "wno",defaultValue = "")String wno)
    {
        return ss.selStudentsbyWno(wno);
    }
    @PostMapping("/StudentUpdateInfo")
    public  boolean updateStudentInfo(@RequestParam(value = "sno",defaultValue = "")String sno,
                                   @RequestParam(value = "stel",defaultValue = "")String stel,
                                   @RequestParam(value = "sclass",defaultValue = "")String sclass)
    {
        Student stu=ss.selStudentbySno(sno);
        System.out.println("修改后的学生信息: "+sno+" "+stel+" "+sclass);
        stu.setStel(stel);
        stu.setSclass(sclass);
        ss.update(stu);
        return true;
    }
}
