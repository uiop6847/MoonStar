$(function(){

    var form = $("#cartForm");

    /* 수량 변경버튼 클릭 시 */
    $("button[id$='count_update']").on("click", function(){

        var td = $(this).parent();

        var cart_cd = td.siblings(":first").children("input[id$=cart_cd]").val();
        var buy_count = td.find("input[id$=buy_count]").val();

        $.ajax({
			url : "/cart/buyCountUpdate",
			type : "post", 
			data : {
                cart_cd : cart_cd,
                buy_count : buy_count
            },
			success : function(data) {

				if(data == "SUCCESS"){
                    var discount_price = td.siblings("td").children("input[id$=discount_price]");
                    var pro_total_price = td.siblings("td").children("input[id$=pro_total_price]");
                    var total = discount_price.val() * buy_count;

                    pro_total_price.val(total);
                    total = makeComma(total);

                    pro_total_price.prev().empty();
                    pro_total_price.prev().append(total);

                    // 상품구매금액합계, 결제예정금액 reflash
                    priceReFlash();
                }
			}
        });
        
    });

    /* table 행의 삭제 버튼 클릭 시 */
    $("button[id$='btn_delete']").on("click", function(){

        var result = confirm("선택하신 상품을 삭제하시겠습니까?");
        
        if(result){
            var td = $(this).parent();

            var cartCdArr = [];
            var cart_cd = td.siblings(":first").children("input[id$=cart_cd]").val();

            cartCdArr.push(cart_cd);

            cartDelete(cartCdArr);
        }

    });

    /* 선택상품 삭제 버튼 클릭 시 */
    $("#btn_check_delete").on("click", function(){

        if($(":checkbox:not(:first):checked").length == 0){
			alert("선택된 상품이 없습니다.");
			return false;
		}

        var result = confirm("선택하신 상품을 삭제하시겠습니까?");
        
        if(result){

            var cartCdArr = [];
            var cart_cd = "";

            $("#tbl_cartListRow tr:not(:last)").each(function(i){

                if($(this).find(":checkbox").is(":checked")){
                    cart_cd = $(this).find("input[id='list["+i+"].cart_cd']").val();
                    cartCdArr.push(cart_cd);
                }
            });

            cartDelete(cartCdArr);
        }

    });

    /* 장바구니 비우기 버튼 클릭 시 */
    $("#btn_all_delete").on("click", function(){

        var result = confirm("장바구니를 비우시겠습니까?");
        
        if(result){
            var cartCdArr = [];
            var cart_cd = "";

            $("#tbl_cartListRow tr:not(:last)").each(function(i){

                cart_cd = $(this).find("input[id='list["+i+"].cart_cd']").val();
                cartCdArr.push(cart_cd);
            });
            
            cartDelete(cartCdArr);
        }

    });

    // 장바구니 삭제 ajax 함수
    function cartDelete(cartCd){
        $.ajax({
            url : "/cart/cartDelete",
            type : "post",
            data : { cartCdArr : cartCd},
            dataType : "text",
            success : function(data) {

                if(data == "SUCCESS"){
                    location.href = "/cart/list";
                }
            }
        });
    }

    /* table 행의 주문하기 버튼 클릭 시 */
    $("button[id$=btn_buy").on("click", function(){

        // 클릭한 행의 내용만 submit되도록 한다.
        var tr = $(this).parents("tr");

        var proCount = $("input[name='pro_count']:eq("+tr.index()+")").val();
        // 품절된 상품인지 check
        if(!proCountCheck(proCount)){ return false; }

        form.find("input[id$=cart_cd]").each(function(index, item){
            // 클릭한 행의 name명만 list로 변경
            if(index == tr.index()){
                $(item).attr("name", "list["+index+"].cart_cd");
            }else{
                $(item).attr("name", "cart_cd");
            }
        });
        
        form.attr("action", "/order/orderForm?cartType=A");
        form.submit();
    });

    /* 전체상품주문 버튼 클릭 시 */
    $("#btn_all_buy").on("click", function(){

        var isOK = true;
        $(":checkbox:not(:first)").each(function(i){

            var proCount = $("input[name='pro_count']:eq("+i+")").val();
            // 품절된 상품인지 check
            if(!proCountCheck(proCount)){ isOK = false; }

        });
        
        if(isOK == false){ return false; }

        form.find("input[id$=cart_cd]").each(function(index, item){
            // 전체 행의 name명 변경
            $(item).attr("name", "list["+index+"].cart_cd");
        });

        form.attr("action", "/order/orderForm?cartType=All");
        form.submit();
    });

    /* 선택상품주문 버튼 클릭 시 */
    $("#btn_check_buy").on("click", function(){

        if($(":checkbox:not(:first):checked").length == 0){
			alert("선택된 상품이 없습니다.");
			return false;
        }

        var isOK = true;
        $(":checkbox:not(:first):checked").each(function(i){
        
            var proCount = $("input[name='pro_count']:eq("+i+")").val();
            // 품절된 상품인지 check
            if(!proCountCheck(proCount)){ isOK = false; }

        });
        
        if(isOK == false){  return false; }

        form.find("input[id$=cart_cd]").each(function(index, item){

            // check된 행의 name명 변경
            if($(":checkbox:not(:first)").eq(index).prop("checked")){
                $(item).attr("name", "list["+index+"].cart_cd");
            }else{
                $(item).attr("name", "cart_cd");
            }
        });

        form.attr("action", "/order/orderForm?cartType=All");
        form.submit();
    });
    

    // 금액 ,(콤마) 정규식
	function makeComma(str) {

		str = String(str);
	   
		return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	   
    }
    
    // 상품구매금액합계, 결제예정금액 reflash
    function priceReFlash(){

        var price = 0;
        var result = 0;
        $("#tbl_cartListRow tr:not(:last)").each(function(i){
            
            price = $("input[id='list["+i+"].pro_total_price']").val();
            
            result = result + parseInt(price);
        });
        
        result = makeComma(result);

        //상품구매금액 price + 배송비 0(무료) = 합계 : price
        $("#buy_price_1").empty();
        $("#buy_price_1").text(result);
        
        $("#buy_total_price_1").empty();
        $("#buy_total_price_1").text(result);
        
        // 총 상품금액, 결제예정금액
        $("#buy_price_2").empty();
        $("#buy_price_2").text(result);
        
        $("#buy_total_price_2").empty();
        $("#buy_total_price_2").text(result);
    }

    // 품절된 상품인지 확인하는 함수
    function proCountCheck(value){

        if(value <= 0){
            alert("품절된 상품은 주문이 불가합니다.");
            return false;
        }
    }

});