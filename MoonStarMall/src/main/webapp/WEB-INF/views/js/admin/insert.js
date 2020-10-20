$(function(){

	var form = $("#productInsertForm");
	var tbl = $("#tbl_product");

    /* 상품 등록 버튼 클릭 시 */
	$("#btn_submit").on("click", function(){

		var result = "";
		
		for(i = 0; i < $(":checkbox:not(:first)").length; i++){
			if($(":checkbox").is(":checked") == true){
				console.log(i);
			}
		}
		/*
		// 체크된 항목 체크
		if($(":checkbox:first", tbl).is(":checked") == true){
			result = confirm("체크되지 않은 항목을 제외하고 등록하시겠습니까?");
		}else{
			result = confirm("상품을 등록하시겠습니까?")
		}

		//insertOne(result);
		if(insertList){
			form.submit();
		}
        */
	});

	function insertList(result){
		var mainCategory    = $("#mainCategory option:selected");
		var subCategory     = $("#subCategory option:selected");
		var proNm           = $("input[name=pro_nm]");
		var proPublisher    = $("input[name=pro_publisher]");
		var proPrice        = $("input[name=pro_price]");
		var proDiscount     = $("input[name=pro_discount]");
		var pro_dtl_info    = $("textarea[name=pro_dtl_info]");
		var file1           = $("input[name=file1]");
		var proCount        = $("input[name=pro_count]");
		//var fileSize        = file1.size;
		var fileFormat      = /(.*?)\.(jpg|jpeg|png|gif|JPG|JPEG|PNG|GIF)$/;
		var maxSize         = 5 * 1024 * 1024; // 5MB

		if(result){
			/* 유효성 검사 */
			if(mainCategory.val()==null || mainCategory.val()=="default"){
				alert("1차 카테고리를 선택해주세요.");
				mainCategory.focus();
				return;
			}
			
			if(subCategory.val()==null || subCategory.val()=="default"){
				alert("2차 카테고리를 선택해주세요.");
				subCategory.focus();
				return;
			}

			proNm.each(function(idx){
				var eqName = proNm.eq(idx);

				if(eqName.val() == null || eqName.val() == "") {
					alert("상품명을 입력해주세요.");
					eqName.focus();
					return;
				}
			});

			proPublisher.each(function(idx){
				var eqName = proPublisher.eq(idx);

				if(proPublisher.val() == null || proPublisher.val() == "") {
					alert("제조사를 입력해주세요.");
					proPublisher.focus();
					return;
				}
			});

			proPrice.each(function(idx){
				var eqName = proPrice.eq(idx);

				if(proPrice.val() == null || proPrice.val() == "") {
					alert("상품 가격을 입력해주세요.");
					proPrice.focus();
					return;
				}
			});

			proDiscount.each(function(idx){
				var eqName = proDiscount.eq(idx);

				if(proDiscount.val() == null || proDiscount.val() == "") {
					alert("할인율을 입력해주세요.");
					proDiscount.focus();
					return;
				}
			});

			pro_dtl_info.each(function(idx){
				var ckeditor = CKEDITOR.instances[pro_dtl_info.eq(idx).attr("id")];

				console.log(ckeditor);

				if(ckeditor.getData()==null || ckeditor.getData()==""){
					alert("상품 상세 내용을 입력해주세요.");
					ckeditor.focus();	
					return;
				}
			});

			

			file1.each(function(idx){
				var eqName = file1.eq(idx);

				if(file1.val() == null || file1.val() == "") {
					alert("이미지 파일을 추가해주세요.");
					file1.focus();
					return;
				}

				if(!file1.val().match(fileFormat)){
					alert("이미지 파일만 업로드 가능합니다.");
					file1.focus();
					return;
				}

				if(eqName.size > maxSize){
					alert("파일 사이즈는 5MB까지만 가능합니다.");
					file1.focus();
					return;
				}
			});

			proCount.each(function(idx){
				var eqName = proCount.eq(idx);

				if(proCount.val() == null || proCount.val() == "") {
					alert("상품 수량을 입력해주세요.");
					proCount.focus();
					return;
				}
			});

		} else {}

	}
	
	function insertOne(result){
		if(result){

            /* 유효성 검사 */
            var mainCategory    = $("#mainCategory option:selected");
            var subCategory     = $("#subCategory option:selected");
            var proNm           = $("#pro_nm");
            var proPublisher    = $("#pro_publisher");
            var proPrice        = $("#pro_price");
            var proDiscount     = $("#pro_discount");
            var ckeditor        = CKEDITOR.instances['pro_dtl_info'];
            var file1           = $("#file1");
            var proCount        = $("#pro_count");
			var fileSize        = file1.size;
			//var fileFormat      = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf)$/;
			var fileFormat      = /(.*?)\.(jpg|jpeg|png|gif|JPG|JPEG|PNG|GIF)$/;
			var maxSize         = 5 * 1024 * 1024; // 5MB

            if(mainCategory.val()==null || mainCategory.val()=="default"){
				alert("1차 카테고리를 선택해주세요.");
				mainCategory.focus();
				return;
				
			} else if(subCategory.val()==null || subCategory.val()=="default"){
				alert("2차 카테고리를 선택해주세요.");
				subCategory.focus();
				return;
				
			} else if(proNm.val()==null || proNm.val()==""){
				alert("상품명을 입력해주세요.");
				proNm.focus();
				return;
				
			} else if(proPublisher.val()==null || proPublisher.val()==""){
				alert("제조사를 입력해주세요.");
				proPublisher.focus();
				return;
				
			}else if(proPrice.val()==null || proPrice.val()==""){
				alert("상품 가격을 입력해주세요.");
				proPrice.focus();
				return;
				
			}else if(proDiscount.val()==null || proDiscount.val()==""){
				alert("할인율 입력해주세요.");
				proDiscount.focus();
				return;
				
			}else if(ckeditor.getData()==null || ckeditor.getData()==""){
				alert("상품 상세 내용을 입력해주세요.");
				ckeditor.focus();	
				return;
				
			}else if(file1.val()==null || file1.val()==""){
				alert("이미지 파일을 추가해주세요.");
				file1.focus();
				return;
				
			}else if(!file1.val().match(fileFormat)){
				alert("이미지 파일만 업로드 가능합니다.");
				file1.focus();
				return;
				
			}else if(fileSize > maxSize){
				alert("파일 사이즈는 5MB까지만 가능합니다.");
				file1.focus();
				return;
				
			}else if(proCount.val()==null || proCount.val()==""){
				alert("상품 수량을 입력해주세요.");
				proCount.focus();
				return;
				
			}else {
				form.submit();
            }
            
		} else {}
	}

});