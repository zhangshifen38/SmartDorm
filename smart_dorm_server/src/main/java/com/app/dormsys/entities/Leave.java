package com.app.dormsys.entities;

import java.util.Date;

public class Leave {
    private String leaveno;
    private Date sdate;
    private Date edate;
    private Date leavedate;
    private Date backdate;
    private String state;
    private String reason;
    private String students_sno;
    private String dorms_dno;
    private String buildings_bno;

    public Leave(String leaveno, Date sdate, Date edate, Date leavedate,
                 Date backdate, String state, String reason,
                 String students_sno, String dorms_dno, String buildings_bno)
    {
        this.leaveno=leaveno;
        this.leavedate=leavedate;
        this.state=state;
        this.sdate=sdate;
        this.edate=edate;
        this.backdate=backdate;
        this.buildings_bno=buildings_bno;
        this.dorms_dno=dorms_dno;
        this.students_sno=students_sno;
        this.reason=reason;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getLeaveno() {
        return leaveno;
    }

    public void setLeaveno(String leaveno) {
        this.leaveno = leaveno;
    }

    public String getDorms_dno() {
        return dorms_dno;
    }

    public void setDorms_dno(String dorms_dno) {
        this.dorms_dno = dorms_dno;
    }

    public String getBuildings_bno() {
        return buildings_bno;
    }

    public void setBuildings_bno(String buildings_bno) {
        this.buildings_bno = buildings_bno;
    }

    public Date getBackdate() {
        return backdate;
    }

    public void setBackdate(Date backdate) {
        this.backdate = backdate;
    }

    public Date getEdate() {
        return edate;
    }

    public void setEdate(Date edate) {
        this.edate = edate;
    }

    public Date getLeavedate() {
        return leavedate;
    }

    public void setLeavedate(Date leavedate) {
        this.leavedate = leavedate;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public Date getSdate() {
        return sdate;
    }

    public void setSdate(Date sdate) {
        this.sdate = sdate;
    }

    public String getStudents_sno() {
        return students_sno;
    }

    public void setStudents_sno(String students_sno) {
        this.students_sno = students_sno;
    }
}
