package com.moonstarmall.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.apache.commons.io.IOUtils;
import org.imgscalr.Scalr;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;

public class FileUtils {
	/*
	 * 파일 업로드
	 * 
	 * @Params
	 * String uploadPath: 기본 파일 업로드 경로
	 * String originName: 원본 파일명
	 * byte[] fileData:   파일 데이터
	 * 
	 * @return
	 * String uploadedFileName : 날짜 경로 + 파일 이름 (ex.\\2020\\03\\13\\uuid+fileName)
	 * 
	 */	
	public static String uploadFile(String uploadPath, String originName, byte[] fileData) throws Exception {
		System.out.println("uploadFile() called");
		
		/* 파일명 설정     ex) uuid_파일명 */
		UUID uuid = UUID.randomUUID();
		String savedName = uuid.toString() + "_" + originName;
		/* 파일 경로 설정     ex) 날짜경로 */
		String savedPath = calcPath(uploadPath);
		/* 설정한 정보로 빈 파일 생성 */
		File target = new File(uploadPath + savedPath, savedName); 
		
		// 만든 파일에 데이터 쓰기
		FileCopyUtils.copy(fileData, target);
		
		/* 확장자명 가져오기 */
		String formatName = originName.substring(originName.lastIndexOf(".") + 1); 
		
		String uploadFileName = null;
		if(MediaUtils.getMediaType(formatName) != null) {
			// 이미지 파일인 경우 썸네일 생성
			uploadFileName = makeThumbnail(uploadPath, savedPath, savedName);
		}else {
			// 일반 파일인 경우 아이콘 생성
			uploadFileName = makeIcon(uploadPath, savedPath, savedName);
		}
		
		return uploadFileName;
	}
	
	/* 날짜 폴더경로 설정 */
	private static String calcPath(String uploadPath) {
		Calendar cal = Calendar.getInstance();
		
		/* \\년월일 형태의 날짜 경로 */
		String datePath = File.separator + cal.get(Calendar.YEAR) 
		+ new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1)
		+ new DecimalFormat("00").format(cal.get(Calendar.DATE));
		
		/* \\년\\월\\일 */
		//String yearPath = File.separator + cal.get(Calendar.YEAR);
		//String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		//String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		
		System.out.println("FileUtils.calcPath() result: " + datePath);
		
		// 날짜별 폴더 생성
		//makeDir(uploadPath, yearPath, monthPath, datePath);
		makeDir(uploadPath, datePath);
		
		return datePath;
	}

	/* 폴더 생성 
	private static void makeDir(String uploadPath, String... paths) {

//		if(new File(paths[paths.length - 1]).exists() == false) {
//			// 가장 마지막 매개변수의 폴더가 존재하지 않으면 폴더 생성
//			for(String path: paths) {
//				File dirPath = new File(uploadPath + path);
//				
//				if(!dirPath.exists()) {
//					dirPath.mkdir();
//				}
//			}
//		}
		if(new File(paths[paths.length - 1]).exists()) {
			return;
		}
		
		for(String path: paths) {
			File dirPath = new File(uploadPath + path);
			
			if(!dirPath.exists()) {
				dirPath.mkdir();
			}
		}
	}
*/
	private static void makeDir(String uploadPath, String datePath) {
		/*
		if(new File(paths[paths.length - 1]).exists() == false) {
			// 가장 마지막 매개변수의 폴더가 존재하지 않으면 폴더 생성
			for(String path: paths) {
				File dirPath = new File(uploadPath + path);
				
				if(!dirPath.exists()) {
					dirPath.mkdir();
				}
			}
		}
		*/
		if(new File(datePath).exists()) {
			return;
		}
		
		File dirPath = new File(uploadPath + datePath);
		
		if(!dirPath.exists()) {
			dirPath.mkdir();
		}
	}
	
	/* 이미지 썸네일 생성 */
	private static String makeThumbnail(String uploadPath, String path, String fileName) throws Exception {
		
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath + path, fileName));
		// 썸네일 높이를 80px로 하고 너비를 맞춤
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 120);
		
		// 썸네일 생성 준비작업
		String thumbnailName = uploadPath + path + File.separator + "s_" + fileName;
		File newFile = new File(thumbnailName);
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
		
		// 썸네일 생성
		ImageIO.write(destImg, formatName.toUpperCase(), newFile);
		
		System.out.println("FileUtils.makeThumbNail() thumbNail: " + thumbnailName);
		
		return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
	
	/* 파일 아이콘 생성 */
	private static String makeIcon(String uploadPath, String path, String fileName) throws Exception {
		
		String iconName = uploadPath + path + File.separator + fileName;
		
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}

	/* 파일 가져오기 */
	public static ResponseEntity<byte[]> getFile(String uploadPath, String fileName) throws Exception {
		
		ResponseEntity<byte[]> entity = null;
		
		InputStream in = null;
		
		try {
			// 확장자로 파일 종류를 확인
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
			MediaType type = MediaUtils.getMediaType(formatName);
			
			// 파일 헤더 설정
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(type);
			
			// 파일 가져오기
			in = new FileInputStream(uploadPath + fileName);
			
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.OK);
			
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			in.close();
		}
		
		return entity;
	}
	
	/* 파일 삭제 */
	public static void deleteFile(String uploadPath, String fileName) {
		//String front = fileName.substring(0, 12);
		//String end = fileName.substring(14);
		//String origin = front + end;
		String origin = thumbToOriginName(fileName);
		
		new File(uploadPath+origin.replace('/', File.separatorChar)).delete();
		new File(uploadPath+fileName.replace('/', File.separatorChar)).delete();
	}
	
	/* 썸네일 파일명을 원본 파일명으로 변경하는 작업 */
	public static String thumbToOriginName(String thumbmailName) {
		String front = thumbmailName.substring(0, 12);
		String end = thumbmailName.substring(14);
		
		return front + end;
	}
}
