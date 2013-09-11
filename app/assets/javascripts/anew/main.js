
$(document).ready(function(){

    $('.chzn-select').chosen()

    if($('.landing-container').length > 0){
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
        option_cheched = $( "[checked='checked']" );
        option_cheched.parent().addClass('ticked');
    }


    // ---------> Resize the window according to spatial use
    console.log($(document).height() +" "+$("body .main-container").height());
    if ($(window).height()>$("body .main-container").height()){
        offsetHeight = 0;
        if($('.basic-tool').length > 0){
            offsetHeight = 0;
        }
        $('#delta-resize').css('height',($(window).height()-$("body .main-container").height()- offsetHeight)+"px")
    }

    // ---------> Section in user editing form
    var sectionContainer = $('.edit_user .section-container section .title');
    sectionContainer.on('click', function () {
        if ($(this).parent().hasClass('active')){
            $(this).parent().removeClass('active');
            $(this).parent().find('input').prop('disabled', true)
            return false;
        }else{
            $(this).parent().find('input').prop('disabled', false)
        }
    });
    // normally section must be closed
    $('.edit_user .section-container').ready(function(){
        $(this).find('section').removeClass('active');
    });

});



