
$(document).ready(function(){
    // ---------> Section in user editing form
    var reviewContainer = $('.report .review section .title');
    reviewContainer.on('click', function () {
        if ($(this).parent().hasClass('active')){
            $(this).parent().removeClass('active');
            return false;
        }
    });
});

