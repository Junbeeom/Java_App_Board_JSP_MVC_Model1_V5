package user;

import java.sql.Timestamp;

public class User {
    private int user_no;
    private String id;
    private String pw;
    private String name;
    private String birthdate;
    private String sex;
    private String phone;
    private Timestamp createdTs;
    private Timestamp updatedTs;
    private Timestamp deleted_ts;
    private String isDeleted;

    public int getUser_no() {
        return user_no;
    }

    public String getId() {
        return id;
    }

    public String getPw() {
        return pw;
    }

    public String getName() {
        return name;
    }

    public String getBirthdate() {
        return birthdate;
    }

    public String getSex() {
        return sex;
    }

    public String getPhone() {
        return phone;
    }

    public Timestamp getCreatedTs() {
        return createdTs;
    }

    public Timestamp getUpdatedTs() {
        return updatedTs;
    }

    public Timestamp getDeleted_ts() {
        return deleted_ts;
    }

    public String getIsDeleted() {
        return isDeleted;
    }

    public void setUser_no(int user_no) {
        this.user_no = user_no;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setPw(String pw) {
        this.pw = pw;
    }

    public void  setName(String name) {
        this.name = name;
    }

    public void setBirthdate(String birthdate) {
        this.birthdate = birthdate;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setCreatedTs(Timestamp createdTs) {
        this.createdTs = createdTs;
    }

    public void setUpdatedTs(Timestamp updatedTs) {
        this.updatedTs = updatedTs;
    }

    public void setDeleted_ts(Timestamp deleted_ts) {
        this.deleted_ts = deleted_ts;
    }

    public void setIsDeleted(String isDeleted) {
        this.isDeleted = isDeleted;
    }
}
