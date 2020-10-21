package com.moonstarmall.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.plaf.multi.MultiFileChooserUI;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.moonstarmall.domain.CategoryVO;
import com.moonstarmall.domain.ProductVO;
import com.moonstarmall.service.AdProductService;
import com.moonstarmall.util.FileUtils;
import com.moonstarmall.util.PageMaker;
import com.moonstarmall.util.SearchCriteria;

@Controller
@RequestMapping("/admin/product/*")
public class AdProductController {
	
	@Autowired
	private AdProductService service;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	private static final Logger logger = LoggerFactory.getLogger(AdProductController.class);
	
	/* 상품 등록 이동 */
	@RequestMapping(value="insert", method = RequestMethod.GET)
	public void productInsert(Model model) throws Exception {
		logger.info("productInsert() called");
		
		// 1차카테고리 전송
		model.addAttribute("mainCategory", service.mainCategory());
	}
	
	/* 2차카테고리 조회 */
	@ResponseBody
	@RequestMapping(value="subCategoryList/{cat_code}", method = RequestMethod.GET)
	public ResponseEntity<List<CategoryVO>> subCategoryList(@PathVariable("cat_code") String cat_code) {
		logger.info("subCategoryList() called");
		
		ResponseEntity<List<CategoryVO>> entity = null;
		
		try {
			entity = new ResponseEntity<List<CategoryVO>>(service.subCategory(cat_code), HttpStatus.OK);

		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<List<CategoryVO>>(HttpStatus.BAD_REQUEST);		
		}
		
		return entity;
	}
	
	/* 상품 등록
	@RequestMapping(value="insertOK", method=RequestMethod.POST)
	public String productInsertOK(ProductVO vo, RedirectAttributes rttr) throws Exception {
		logger.info("productInsertOK() called");
		logger.info("=====ProductVO: " + vo.toString());
		
		vo.setPro_main_img(FileUtils.uploadFile(uploadPath, vo.getFile1().getOriginalFilename(), vo.getFile1().getBytes()));
		
		service.productInsertOK(vo);
		rttr.addFlashAttribute("msg", "INSERT_SUCCESS");
		
		return "redirect:/admin/product/list";
	} */
	
	/* 상품 등록 */
	@RequestMapping(value="insertOK", method=RequestMethod.POST)
	public ResponseEntity<String> productInsertOK(@RequestBody List<ProductVO> product) throws Exception {
		logger.info("productInsertOK() called");
		logger.info("=====list: " + product.toString());
		
		ResponseEntity<String> entity = null;
		ProductVO vo = null;
		
		logger.info("=====list.size(): " + product.size());
		try {
			for(int i=0; i<product.size(); i++) {
				vo = product.get(i);
				logger.info("=====ProductVO: " + vo.toString());
				
				logger.info("=====getFile(): " + vo.getFile1());
				
				vo.setPro_main_img(FileUtils.uploadFile(uploadPath, vo.getFile1().getOriginalFilename(), vo.getFile1().getBytes()));
				
				//service.productInsertOK(vo);
			}
			
			entity = new ResponseEntity<String>(HttpStatus.OK);
			
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	/* 상품상세내용(ckEditor) 파일업로드 */
	@RequestMapping(value = "imgUpload", method = RequestMethod.POST)
	public void imgUpload(HttpServletRequest request, HttpServletResponse response, MultipartFile upload) {
		logger.info("imgUpload() called");
		
		OutputStream out = null;
		PrintWriter printWriter = null;
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		try {
			// 전송할 파일의 정보
			String fileName = upload.getOriginalFilename();
			byte[] bytes = upload.getBytes();
			
			// 폴더경로 설정
			String uploadPath = request.getSession().getServletContext().getRealPath("/");
			uploadPath = uploadPath + "resources\\upload\\" + fileName;
			
			logger.info("=====uploadPath: " + uploadPath);
			
			out = new FileOutputStream(new File(uploadPath));
			out.write(bytes);
			
			printWriter = response.getWriter();
			String fileUrl = "/upload/" + fileName;
			
			printWriter.println("{\"filename\":\"" + fileName + "\", \"uploaded\":1,\"url\":\"" + fileUrl + "\"}");
			printWriter.flush();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(out != null) {
				try { out.close(); } catch(Exception e) { e.printStackTrace(); }
			}
			
			if(printWriter != null) {
				try { printWriter.close(); } catch(Exception e) {e.printStackTrace();}
			}
		}
	}
	
	/* 파일 출력 */
	@RequestMapping(value = "displayFile", method = RequestMethod.GET)
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		return FileUtils.getFile(uploadPath, fileName);
	}
	
	/* 상품 리스트 */
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public void productList(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		logger.info("productList() called");
		logger.info("=====cri : " + cri);
		
		model.addAttribute("productList", service.productList(cri));
		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		
		int count = service.productSearchCount(cri);
		pm.setTotalCount(count);
		
		logger.info("=====PageMaker: " + pm.toString());
		
		model.addAttribute("pm", pm);
	}
	
	/* 상품 상세정보 */
	@RequestMapping(value = "read", method = RequestMethod.GET)
	public void productRead(@ModelAttribute("cri") SearchCriteria cri,
							@RequestParam("pro_num") int pro_num, Model model) throws Exception {
		logger.info("productRead() called");
		
		ProductVO vo = service.readProduct(pro_num);
		logger.info("=====readProduct: " + vo);
		
		// 썸네일 파일 이름 수정
		vo.setPro_main_img(vo.getPro_main_img().substring(vo.getPro_main_img().lastIndexOf("_") + 1));
		logger.info("=====change readProduct: " + vo);
		
		model.addAttribute("vo", vo);
		
		// 상품 목록으로 돌아가기 위한 목적
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		
		model.addAttribute("pm", pm);
		
	}
	

}
