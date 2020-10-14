package com.moonstarmall.domain;

public class CategoryVO {
	
	private String	cat_code;
	private String	cat_prtcode;
	private String	cat_name;
	
	public String getCat_code() {
		return cat_code;
	}
	public void setCat_code(String cat_code) {
		this.cat_code = cat_code;
	}
	public String getCat_prtcode() {
		return cat_prtcode;
	}
	public void setCat_prtcode(String cat_prtcode) {
		this.cat_prtcode = cat_prtcode;
	}
	public String getCat_name() {
		return cat_name;
	}
	public void setCat_name(String cat_name) {
		this.cat_name = cat_name;
	}
	
	@Override
	public String toString() {
		return "CategoryVO [cat_code=" + cat_code + ", cat_prtcode=" + cat_prtcode + ", cat_name=" + cat_name + "]";
	}
}
