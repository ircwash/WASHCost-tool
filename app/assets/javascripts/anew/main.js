
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
        var option_cheched = $( "[checked='checked']" );
        option_cheched.parent().addClass('ticked');
    }


    // ---------> Resize the window according to spatial use
    function footerPositioning(){
        var mainContainer = $('body .main-container');
        if ($(document).height()>mainContainer.height()){

            $('#delta-resize').css('height',($(document).height()-mainContainer.height())+"px")
        }
    } footerPositioning();

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

    // logic in selectors
    $('.select-container label').click(function(){
        $('.select-container label').removeClass('ticked');
        $(this).addClass('ticked');
    });
    $('.select-container label input:checked').parent().addClass('ticked');

    $(window).resize(function(){
        footerPositioning();
    });
});



