package com.moonstarmall.util;

public class SortCriteria extends Criteria{

	private String sort;
	
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	@Override
	public String toString() {
		return super.toString() + " SortCriteria [sort=" + sort + "]";
	}
}


