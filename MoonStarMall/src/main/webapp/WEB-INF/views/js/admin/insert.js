$(function(){

    var form = $("#productInsertForm");

    /* 상품 등록 버튼 클릭 시 */
	$("#btn_submit").on("click", function(){

        if(result){

            /* 유효성 검사 */
            var mainCategory    = $("#mainCategory option:selected");
            var subCategory     = $("#subCategory option:selected");
            var proName         = $("#pro_name");
            var proPublisher    = $("#pro_publisher");
            var proPrice        = $("#pro_price");
            var proDiscount     = $("#pro_discount");
            var ckeditor        = CKEDITOR.instances['pro_dtl_info'];
            var file1           = $("#file1");
            var pdtAmount       = $("#pdt_amount");
			var fileSize        = file1.size;
			var fileFormat      = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf)$/;
			var maxSize         = 5 * 1024 * 1024; // 5MB

            if(mainCategory.val()==null || mainCategory.val()=="default"){
				alert("1차 카테고리를 선택해주세요.");
				mainCategory.focus();
				return;
				
			} else if(subCategory.val()==null || subCategory.val()=="default"){
				alert("2차 카테고리를 선택해주세요.");
				subCategory.focus();
				return;
				
			} else if(proName.val()==null || proName.val()==""){
				alert("상품명을 입력해주세요.");
				proName.focus();
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
				alert("할인 가격을 입력해주세요.");
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
				
			}else if(pdtAmount.val()==null || pdtAmount.val()==""){
				alert("상품 수량을 입력해주세요.");
				pdtAmount.focus();
				return;
				
			}else {
				form.submit();
            }
            
		} else {}
        
    });

});