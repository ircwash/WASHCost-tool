
// $(document).ready(function(){
//     function infoPanel()
//     {
//         var infoTab = $('.info-tab');
//         if (infoTab.length>0){
//             var headerWidth = $('header').width();
//             var contentContainerMarginLeft = parseInt($('.row.content-container').css('margin-left').replace('px',''));
//             infoTab.css('left',headerWidth-$('.info-tab .tab').width()-contentContainerMarginLeft+'px');
//             infoTab.on('click', function(e){
//                 var offset = $('header').width() - parseInt($('.row.content-container').css('margin-left').replace('px','')) - $('.info-tab .tab').width();
//                 var offsetByBrowser = 20;
//                 var tabContent = $('.info-tab .tab-content');
//                 var tab = $('.info-tab .tab');
//                 var left = 0;
//                 var tabContentWidth = parseInt(tabContent.css('width').replace('px',''));
//                 e.preventDefault();
//                 console.log('info-tab');
//                 var panel = $(this);
//                 if(parseInt(panel.css('left'),10) == offset){
//                     left = offset - tabContent.width() - offsetByBrowser;
//                     panel.width(tab.width() + tabContentWidth);
//                     tabContent.css('display','inherit');
//                 }else{
//                     panel.width(panel.width() - tabContentWidth)
//                     tabContent.css('display','none');
//                     left = offset;
//                 }
//                 panel.animate({
//                     left: left
//                 }, 0);
//             });
//         }
//     } infoPanel();
//     $(window).resize(function(){
//        infoPanel();
//     });
// });

