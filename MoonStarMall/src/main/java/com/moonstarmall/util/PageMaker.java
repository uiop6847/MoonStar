package com.moonstarmall.util;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {

	private int totalCount;
	
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	
	// 페이지 번호의 개수:  1  2  3  4  5
	private int displayPageNum = 5;
	

	//  1  2  3  4  5 : 페이지번호에 링크기능을 적용시 사용할 파라미터 
	// this.page = 1; // 현재 페이지 번호. this.perPageNum = 10; // 페이지에 출력 게시물 개수
	private Criteria cri;


	public void setCri(Criteria cri) {
		this.cri = cri;
	}

	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		
		calcData();
	}

	private void calcData() {
		// 현재 페이지에서의 종료페이지
		endPage = (int) (Math.ceil(cri.getPage() / (double)displayPageNum) * displayPageNum);
		// 현재 페이지에서의 시작페이지
		startPage = (endPage - displayPageNum) + 1;
		
		// 전체 종료페이지
		int tempEndPage = (int)(Math.ceil(totalCount / (double)cri.getPerPageNum()));
		if(endPage > tempEndPage){
			endPage = tempEndPage;
		}
		
		// [이전]/[다음] 표시 유무 
		prev = startPage ==1 ? false : true;
		next = endPage * cri.getPerPageNum() >= totalCount ? false : true;
		
	}

	public int getTotalCount() {
		return totalCount;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public boolean isNext() {
		return next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public Criteria getCri() {
		return cri;
	}
	
	/*
	 * page와 perPageNum 을 이용한 쿼리스트링을 생성 후 반환
	 * 
	 * @return
	 * String : ex)?page=1&perPageNum=5
	 */
	public String makeQuery(int page){
		
		UriComponents uriComponents =
	            UriComponentsBuilder.newInstance()
	            .queryParam("page", page)
	            .queryParam("perPageNum", cri.getPerPageNum())
	            .build();	            
		
		return uriComponents.toUriString();
	}

	/*
	 * 페이지 정보와 검색조건을 이용한 쿼리스트링을 생성 후 반환
	 * 
	 * @return
	 * String : ex)?page=1&perPageNum=5&searchType=all&keyword=3
	 */
	public String makeSearch(int page){
		
		UriComponents uriComponents =
	            UriComponentsBuilder.newInstance()
	            .queryParam("page", page)
	            .queryParam("perPageNum", cri.getPerPageNum())
	            .queryParam("searchType", ((SearchCriteria)cri).getSearchType())
	            .queryParam("keyword", ((SearchCriteria)cri).getKeyword())
	            .build();	            
		
		return uriComponents.toUriString();
	}
	
	/*
	 * 페이지 정보와 검색조건을 이용한 쿼리스트링을 생성 후 반환
	 * 
	 * @return
	 * String : ex)?page=1&perPageNum=5&SortType=new
	 */
	public String makeSort(int page){
		
		UriComponents uriComponents =
	            UriComponentsBuilder.newInstance()
	            .queryParam("page", page)
	            .queryParam("perPageNum", cri.getPerPageNum())
	            .queryParam("sortType", ((SortCriteria)cri).getSort())
	            .build();	            
		
		return uriComponents.toUriString();
	}
	
	/*
	 * 페이지 정보와 검색조건을 이용한 쿼리스트링을 생성 후 반환
	 * 
	 * @return
	 * String : ex)?page=1&perPageNum=5&searchType=all&keyword=3
	 */
	public String makeDate(int page){
		
		UriComponents uriComponents =
	            UriComponentsBuilder.newInstance()
	            .queryParam("page", page)
	            .queryParam("perPageNum", cri.getPerPageNum())
	            .queryParam("searchType", ((DateCriteria)cri).getSearchType())
	            .queryParam("fromDate", ((DateCriteria)cri).getFromDate())
	            .queryParam("toDate", ((DateCriteria)cri).getToDate())
	            .build();	            
		
		return uriComponents.toUriString();
	}
	
	public String makeOrderSearch(int page){
		
		UriComponents uriComponents =
	            UriComponentsBuilder.newInstance()
	            .queryParam("page", page)
	            .queryParam("perPageNum", cri.getPerPageNum())
	            .queryParam("statusType", ((OrderSearchCriteria)cri).getStatusType())
	            .queryParam("fromDate", ((OrderSearchCriteria)cri).getFromDate())
	            .queryParam("toDate", ((OrderSearchCriteria)cri).getToDate())
	            .queryParam("searchType", ((OrderSearchCriteria)cri).getSearchType())
	            .queryParam("keyword", ((OrderSearchCriteria)cri).getKeyword())
	            .build();
		
		return uriComponents.toUriString();
	}
	
	@Override
	public String toString() {
		return "PageMaker [totalCount=" + totalCount + ", startPage="
				+ startPage + ", endPage=" + endPage + ", prev=" + prev
				+ ", next=" + next + ", displayPageNum=" + displayPageNum
				+ ", cri=" + cri + "]";
	}
	
	
}
