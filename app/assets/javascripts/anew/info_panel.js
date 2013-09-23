
$(document).ready(function(){
    function infoPanel()
    {
        var infoTab = $('.info-tab');
        if (infoTab.length>0){
            var headerWidth = $('header').width();
            var contentContainerMarginLeft = parseInt($('.row.content-container').css('margin-left').replace('px',''));
            infoTab.css('left',headerWidth-$('.info-tab .tab').width()-contentContainerMarginLeft+'px');
            infoTab.on('click', function(e){
                var offset = $('header').width() - parseInt($('.row.content-container').css('margin-left').replace('px','')) - $('.info-tab .tab').width();
                var offsetByBrowser = 20;
                e.preventDefault();
                console.log('info-tab');
                var panel = $(this);
                panel.animate({
                    left: parseInt(panel.css('left'),10) == offset ? offset - $('.info-tab .tab-content').width() - offsetByBrowser : offset
                }, 0);
            });
        }
    } infoPanel();
    $(window).resize(function(){
       infoPanel();
    });
});

