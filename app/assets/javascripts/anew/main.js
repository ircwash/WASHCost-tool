
$(document).ready(function(){
    $('.chzn-select').chosen()

    function radioInputTick() {
        $('.tickCheckBox').on('click', function(e)
        {
            e.preventDefault();
            console.log($(this));
            inputTick = $(".tickCheckBox input[name='"+$(this).attr('for')+"']");
            console.log(inputTick);
            if(inputTick.length)
            {
                inputTick.parent().removeClass('ticked');
                if ($(this).hasClass('ticked')) {
                    $(this).removeClass('ticked');
                } else {
                    $(this).addClass('ticked');
                    $('#'+$(this).data('target')).val($(this).find('input').val())
                }
            }
        });

    } radioInputTick();
    // Option buttons that are checked should be highlighted.
    option_cheched = $( "[checked='checked']" )
    option_cheched.parent().addClass('ticked');

    // Resize the window according to spatial use
    if ($(window).height()>$("body").height()){
        $('#delta-resize').css('height',($(window).height()-$("body").height())+"px")
    }
});
