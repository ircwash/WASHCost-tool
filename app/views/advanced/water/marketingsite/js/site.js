$(function(){

	$('#placeholder-image').click(function(){
    	var video = '<iframe src="https://player.vimeo.com/video/73270180?autoplay=true" width="800" height="451" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>';
   		$(this).replaceWith(video);
	});
	
});