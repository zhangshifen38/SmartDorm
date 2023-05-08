package com.app.dormsys.entities;

import java.util.Date;

public class Checkout {
    private String checkoutno;
    private Date sdate;
    private Date edate;
    private Date checkoutdate;
    private String state;
    private String reason;
    private String students_sno;
    private String dorms_dno;
    private String buildings_bno;

    public Checkout(String checkoutno, Date sdate, Date edate,
                    Date checkoutdate, String state, String reason,
                      String students_sno, String dorms_dno, String buildings_bno)
    {
        this.checkoutno=checkoutno;
        this.checkoutdate=checkoutdate;
        this.state=state;
        this.sdate=sdate;
        this.edate=edate;
        this.buildings_bno=buildings_bno;
        this.dorms_dno=dorms_dno;
        this.students_sno=students_sno;
        this.reason=reason;
    }

    public Date getCheckoutdate() {
        return checkoutdate;
    }

    public String getCheckoutno() {
        return checkoutno;
    }

    public void setCheckoutdate(Date checkoutdate) {
        this.checkoutdate = checkoutdate;
    }

    public void setCheckoutno(String checkoutno) {
        this.checkoutno = checkoutno;
    }

    public String getStudents_sno() {
        return students_sno;
    }

    public void setStudents_sno(String students_sno) {
        this.students_sno = students_sno;
    }

    public Date getSdate() {
        return sdate;
    }

    public void setSdate(Date sdate) {
        this.sdate = sdate;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getReason() {
        return reason;
    }

    public Date getEdate() {
        return edate;
    }

    public void setEdate(Date edate) {
        this.edate = edate;
    }

    public String getBuildings_bno() {
        return buildings_bno;
    }

    public void setBuildings_bno(String buildings_bno) {
        this.buildings_bno = buildings_bno;
    }

    public void setDorms_dno(String dorms_dno) {
        this.dorms_dno = dorms_dno;
    }

    public String getDorms_dno() {
        return dorms_dno;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getState() {
        return state;
    }
}
