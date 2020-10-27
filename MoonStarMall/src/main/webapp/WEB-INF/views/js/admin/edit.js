$(function(){

	var form = $("#productEditForm");
    /* 상품수정 버튼클릭 시 */
    $("#btn_submit").on("click", function(){

        var result = confirm("상품을 수정하시겠습니까?");

        if($(":checkbox:not(:first):checked").length == 0){
			alert("등록할 상품이 없습니다.");
			return false;
		}

        if(result){
            /* 유효성검사 */
            if(!validationCheck()) return false;
            
            form.submit();
        }
    });

    /* 유효성검사 */
	function validationCheck(){

		var isOk = false;
		$("#productRowAdd tr").each(function(i){

            var mainCategory    = $("input[id='list["+i+"].cat_prtcode'");
		    var subCategory     = $("input[id='list["+i+"].cat_code'");
			var proNm           = $("input[id='list["+i+"].pro_nm'");
			var proPublisher    = $("input[id='list["+i+"].pro_publisher'");
			var proPrice        = $("input[id='list["+i+"].pro_price'");
			var proDiscount     = $("input[id='list["+i+"].pro_discount'");
			var proCount        = $("input[id='list["+i+"].pro_count'");
			var file1           = $("input[id='list["+i+"].file1'");
			var pro_dtl_info    = $("textarea[id='list["+i+"].pro_dtl_info'");
			var ckeditor 		= CKEDITOR.instances[pro_dtl_info.attr("id")];
			var fileFormat      = /(.*?)\.(jpg|jpeg|png|gif|JPG|JPEG|PNG|GIF)$/;
            var maxSize         = 5 * 1024 * 1024; // 5MB
            
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
				$(this).trigger("click");
				proNm.eq(i).focus();
				return false;
				
			} else if(proPublisher.eq(i).val() == null || proPublisher.eq(i).val() == "") {
				alert("제조사를 입력해주세요.");
				$(this).trigger("click");
				proPublisher.eq(i).focus();
				return false;
				
			} else if(proPrice.eq(i).val() == null || proPrice.eq(i).val() == "") {
				alert("상품 가격을 입력해주세요.");
				$(this).trigger("click");
				proPrice.eq(i).focus();
				return false;
				
			} else if(proDiscount.eq(i).val() == null || proDiscount.eq(i).val() == "") {
				alert("할인율을 입력해주세요.");
				$(this).trigger("click");
				proDiscount.eq(i).focus();
				return false;
				
			} else if(proCount.eq(i).val() == null || proCount.eq(i).val() == "") {
				alert("상품 수량을 입력해주세요.");
				$(this).trigger("click");
				proCount.eq(i).focus();
				return false;
				
			} else if(file1.eq(i).val() == null || file1.eq(i).val() == "") {
				alert("이미지 파일을 추가해주세요.");
				$(this).trigger("click");
				file1.eq(i).focus();
				return false;
				
			} else if(ckeditor.getData() == null || ckeditor.getData() == ""){
				alert("상품 상세 내용을 입력해주세요.");
				$(this).trigger("click");
				pro_dtl_info.eq(i).focus();	
				return false;
				
			} else if(!file1.eq(i).val().match(fileFormat)){
				alert("이미지 파일만 업로드 가능합니다.");
				$(this).trigger("click");
				file1.eq(i).focus();
				return false;
				
			} else if(file1.eq(i).size > maxSize){
				alert("파일 사이즈는 5MB까지만 가능합니다.");
				$(this).trigger("click");
				file1.eq(i).focus();
				return false;

			} else {
				isOk = true;
			}
		});

		if(isOk == false){
			return false;
		}else {
			return true;
		}
	}
});