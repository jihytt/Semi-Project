<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charser=UTF-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펫 다이어리 챗봇</title>
<style type="text/css">

	*{ margin: 0; padding: 0; }
	 
	.chat_wrap .header { position:fixed; width:100%; font-size: 17px; font-weight: 500; padding: 15px 0; background: salmon; color: white; text-align: center; } 
	.chat_wrap .chat { padding-top:60px; padding-bottom: 80px; }
	.chat_wrap .chat ul { width: 100%; list-style: none; }
	.chat_wrap .chat ul li { width: 100%; }
	.chat_wrap .chat ul li.left { text-align: left; }
	.chat_wrap .chat ul li.right { text-align: right; }
	.chat_wrap .chat ul li > div { font-size: 13px; }
	.chat_wrap .chat ul li > div.sender { margin: 10px 20px 0 20px; font-weight: bold; }
	.chat_wrap .chat ul li > div.message { display: inline-block; word-break:break-all; margin: 5px 20px; max-width: 75%; border: 1px solid #888; padding: 10px; border-radius: 5px; background-color: #FCFCFC; color: #555; text-align: left; }
	 
	.chat_wrap .input { position: fixed; bottom: 0; width: 100%; background-color: #FFF; text-align: center; border-top: 1px solid salmon; }
	.chat_wrap .input > textarea { width: 100%; height: 60px; border: none; padding: 10px; }
	 
	.form { display: none; }


</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	var Chat = (function(){
	    var userName = " ";
	 
	    function init() {

	        $(document).on('keydown', 'div.input textarea', function(e){
	            if(e.keyCode == 13 && !e.shiftKey) {
	                e.preventDefault();
	                var message = $(this).val();
	 
	                sendMessage(message);

	                clearTextarea();
	            }
	        });
	    }
	 
	    function createMessageTag(LR_className, senderName, message) {

	        var chatLi = $('div.chat.form ul li').clone();
	 
	        chatLi.addClass(LR_className);
	        chatLi.find('.sender span').text(senderName);
	        chatLi.find('.message span').text(message);
	 
	        return chatLi;
	    }
	 
	    function sendMessage(message) {
	        var data = {
	            "senderName"    : " ",
	            "message"       : message
	        };
	        
	        request(data);
	        
	        $.ajax({
	        	type:"POST",
	        	url: "../chatbot.do?command=dialog&message="+encodeURIComponent(message),
	        	dataType: "json",
	        	success : function(data){
	        		if (data.message!="감사합니다. 대화를 종료합니다."){
	        			response(data);
	        		} else {
	        			response(data);
	        			setTimeout(function() {
	        				window.close();
	        			}, 800);
	        		}
	        	}
	        	,
	        	error : function(){
	        		alert("error");
	        	}
	        
	        }); 
	    }
	    
	    function request(data) {
	      	var LR = (data.senderName != userName)? "left" : "right";
	        appendMessageTag("right", data.senderName, data.message);
	        $('div.chat').scrollTop($('div.chat')[0].scrollHeight);
	    }
		
		function response(data) {
			var LR = (data.senderName != userName)? "left" : "right";
			appendMessageTag("left", data.senderName, data.message);
		}
		
	    function appendMessageTag(LR_className, senderName, message) {
	        var chatLi = createMessageTag(LR_className, senderName, message);
	        $('div.chat:not(.form) ul').append(chatLi);
	        
	        $("html, body").animate({ scrollTop: $(document).height() }, 500);
	    }
	 
	 
	    function clearTextarea() {
	        $('div.input textarea').val('');
	    }
	 
	    return {
	        'init': init
	    };
	})();
	 
	$(function(){
	    Chat.init();
	});

</script>
</head>
<body>

	<div class="chat_wrap">
		<div class="header">
			펫 다이어리 CHATBOT
		</div>
		 <div class="chat">
        <ul>
        	<li>
        		<div class="message"><span>안녕하세요. 도움이 필요하신가요? 반려 동물이 먹는 음식과 관련된 질의응답과 연계 병원/가게 예약 시스템을 제공하고 있어요 !</span></div>
	       </li>
	       <!-- 동적 생성 -->
        </ul>
    </div>
    <div class="input">
        <textarea placeholder="메세지 입력 후 엔터를 눌러주세요." style="resize: none;"></textarea>
    </div>
 	<br/>
 	<br/>
    <div class="chat form">
        <ul>
            <li>
                <div class="sender">
                    <span></span>
                </div>
                <div class="message">
                    <span></span>
                </div>
            </li>
        </ul>
    </div>
	</div>

</body>
</html>