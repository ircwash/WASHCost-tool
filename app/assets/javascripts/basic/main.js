$(document).ready(function()
{
    function infoPanel()
    {
        $('.tab').on('click', function(e){

            e.preventDefault();

            var $panel = $(this).parent();

            $panel.animate({
                right: parseInt($panel.css('right'),10) == -214 ? ($panel.width()-245) : -214
            }, 100);

        });
    } infoPanel();

    function initSelects(){
        var config = {
            '.chzn-select'           : {},
            '.chzn-select-deselect'  : {allow_single_deselect:true},
            '.chzn-select-no-single' : {disable_search_threshold:10},
            '.chzn-select-no-results': {no_results_text:'Nothing found!'},
            '.chzn-select-width'     : {width:"95%"}
        }
        for (var selector in config) {
            $(selector).chosen(config[selector]);
        }
    } initSelects();

    function radioInputTick() {
        // target to change the info box regarding to item selected
        target_select = $('input[name="target-select"]').data("target");
        var $tick = $('.tickCheckBox'),
            $inputTick = $('.tickCheckBox input');
        $('.tickCheckBox').on('click', function(e)
        {
            e.preventDefault();
            // Change the info box regarding to item selected
            console.log(target_select);
            $.ajax({
                url : "/water_basic/data_info_box",
                data : "trigger="+target_select+"&index="+$(this).find('input').val(),
                type : "POST",
            });
            if($inputTick.length)
            {
                $inputTick.parent().removeClass('ticked');
                if ($(this).hasClass('ticked')) {
                    $(this).removeClass('ticked');
                } else {
                    $(this).addClass('ticked');
                    var targetHiddenInput= $inputTick.attr('name').split('_')[1];
                    var clickedLabelsInputValue= $(this).find('input').val();
                    $('input[name="'+targetHiddenInput+'"]').val(clickedLabelsInputValue);
                }
            }
        });

    } radioInputTick();
    function readMore() {
        var $target = $('.readMore');
        $target.on('click', function(e) {
            $(this).next().slideToggle();
            e.preventDefault();
        });
    } readMore();

    //Function to resize the size of header in each page of basic tools
    header_basic_tool = $('.basic_tool_header_item');
    heihgt_header = header_basic_tool.height();
    HEIGHT_HEADER_LIMIT = 94;
    HEADER_FONT_SIZE_BASE = 40
    if(header_basic_tool.length>0 && heihgt_header> HEIGHT_HEADER_LIMIT){
        font_size = HEADER_FONT_SIZE_BASE;
        while(heihgt_header > HEIGHT_HEADER_LIMIT){
            font_size--;
            header_basic_tool.css('font-size',font_size+'px');
            heihgt_header = header_basic_tool.height();
        }
    }

});
