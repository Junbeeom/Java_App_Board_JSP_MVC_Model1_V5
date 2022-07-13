package board;

public class Board {
    private int boardNo;
    private String title;
    private String content;
    private String name;
    private String createdTs; //ts
    private String updatedTs; //ts
    private String deletedTs; //ts
    private int isDeleted; //boolean

    public int getBoardNo() {
        return boardNo;
    }

    public String getTitle() {
        return title;
    }

    public String getContent() {
        return content;
    }

    public String getName() {
        return name;
    }

    public String getCreatedTs() {
        return createdTs;
    }

    public String getUpdatedTs() {
        return updatedTs;
    }

    public String getDeletedTs() {
        return deletedTs;
    }

    public int getIsDeleted() {
        return isDeleted;
    }



    public String getUserNo() {
        return userNo;
    }

    private String userNo;
    public void setTitle(String title) {
        this.title = title;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setCreatedTs(String createdTs) {
        this.createdTs = createdTs;
    }

    public void setUpdatedTs(String updatedTs) {
        this.updatedTs = updatedTs;
    }

    public void setDeletedTs(String deletedTs) {
        this.deletedTs = deletedTs;
    }

    public void setIsDeleted(int isDeleted) {
        this.isDeleted = isDeleted;
    }

    public void setUserNo(String userNo) {
        this.userNo = userNo;
    }

    public void setBoardNo(int boardNo) {
        this.boardNo = boardNo;
    }

}
