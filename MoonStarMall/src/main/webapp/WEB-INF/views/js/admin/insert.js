$(function(){

	var form = $("#productInsertForm");

    /* 상품 등록 버튼 클릭 시 */
	$("#btn_submit").on("click", function(){

		var checked = "N"; // checked 여부
		var result = confirm("상품을 등록하시겠습니까?");

		var list = new Array(); // 리스트 생성
		var data = new Object() ; // 객체 생성

		for(i = 0; i < $(":checkbox:not(:first)").length; i++){
			
			if($(":checkbox").is(":checked")){
				checked = "Y";

				if(result){
					/* 유효성검사 */
					if(validationCheck(i)){

						/* JSON 형태로 데이터 변환 
						console.log("JSON_DataPush");
						var subCategory     = $("#subCategory option:selected");
						var proNm           = $("input[name=pro_nm]:eq("+i+")");
						var proPublisher    = $("input[name=pro_publisher]:eq("+i+")");
						var proPrice        = $("input[name=pro_price]:eq("+i+")");
						var proDiscount     = $("input[name=pro_discount]:eq("+i+")");
						var proCount        = $("input[name=pro_count]:eq("+i+")");
						var proBuyYN		= $("select[name=pro_buy_yn] option:selected");
						var file1           = $("input[name=file1]:eq("+i+")");
						var pro_dtl_info    = $("textarea[name=pro_dtl_info]:eq("+i+")");
						var ckeditor 		= CKEDITOR.instances[pro_dtl_info.attr("id")];
						
						data.cat_code 		= subCategory.val();
						data.pro_nm 		= proNm.val();
						data.pro_publisher	= proPublisher.val();
						data.pro_price		= proPrice.val();
						data.pro_discount	= proDiscount.val();
						data.pro_count		= proCount.val();
						data.proBuyYN		= proBuyYN.val();
						data.file1			= file1.val();
						data.pro_dtl_info	= ckeditor.getData();

						
						// 리스트에 생성된 객체 삽입
						list.push(data);*/
					}else {
						return false;
					}
				}
			}

		}

		/* submit */
		if(checked == "Y"){
			console.log("checked : " + checked);

			form.submit();
			/*
			// String 형태로 변환
			var jsonData = JSON.stringify(list);

			console.log(jsonData);

			$.ajax({
				url: '/admin/product/insertOK',
				type: 'post',
				contentType: 'application/json; charset=utf-8',
				//processData: false,
				//contentType: false,
				//enctype: 'multipart/form-data',
				data: jsonData,
				dataType: 'json',
				success: function(data){
					console.log("success");
					location.href="/admin/product/list";
					
				}, error: function(xhr, status, error){
					console.log("error: " + status);
				}
			});*/

		} else if(checked == "N"){
			alert("등록할 상품을 체크해주세요.");
			return;
		}
	});

	/* 유효성검사 */
	function validationCheck(i){
		console.log("validationCheck");
		var mainCategory    = $("#mainCategory option:selected");
		var subCategory     = $("#subCategory option:selected");
		var proNm           = $("input[name=pro_nm]");
		var proPublisher    = $("input[name=pro_publisher]");
		var proPrice        = $("input[name=pro_price]");
		var proDiscount     = $("input[name=pro_discount]");
		var proCount        = $("input[name=pro_count]");
		var file1           = $("input[name=file1]");
		var pro_dtl_info    = $("textarea[name=pro_dtl_info]");
		var ckeditor 		= CKEDITOR.instances[pro_dtl_info.eq(i).attr("id")];
		var fileFormat      = /(.*?)\.(jpg|jpeg|png|gif|JPG|JPEG|PNG|GIF)$/;
		var maxSize         = 5 * 1024 * 1024; // 5MB

		//var isOk = false;

		/* 유효성 검사 */
		if(mainCategory.val()==null || mainCategory.val()=="default"){
			alert("1차 카테고리를 선택해주세요.");
			mainCategory.focus();
			return false;

		} else if(subCategory.val()==null || subCategory.val()=="default"){
			alert("2차 카테고리를 선택해주세요.");
			subCategory.focus();
			return false;
			
		} else if(proNm.eq(i).val() == null || proNm.eq(i).val() == "") {
			alert("상품명을 입력해주세요.");
			proNm.eq(i).focus();
			return false;
			
		} else if(proPublisher.eq(i).val() == null || proPublisher.eq(i).val() == "") {
			alert("제조사를 입력해주세요.");
			proPublisher.eq(i).focus();
			return false;
			
		} else if(proPrice.eq(i).val() == null || proPrice.eq(i).val() == "") {
			alert("상품 가격을 입력해주세요.");
			proPrice.eq(i).focus();
			return false;
			
		} else if(proDiscount.eq(i).val() == null || proDiscount.eq(i).val() == "") {
			alert("할인율을 입력해주세요.");
			proDiscount.eq(i).focus();
			return false;
			
		} else if(proCount.eq(i).val() == null || proCount.eq(i).val() == "") {
			alert("상품 수량을 입력해주세요.");
			proCount.eq(i).focus();
			return false;
			
		} else if(file1.eq(i).val() == null || file1.eq(i).val() == "") {
			alert("이미지 파일을 추가해주세요.");
			file1.eq(i).focus();
			return false;
			
		} else if(ckeditor.getData() == null || ckeditor.getData() == ""){
			alert("상품 상세 내용을 입력해주세요.");
			pro_dtl_info.eq(i).focus();	
			return false;
			
		} else if(!file1.eq(i).val().match(fileFormat)){
			alert("이미지 파일만 업로드 가능합니다.");
			file1.eq(i).focus();
			return false;
			
		} else if(file1.eq(i).size > maxSize){
			alert("파일 사이즈는 5MB까지만 가능합니다.");
			file1.eq(i).focus();
			return false;
		} else {
			return true;
		}
	}

	/* 단일저장 validation Check */
	/*
	function insertOne(result){
		if(result){

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
	*/
});