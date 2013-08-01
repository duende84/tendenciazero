$(document).ready(function() {
    var i = 0,
    settings = [
    {
        duration: 1200,   
        easing: 'easeOutBounce'
    },
    {
        duration: 1600, 
        easing: 'easeOutElastic'
    },
    {
        duration: 600, 
        easing: 'easeOutQuad'
    },
    {
        duration: 1000, 
        easing: 'easeOutBack'
    }
    ];
    
    var interval;
    $('#myRoundabout').roundabout({                    
        shape: 'tearDrop', //'square', // 'tearDrop',
        minScale: 0.5,//0.93,
        maxScale: 1.03, //1,
        easing:'easeOutBack',//'easeOutQuad',//'easeOutExpo', //'easeOutBounce', //'swing',
        clickToFocus:'true',
        focusBearing:'0',
        duration:1000,
        reflect:true //true = giro izq false = giro der
    })
    .hover(function() {                   
        clearInterval(interval);
    },
    function() {                    
        interval = startAutoPlay();
    }
    );            
    interval = startAutoPlay();
});
		
function startAutoPlay() {
    return setInterval(function() {
        $('#myRoundabout').roundabout_animateToNextChild();
    }, 3000);
}

//$(document).ready(function() {    
//    $('li').bind({
//        "reposition": function() {
//            alert("duende")
//            var degrees = $(this).data('roundabout').degrees,
//            roundaboutBearing = $(this).parent().data('roundabout').bearing,
//            rotateY = Math.round(roundaboutBearing - degrees);
//							
//            $(this).css({
//                "-webkit-transform": "perspective(2000) rotateY(" + rotateY + "deg)",
//                "-moz-transform": "perspective(2000) rotateY(" + rotateY + "deg)",
//                "transform": "perspective(2000) rotateY(" + rotateY + "deg)"
//            });
//        }
//    })
//				
//    $('#myRoundabout').roundabout({
//        minScale: 0.7,
//        easing: 'easeOutElastic',
//        duration: 1600
//    });
//});