package com.moonstarmall.util;

public class DateCriteria extends Criteria{

	private String searchType;
	private String fromDate;
	private String toDate;
	
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getFromDate() {
		return fromDate;
	}
	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}
	public String getToDate() {
		return toDate;
	}
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}

	@Override
	public String toString() {
		return super.toString() + "DateCriteria [searchType=" + searchType + ", fromDate=" + fromDate + ", toDate=" + toDate + "]";
	}
	
	
}


