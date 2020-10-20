$(document).ready(function(){
    var tbl = $("#tbl_product");
     
    // 테이블 헤더에 있는 checkbox 클릭시
    $(":checkbox:first", tbl).click(function(){
        // 클릭한 체크박스가 체크상태인지 체크해제상태인지 판단
        if( $(this).is(":checked") ){
            $(":checkbox", tbl).attr("checked", "checked");
        }
        else{
            $(":checkbox", tbl).removeAttr("checked");
        }

        // 모든 체크박스에 change 이벤트 발생시키기               
        $(":checkbox", tbl).trigger("change");
    });
     
    // 헤더에 있는 체크박스외 다른 체크박스 클릭시
    $(":checkbox:not(:first)", tbl).click(function(){
        var allCnt = $(":checkbox:not(:first)", tbl).length;
        var checkedCnt = $(":checkbox:not(:first)", tbl).filter(":checked").length;
         
        // 전체 체크박스 갯수와 현재 체크된 체크박스 갯수를 비교해서 헤더에 있는 체크박스 체크할지 말지 판단
        if( allCnt==checkedCnt ){
            $(":checkbox:first", tbl).attr("checked", "checked");
        }
        else{
            $(":checkbox:first", tbl).removeAttr("checked");
        }
    }).change(function(){
        if( $(this).is(":checked") ){
            // 체크박스의 부모 > 부모 니까 tr 이 되고 tr 에 selected 라는 class 를 추가한다.
            $(this).parent().parent().addClass("checkSelected");
        }
        else{
            $(this).parent().parent().removeClass("checkSelected");
        }
    });
});