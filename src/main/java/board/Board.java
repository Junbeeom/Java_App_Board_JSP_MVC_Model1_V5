package board;

public class Board {
    private int boardNo;
    private String title;
    private String content;
    private String name;
    private String createdTs;
    private String updatedTs;
    private String deletedTs;
    private String isDeleted;

    public Board() {
    }

    public Board(int boardNo, String title, String content, String name, String createdTs, String updatedTs, String deletedTs, String isDeleted) {
        this.boardNo = boardNo;
        this.title = title;
        this.content = content;
        this.name = name;
        this.createdTs = createdTs;
        this.updatedTs = updatedTs;
        this.deletedTs = deletedTs;
        this.isDeleted = isDeleted;
    }

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

    public String getIsDeleted() {
        return isDeleted;
    }

    public void setBoardNo(int boardNo) {
        this.boardNo = boardNo;
    }

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

    public void setIsDeleted(String isDeleted) {
        this.isDeleted = isDeleted;
    }
}

