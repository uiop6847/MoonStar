package com.moonstarmall.domain;

public class DeliveryVO {
	private String	de_num;
	private String	user_id;
	private String	de_nm;
	private String	de_recent_nm;
	private String	de_zip_num;
	private String	de_addr;
	private String	de_addr_dtl;
	private String	de_tel_phone;
	private String	de_cell_phone;
	private String	de_default_yn;

	public String getDe_num() {
		return de_num;
	}

	public void setDe_num(String de_num) {
		this.de_num = de_num;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getDe_nm() {
		return de_nm;
	}

	public void setDe_nm(String de_nm) {
		this.de_nm = de_nm;
	}

	public String getDe_recent_nm() {
		return de_recent_nm;
	}

	public void setDe_recent_nm(String de_recent_nm) {
		this.de_recent_nm = de_recent_nm;
	}

	public String getDe_zip_num() {
		return de_zip_num;
	}

	public void setDe_zip_num(String de_zip_num) {
		this.de_zip_num = de_zip_num;
	}

	public String getDe_addr() {
		return de_addr;
	}

	public void setDe_addr(String de_addr) {
		this.de_addr = de_addr;
	}

	public String getDe_addr_dtl() {
		return de_addr_dtl;
	}

	public void setDe_addr_dtl(String de_addr_dtl) {
		this.de_addr_dtl = de_addr_dtl;
	}

	public String getDe_tel_phone() {
		return de_tel_phone;
	}

	public void setDe_tel_phone(String de_tel_phone) {
		this.de_tel_phone = de_tel_phone;
	}

	public String getDe_cell_phone() {
		return de_cell_phone;
	}

	public void setDe_cell_phone(String de_cell_phone) {
		this.de_cell_phone = de_cell_phone;
	}

	public String getDe_default_yn() {
		return de_default_yn;
	}

	public void setDe_default_yn(String de_default_yn) {
		this.de_default_yn = de_default_yn;
	}

	@Override
	public String toString() {
		return "DeliveryVO [de_num=" + de_num + ", user_id=" + user_id + ", de_nm=" + de_nm + ", de_recent_nm="
				+ de_recent_nm + ", de_zip_num=" + de_zip_num + ", de_addr=" + de_addr + ", de_addr_dtl=" + de_addr_dtl
				+ ", de_tel_phone=" + de_tel_phone + ", de_cell_phone=" + de_cell_phone + ", de_default_yn="
				+ de_default_yn + "]";
	}
}
