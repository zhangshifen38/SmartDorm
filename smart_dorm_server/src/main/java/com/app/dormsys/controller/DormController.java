package com.app.dormsys.controller;

import com.app.dormsys.entities.Dorm;
import com.app.dormsys.mapper.MapperDorm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@CrossOrigin
@RestController
public class DormController {
    private final MapperDorm md;
    @Autowired
    public DormController(MapperDorm md) {
        this.md = md;
    }

    @GetMapping("/getDormbyDno")
    public Dorm getDormbyDno(@RequestParam(value = "dno")String dno,
                             @RequestParam(value = "wno")String wno)
    {
        return md.selDormbyDno(dno,wno);
    }
    @GetMapping("/getDormsbyWno")
    public List<Dorm> getDormsbyWno(@RequestParam(value = "wno")String wno){
        return md.selDormsbyWno(wno);
    }
    @GetMapping("/getDormbySno")
    public Dorm getDormbySno(@RequestParam(value = "sno")String sno)
    {
        return md.selDormbySno(sno);
    }
}
