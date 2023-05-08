package com.app.dormsys.entities;

import java.util.Date;

public class Repair {
    public String repairno; //表单号
    public String itemname; //报修物品
    public Date sdate; //报修表单提交的日期
    public Date edate; //报修表单被受理的日期
    public Date repairdate; //期望物品能够修复好的日期
    public String reason; //报修原因
    public String state; //表单被受理的状态：未处理、通过等
    public String dorms_dno;
    public String buildings_bno;
    public Repair(String repairno, String itemname, Date sdate, Date edate, Date repairdate,
                  String reason, String state, String dorms_dno, String buildings_bno)
    {
        this.buildings_bno=buildings_bno;
        this.dorms_dno=dorms_dno;
        this.edate=edate;
        this.reason=reason;
        this.repairdate=repairdate;
        this.repairno=repairno;
        this.sdate=sdate;
        this.state=state;
        this.itemname=itemname;
    }

    public Date getSdate() {
        return sdate;
    }

    public String getBuildings_bno() {
        return buildings_bno;
    }

    public void setBuildings_bno(String buildings_bno) {
        this.buildings_bno = buildings_bno;
    }

    public void setSdate(Date sdate) {
        this.sdate = sdate;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getDorms_dno() {
        return dorms_dno;
    }

    public void setDorms_dno(String dorms_dno) {
        this.dorms_dno = dorms_dno;
    }

    public void setEdate(Date edate) {
        this.edate = edate;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public Date getEdate() {
        return edate;
    }

    public Date getRepairdate() {
        return repairdate;
    }

    public String getItemname() {
        return itemname;
    }

    public String getRepairno() {
        return repairno;
    }

    public void setItemname(String itemname) {
        this.itemname = itemname;
    }

    public void setRepairdate(Date repairdate) {
        this.repairdate = repairdate;
    }

    public void setRepairno(String repairno) {
        this.repairno = repairno;
    }
}
