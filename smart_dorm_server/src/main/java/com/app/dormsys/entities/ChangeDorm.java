package com.app.dormsys.entities;

import java.util.Date;

public class ChangeDorm {
    private String changedormno;
    private Date sdate;
    private Date edate;
    private Date changedormdate;
    private String state;
    private String reason;
    private String students_sno;
    private String dorms_dno;
    private String buildings_bno;

    public ChangeDorm(String changedormno, Date sdate, Date edate,
                      Date changedormdate, String state, String reason,
                      String students_sno, String dorms_dno, String buildings_bno)
    {
        this.changedormno=changedormno;
        this.changedormdate=changedormdate;
        this.state=state;
        this.sdate=sdate;
        this.edate=edate;
        this.buildings_bno=buildings_bno;
        this.dorms_dno=dorms_dno;
        this.students_sno=students_sno;
        this.reason=reason;
    }

    public Date getChangedormdate() {
        return changedormdate;
    }

    public void setChangedormdate(Date changedormdate) {
        this.changedormdate = changedormdate;
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

    public String getChangedormno() {
        return changedormno;
    }

    public void setChangedormno(String changedormno) {
        this.changedormno = changedormno;
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
