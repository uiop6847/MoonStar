$(function(){
	/* 검색버튼 클릭 시 */
	$("#btn_search").on("click", function(){
		self.location = "list"
			+ '${pm.makeQuery(1)}'
			+ "&searchType="
			+ $("select option:selected").val()
			+ "&keyword=" + $('#keyword').val();
    });
    
    /* 수정버튼 클릭 시 */
    $("#btn_edit").on("click", function(){
        
        var proNum = [];
        
        if($(":checkbox:checked").length == 0){
            alert("수정할 상품이 없습니다.\n수정할 상품을 체크해주세요.");
			return false;
        }
        
        // 체크된 상품 json 변환
        $("#tbl_productListRow tr").each(function(i){

            if($(this).find(":checkbox").is(":checked")){
                
                proNum.push($(this).children().eq(1).text());
            }
        });
        console.log(proNum);

        $.ajax({
            url: '/admin/product/edit',
            type: 'post',
            dataType: 'text',
            data: { proNum : proNum },
            success : function(data) {
                alert("수정이 완료되었습니다.");
                location.href="/admin/product/list${pm.makeSearch(pm.cri.page)}";
            }

        });
    });
	
});