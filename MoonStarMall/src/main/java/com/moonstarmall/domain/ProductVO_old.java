package com.moonstarmall.domain;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ProductVO_old {
	
	private int		pro_num;
	private String	cat_code;
	private String 	cat_prtcode;
	private	String	pro_nm;
	private	int		pro_price;
	private int		pro_discount;
	private String	pro_publisher;
	private String	pro_dtl_info;
	private String	pro_main_img;
	private	int		pro_count;
	private	String	pro_buy_yn;
	private Date	sta_date;
	private Date	udt_date;
	
	// 업로드 파일
	private MultipartFile file1;
	
	private List<ProductVO_old> list;
	
	public int getPro_num() {
		return pro_num;
	}

	public void setPro_num(int pro_num) {
		this.pro_num = pro_num;
	}

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

	public String getPro_nm() {
		return pro_nm;
	}

	public void setPro_nm(String pro_nm) {
		this.pro_nm = pro_nm;
	}

	public int getPro_price() {
		return pro_price;
	}

	public void setPro_price(int pro_price) {
		this.pro_price = pro_price;
	}

	public int getPro_discount() {
		return pro_discount;
	}

	public void setPro_discount(int pro_discount) {
		this.pro_discount = pro_discount;
	}

	public String getPro_publisher() {
		return pro_publisher;
	}

	public void setPro_publisher(String pro_publisher) {
		this.pro_publisher = pro_publisher;
	}

	public String getPro_dtl_info() {
		return pro_dtl_info;
	}

	public void setPro_dtl_info(String pro_dtl_info) {
		this.pro_dtl_info = pro_dtl_info;
	}

	public String getPro_main_img() {
		return pro_main_img;
	}

	public void setPro_main_img(String pro_main_img) {
		this.pro_main_img = pro_main_img;
	}

	public int getPro_count() {
		return pro_count;
	}

	public void setPro_count(int pro_count) {
		this.pro_count = pro_count;
	}

	public String getPro_buy_yn() {
		return pro_buy_yn;
	}

	public void setPro_buy_yn(String pro_buy_yn) {
		this.pro_buy_yn = pro_buy_yn;
	}

	public Date getSta_date() {
		return sta_date;
	}

	public void setSta_date(Date sta_date) {
		this.sta_date = sta_date;
	}

	public Date getUdt_date() {
		return udt_date;
	}

	public void setUdt_date(Date udt_date) {
		this.udt_date = udt_date;
	}

	public MultipartFile getFile1() {
		return file1;
	}

	public void setFile1(MultipartFile file1) {
		this.file1 = file1;
	}

	public List<ProductVO_old> getList() {
		return list;
	}

	public void setList(List<ProductVO_old> list) {
		this.list = list;
	}

	@Override
	public String toString() {
		return "ProductVO [pro_num=" + pro_num + ", cat_code=" + cat_code + ", cat_prtcode=" + cat_prtcode + ", pro_nm="
				+ pro_nm + ", pro_price=" + pro_price + ", pro_discount=" + pro_discount + ", pro_publisher="
				+ pro_publisher + ", pro_dtl_info=" + pro_dtl_info + ", pro_main_img=" + pro_main_img + ", pro_count="
				+ pro_count + ", pro_buy_yn=" + pro_buy_yn + ", sta_date=" + sta_date + ", udt_date=" + udt_date
				+ ", file1=" + file1 + ", list=" + list + "]";
	}
}
