package com.app.dormsys.entities;

import java.util.Date;

public class Announces {
    public String announceno;
    public Date sdate;
    public String title;
    public String text;
    public String buildings_bno;
    public String admins_wno;
    public Announces(String announceno, Date sdate, String title, String text, String buildings_bno, String admins_wno){
        this.admins_wno=admins_wno;
        this.announceno=announceno;
        this.sdate=sdate;
        this.text=text;
        this.title=title;
        this.buildings_bno=buildings_bno;
    }

    public void setSdate(Date sdate) {
        this.sdate = sdate;
    }

    public void setBuildings_bno(String buildings_bno) {
        this.buildings_bno = buildings_bno;
    }

    public String getBuildings_bno() {
        return buildings_bno;
    }

    public Date getSdate() {
        return sdate;
    }

    public String getAdmins_wno() {
        return admins_wno;
    }

    public String getAnnounceno() {
        return announceno;
    }

    public String getText() {
        return text;
    }

    public String getTitle() {
        return title;
    }

    public void setAdmins_wno(String admins_wno) {
        this.admins_wno = admins_wno;
    }

    public void setAnnounceno(String announceno) {
        this.announceno = announceno;
    }

    public void setText(String text) {
        this.text = text;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
