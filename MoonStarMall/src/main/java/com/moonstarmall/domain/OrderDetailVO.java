package com.moonstarmall.domain;

public class OrderDetailVO {
/*
ORD_CD      NUMBER      NOT NULL REFERENCES ORDER_INFO(ORD_CD),
PRO_NUM     NUMBER      NOT NULL REFERENCES PRODUCT_TBL(PRO_NUM),
BUY_CNT     NUMBER      NOT NULL,
BUY_PRICE   NUMBER      NOT NULL,  -- 역정규화
*/
	
	private int	ord_cd;
	private int	pro_num;
	private int	buy_cnt;
	private int buy_price;
	
	public int getOrd_cd() {
		return ord_cd;
	}
	
	public void setOrd_cd(int ord_cd) {
		this.ord_cd = ord_cd;
	}
	
	public int getPro_num() {
		return pro_num;
	}
	
	public void setPro_num(int pro_num) {
		this.pro_num = pro_num;
	}
	
	public int getBuy_cnt() {
		return buy_cnt;
	}
	
	public void setBuy_cnt(int buy_cnt) {
		this.buy_cnt = buy_cnt;
	}
	
	public int getBuy_price() {
		return buy_price;
	}
	
	public void setBuy_price(int buy_price) {
		this.buy_price = buy_price;
	}

	@Override
	public String toString() {
		return "OrderDetailVO [ord_cd=" + ord_cd + ", pro_num=" + pro_num + ", buy_cnt=" + buy_cnt + ", buy_price="
				+ buy_price + "]";
	}
}
