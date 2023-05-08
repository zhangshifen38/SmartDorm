package com.app.dormsys.entities;

public class Dorm {
    public String dno;
    public String dsize;
    public String dcharge;
    public String buildings_bno;

    public Dorm(String dno, String dsize, String dcharge, String buildings_bno){
        this.dno=dno;
        this.dsize=dsize;
        this.dcharge=dcharge;
        this.buildings_bno=buildings_bno;
    }

    public String getBuildings_bno() {
        return buildings_bno;
    }

    public String getDcharge() {
        return dcharge;
    }

    public String getDno() {
        return dno;
    }

    public String getDsize() {
        return dsize;
    }

    public void setBuildings_bno(String buildings_bno) {
        this.buildings_bno = buildings_bno;
    }

    public void setDcharge(String dcharge) {
        this.dcharge = dcharge;
    }

    public void setDno(String dno) {
        this.dno = dno;
    }

    public void setDsize(String dsize) {
        this.dsize = dsize;
    }
}
