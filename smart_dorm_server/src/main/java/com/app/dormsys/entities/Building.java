package com.app.dormsys.entities;

public class Building {
    public String bno;
    public String bname;
    public String baddr;
    public String poweroff;

    public Building(String bno, String bname, String baddr, String poweroff)
    {
        this.bname=bname;
        this.bno=bno;
        this.baddr=baddr;
        this.poweroff=poweroff;
    }

    public String getBaddr() {
        return baddr;
    }

    public String getBname() {
        return bname;
    }

    public String getBno() {
        return bno;
    }

    public String getPoweroff() {
        return poweroff;
    }

    public void setBaddr(String baddr) {
        this.baddr = baddr;
    }

    public void setBname(String bname) {
        this.bname = bname;
    }

    public void setBno(String bno) {
        this.bno = bno;
    }

    public void setPoweroff(String poweroff) {
        this.poweroff = poweroff;
    }

}
