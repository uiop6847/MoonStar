var replyPage = 1;

$(function(){
	var pro_num = $("#pro_num").val();

	$("#buy_count").on("change", function(){

		var total = $("#pro_price").val() * $(this).val();

		total = makeComma(total);

		$("#total_price").empty();
		$("#total_price").append(total);

		$("#total").empty();
		$("#total").append(total + " (" + $(this).val() + "개)");

	});

	// 금액 ,(콤마) 정규식
	function makeComma(str) {

		str = String(str);
	   
		return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	   
	}
	
	/* 별점 클릭 시, 색상 변경 */
	$("#star_grade a").click(function(e){
		$(this).parent().children("a").removeClass("on");  /* 별점의 on 클래스 전부 제거 */ 
		$(this).addClass("on").prevAll("a").addClass("on"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
		
		e.preventDefault();
	});

	/* 상품후기쓰기 버튼 클릭 시 */
	$("#btn_write_review").on("click", function(){

		var rew_score = 0;
		var rew_content = $("#reviewContent").val();
		//var pro_num = $("#pro_num").val();
		
		// 선택된 별점 개수를 가져옴
		$("#star_grade a").each(function(){
			if($(this).attr("class") == "on"){
				rew_score += 1;
			}
		});
		
		// 유효성 검사
		if(rew_score == 0){
			alert("별점을 선택해주세요.");
			return;
			
		} else if(rew_content == "" || rew_content == null){
			alert("후기 내용을 입력해주세요.")
			return;
		}

		// DB작업
		$.ajax({
			url: "/review/write",
			type: "post",
			dataType: "text",
			data: {
				"rew_score" : rew_score,
				"rew_content" : rew_content,
				"pro_num" : pro_num
			},
			success : function(data){

				if(data == "SUCCESS"){
					alert("상품후기가 등록되었습니다.");

					// 별점, 상품후기 비우기
					$("#star_grade a").parent().children("a").removeClass("on");  
					$("#reviewContent").val("");
					replyPage = 1;
					getPage("/review/" + pro_num + "/1");
					
				}else if(data == "N_SESSION"){
					var result = confirm("후기를 등록하려면 로그인을 해주세요. \n로그인 하시겠습니까?");
				
					if(result){
						location.href = "/member/login";
					}
				}
			}
		});
	});

	/* 상품 후기 클릭 시 */
	$("#product-review-tab").one("click", function(){

		//var pro_num = $("#pro_num").val();
		getPage("/review/" + pro_num + "/1");

	});

	/* 상품 후기 하단 페이지 클릭 시 페이지 이동 */
	$(".pagination").on("click", "li a", function(e){
		
		//var pro_num = $("#pro_num").val();

		e.preventDefault(); // a태그 이동중지

		replyPage = $(this).attr("href");
		getPage("/review/" + pro_num + "/" + replyPage);
	});

	/* 
	 * Modal 창에 뿌리기
	 * 후기 리스트 ul 태그 밑에 있는 템플릿(li) 클릭 시,
	 * Modal 창의 title, content, rv_num 가져와서 뿌려줌
	 */
	$(".timeline").on("click", ".replyLi", function() {
		var reply = $(this);
		var rew_num = $(this).attr("data-rew_num");
		var score = $(this).find(".rew_score").text();
		
		// 후기 평점 가져오기
		$("#star_grade_modal a").each(function(index, item){
			if(index < score){
				$(item).addClass("on");
			} else{
				$(item).removeClass("on");
			}
		});
		
		// 후기 내용 가져오기
		$("#replytext").val(reply.find(".rew_content").text());
		// 후기 번호 가져오기
		$(".modal-body").attr("replytext", rew_num);

	});

	/*
	* Modal 창에서 별점 클릭 시, 색상 변경
	*/
	 $("#star_grade_modal a").click(function(e){
		$(this).parent().children("a").removeClass("on"); 
		$(this).addClass("on").prevAll("a").addClass("on"); 
		
		e.preventDefault();
	});

	/* modal 창에서 수정버튼 클릭 시 */
	$("#btn_modal_modify").on("click", function(){

		var rew_score = 0;
		var rew_num = $(".modal-body").attr("replytext");
		var rew_content = $("#replytext").val();

		// 선택된 별점 개수를 가져옴
		$("#star_grade_modal a").each(function(){
			if($(this).attr("class") == "on"){
				rew_score += 1;
			}
		});

		// DB작업
		$.ajax({
			url : "/review/modify",
			type : "post",
			dataType: "text",
			data : {
				"rew_num" : rew_num,
				"rew_content" : rew_content,
				"rew_score" : rew_score
			},
			success : function(data) {

				if(data == "SUCCESS"){
					alert("상품후기가 수정되었습니다.");
					getPage("/review/" + pro_num + "/" + replyPage);
				}
			}
			
		});

	});

	/* 장바구니 담기 */
	$("#btn_cart").on("click", function(){
		
		var result = "";
		var formData = { 	
							pro_num : pro_num, 
							buy_count : $("#buy_count").val() 
						};
		
		// 동일한 상품이 장바구니에 존재하는지 확인
		$.ajax({
			url: "/cart/itemCheck",
			type : "post", 
			data : formData,
			success : function(data) {

				if(data == "UPDATE"){
					result = confirm("장바구니에 동일한 상품이 있습니다. \n장바구니에 추가하시겠습니까?");
					if(result){
						cartUpdate(formData);
					}

				}else if(data == "INSERT"){
					cartUpdate(formData);
				
				}else 
				if(data == "N_SESSION"){
					result = confirm("장바구니에 담으려면 로그인을 해주세요. \n로그인 하시겠습니까?");
					if(result){
						location.href = "/member/login";
					}

				}
			}
		});

	});

	/* 장바구니 등록 및 수량 변경 처리 */
	function cartUpdate(formData){
		$.ajax({
			url : "/cart/cartUpdate",
			type : "post", 
			data : formData,
			success : function(data) {

				if(data == "SUCCESS"){
					result = confirm("장바구니에 담았습니다. \n장바구니로 이동 하시겠습니까?");
					if(result){
						location.href = "/cart/list";

					}
				}
			}
		});
	}

	/* BUY IT NOW 버튼 클릭 시 */
	$("#btn_buy").on("click", function(){
		
		var result = "";
		var formData = { 	
							pro_num : pro_num, 
							buy_count : $("#buy_count").val() 
						};
		
		// 동일한 상품이 장바구니에 존재하는지 확인
		$.ajax({
			url: "/cart/itemCheck",
			type : "post", 
			data : formData,
			success : function(data) {

				if(data == "UPDATE"){
					// 장바구니에 있으면 같이 주문할지 확인
					result = confirm("장바구니에 동일한 상품이 있습니다. \n함께 구매하시겠습니까?");
					if(result){
						// yes -> cart에 buy_count update하고 주문페이지로 이동
						buyCartUpdate(formData);
					}else{
						// no  -> cart에 있는 정보를 가지고 주문페이지로 이동
						$("#orderInfo").submit();
					}

				}else if(data == "INSERT"){
					// 장바구니에 없으면 insert -> 주문페이지로 이동
					buyCartUpdate(formData);

				}else 
				if(data == "N_SESSION"){
					location.href = "/member/login";
				}
			}
		});


	});

	/* 장바구니 등록 및 수량 변경 처리 */
	function buyCartUpdate(formData){
		$.ajax({
			url : "/cart/cartUpdate",
			type : "post", 
			data : formData,
			success : function(data) {
				
				if(data == "SUCCESS"){
					$("#orderInfo").submit();
				}
			}
		});
	}
	
});

/* 
* 후기 리스트 템플릿 적용 함수 
* 후기를 DB에서 가져와서 뿌려주는 작업
*/
 var getPage = function(pageInfo) {

	$.getJSON(pageInfo, function(data) {

		printData(data.list, $("#repliesDiv"), $('#reviewTemplate'));
		printPaging(data.pageMaker, $(".pagination"));

		// 모달 창 숨기고 댓글 카운트
		$("#modifyModal").modal('hide');
		$("#replycntSmall").html("[ " + data.pageMaker.totalCount + " ]");

		if(data.list.length > 0){

		}else{
			$(".replyLi").remove();
			$(".noReview").show();
		}
	});
}


/*
* printData()
* : 상품후기 리스트를 보여주는 템플릿 적용
*/
var printData = function(replyArr, target, templateObject) {
	var template = Handlebars.compile(templateObject.html());

	var html = template(replyArr);
	$(".replyLi").remove();
	$(".noReview").hide();
	target.after(html);
}

/*
* printPaging()
* : 상품후기 리스트의 하단 페이지 부분 작업
*/
var printPaging = function(pageMaker, target) {

	var str = "";

	// 이전
	if (pageMaker.prev) {
		str += '<li class="page-item"><a class="page-link" href="' + (pageMaker.startPage - 1)
				+ '">&laquo;</a></li>';
	}
	// 페이지 인덱스
	for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
		var strClass = pageMaker.cri.page == i ? 'active' : '';
		str += '<li class="page-item ' + strClass + '"><a class="page-link" href="' + i + '">' + i + '</a></li>';
	}
	// 다음
	if (pageMaker.next) {
		str += '<li class="page-item"><a class="page-link" href="' + (pageMaker.endPage + 1)
				+ '">&raquo;</a></li>';
	}

	target.html(str);
};

/* 상품후기 삭제 버튼 클릭 시 */
var deleteReview = function(rew_num){

	var result = confirm("후기를 삭제하시겠습니까?");

	if(result){
		$.ajax({
			url: "/review/" + rew_num,
			type: "delete",
			dataType: "text",
			data:{"rew_num" : rew_num},
			success: function(data){

				if(data == "SUCCESS"){
					alert("상품후기가 삭제되었습니다.");
					var pro_num = $("#pro_num").val();
					getPage("/review/" + pro_num + "/" + replyPage);
				}
			}
		});
	}
	
}