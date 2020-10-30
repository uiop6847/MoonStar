package com.moonstarmall.util;

public class Criteria {
	// 페이징 기능에서 페이지 번호 출력을 위한 부분
	private int page;			// 현재 페이지 (클릭한 페이지)
	private int perPageNum;		// 페이지 당 글의 게시물 개수
  	
	// mapper 페이징 sql문에서 사용됨.
	private int rowStart;		// 행 시작
	private int rowEnd;			// 행 끝

//	private String cat_id;	// 카테고리 코드
	
	public Criteria() 	// 기본 설정
	{
		this.page = 1; // 현재 페이지 번호.
		this.perPageNum = 20; // 페이지에 출력 게시물 개수
	}

	public void setPage(int page) 
	{
		if (page <= 0) 
	    {
	      this.page = 1;
	      return;
	    }
	
	    this.page = page;
	}
	
	public void setPerPageNum(int perPageNum) 
	{
	    if (perPageNum <= 0 || perPageNum > 100) 
	    {
	      this.perPageNum = 20;
	      return;
	    }
	
	    this.perPageNum = perPageNum;
	}
	
	public int getPage() 
	{
	    return page;
	}
	
	public int getPageStart() 
	{
	    return (this.page - 1) * perPageNum;
	}
	
	public int getPerPageNum() 
	{
	    return this.perPageNum;
	}
	  
	// mapper파일에서 페이징기능쿼리에서 호출됨.
	public int getRowStart() 
	{
		return ((page - 1) * perPageNum) + 1;
	}
	// mapper파일에서 페이징기능쿼리에서 호출됨.
	public int getRowEnd() 
	{
		return getRowStart() + perPageNum - 1;
	}
	
	
	@Override
	public String toString() 
	{
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + ", "
				+ "getRowStart()=" + getRowStart() + ", getRowEnd()=" + getRowEnd() + "]";
	}
}