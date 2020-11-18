package com.moonstarmall.domain;

public class StatusVO {
/*
    STATUS_NUM       NUMBER          PRIMARY KEY,
    DIV_NM           VARCHAR2(50)    NOT NULL,
    STATUS_CD        VARCHAR2(50)    NOT NULL,
    STATUS_NM        VARCHAR2(50)    NOT NULL,
    STATUS_COMMENT   VARCHAR2(1000)
*/

	private int		status_num;
	private String	div_nm;
	private String	status_cd;
	private String	status_nm;
	private String	status_comment;

	public int getStatus_num() {
		return status_num;
	}

	public void setStatus_num(int status_num) {
		this.status_num = status_num;
	}

	public String getDiv_nm() {
		return div_nm;
	}

	public void setDiv_nm(String div_nm) {
		this.div_nm = div_nm;
	}

	public String getStatus_cd() {
		return status_cd;
	}

	public void setStatus_cd(String status_cd) {
		this.status_cd = status_cd;
	}

	public String getStatus_nm() {
		return status_nm;
	}

	public void setStatus_nm(String status_nm) {
		this.status_nm = status_nm;
	}

	public String getStatus_comment() {
		return status_comment;
	}

	public void setStatus_comment(String status_comment) {
		this.status_comment = status_comment;
	}

	@Override
	public String toString() {
		return "StatusVO [status_num=" + status_num + ", div_nm=" + div_nm + ", status_cd=" + status_cd + ", status_nm="
				+ status_nm + ", status_comment=" + status_comment + "]";
	}
}
