$(document).ready(function(){
    var navBasicContainer = $('.nav-basic-container');
    if(navBasicContainer.length>0){
        var navItem = navBasicContainer.find('.navigation-basic-tool li').first();
        var navigationBasicTool = navBasicContainer.find('.navigation-basic-tool');
        var navigationBasicToolUL = navBasicContainer.find('.navigation-basic-tool ul');
        //console.log('Index: ' + $('.navigation-basic-tool ul li').index($('li.active')));// another way

        var width = navBasicContainer.width();
        var item_width = navItem.width();
        var activeItemIndex = $(".navigation-basic-tool li.active").index()/2 + 1;
        var numberItemsLimit = Math.floor(width/item_width)
        var totalNumberItems = navBasicContainer.find('.navigation-basic-tool li').length/2
        var navigationBasicToolLenght = item_width * numberItemsLimit;
        //Aplying the new width
        navigationBasicTool.width(navigationBasicToolLenght);
        //Aplying the offset
        var offsetInNumber = activeItemIndex - numberItemsLimit + 1
        console.log(totalNumberItems +' ' +activeItemIndex);
        if (offsetInNumber > 0){
            if (totalNumberItems == activeItemIndex) offsetInNumber=offsetInNumber-1;
            var offset = offsetInNumber * item_width;
            navigationBasicToolUL.css('left','-'+offset+'px');
        }
    }
});
