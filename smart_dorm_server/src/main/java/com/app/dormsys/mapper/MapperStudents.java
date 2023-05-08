package com.app.dormsys.mapper;

import com.app.dormsys.entities.Student;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface MapperStudents {
    Student selStudentbySno(String sno);
    void update(Student stu);
    Student selStudentbyWno(String wno,String sno);
    List<Student> selStudentsbyWno(String wno);
}
