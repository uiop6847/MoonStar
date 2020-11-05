package com.moonstarmall.domain;

import java.util.Date;

public class ReviewVO {
	
	private int		rew_num;
	private String	user_id;
	private int		pro_num;
	private String	rew_content;
	private int		rew_score;
	private Date	sta_date;
	
	private int		no; // jsp페이지에서 보여줄 후기번호
	
	public int getRew_num() {
		return rew_num;
	}
	
	public void setRew_num(int rew_num) {
		this.rew_num = rew_num;
	}
	
	public String getUser_id() {
		return user_id;
	}
	
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	
	public int getPro_num() {
		return pro_num;
	}
	
	public void setPro_num(int pro_num) {
		this.pro_num = pro_num;
	}
	
	public String getRew_content() {
		return rew_content;
	}
	
	public void setRew_content(String rew_content) {
		this.rew_content = rew_content;
	}
	
	public int getRew_score() {
		return rew_score;
	}
	
	public void setRew_score(int rew_score) {
		this.rew_score = rew_score;
	}
	
	public Date getSta_date() {
		return sta_date;
	}
	
	public void setSta_date(Date sta_date) {
		this.sta_date = sta_date;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	@Override
	public String toString() {
		return "ReviewVO [rew_num=" + rew_num + ", user_id=" + user_id + ", pro_num=" + pro_num + ", rew_content="
				+ rew_content + ", rew_score=" + rew_score + ", sta_date=" + sta_date + ", no=" + no + "]";
	}
}
