package com.moonstarmall.util;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;

public class MediaUtils {
	
	private static Map<String, MediaType> mediaMap;
	
	static {
		mediaMap = new HashMap<String, MediaType>();
		
		mediaMap.put("JPG", MediaType.IMAGE_JPEG);
		mediaMap.put("JPEG", MediaType.IMAGE_JPEG);
		mediaMap.put("GIF", MediaType.IMAGE_GIF);
		mediaMap.put("PNG", MediaType.IMAGE_PNG);
	}
	
	public static MediaType getMediaType(String type) {
		/*
		 * 해당 확장자가 Map에 key로 존재하는지 확인 
		 * 
		 * @Params
		 * String type : 확인할 확장자 명
		 * 
		 * @return 
		 * 이미지 파일은 value,
		 * 이미지 파일이 아니면 null 
		 * */
		return mediaMap.get(type.toUpperCase());
	}

}
