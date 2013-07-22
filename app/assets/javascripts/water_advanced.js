var washCost = window.washCost || {};

washCost.page = (function(){

    function inputPlaceholder() {

        $('[placeholder]').focus(function() {
            var input = $(this);
            if (input.val() == input.attr('placeholder')) {
                input.val('');
                input.removeClass('placeholder');
            }
        }).blur(function() {
                var input = $(this);
                if (input.val() == '' || input.val() == input.attr('placeholder')) {
                    input.addClass('placeholder');
                    input.val(input.attr('placeholder'));
                }
            }).blur().parents('form').submit(function() {
                $(this).find('[placeholder]').each(function() {
                    var input = $(this);
                    if (input.val() == input.attr('placeholder')) {
                        input.val('');
                    }
                })
            });
    }
    function chosenSelect() {
        var config = {
            '.chzn-select'           : {},
            '.chzn-select-deselect'  : {allow_single_deselect:true},
            '.chzn-select-no-single' : {disable_search_threshold:10},
            '.chzn-select-no-results': {no_results_text:'Oops, nothing found!'},
            '.chzn-select-width'     : {width:"95%"}
        }
        for (var selector in config) {
            $(selector).chosen(config[selector]);
        }
    }
    function chosenWidthFix() {
        $widthTarget = $('select').next();
        $widthTarget.each(function() {
            $widthTarget.css({'width':'88%'});
        });
    }
    return {
        init: function() {
            chosenSelect();
            inputPlaceholder();
            chosenWidthFix();
        }
    }
}());

$(function(){
    washCost.page.init();
});
