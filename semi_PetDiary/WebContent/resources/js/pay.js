function requestPay(book_num) {

    var IMP = window.IMP; // 생략가능
    IMP.init('iamport');  // 가맹점 식별 코드
    var url = "../pet_servlet";
    $.ajax({
        url : url + "?command=memberInfo" ,
        type : "POST",
        dataType : "json",
        success : function (data) {
            $.each(data, function (key, value) {
                IMP.request_pay({
                    pg: 'html5_inicis', // 결제방식
                    pay_method: 'card',	// 결제 수단
                    merchant_uid: 'merchant_' + new Date().getTime(),
                    name: '예약금',	// order 테이블에 들어갈 주문명 혹은 주문 번호
                    amount: '10',	// 결제 금액
                    buyer_email: value.member_email,	// 구매자 email
                    buyer_name: value.member_name,	// 구매자 이름
                    buyer_tel: value.member_phone,	// 구매자 전화번호
                    buyer_addr: value.member_address,	// 구매자 주소
                    buyer_postcode: '',	// 구매자 우편번호
                    m_redirect_url: ''	// 결제 완료 후 보낼 컨트롤러의 메소드명
                }, function (rsp) {
                    if (rsp.success) { // 성공시
                        var msg = '결제가 완료되었습니다.';
                        msg += '고유ID : ' + rsp.imp_uid;
                        msg += '상점 거래ID : ' + rsp.merchant_uid;
                        msg += '결제 금액 : ' + rsp.paid_amount;
                        msg += '카드 승인번호 : ' + rsp.apply_num;
                        var order_info = {book_num : String(book_num), merchant_uid : rsp.merchant_uid, order_name : value.member_name, order_amount : rsp.paid_amount, order_info : "예약금"};
                        $.ajax({
                            url : url + "?command=orderSuccess",
                            type: "POST",
                            data : {order_data : JSON.stringify(order_info)},

                            error: function (request, status, error) {
                                console.log("code:" + request.status + "<br>" + "message:" + request.responseText + "<br>" + "error:" + error);
                            }
                        })
                    } else { // 실패시
                        var msg = '결제에 실패하였습니다.';
                        msg += '에러내용 : ' + rsp.error_msg;
                    }
                })
            });

        },
        error: function (request, status, error) {
            console.log("code:" + request.status + "<br>" + "message:" + request.responseText + "<br>" + "error:" + error)
        }
    })

}