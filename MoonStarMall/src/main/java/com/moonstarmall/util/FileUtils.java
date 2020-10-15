package com.moonstarmall.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;

public class FileUtils {
	
	private static final Logger logger = LoggerFactory.getLogger(FileUtils.class);
	
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
		logger.info("uploadFile() called");
		
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
		
		/* \\년\\월\\일 형태의 날짜 경로 */
		String yearPath = File.separator + cal.get(Calendar.YEAR);
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		
		logger.info("calcPath result: " + datePath);
		
		// 날짜별 폴더 생성
		makeDir(uploadPath, yearPath, monthPath, datePath);
		
		return datePath;
	}
	
	/* 폴더 생성 */
	private static void makeDir(String uploadPath, String... paths) {
		
		if(new File(paths[paths.length - 1]).exists() == false) {
			// 가장 마지막 매개변수의 폴더가 존재하지 않으면 폴더 생성
			for(String path: paths) {
				File dirPath = new File(uploadPath + path);
				
				if(!dirPath.exists()) {
					dirPath.mkdir();
				}
			}
		}
	}
	
	/* 이미지 썸네일 생성 */
	private static String makeThumbnail(String uploadPath, String path, String fileName) throws IOException {
		
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath + path, fileName));
		// 썸네일 높이를 80px로 하고 너비를 맞춤
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 120);
		
		// 썸네일 파일명
		String thumbnailName = uploadPath + path + File.separator + "s_" + fileName;
		File newFile = new File(thumbnailName);
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
		
		// 썸네일 생성
		ImageIO.write(destImg, formatName, newFile);
		
		System.out.println("=====makeThumbNail() thumbNail: " + thumbnailName);
		
		return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
	
	/* 파일 아이콘 생성 */
	private static String makeIcon(String uploadPath, String path, String fileName) throws Exception {
		
		String iconName = uploadPath + path + File.separator + fileName;
		
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}

}
