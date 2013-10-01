$(document).ready(function(){
    var navBasicContainer = $('.nav-basic-container');
    if(navBasicContainer.length>0){
        var navItem = navBasicContainer.find('.navigation-basic-tool li').first();
        var navigationBasicTool = navBasicContainer.find('.navigation-basic-tool');
        var navigationBasicToolUL = navBasicContainer.find('.navigation-basic-tool ul');
        //console.log('Index: ' + $('.navigation-basic-tool ul li').index($('li.active')));// another way
        var width = navBasicContainer.width();
        var item_width = navItem.width();
        var activeItemIndex = $('.navigation-basic-tool li.active').index()/2 + 1;
        var numberItemsLimit = Math.floor(width/item_width)
        // taking into account that there are li elements that are not elements if not divisors, for this reason the
        // length is divided into 2
        var totalNumberItems = navBasicContainer.find('.navigation-basic-tool li').length/2
        var navigationBasicToolLenght = item_width * numberItemsLimit;
        // --> Aplying the new width
        navigationBasicTool.width(navigationBasicToolLenght);
        // --> Aplying the offset
        // - Check if the number of items constraint exists in header navigation
        var numberOfItemsBySection = parseInt($('.nav-basic-container .headernav-basic-tool ul').data('number-of-items'));
        var offsetInNumber;
        if(numberOfItemsBySection > 0){
            if(numberOfItemsBySection >= numberItemsLimit){
                offsetInNumber = activeItemIndex - 1;
            }else{
                offsetInNumber = activeItemIndex + numberOfItemsBySection - numberItemsLimit - 1;
            }
        }else{
            offsetInNumber = activeItemIndex - numberItemsLimit + 1;
        }
        if (offsetInNumber > 0){
            if (totalNumberItems == activeItemIndex) offsetInNumber=offsetInNumber-1;
            var offset = offsetInNumber * item_width;
            navigationBasicToolUL.css('left','-'+offset+'px');
        }
    }
});
