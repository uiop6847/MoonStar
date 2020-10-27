package com.moonstarmall.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	
	/* 상품 등록 */
	@RequestMapping(value="insertOK", method=RequestMethod.POST)
	public String productInsertOK(ProductVO list, RedirectAttributes rttr) throws Exception {
		logger.info("productInsertOK() called");
		logger.info("=====list: " + list.toString());
		
		for(ProductVO vo : list.getList()) {
			logger.info("=====vo: " + vo);
			
			vo.setCat_code(list.getCat_code());
			vo.setPro_main_img(FileUtils.uploadFile(uploadPath, vo.getFile1().getOriginalFilename(), vo.getFile1().getBytes()));
			
			service.productInsertOK(vo);
		}
		
		rttr.addFlashAttribute("msg", "INSERT_SUCCESS");
		
		return "redirect:/admin/product/list";
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
		logger.info("=====cri : " + cri.toString());
		
		model.addAttribute("productList", service.productList(cri));
		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		
		model.addAttribute("pm", pm);
	}
	
	/* 상품 상세정보 조회 */
	@RequestMapping(value = "read", method = RequestMethod.GET)
	public void productRead(@ModelAttribute("cri") SearchCriteria cri,
							@RequestParam("pro_num") int pro_num, Model model) throws Exception {
		logger.info("productRead() called");
		
		ProductVO vo = service.readProduct(pro_num);
		logger.info("=====readProduct: " + vo);
		
		model.addAttribute("vo", vo);
		
		// 상품 목록으로 돌아가기 위한 목적
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		
		model.addAttribute("pm", pm);
	}
	
	/* 체크된 상품리스트 조회 
	@RequestMapping(value = "editList", method = RequestMethod.POST)
	public ResponseEntity<String> productEditList(@RequestParam("proNum[]") List<Integer> proNumArr, Model model) throws Exception {
		logger.info("productEditList() called");
		
		ResponseEntity<String> entity = null;
		
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			String pro_num = null;

			for(int i=0; i<proNumArr.size(); i++) {
				pro_num += "," + proNumArr.get(i);
			}
			
			pro_num = pro_num.substring(5); // null,을 제외한 값 가져오기
			
			map.put("pro_num", pro_num);
			logger.info("=====pro_num : " + map.get("pro_num"));
			
			List<ProductVO> editList =  service.productEditList(map);
			logger.info("=====editList : " + editList);
			model.addAttribute("editList", editList);
			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}*/
	
	/* 체크된 상품리스트 조회 */
	@RequestMapping(value = "edit", method = RequestMethod.GET)
	public void productEditList(@ModelAttribute("cri") SearchCriteria cri, 
								@RequestParam("proNum[]") List<Integer> proNumArr,
								Model model) throws Exception {
		logger.info("productEditList() called");
		
		Map<String, Object> map = new HashMap<String, Object>();
		String pro_num = null;

		for(int i=0; i<proNumArr.size(); i++) {
			pro_num += "," + proNumArr.get(i);
		}
		
		pro_num = pro_num.substring(5); // null,을 제외한 값 가져오기
		
		map.put("pro_num", pro_num);
		logger.info("=====pro_num : " + map.get("pro_num"));
		
		List<ProductVO> editList =  service.productEditList(map);
		logger.info("=====editList : " + editList);
		model.addAttribute("editList", editList);
	}
	
	/* 상품 수정 이동
	@RequestMapping(value = "edit", method = RequestMethod.GET)
	public String productEdit(@ModelAttribute("editList") List<ProductVO> editList) {
		logger.info("productEdit() called");
		logger.info("=====editList : " + editList);
		
		return "/admin/product/edit";
	} */
	
	/* 체크된 상품 수정 */
	
	/* 체크된 상품 삭제 */
	

}
