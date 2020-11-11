package com.moonstarmall.domain;

import java.util.List;

public class CartVO {
	
	private int		cart_cd;
	private int		pro_num;
	private String	user_id;
	private	int		buy_count;
	
	private List<CartVO> list;
	
	public int getCart_cd() {
		return cart_cd;
	}
	
	public void setCart_cd(int cart_cd) {
		this.cart_cd = cart_cd;
	}
	
	public int getPro_num() {
		return pro_num;
	}
	
	public void setPro_num(int pro_num) {
		this.pro_num = pro_num;
	}
	
	public String getUser_id() {
		return user_id;
	}
	
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	
	public int getBuy_count() {
		return buy_count;
	}
	
	public void setBuy_count(int buy_count) {
		this.buy_count = buy_count;
	}

	public List<CartVO> getList() {
		return list;
	}

	public void setList(List<CartVO> list) {
		this.list = list;
	}

	@Override
	public String toString() {
		return "CartVO [cart_cd=" + cart_cd + ", pro_num=" + pro_num + ", user_id=" + user_id + ", buy_count="
				+ buy_count + ", list=" + list + "]";
	}
}
