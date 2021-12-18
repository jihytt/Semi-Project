<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Title</title>
    <style type="text/css">
        #webcam {
            position: center;
            border-collapse: collapse;
            margin: 25px 25%;
            font-size: 0.9em;
            font-family: sans-serif;
            width: 400px;
            height: 550px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.55);
            border-radius: 6px;
        }

        .startWebcam {
            position: absolute;
            margin-left: 50%;
            background-color: wheat;
            padding: 3px 5px;
            border-radius: 4px;
            cursor:pointer;
            font-size: 13px;
        }
        canvas { border-radius: 4px 4px 0 0; }
        #label-container span { font-size: 15pt; letter-spacing: 3px; }

        .graph1 { display: block; padding: 0 10px; text-align: center; background-color: skyblue; border-radius: 40px; box-sizing: border-box; color: #fff;}
        .graph2 {display: block; padding: 0 10px; text-align: center; background-color: violet; border-radius: 40px; box-sizing: border-box; color: #fff;}
        .graph3 {display: block; padding: 0 10px; text-align: center; background-color: sandybrown; border-radius: 40px; box-sizing: border-box; color: #fff;}

    </style>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        // More API functions here:
        // https://github.com/googlecreativelab/teachablemachine-community/tree/master/libraries/image

        // the link to your model provided by Teachable Machine export panel
        const URL = "../my_model/";

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
            webcam = new tmImage.Webcam(400, 400, flip); // width, height, flip
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
            $(".graph1").css({width : prediction[0].probability.toFixed(2) * 100 + '%', height : "10px"});
            //$(".graph1").text(prediction[0].probability.toFixed(2) * 100 + '%');
            $(".cat").text(prediction[1].className);
            $(".graph2").css({width : prediction[1].probability.toFixed(2) * 100 + '%', height : "10px"});
           // $(".graph2").text(prediction[1].probability.toFixed(2) * 100 + '%');
            $(".dinosaur").text(prediction[2].className);
            $(".graph3").css({width : prediction[2].probability.toFixed(2) * 100 + '%', height : "10px"});
           // $(".graph3").text(prediction[2].probability.toFixed(2) * 100 + '%');
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@1.3.1/dist/tf.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@teachablemachine/image@0.8/dist/teachablemachine-image.min.js"></script>
</head>
<body>
<div id="webcam">
    <div id="webcam-container"></div>
    <hr>
    <div id="label-container">
        <div class="species_info">
            <span class="dog"></span>
            <span class="graph1" style=""></span>
        </div>
        <div class="species_info">
            <span class="cat"></span>
            <span class="graph2" style=""></span>
        </div>
        <div class="species_info">
            <span class="dinosaur"></span>
            <span class="graph3 " style=""></span>
        </div>
    </div>
</div>
<div>
    <button type="button" class="startWebcam" onclick="init()">찾기</button>
</div>
</body>
</html>