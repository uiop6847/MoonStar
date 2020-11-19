package com.moonstarmall.util;

public class OrderSearchCriteria extends Criteria{

	private String statusType;
	private String fromDate;
	private String toDate;
	private String searchType;
	private String keyword;
	
	public String getStatusType() {
		return statusType;
	}
	public void setStatusType(String statusType) {
		this.statusType = statusType;
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
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	@Override
	public String toString() {
		return super.toString() + "OrderSearchCriteria [statusType=" + statusType 
				+ ", fromDate=" + fromDate + ", toDate=" + toDate 
				+ ", searchType=" + searchType + ", keyword=" + keyword + "]";
	}
	
	
}


