$(document).ready(function(){
    $(".text-wrapper").hover(function(){
        // console.log("image clicked")
        // Change src attribute of image
        $(".selected-image").attr("src", "images/cow_sofa/cow_sofa_YOLOV3.jpeg");
        console.log("change color");
        $(".text-wrapper").attr("color", "blue");
    }, function(){
        $(".selected-image").attr("src", "images/cow_sofa/cow_sofa.jpeg");
        $(".text-wrapper").attr("color", "black");
    });     
});