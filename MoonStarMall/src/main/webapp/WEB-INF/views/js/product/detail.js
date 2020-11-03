$(function(){

	
	/* 상품 후기 클릭 시 */
	$("#product-review-tab").one("click", function(){

		var pro_num = $("#pro_num").val();
		getPage("/review/" + pro_num + "/1");

	});

	/* 
	* 후기 리스트 템플릿 적용 함수 
	* 후기를 DB에서 가져와서 뿌려주는 작업
	*/
	function getPage(pageInfo) {

		$.getJSON(pageInfo, function(data) {
			
			console.log(data);

			printData(data.list, $("#repliesDiv"), $('#reviewTemplate'));
			printPaging(data.pageMaker, $(".pagination"));

			// 모달 창 숨기고 댓글 카운트
			//$("#modifyModal").modal('hide');
			//$("#replycntSmall").html("[ " + data.pageMaker.totalCount + " ]");

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
			str += "<li><a href='" + (pageMaker.startPage - 1)
					+ "'> << </a></li>";
		}
		// 페이지 인덱스
		for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
			var strClass = pageMaker.cri.page == i ? 'class=active' : '';
			str += "<li "+strClass+"><a href='"+i+"'>" + i + "</a></li>";
		}
		// 다음
		if (pageMaker.next) {
			str += "<li><a href='" + (pageMaker.endPage + 1)
					+ "'> >> </a></li>";
		}

		target.html(str);
	};
	
});