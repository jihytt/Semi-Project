<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Title</title>
    <style type="text/css">

        *{ margin: 0; padding: 0; }
        #webcamWrap { width: 100%; text-align: center;}
        #webCam {margin-top: 10%;display: inline-block;text-align: center;font-size: 0.9em;font-family: sans-serif;width: 500px;height: 550px;box-shadow: 0 0 20px rgba(0, 0, 0, 0.55);border-radius: 6px;}
        .startWebcam {margin-top: 10px;background-color: salmon;padding: 3px 5px;border-radius: 4px;cursor:pointer;font-size: 13px;color: white;border: none;}
        canvas { border-radius: 4px 4px 0 0; }
        .btnWrap{position: relative;}
        .webBtn, .imgBtn { border: none; background-color: salmon; color: white}
        .findBtnWrap { text-align: center;}
        .div_common { float: left; }
        .graphWrap {overflow: auto; background-color: gainsboro; border-radius: 4px; }
        .species_info {height: 30px; margin-top: 15px; padding-right: 15px; vertical-align:middle;}
        .dog, .cat, .dinosaur { width: 60px; font-size: 10pt;}
        .graph1 { box-sizing: border-box; background-color: skyblue; border-radius: 4px; color: #fff;}
        .graph2 { box-sizing: border-box; background-color: violet; border-radius: 4px;color: #fff;}
        .graph3 { box-sizing: border-box; background-color: sandybrown; border-radius: 4px;  color: #fff;}
        .webHeader { position:fixed; width:100%; font-size: 17px; font-weight: 500; padding: 15px 0; background: salmon; color: white; text-align: center; }
        body {font-family: sans-serif;background-color: #eeeeee;}
        .file-upload { background-color: #ffffff; width: 500px; margin: 0 auto; padding: 10px}
        .file-upload-btn {width: 100%;margin: 0;color: #ffffff;background: salmon;border: none;padding: 10px;border-radius: 4px;border-bottom: 4px solid ;transition: all .2s ease;
            outline: none;text-transform: uppercase;font-weight: 700;cursor:pointer;}
        .file-upload-btn:active {border: 0;transition: all .2s ease;}
        .file-upload-content {display: none;text-align: center;}
        .file-upload-input {position: absolute;margin: 0;padding: 0;width: 100%;height: 100%;outline: none;opacity: 0;cursor: pointer;}
        .image-upload-wrap {margin-top: 20px;border: 4px outset salmon;position: relative;}
        .image-dropping, .image-upload-wrap:hover {background-color: #d5e5fe;border: 4px solid #d5e5fe;}
        .image-title-wrap {padding: 0 15px 15px 15px;color: white;}
        .drag-text {text-align: center;}
        .drag-text:hover{color:white;}
        .drag-text h3 {font-weight: 100;text-transform: uppercase;color: salmon;padding: 60px 0;}
        .file-upload-image {max-height: 200px;max-width: 200px;margin: auto;padding: 20px;}
        .remove-image {width: 200px;margin: 0;color: #fff;background: #cd4535;border: none;padding: 10px;border-radius: 4px;border-bottom: 4px solid #b02818;transition: all .2s ease;outline: none;text-transform: uppercase;font-weight: 700;}
        .remove-image:hover {background: #c13b2a;color: #ffffff;transition: all .2s ease;cursor: pointer;}
        .remove-image:active {border: 0;transition: all .2s ease;}
        .teachable_text{margin-top: 10%;text-align: center; }
        .startUpload{margin:5px 3px 5px 205px; border:none; background-color: wheat;padding: 3px 5px;border-radius: 4px;cursor:pointer;font-size: 13px;}
        .predictUpload{margin:5px 3px 5px auto; border:none; background-color: salmon;padding: 3px 5px;cursor:pointer;border-radius: 4px;font-size:13px;}
    </style>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@1.3.1/dist/tf.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@teachablemachine/image@0.8/dist/teachablemachine-image.min.js"></script>
    <script class="jsbin" src="https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script type="text/javascript">

        const URL = "https://teachablemachine.withgoogle.com/models/lRmi_M1M1/";

        let model, webcam, labelContainer, maxPredictions;
        let graph1, graph2, graph3;

        // Load the image model and setup the webcam
        async function init() {
            const modelURL = URL + "model.json";
            const metadataURL = URL + "metadata.json";

            // load the model and metadata
            // Refer to tmImage.loadFromFiles() in the API to support files from a file picker
            // or files from your local hard drive
            // Note: the pose library adds "tmImage" object to your window (window.tmImage)
            model = await tmImage.load(modelURL, metadataURL);
            maxPredictions = model.getTotalClasses();

            // Convenience function to setup a webcam
            const flip = true; // whether to flip the webcam
            webcam = new tmImage.Webcam(500, 400, flip); // width, height, flip
            await webcam.setup(); // request access to the webcam
            await webcam.play();
            window.requestAnimationFrame(loop);

            // append elements to the DOM
            if (document.getElementById("webcam-container").hasChildNodes()) {
                document.getElementById("webcam-container").removeChild(document.getElementById("webcam-container").childNodes[0]);
            }
            document.getElementById("webcam-container").appendChild(webcam.canvas);
        }

        async function loop() {
            webcam.update(); // update the webcam frame
            await predict();
            window.requestAnimationFrame(loop);
        }
        // run the webcam image through the image model
        async function predict() {
            // predict can take in an image, video or canvas html element
            const prediction = await model.predict(webcam.canvas);
            $(".dog").text(prediction[0].className);
            $(".graph1").css({width : prediction[0].probability.toFixed(2) * 100 + '%', height : "30px"});
            //$(".graph1").text(prediction[0].probability.toFixed(2) * 100 + '%');
            $(".cat").text(prediction[1].className);
            $(".graph2").css({width : prediction[1].probability.toFixed(2) * 100 + '%', height : "30px"});
           // $(".graph2").text(prediction[1].probability.toFixed(2) * 100 + '%');
            $(".dinosaur").text(prediction[2].className);
            $(".graph3").css({width : prediction[2].probability.toFixed(2) * 100 + '%', height : "30px"});
           // $(".graph3").text(prediction[2].probability.toFixed(2) * 100 + '%');
        }

        async
        async function initUpload() {
            const modelURL = URL + "model.json";
            const metadataURL = URL + "metadata.json";

            model = await
                tmImage.load(modelURL, metadataURL);
            maxPredictions = model.getTotalClasses();


            labelContainer = document.getElementById("label-container");
            for (let i = 0; i < maxPredictions; i++) { // and class labels
                labelContainer.appendChild(document.createElement("div"));
            }
        }
        // 사진 예측(업로드용)
        async function predictUpload() {
            // predict can take in an image, video or canvas html element
            var image = document.getElementById("face-image");
            const prediction = await model.predict(image, false);
            $(".dog").text(prediction[0].className);
            $(".graph1").css({width : prediction[0].probability.toFixed(2) * 100 + '%', height : "30px"});
            //$(".graph1").text(prediction[0].probability.toFixed(2) * 100 + '%');
            $(".cat").text(prediction[1].className);
            $(".graph2").css({width : prediction[1].probability.toFixed(2) * 100 + '%', height : "30px"});
            // $(".graph2").text(prediction[1].probability.toFixed(2) * 100 + '%');
            $(".dinosaur").text(prediction[2].className);
            $(".graph3").css({width : prediction[2].probability.toFixed(2) * 100 + '%', height : "30px"});
        }
        function readURL(input) {
            if (input.files && input.files[0]) {

                var reader = new FileReader();
                reader.onload = function(e) {
                    $('.image-upload-wrap').hide();
                    $('.file-upload-image').attr('src', e.target.result);
                    $('.file-upload-content').show();
                    $('.image-title').html(input.files[0].name);
                };
                reader.readAsDataURL(input.files[0]);
            } else {
                removeUpload();
            }
        }
        function removeUpload() {
            $('.file-upload-input').replaceWith($('.file-upload-input').clone());
            $('.file-upload-content').hide();
            $('.image-upload-wrap').show();
        }
        $('.image-upload-wrap').bind('dragover', function () {
            $('.image-upload-wrap').addClass('image-dropping');
        });
        $('.image-upload-wrap').bind('dragleave', function () {
            $('.image-upload-wrap').removeClass('image-dropping');
        });
    </script>
    <script type="text/javascript">
        $(function () {
            $(".imgBtn").click(function () {
                $(".findBtnWrap").hide();
                $("#webCam").hide();
                $("#imgWrap").show();
            });

            $(".webBtn").click(function () {
                $(".findBtnWrap").show();
                $("#webCam").show();
                $("#imgWrap").hide();
            });
        });
    </script>
</head>
<body>
<div class="header_wrap">
    <div class="webHeader">
        나와 닮은 동물 찾기
    </div>
</div>
<div class="btnWrap">
    <div><button type="button" class="webBtn">웹캠</button></div>
    <div><button type="button" class="imgBtn">이미지</button></div>
</div>
<div id="webcamWrap">
    <div id="webCam">
        <div id="webcam-container"></div>
        <div>
            <div class="species_info">
                <div class="dog div_common"></div>
                <div class="graphWrap">
                    <div class="graph1 div_common" style=""></div>
                </div>
            </div>
            <div class="species_info">
                <div class="cat div_common"></div>
                <div class="graphWrap">
                    <div class="graph2 div_common" style=""></div>
                </div>
            </div>
            <div class="species_info">
                <div class="dinosaur div_common"></div>
                <div class="graphWrap">
                    <div class="graph3 div_common" style=""></div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="findBtnWrap">
    <button type="button" class="startWebcam" onclick="init()">찾기</button>
</div>


<div id="imgWrap"  style="display: none">
    <div class="teachable_text">닮은 동물 찾기<br>
        <p>Start 클릭 -> 사진 업로드 -> Predict</p>
    </div>
    <div class="teachable_button">
        <button type="button" class="startUpload" onclick="initUpload();">Start(사진업로드용)</button>
        <button type="button" class="predictUpload" onclick="predictUpload();">Predict(사진업로드용)</button>
    </div>

    <div class="file-upload">
        <button class="file-upload-btn" type="button" onclick="$('.file-upload-input').trigger( 'click' )">사진 업로드</button>
        <div class="image-upload-wrap">
            <input class="file-upload-input" type='file' onchange="readURL(this);" accept="image/*" />
            <div class="drag-text">
                <h3>DRAG AND DROP</h3>
            </div>
        </div>
        <div class="file-upload-content">
            <img class="file-upload-image" id="face-image" src="#" alt="your image" />
            <div class="image-title-wrap">
                <button type="button" onclick="removeUpload()" class="remove-image">
                    파일 지우기 - <span class="image-title">Uploaded Image</span>
                </button>
            </div>
        </div>
        <div id="label-container">
            <div class="species_info">
                <div class="dog div_common"></div>
                <div class="graphWrap">
                    <div class="graph1 div_common" style=""></div>
                </div>
            </div>
            <div class="species_info">
                <div class="cat div_common"></div>
                <div class="graphWrap">
                    <div class="graph2 div_common" style=""></div>
                </div>
            </div>
            <div class="species_info">
                <div class="dinosaur div_common"></div>
                <div class="graphWrap">
                    <div class="graph3 div_common" style=""></div>
                </div>
            </div>
        </div>
    </div>

</div>
</body>
</html>