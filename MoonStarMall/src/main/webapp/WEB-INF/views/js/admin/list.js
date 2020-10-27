$(function(){
	/* 검색버튼 클릭 시 */
	$("#btn_search").on("click", function(){
		self.location = "list"
			+ '${pm.makeQuery(1)}'
			+ "&searchType="
			+ $("select option:selected").val()
			+ "&keyword=" + $('#keyword').val();
    });
	
});