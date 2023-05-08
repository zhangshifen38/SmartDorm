package com.app.dormsys.entities;

public class Student {
    private String sno;
    private String sname;
    private String stel;
    private String sdept;
    private String scol;
    private String sclass;
    private String ssex;
    private String state;
    private String access;
    private String dorms_dno;
    private String buildings_bno;

    public Student(String sno, String sname, String stel, String sdept,
                   String scol, String sclass, String ssex, String state,
                   String access, String dorms_dno, String buildings_bno)
    {
        this.sno=sno;
        this.sname=sname;
        this.stel=stel;
        this.sdept=sdept;
        this.scol=scol;
        this.sclass=sclass;
        this.ssex=ssex;
        this.state=state;
        this.access=access;
        this.dorms_dno=dorms_dno;
        this.buildings_bno=buildings_bno;
    }

    public String getSno(){
        return this.sno;
    }

    public void setSno(String sno) {
        this.sno = sno;
    }

    public String getSdept() {
        return sdept;
    }

    public void setSdept(String sdept) {
        this.sdept = sdept;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }

    public String getSclass() {
        return sclass;
    }

    public void setSclass(String sclass) {
        this.sclass = sclass;
    }

    public String getAccess() {
        return access;
    }

    public void setAccess(String access) {
        this.access = access;
    }
    public String getBuildings_bno() {
        return buildings_bno;
    }

    public void setBuildings_bno(String buildings_bno) {
        this.buildings_bno = buildings_bno;
    }

    public String getDorms_dno() {
        return dorms_dno;
    }

    public void setDorms_dno(String dorms_dno) {
        this.dorms_dno = dorms_dno;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getScol() {
        return scol;
    }

    public void setScol(String scol) {
        this.scol = scol;
    }

    public String getSsex() {
        return ssex;
    }

    public void setSsex(String ssex) {
        this.ssex = ssex;
    }

    public String getStel() {
        return stel;
    }

    public void setStel(String stel) {
        this.stel = stel;
    }
}
