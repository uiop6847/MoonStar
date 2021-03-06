package com.moonstarmall.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.moonstarmall.domain.CategoryVO;
import com.moonstarmall.domain.ProductVO;
import com.moonstarmall.service.ProductService;
import com.moonstarmall.service.ReviewService;
import com.moonstarmall.util.FileUtils;
import com.moonstarmall.util.PageMaker;
import com.moonstarmall.util.SortCriteria;

@Controller
@RequestMapping("/product/*")
public class PoductController {

	@Autowired
	ProductService service;
	@Autowired
	ReviewService reviewServie;
	
	// 웹 프로젝트 영역 외부에 파일을 저장할 때 사용할 경로
	@Resource(name="uploadPath")
	private String uploadPath; // servlet-context.xml에 설정
	
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(PoductController.class);
	
	/* 1차 카테고리에 따른 2차 카테고리 출력*/
	@ResponseBody
	@RequestMapping(value = "subCategoryList/{cat_code}", method = RequestMethod.GET)
	public ResponseEntity<List<CategoryVO>> subCategoryList(@PathVariable("cat_code") String cat_code, Model model) {
		logger.info("subCategoryList() called");
		
		ResponseEntity<List<CategoryVO>> entity = null;
		
		try {
			List<CategoryVO> list = service.subCategoryList(cat_code);
			//logger.info("=====list : " + list);
			entity = new ResponseEntity<List<CategoryVO>>(list, HttpStatus.OK); 
			
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<CategoryVO>>(HttpStatus.BAD_REQUEST);
		}
	
		return entity;
	}

	/* 카테고리별 상품 리스트(상품정렬 포함) */
	@RequestMapping(value = "category", method = RequestMethod.GET)
	public void categoryProductList(@ModelAttribute("cri") SortCriteria cri, 
									@ModelAttribute("cat_code") String cat_code,
									Model model) throws Exception {
		logger.info("categoryProductList() called");
		logger.info("=====cri : " + cri.toString());
		
		List<Map<String, Object>> list = service.categoryProductList(cat_code, cri);

		for(int i=0; i<list.size(); i++) {
			
			Map<String, Object> vo = new HashMap<String, Object>();	
			
			// map key를 소문자로 변경
			for(String key : list.get(i).keySet()) {
				vo.put(key.toLowerCase(), list.get(i).get(key));
			}
			// 변경된 map을 다시 list에 세팅
			list.set(i, vo);
		}
		model.addAttribute("categoryProductList", list);
		
		// 클릭한 카테고리의 1차,2차 카테고리 조회
		model.addAttribute("categoryList", service.categoryList(cat_code.substring(0, 1)));
		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(service.categoryProductCount(cat_code, cri));
		logger.info("=====pm : " + pm);
		model.addAttribute("pm", pm);
	}
	
	/* 파일 출력 */
	@RequestMapping(value = "displayFile", method = RequestMethod.GET)
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		return FileUtils.getFile(uploadPath, fileName);
	}
	
	/* 상품 상세정보 조회 */
	@RequestMapping(value = "detail", method = RequestMethod.GET)
	public void productDetail(@ModelAttribute("cri") SortCriteria cri,
							  @ModelAttribute("pro_num") int pro_num, Model model) throws Exception {
		logger.info("productDetail() called");
		logger.info("cri : " + cri);
		
		ProductVO vo = service.productDetail(pro_num);
		logger.info("=====productDetail: " + vo);
		
		model.addAttribute("vo", vo);
		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		
		model.addAttribute("pm", pm);
		model.addAttribute("totalReview", reviewServie.reviewCount(pro_num));
	}
	
	
}
