package com.app.dormsys.entities;

public class Admin {
    public String wno;
    public String wname;
    public String wsex;
    public String wtel;
    public  Admin(String wno, String wname, String wsex, String wtel){
        this.wname=wname;
        this.wno=wno;
        this.wsex=wsex;
        this.wtel=wtel;
    }

    public String getWname() {
        return wname;
    }

    public void setWname(String wname) {
        this.wname = wname;
    }

    public String getWno() {
        return wno;
    }

    public void setWno(String wno) {
        this.wno = wno;
    }

    public String getWsex() {
        return wsex;
    }

    public void setWsex(String wsex) {
        this.wsex = wsex;
    }

    public String getWtel() {
        return wtel;
    }

    public void setWtel(String wtel) {
        this.wtel = wtel;
    }
}
