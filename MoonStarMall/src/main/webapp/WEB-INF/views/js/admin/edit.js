$(function(){

	var form = $("#productEditForm");

    /* 수정 버튼 클릭 시 */
    $("#btn_submit").on("click", function(){

        var result = confirm("상품을 수정하시겠습니까?");

        if($(":checkbox:not(:first):checked").length == 0){
			alert("등록할 상품이 없습니다.");
			return false;
		}

        if(result){
            /* 유효성검사 */
			if(!validationCheck()) return false;
			
			/* 태그name을 list로 변환 */
			$("#productRowAdd tr").each(function(i){
				var td = $(this).find("td");
				
				td.each(function(j){

					if(j == 0){
						$(this).children().eq(1).attr("name", "list[" + i + "].cat_code");
						$(this).children().eq(2).attr("name", "list[" + i + "].cat_prtcode");
					}
					
					if(j != 0){
						var name = $(this).children().attr("name");
						$(this).children().attr("name", "list[" + i + "]." + name);
					}
				});
			});

			$("#productRowAddInfo div[name=proDtl]").each(function(i){
				
				$(this).find("input[name=pro_main_img]").attr("name", "list[" + i + "].pro_main_img");
				$(this).find("input[name=file1]").attr("name", "list[" + i + "].file1");
				$(this).find("textarea[name=pro_dtl_info]").attr("name", "list[" + i + "].pro_dtl_info");
			});
			
            form.submit();
        }
    });

    /* 유효성검사 */
	function validationCheck(){

		var isOk;
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
			
			isOk = false;
			
            /* 유효성 검사 */
            if(mainCategory.val()==null || mainCategory.val()=="default"){
                alert("1차 카테고리를 선택해주세요.");
                mainCategory.focus();
                return false;
                
            } else if(subCategory.val()==null || subCategory.val()=="default"){
                alert("2차 카테고리를 선택해주세요.");
                subCategory.focus();
                return false;

            } else if(proNm.val() == null || proNm.val() == "") {
				alert("상품명을 입력해주세요.");
				$(this).trigger("click");
				proNm.focus();
				return false;
				
			} else if(proPublisher.val() == null || proPublisher.val() == "") {
				alert("제조사를 입력해주세요.");
				$(this).trigger("click");
				proPublisher.focus();
				return false;
				
			} else if(proPrice.val() == null || proPrice.val() == "") {
				alert("상품 가격을 입력해주세요.");
				$(this).trigger("click");
				proPrice.focus();
				return false;
				
			} else if(proDiscount.val() == null || proDiscount.val() == "") {
				alert("할인율을 입력해주세요.");
				$(this).trigger("click");
				proDiscount.focus();
				return false;
				
			} else if(proCount.val() == null || proCount.val() == "") {
				alert("상품 수량을 입력해주세요.");
				$(this).trigger("click");
				proCount.focus();
				return false;
				
			} else if(ckeditor.getData() == null || ckeditor.getData() == ""){
				alert("상품 상세 내용을 입력해주세요.");
				$(this).trigger("click");
				pro_dtl_info.focus();	
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