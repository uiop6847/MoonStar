package com.moonstarmall.domain;

import java.util.List;

public class ProductWapper {
	
	List<ProductVO> product;

	public List<ProductVO> getProduct() {
		return product;
	}

	public void setProduct(List<ProductVO> product) {
		this.product = product;
	}

	@Override
	public String toString() {
		return "ProductWapper [product=" + product + "]";
	}
	
}
