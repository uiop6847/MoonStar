$(function(){

    var form = $("#orderInfo");

    /* 구매적립금 이벤트 */
    $("#use_point").on("change", function(){

        if($(this).val() > Number($("#user_point").val())){
            alert("사용가능 구매적립금보다 많습니다.\n구매적립금 사용금액을 다시 입력해 주세요.");
            $(this).val(0);

        }else if($(this).val() < 0){
            alert("구매적립금은 -가 될 수 없습니다.\n구매적립금 사용금액을 다시 입력해 주세요.");
            $(this).val(0);
        }else if($(this).val() <= 0){
            console.log($(this).val());
            $(this).val(0);
        }

        $("#total_discount_1").empty();
        $("#total_discount_1").text("- " + makeComma($(this).val())); // 총 할인금액
        $("#total_discount_2").empty();
        $("#total_discount_2").text("- " + makeComma($(this).val())); // 총 할인금액

        var result = $("#total_price").val() - $(this).val(); // 총 주문금액 - 총 할인금액
        $("#buy_total_price_2").empty();
        $("#buy_total_price_2").text(makeComma(result)); // 총 결제예정금액

        $("#pay_amount").val(result); // 총 결제예정금액
        $("#pay_price").empty();
        $("#pay_price").text(makeComma(result)); // 최종결제금액
    });

    /* 배송지선택 기본주소지 radio 선택 시 이벤트 */
    $("input[name=buy_addr]:eq(0)").on("click", function(){

        $("#ord_nm").val($("#def_nm").val());
        $("input[name=zip_num]").val($("#def_zip_num").val());
        $("input[name=addr]").val($("#def_addr").val());
        $("input[name=addr_dtl]").val($("#def_addr_dtl").val());
        $("input[name=tel_phone]").val($("#def_tel_phone").val());
        $("input[name=cell_phone]").val($("#def_cell_phone").val());
    });

    /* 배송지선택 새로입력 radio 선택 시 이벤트 */
    $("input[name=buy_addr]:eq(1)").on("click", function(){

        $("#ord_nm").val("");
        $("input[name=zip_num]").val("");
        $("input[name=addr]").val("");
        $("input[name=addr_dtl]").val("");
        $("input[name=tel_phone]").val("");
        $("input[name=cell_phone]").val("");
    });

    // 결제수단 radio 클릭 이벤트
    $("input[name=payment]").on("click", function(){
        
        // 관련 폼 display: none; 처리
        $("[id$='_section']").each(function(){
            $(this).addClass("selected");
        });
        
        // 선택한 radio는 display 되도록 처리
        if($(this).is(":checked")){
            $("#"+$(this).val()+"_section").removeClass("selected");
        }
    });

    /* 결제하기 버튼 클릭 시 */
    $("#btn_buy").on("click", function(){
        
        // 유효성 검사
        var ord_nm          = $("#ord_nm");
        var zip_num         = $("input[name=zip_num]");
        var addr            = $("input[name=addr]");
        var tel_phone       = $("input[name=tel_phone]");
        var cell_phone      = $("input[name=cell_phone]");
        var pay_nm          = $("#pay_nm");
        var chk_agreement   = $("#chk_agreement");

        var telPhoneCheck = RegExp(/^\d{2,3}-\d{3,4}-\d{4}$/);
        var cellPhoneCheck = RegExp(/^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/);

        var isOK = true;

        if(ord_nm.val() == null || ord_nm.val() == ""){
            alert("받으시는분을 입력해주세요.");
            ord_nm.focus();
            isOK = false;

        } else if(zip_num.val() == null || zip_num.val() == ""){
            alert("주소를 입력해주세요.");
            zip_num.focus();
            isOK = false;

        } else if(addr.val() == null || addr.val() == ""){
            alert("주소를 입력해주세요.");
            addr.focus();
            isOK = false;

        } else if(cell_phone.val() == null || cell_phone.val() == ""){
			alert("휴대전화를 입력해주세요.");
            cell_phone.focus();
            isOK = false;

		} else if(tel_phone.val()){
			if(!telPhoneCheck.test(tel_phone.val())){
				alert("일반전화를 올바르게 입력했는지 확인해주세요. ex) 02-0000-0000");
                tel_phone.focus();
                isOK = false;
			}
			
		} else if(!cellPhoneCheck.test(cell_phone.val())){
			alert("휴대전화를 올바르게 입력했는지 확인해주세요. ex) 010-0000-0000");
            cell_phone.focus();
            isOK = false;

		} else if($("input[name=payment]:checked").val() == "cash"){
            // 무통장입금
            if(pay_nm.val() == null || pay_nm.val() == ""){
                alert("입금자명을 입력해주세요.");
                pay_nm.focus();
                isOK = false;
            }
            
		} else if(!chk_agreement.prop("checked")){
			alert("결제정보 확인 및 구매진행에 동의하셔야 주문이 가능합니다.");
            chk_agreement.focus();
            isOK = false;

        }
        
        // 유효성검사 정상이면 submit처리
        if(isOK == true){
            form.submit();
        }
        
    });

    // 금액 ,(콤마) 정규식
	function makeComma(str) {

		str = String(str);
	   
		return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	   
    }

});