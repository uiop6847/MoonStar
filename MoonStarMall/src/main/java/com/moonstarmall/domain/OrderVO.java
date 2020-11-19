package com.moonstarmall.domain;

import java.util.Date;
import java.util.List;

public class OrderVO {
	
	private int		ord_cd;
	private String	user_id;
	private String	ord_nm;
	private String	zip_num;
	private String	addr;
	private String	addr_dtl;
	private String	tel_phone;
	private String	cell_phone;
	private int		pay_amount;
	private String	payment;
	private String	pay_nm;
	private String	ord_status;
	private int		re_point;
	private Date	ord_date;
	
	private List<OrderVO> list;

	public int getOrd_cd() {
		return ord_cd;
	}

	public void setOrd_cd(int ord_cd) {
		this.ord_cd = ord_cd;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getOrd_nm() {
		return ord_nm;
	}

	public void setOrd_nm(String ord_nm) {
		this.ord_nm = ord_nm;
	}

	public String getZip_num() {
		return zip_num;
	}

	public void setZip_num(String zip_num) {
		this.zip_num = zip_num;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getAddr_dtl() {
		return addr_dtl;
	}

	public void setAddr_dtl(String addr_dtl) {
		this.addr_dtl = addr_dtl;
	}

	public String getTel_phone() {
		return tel_phone;
	}

	public void setTel_phone(String tel_phone) {
		this.tel_phone = tel_phone;
	}

	public String getCell_phone() {
		return cell_phone;
	}

	public void setCell_phone(String cell_phone) {
		this.cell_phone = cell_phone;
	}

	public int getPay_amount() {
		return pay_amount;
	}

	public void setPay_amount(int pay_amount) {
		this.pay_amount = pay_amount;
	}

	public String getPayment() {
		return payment;
	}

	public void setPayment(String payment) {
		this.payment = payment;
	}

	public String getPay_nm() {
		return pay_nm;
	}

	public void setPay_nm(String pay_nm) {
		this.pay_nm = pay_nm;
	}

	public String getOrd_status() {
		return ord_status;
	}

	public void setOrd_status(String ord_status) {
		this.ord_status = ord_status;
	}
	
	public int getRe_point() {
		return re_point;
	}

	public void setRe_point(int re_point) {
		this.re_point = re_point;
	}

	public Date getOrd_date() {
		return ord_date;
	}

	public void setOrd_date(Date ord_date) {
		this.ord_date = ord_date;
	}

	public List<OrderVO> getList() {
		return list;
	}

	public void setList(List<OrderVO> list) {
		this.list = list;
	}

	@Override
	public String toString() {
		return "OrderVO [ord_cd=" + ord_cd + ", user_id=" + user_id + ", ord_nm=" + ord_nm + ", zip_num=" + zip_num
				+ ", addr=" + addr + ", addr_dtl=" + addr_dtl + ", tel_phone=" + tel_phone + ", cell_phone="
				+ cell_phone + ", pay_amount=" + pay_amount + ", payment=" + payment + ", pay_nm=" + pay_nm
				+ ", ord_status=" + ord_status + ", re_point=" + re_point + ", ord_date=" + ord_date + ", list=" + list
				+ "]";
	}
}
