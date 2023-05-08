package com.app.dormsys.entities;

public class Users {

        private final String uno;

        private String upass;

        private final String utype;

        public Users(String username, String password, String userclas){
            this.upass=password;
            this.utype=userclas;
            this.uno=username;
        }

        public String getUsername(){
            return this.uno;
        }
        public String getUserclas(){
            return this.utype;
        }
        public String getPassword(){
            return this.upass;
        }

        public void setUpass() {
            this.upass = "123456";
        }

    @Override
        public String toString(){
            return "Admin{" +
                    "uno: "+'\"'+this.uno +'\"'+
                    ",upass: "+'\"'+this.upass+'\"'+
                    ",utype: "+'\"'+this.utype+'\"'+
                    "}";
        }
}
